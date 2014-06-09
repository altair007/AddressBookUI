//
//  CFAddressBookModel.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-6.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFAddressBookModel.h"
#import "CFPerson.h"

@implementation CFAddressBookModel
#pragma mark - 实例方法
- (instancetype)initWithFile:(NSString *)path
{
    if (self = [super init]) {
        self.pathOfData = path;

        self.persons = [NSKeyedUnarchiver unarchiveObjectWithFile: self.pathOfData];
        
        if (nil == self.persons) {
            return nil;
        }
    }
    
    return self;
}

- (BOOL) update
{
    BOOL result = [NSKeyedArchiver archiveRootObject: self.persons toFile: self.pathOfData];
    
    return result;
}

-(void)dealloc
{
    self.persons = nil;
    self.pathOfData = nil;
    
    [super dealloc];
}

- (NSDictionary *) personsByGroups
{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:42];
    
    [self.persons enumerateObjectsUsingBlock:^(CFPerson * person, NSUInteger idx, BOOL *stop) {
        // 获取联系人拼音首字母
        NSString * firstChar = [self firstCharOfName: person.name];
        
        // 获取联系人对应的数组
        NSMutableArray * persons = [dict objectForKey: firstChar];
        
        // 判断键是否存在于数组中,不存在则创建
        if (nil == persons) {
            [dict setObject: [[[NSMutableArray alloc] initWithCapacity:42] autorelease] forKey:firstChar];
            
            // 重新获取联系人对应的数组
            persons = [dict objectForKey: firstChar];
        }
        
        // 将联系人添加到对应数组中
        [persons addObject: person];
    }];
    
    return dict.autorelease;
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

- (void) removePerson: (CFPerson *) aPerson
{
    [self.persons removeObject: aPerson];
    [self update];
}

- (BOOL) addPerson: (CFPerson *) aPerson
{
    if([aPerson.name isEqualToString: @""] || [aPerson.tel isEqualToString: @""]){
        return NO;
    }
    
    if ([self.persons containsObject:aPerson]) { // 联系人已存在,直接修改.
        return [self update];
    }
    
    [self.persons addObject: aPerson];
    
    return [self update];
}
@end
