//
//  CFPerson.m
//  AddressBook
//
//  Created by   颜风 on 14-5-19.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "CFPerson.h"

@implementation CFPerson

-(void)dealloc
{
    self.name = nil;
    self.avatar = nil;
    self.tel = nil;
    self.intro = nil;
    
    [super dealloc];
}

+ (instancetype) personWithName: (NSString *) name
                         avatar: (NSString *) avatar
                            sex: (BOOL) sex
                            age: (NSUInteger) age
                            tel: (NSString *) tel
                          intro: (NSString *) intro
{
    CFPerson * person = [[[[self class] alloc]initWithName: name avatar:avatar sex: sex age: age tel: tel intro: intro] autorelease];
    return person;
}

- (instancetype) init
{
    if (self = [self initWithName:nil avatar:nil sex:NO age:0 tel:nil intro: nil]) {
        
    }
    
    return self;
}

- (instancetype) initWithName: (NSString *) name
                   avatar: (NSString *) avatarName
                          sex: (BOOL) sex
                          age: (NSUInteger) age
                          tel: (NSString *) tel
                        intro: (NSString *) intro
{
    if (self = [super init]) {
        self.name = name;
        self.avatar = avatarName;
        self.sex = sex;
        self.age = age;
        self.tel = tel;
        self.intro = intro;
    }
    
    return self;
}

- (BOOL) isEqualToPerson: (CFPerson *) aPerson
{
    if (nil == aPerson) { // 为空
        return NO;
    }
    
    if (NO == [aPerson isMemberOfClass: [self class]]) { // 不是同类对象
        return NO;
    }
    
    if (self == aPerson) { // 为同一对象.
        return YES;
    }
    
    if ([self.name isEqualToString: aPerson.name] &&
        [self.avatar isEqualToString: aPerson.avatar] &&
        self.sex == aPerson.sex &&
        self.age == aPerson.age &&
        [self.tel isEqualToString: aPerson.tel] &&
        [self.intro isEqualToString: aPerson.intro]) {
        return YES;
    }
    
    return NO;
}

- (void) updateWithPerson: (CFPerson *) aPerson
{
    if (nil == aPerson) {
        return;
    }
    
    self.name = aPerson.name;
    self.avatar = aPerson.avatar;
    self.sex = aPerson.sex;
    self.tel = aPerson.tel;
    self.intro = aPerson.intro;
}

@end
