//
//  CFAvatarView.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-14.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFAvatarView.h"
#import "UIImage+AssetUrl.h"

@interface CFAvatarView ()
@property (copy, nonatomic, readwrite) NSString * defaultImg; //!< 默认图片.
@end

@implementation CFAvatarView
- (void)dealloc
{
    self.avatarName = nil;
    self.defaultImg = nil;

    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.defaultImg = @"default.jpg";
        
    }
    return self;
}

- (void)setAvatarName:(NSString *)nameOfImage
{
    // 设置属性
    NSString * temp = [nameOfImage copy];
    [_avatarName release];
    _avatarName = temp;
    
    // 更新联系人头像
    if (nil != nameOfImage) {
        [UIImage imageForAssetUrl:self.avatarName success:^(UIImage * aImg) {// 使用本地图片
            self.image = aImg;
        } fail:^{// 使用app内置图片
            UIImage * image = [UIImage imageNamed: self.avatarName];
            
            if (nil == image) {// 使用默认图片
                if ([self.defaultImg isEqualToString: self.avatarName]) {
                    return;
                }
                
                self.avatarName = self.defaultImg;
            }
            
            self.image = image;
        }];
    }
}

@end
