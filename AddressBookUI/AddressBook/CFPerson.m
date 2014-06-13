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

// ???:备用!
//- (void) updateAvatarImage
//{
//    [self imageForAssetUrl:self.avatarName success:^(UIImage * aImg) {// 使用本地图片
//        self.avatarImage = aImg;
//    } fail:^{// 使用app内置图片或者默认图片.
//        UIImage * img = [UIImage imageNamed:self.avatarName];
//        if (nil == img) {// 使用默认图片
//            img = [UIImage imageNamed: self.nameOfdefaultImg];
//        }
//        self.avatarImage = img;
//    }];
//}

// ???:代码备用.
//- (void) imageForAssetUrl: (NSString *) assetUrl
//                  success: (void(^)(UIImage *)) successBlock
//                     fail: (void(^)()) failBlock
//{
//    __block UIImage * image;
//    ALAssetsLibrary   *lib = [[[ALAssetsLibrary alloc] init] autorelease];
//    [lib assetForURL:[NSURL URLWithString:self.avatarName] resultBlock:^(ALAsset *asset)
//     {
//         // 使用asset来获取本地图片
//         ALAssetRepresentation *assetRep = [asset defaultRepresentation];
//         CGImageRef imgRef = [assetRep fullResolutionImage];
//         image = [UIImage imageWithCGImage:imgRef
//                                       scale:assetRep.scale
//                                 orientation:(UIImageOrientation)assetRep.orientation];
//         if (nil == image) { // 获取图片失败
//             failBlock();
//             return;
//         }
//         
//         successBlock(image);
//         [image release];
//     }
//        failureBlock:^(NSError *error) {
//            failBlock();
//        }];
//}

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
