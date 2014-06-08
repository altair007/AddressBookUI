//
//  CFDetailView.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-6.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFDetailView.h"
#import "CFPerson.h"

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
        
    }
    return self;
}

-(void)dealloc
{
    self.person = nil;
    self.avatar = nil;
    self.infoLabel = nil;
    
    [super dealloc];
}

-(void)drawRect:(CGRect)rect
{
    if (nil == self.avatar) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 130, 100)];
        self.avatar = imageView;
        [imageView release];
        
        [self addSubview: self.avatar];
    }

    self.avatar.image = [UIImage imageNamed: self.person.name];
    
    
    if (nil == self.infoLabel) {
        UILabel * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.avatar.frame.origin.x + self.avatar.frame.size.width, self.avatar.frame.origin.y, rect.size.width - self.avatar.frame.size.width - self.avatar.frame.origin.x, self.avatar.frame.size.height)];
        infoLabel.numberOfLines = 0;
        infoLabel.adjustsFontSizeToFitWidth = YES;
        
        self.infoLabel = infoLabel;
        [infoLabel release];
        
        [self addSubview:self.infoLabel];
    }

    self.infoLabel.text = [[[NSString alloc] initWithFormat:@"%@\n%@\n%ld\n%@", self.person.name, self.person.sex, self.person.age, self.person.tel] autorelease];
    
}
@end
