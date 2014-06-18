//
//  CFAvatarView.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-14.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFAvatarView.h"
#import "UIImage+AssetUrl.h"

@implementation CFAvatarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    [UIImage imageForAssetUrl:self.avatarName success:^(UIImage * aImg) {// 使用本地图片
        self.image = aImg;
    } fail:^{// 使用app内置图片
        UIImage * image = [UIImage imageNamed: self.avatarName];
        
        if (nil == image) {// 使用默认图片
            image = [UIImage imageNamed: @"default.jpg"];
        }
        
        self.image = image;
    }];
}

@end
