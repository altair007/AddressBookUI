//
//  CFPersonTableViewCell.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-10.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFPersonTableViewCell.h"
#import "CFPerson.h"
#import "CFPersonCellInfoView.h"
#import "UIImage+AssetUrl.h"
#import "CFAvatarView.h"

@interface CFPersonTableViewCell ()
@property (retain, nonatomic, readwrite) CFAvatarView * avatarView; //!< 联系人头像.
@property (retain, nonatomic, readwrite) CFPersonCellInfoView * infoView; //!< 联系人信息
@end

@implementation CFPersonTableViewCell
+ (CGFloat) heightWithPerson: (CFPerson *) aPerson
{
    CGFloat height;
    height = [CFPersonCellInfoView heightWithPerson: aPerson];
    
    if (height < HEIGHT_AVATAR) {
        height = HEIGHT_AVATAR;
    }
    
    height += 2 * PADDING_UP_AVATAR;
    
    return height;
}

-(void)dealloc
{
    self.person = nil;
    self.avatarView = nil;
    self.infoView = nil;
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect frame = [UIScreen mainScreen].bounds;
        [self setupSubviews: frame];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupSubviews: (CGRect) rect
{
    self.backgroundColor = [UIColor whiteColor];
    
    // 头像视图
    CFAvatarView * avatarView = [[CFAvatarView alloc] initWithFrame:CGRectMake(PADDING_LEFT_AVATAR, PADDING_UP_AVATAR, WIDTH_AVATAR, HEIGHT_AVATAR)];
    
    self.avatarView= avatarView;
    [avatarView release];
    
    [self.contentView addSubview: self.avatarView];
    
    // 信息视图
    CFPersonCellInfoView * infoView = [[CFPersonCellInfoView alloc] initWithFrame:CGRectMake(rect.size.width - DEFAULT_WIDTH - PADDING_LEFT_AVATAR, self.avatarView.frame.origin.y, DEFAULT_WIDTH, DEFAULT_HEIGHT)];
    
    self.infoView = infoView;
    [self.contentView addSubview: self.infoView];
    [infoView release];
    
}

-(void)setPerson:(CFPerson *)person
{
    // 设置属性
    [person retain];
    [_person release];
    _person = person;
    
    // 更新视图内容
    if (nil != person) {
        [self updateContentOfView];
    }

}

- (CGFloat) height
{
    CGFloat height = [[self class] heightWithPerson: self.person];
    
    return height;
}

- (void) updateContentOfView
{
    
    self.avatarView.avatarName = self.person.avatar;
    
    self.infoView.person = self.person;
    
    // 更新视图边框信息.
    [self updateFrameOfView];
}

- (void)updateFrameOfView
{    
    // 更新视图的边框信息
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.height);
}
@end
