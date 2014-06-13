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
    self.avatarName = nil;
    self.sex = nil;
    self.tel = nil;
    self.intro = nil;
    
    [super dealloc];
}

#pragma mark - 便利初始化
- (instancetype) init
{
    if (self = [self initWithName:nil avatarName:nil sex:nil age:0 tel:nil intro: nil]) {
        
    }
    
    return self;
}
- (instancetype) initWithName: (NSString *) name
                   avatarName: (NSString *) avatarName
                          sex: (NSString *) sex
                          age: (NSUInteger) age
                          tel: (NSString *) tel
                        intro: (NSString *) intro
{
    if (self = [super init]) {
        self.name = name;
        self.avatarName = avatarName;
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
        [self.avatarName isEqualToString: aPerson.avatarName] &&
        [self.sex isEqualToString: aPerson.sex] &&
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
    self.avatarName = aPerson.avatarName;
    self.sex = aPerson.sex;
    self.tel = aPerson.tel;
    self.intro = aPerson.intro;
}

#pragma mark - NSCoding协议方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey: kNameKey];
        self.avatarName = [aDecoder decodeObjectForKey: kAvatarKey];
        self.sex = [aDecoder decodeObjectForKey: kSexKey];
        self.age = [aDecoder decodeIntegerForKey: kAgeKey];
        self.tel = [aDecoder decodeObjectForKey: kTelKey];
        self.intro = [aDecoder decodeObjectForKey: kIntro];
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject: self.name forKey: kNameKey];
    [aCoder encodeObject: self.avatarName forKey: kAvatarKey];
    [aCoder encodeObject: self.sex forKey: kSexKey];
    [aCoder encodeInteger: self.age forKey: kAgeKey];
    [aCoder encodeObject: self.tel forKey: kTelKey];
    [aCoder encodeObject: self.intro forKey: kIntro];
}

@end
