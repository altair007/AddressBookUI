//
//  CFPersonCellInfoView.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-11.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFPersonCellInfoView.h"

@interface CFPersonCellInfoView ()
@property (retain, nonatomic, readwrite) UILabel * nameLabel; //!< 姓名.
@property (retain, nonatomic, readwrite) UILabel * telLabel; //!< 联系方式.
@property (retain, nonatomic, readwrite) UILabel * introLabel; //!< 简介.
@end

@implementation CFPersonCellInfoView

- (void)dealloc
{
    self.nameLabel = nil;
    self.telLabel = nil;
    self.introLabel = nil;
    
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    // 视图的高度使用预定义的值.
    CGRect realRect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, DEFAULT_HEIGHT);
    
    self = [super initWithFrame: realRect];
    if (self) {
        // Initialization code
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    
    NSArray * keys = @[kNameLabel, kTelLabel, kIntroLabel]; // 属性键组成的数组.
    
    __block CGRect baseRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/ (keys.count - 1));
    [keys enumerateObjectsUsingBlock:^(NSString * aKey, NSUInteger idx, BOOL *stop) {
        UILabel * tempLabel = [[UILabel alloc] initWithFrame:baseRect];
        
        // 单独处理"简介"框的框架高度:设为0.0
        if ([aKey isEqualToString: kIntroLabel]) {
            tempLabel.frame = CGRectMake(tempLabel.frame.origin.x, tempLabel.frame.origin.y, tempLabel.frame.size.width, 0.0);
        }
        
        tempLabel.backgroundColor = [UIColor cyanColor];
        tempLabel.numberOfLines = 0;
        tempLabel.font = [UIFont systemFontOfSize: 15.0];
        
        [self setValue: tempLabel forKey: aKey];
        [self addSubview: tempLabel];
        [tempLabel release];
        
        baseRect = CGRectMake(baseRect.origin.x, baseRect.origin.y + baseRect.size.height, baseRect.size.width, baseRect.size.height);
    }];
}

@end
