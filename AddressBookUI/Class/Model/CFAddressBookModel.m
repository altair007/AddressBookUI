//
//  CFAddressBookModel.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-6.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFAddressBookModel.h"
#import "CFPerson.h"
#import "FMDB.h"

@interface CFAddressBookModel ()
@property (nonatomic, retain, readwrite) NSMutableDictionary * persons; //!: 联系人数据:按姓名拼音首字母分组排序的字典,以首字母为键,以联系人数组为值.
@property (retain, nonatomic, readwrite) FMDatabase * db; //!< 数据库.
@end

@implementation CFAddressBookModel
-(void)dealloc
{
    self.persons = nil;
    self.db = nil;
    
    [super dealloc];
}

- (instancetype)init
{
    if (self = [super init]) {
        if (NO == [self setupDB]) {
            return nil;
        }
    }
    
    return self;
}

- (BOOL) setupDB
{
    // 连接数据库.
    NSString * dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/AddressBook.db"];
    FMDatabase * db = [FMDatabase databaseWithPath: dbPath];
    self.db = db;
    
    // 初始化数据库.
    if (NO == [self.db open]) {
        return NO;
    }
    NSString * sql = @"CREATE TABLE IF NOT EXISTS `abPersons` (`pkPersonId`INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE, `txtName` TEXT NOT NULL, `txtAvatar` TEXT, `intSex` INTEGER, `intAge` INTEGER, `txtTel` TEXT NOT NULL UNIQUE, `txtIntro` TEXT)";
    
    if (NO == [self.db executeUpdate: sql]) {
        return NO;
    }
    
    // 更新数据.
    if (NO == [self updateData]) {
        return NO;
    };
    
    return YES;
}

- (BOOL) updateData
{
    NSMutableDictionary * persons = [NSMutableDictionary dictionaryWithCapacity:42];
    
    if (NO == [self.db open]) {
        return NO;
    }

    FMResultSet * results = [self.db executeQuery:@"SELECT `txtName`, `txtAvatar`, `intSex`, `intAge`, `txtTel`, `txtIntro`  FROM `abPersons`"];
    
    while (YES == [results next]) {
        /* 根据返回数据,创建一个联系人对象. */
        NSString * name = [results stringForColumn: @"txtName"];
        NSString * avatar = [results stringForColumn: @"txtAvatar"];
        BOOL sex = [results boolForColumn: @"intSex"];
        NSUInteger age = [results longLongIntForColumn: @"intAge"];
        NSString * tel = [results stringForColumn: @"txtTel"];
        NSString * intro = [results stringForColumn: @"txtIntro"];
        CFPerson * person = [CFPerson personWithName: name avatar: avatar sex: sex age: age tel: tel intro: intro];
        
        /* 将联系人添加到联系人字典中.*/
        NSString * firstChar = [self firstCharOfName: person.name];
        NSMutableArray * group = [persons objectForKey: firstChar];

        if (nil == group) {
            [persons setObject: [[[NSMutableArray alloc] initWithCapacity:42] autorelease] forKey:firstChar];
            group = [persons objectForKey: firstChar];
        }

        [group addObject: person];
    }
    
    self.persons = persons;
    
    [self.db close];
    
    return YES;
}

- (NSString *) firstCharOfName: (NSString *) aChinenseName
{
    NSMutableString * first = [[[NSMutableString alloc] initWithString:[aChinenseName substringWithRange:NSMakeRange(0, 1)]] autorelease];
    
    CFRange range = CFRangeMake(0, 1);
    
    // 汉字转换为拼音,并去除音调
    if ( ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformMandarinLatin, NO) ||
        ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    
    NSString * result;
    result = [first substringWithRange:NSMakeRange(0, 1)];
    
    return result.uppercaseString;
}

- (BOOL) removePersonWithTel: (NSString *) tel
{
    if (NO == [self.db open]) {
        return NO;
    }
    
    if (NO == [self.db executeUpdateWithFormat:@"DELETE FROM `abPersons` Where `txtTel` = %@", tel]) {
        return NO;
    }

    if (NO == [self updateData]) {
        return NO;
    }
    
    [self.db close];
    
    return YES;
}

- (BOOL) addPerson: (CFPerson *) aPerson
{
    if (NO == [self.db open]) {
        return NO;
    }
    
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO `abPersons` (`txtName`, `txtAvatar`, `intSex`, `intAge`, `txtTel`, `txtIntro`) VALUES(?, ?, ?, ?, ?, ?)"];
    NSArray * sqlArgs = @[aPerson.name, aPerson.avatar, [NSNumber numberWithBool: aPerson.sex], [NSNumber numberWithInteger: aPerson.age], aPerson.tel, aPerson.intro];
    
    if (NO == [self.db executeUpdate:sql withArgumentsInArray: sqlArgs]) {
        return NO;
    }
    
    if (NO == [self updateData]) {
        return NO;
    }
    
    [self.db close];
    
    return YES;
}

@end
