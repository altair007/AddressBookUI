//
//  CFPerson.m
//  AddressBook
//
//  Created by   颜风 on 14-5-19.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFPerson.h"

@implementation CFPerson

#pragma mark - 便利初始化
- (instancetype) initWithName: (NSString *) name
                       avatar: (NSString *) avatar
                          sex: (NSString *) sex
                          age: (NSUInteger) age
                          tel: (NSString *) tel
{
    if (self = [super init]) {
        self.name = name;
        self.avatar = avatar;
        self.sex = sex;
        self.age = age;
        self.tel = tel;
    }
    
    return self;
}

#pragma mark - NSCoding协议方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey: kNameKey];
        self.avatar = [aDecoder decodeObjectForKey: kAvatarKey];
        self.sex = [aDecoder decodeObjectForKey: kSexKey];
        self.age = [aDecoder decodeIntegerForKey: kAgeKey];
        self.tel = [aDecoder decodeObjectForKey: kTelKey];
    }

    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject: self.name forKey: kNameKey];
    [aCoder encodeObject: self.avatar forKey: kAvatarKey];
    [aCoder encodeObject: self.sex forKey: kSexKey];
    [aCoder encodeInteger: self.age forKey: kAgeKey];
    [aCoder encodeObject: self.tel forKey: kTelKey];
}

#pragma mark - 重写方法
-(void)dealloc
{
    self.avatar = nil;
    self.name = nil;
    self.tel = nil;
    
    [super dealloc];
}
@end
