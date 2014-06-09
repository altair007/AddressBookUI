//
//  CFDetailView.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-6.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFDetailView.h"
#import "CFPerson.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface CFDetailView ()
@property (retain, nonatomic, readwrite) UIImageView * avatarImageView; //!< 头像
@property (retain, nonatomic, readwrite) NSString * nameOfdefaultImg; //!< 默认显示的图片
@property (retain, nonatomic, readwrite) UILabel * infoLabel; //!< 联系人详细信息
@end

@implementation CFDetailView
#pragma mark - 实例方法

- (instancetype) initWithFrame:(CGRect) frame
           andNameOfDefaultImg:(NSString *) aImgName
{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.nameOfdefaultImg = aImgName;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self = [self initWithFrame:frame andNameOfDefaultImg:@"default.jpg"]) {
        // Initialization code
    }
    return self;
}


-(void)dealloc
{
    self.person = nil;
    self.avatarImageView = nil;
    self.infoLabel = nil;
    
    [super dealloc];
}

-(void)drawRect:(CGRect)rect
{
    // 头像
    if (nil == self.avatarImageView) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 130, 100)];
        self.avatarImageView = imageView;
        [imageView release];
        
        [self addSubview: self.avatarImageView];
    }
    self.avatarImageView.image = self.person.avatarImage;
    
    // 详细信息
    if (nil == self.infoLabel) {
        UILabel * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.avatarImageView.frame.origin.x + self.avatarImageView.frame.size.width, self.avatarImageView.frame.origin.y, rect.size.width - self.avatarImageView.frame.size.width - self.avatarImageView.frame.origin.x, self.avatarImageView.frame.size.height)];
        infoLabel.numberOfLines = 0;
        infoLabel.adjustsFontSizeToFitWidth = YES;
        
        self.infoLabel = infoLabel;
        [infoLabel release];
        
        [self addSubview:self.infoLabel];
    }
    self.infoLabel.text = [[[NSString alloc] initWithFormat:@"%@\n%@\n%ld\n%@", self.person.name, self.person.sex, self.person.age, self.person.tel] autorelease];
    
}
@end
