//
//  CFPersonTableViewCell.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-10.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFPersonTableViewCell.h"
#import "CFPerson.h"

@interface CFPersonTableViewCell ()
@property (retain, nonatomic, readwrite) UIImageView * avatarIV; //!< 联系人头像.
// FIXME:应该把contentView封装成一个类.
@property (retain, nonatomic, readwrite) UIView * infoView; //!< 下面几个属性的父视图.
@property (retain, nonatomic, readwrite) UILabel * nameLabel; //!< 姓名.
@property (retain, nonatomic, readwrite) UILabel * telLabel; //!< 联系方式.
@property (retain, nonatomic, readwrite) UILabel * introLabel; //!< 简介.
@end

@implementation CFPersonTableViewCell
-(void)dealloc
{
    self.person = nil;
    self.avatarIV = nil;
    self.infoView = nil;
    self.nameLabel = nil;
    self.telLabel = nil;
    self.introLabel = nil;
    
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
    
    // 头像
    CGFloat landscapeSpace = 30.0; // 头像距离边框的距离
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(landscapeSpace, 15, 80, 120)];
    
    self.avatarIV= imageView;
    [imageView release];
    
    [self addSubview: self.avatarIV];
    
    //头像旁边的几个编辑框
    // ???: 不给初始frame值,真的合适吗?
    UIView * infoView = [[UIView alloc] init];
    self.infoView = infoView;
    [self addSubview: self.infoView];
    [infoView release];
    
    NSArray * contents = @[kNameLabel, kTelLabel, kIntroLabel];
    
    CGFloat portraitSpace = 0; // 编辑框竖直方向的间距
    
    // ???: 动态计算信息视图的算法需要优化.
    CGRect originalRectOfInfoView = CGRectMake(2 * self.avatarIV.frame.origin.x + self.avatarIV.frame.size.width, self.avatarIV.frame.origin.y, rect.size.width - self.avatarIV.frame.size.width - self.avatarIV.frame.origin.x - 2 * self.avatarIV.frame.origin.x, (self.avatarIV.frame.size.height - portraitSpace * (contents.count - 1)) / contents.count);
    __block CGRect baseRect = CGRectMake(0, 0, rect.size.width - self.avatarIV.frame.size.width - self.avatarIV.frame.origin.x - 2 * self.avatarIV.frame.origin.x, (self.avatarIV.frame.size.height - portraitSpace * (contents.count - 1)) / contents.count);
    [contents enumerateObjectsUsingBlock:^(NSString * aKey, NSUInteger idx, BOOL *stop) {
        UILabel * tempLabel = [[UILabel alloc] initWithFrame:baseRect];
        
        tempLabel.numberOfLines = 0;
        tempLabel.font = [UIFont systemFontOfSize: 15.0];
        
        [self setValue: tempLabel forKey: aKey];
        [self.infoView addSubview: tempLabel];
        [tempLabel release];
        
        baseRect = CGRectMake(baseRect.origin.x, baseRect.origin.y + baseRect.size.height + portraitSpace, baseRect.size.width, baseRect.size.height);
    }];
    CGFloat totalHeightOfInfoView = baseRect.origin.y - portraitSpace;
    self.infoView.frame = CGRectMake(originalRectOfInfoView.origin.x, originalRectOfInfoView.origin.y, originalRectOfInfoView.size.width, totalHeightOfInfoView);
}

-(void)setPerson:(CFPerson *)person
{
    // 设置属性
    [person retain];
    [_person release];
    _person = person;
    
    // 设置视图
    self.avatarIV.image = person.avatarImage;
    self.nameLabel.text = person.name;
    self.telLabel.text = person.tel;
    self.introLabel.text = person.intro;
    
    // 设置信息视图的边框.
    CGRect originalOfInfowView = self.infoView.frame;
    CGRect originalOfIntrofoLabel = self.introLabel.frame;
    
    NSDictionary * textDic = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
    CGRect rect  = [person.intro boundingRectWithSize:CGSizeMake(self.introLabel.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    
    self.introLabel.frame = CGRectMake(originalOfIntrofoLabel.origin.x, originalOfIntrofoLabel.origin.y, originalOfIntrofoLabel.size.width, rect.size.height);
    
    self.infoView.frame = CGRectMake(originalOfInfowView.origin.x, originalOfInfowView.origin.y, originalOfInfowView.size.width, originalOfInfowView.size.height + self.introLabel.frame.size.height - originalOfIntrofoLabel.size.height);
}

- (CGFloat) height
{
    CGFloat height = 2 * self.infoView.frame.origin.y + self.infoView.frame.size.height;
    return height;
}

@end
