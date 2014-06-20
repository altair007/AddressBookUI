//
//  CFAddPersonView.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-20.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFAddPersonView.h"
#import "UIImage+AssetUrl.h"
#import "CFAvatarView.h"

@implementation CFAddPersonView

- (void)setupSubviews
{
    [super setupSubviews];
    
    // 设置默认显示的信息
    self.avatarView.avatarName = self.avatarView.defaultImg;
    self.introTV.text = @"请简单描述一下这个人吧!";
}
@end
