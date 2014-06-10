//
//  CFPerson.m
//  AddressBook
//
//  Created by   颜风 on 14-5-19.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "CFPerson.h"

@interface CFPerson ()
@property (retain, nonatomic, readwrite) NSString * nameOfdefaultImg; //!< 默认头像名称.
@property (retain, nonatomic, readwrite) UIImage * avatarImage; //!< 头像图片,根据头像名称动态获取.
@end

@implementation CFPerson

-(void)dealloc
{
    self.avatar = nil;
    self.name = nil;
    self.tel = nil;
    self.nameOfdefaultImg = nil;
    self.avatarImage = nil;
    self.intro = nil;
    
    [super dealloc];
}

#pragma mark - 便利初始化
- (instancetype) init
{
    if (self = [self initWithName:nil avatar:nil sex:nil age:0 tel:nil nameOfdefaultImg:nil]) {
        
    }
    
    return self;
}
- (instancetype) initWithName: (NSString *) name
                       avatar: (NSString *) avatar
                          sex: (NSString *) sex
                          age: (NSUInteger) age
                          tel: (NSString *) tel
             nameOfdefaultImg: (NSString *) nameOfdefaultImg
{
    if (self = [super init]) {
        self.name = name;
        self.avatar = avatar;
        self.sex = sex;
        self.age = age;
        self.tel = tel;
        self.nameOfdefaultImg = nameOfdefaultImg;
    }
    
    return self;
}

- (instancetype) initWithName: (NSString *) name
                       avatar: (NSString *) avatar
                          sex: (NSString *) sex
                          age: (NSUInteger) age
                          tel: (NSString *) tel
{
    if (self = [self initWithName: name avatar: avatar sex: sex age: age tel: tel nameOfdefaultImg: nil]) {
        
    }
    
    return self;
}

- (void) updateAvatarImage
{
    // 是否是应用内置图片?
    self.avatarImage = [UIImage imageNamed: self.avatar];
    if (nil != self.avatarImage) {
        return;
    }
    
    // 是否是本地图片?
    ALAssetsLibrary   *lib = [[[ALAssetsLibrary alloc] init] autorelease];
    [lib assetForURL:[NSURL URLWithString:self.avatar] resultBlock:^(ALAsset *asset)
     {
         // 使用asset来获取本地图片
         ALAssetRepresentation *assetRep = [asset defaultRepresentation];
         CGImageRef imgRef = [assetRep fullResolutionImage];
         self.avatarImage = [UIImage imageWithCGImage:imgRef
                                                scale:assetRep.scale
                                          orientation:(UIImageOrientation)assetRep.orientation];
     }
        failureBlock:^(NSError *error)
     {
         // 使用默认图片
         self.avatarImage = [[UIImage alloc] initWithContentsOfFile: self.nameOfdefaultImg];
     }
     ];
}

- (void)setAvatar:(NSString *)avatar
{
    [avatar retain];
    [_avatar release];
    _avatar = avatar;
    
    if (nil == _avatar) {
        return;
    }
    
    [self updateAvatarImage];
}

- (void)setNameOfdefaultImg:(NSString *)nameOfdefaultImg
{
    [nameOfdefaultImg retain];
    [_nameOfdefaultImg release];
    _nameOfdefaultImg = nameOfdefaultImg;
    
    if (nil == _nameOfdefaultImg) {
        _nameOfdefaultImg = DEFAULT_AVATAR_NAME;
    }
    
    if (nil == self.avatar) {
        self.avatar = _nameOfdefaultImg;
    }
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
        self.intro = [aDecoder decodeObjectForKey: kIntro];
        self.nameOfdefaultImg = DEFAULT_AVATAR_NAME;
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
    [aCoder encodeObject: self.intro forKey: kIntro];
}
@end
