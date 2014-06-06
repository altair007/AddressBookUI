//
//  CFDetailView.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-6.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFDetailView.h"
@interface CFDetailView ()
@property (retain, nonatomic, readwrite) UIImageView * avatar; //!< 头像
@property (retain, nonatomic, readwrite) UILabel * infoLabel; //!< 联系人详细信息
@end

@implementation CFDetailView
#pragma mark - 实例方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 130, 100)];
        self.avatar = imageView;
        [imageView release];
        
        [self addSubview: self.avatar];
        
        UILabel * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, 150, 100)];
        infoLabel.numberOfLines = 0;
        infoLabel.adjustsFontSizeToFitWidth = YES;
        
        self.infoLabel = infoLabel;
        [infoLabel release];
        
        [self addSubview:infoLabel];
    }
    return self;
}

-(void)dealloc
{
    self.avatar = nil;
    self.infoLabel = nil;
    
    [super dealloc];
}

@end
