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

@interface CFPersonTableViewCell ()
@property (retain, nonatomic, readwrite) UIImageView * avatarIV; //!< 联系人头像.
@property (retain, nonatomic, readwrite) CFPersonCellInfoView * infoView; //!< 联系人信息
@end

@implementation CFPersonTableViewCell
+ (CGFloat) heightWithPerson: (CFPerson *) aPerson
{
    return 300;
}

-(void)dealloc
{
    self.person = nil;
    self.avatarIV = nil;
    self.infoView = nil;
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // ???: 此处用主屏值,不太妥.
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
    // ???:不应该存在魔数!
    CGFloat landscapeSpace = 30.0; // 头像距离边框的距离
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(landscapeSpace, 15, 80, 120)];
    
    self.avatarIV= imageView;
    [imageView release];
    
    [self addSubview: self.avatarIV];
    
    //头像旁边的几个编辑框
    CFPersonCellInfoView * infoView = [[CFPersonCellInfoView alloc] initWithFrame:CGRectMake(2 * self.avatarIV.frame.origin.x + self.avatarIV.frame.size.width, self.avatarIV.frame.origin.y, rect.size.width - self.avatarIV.frame.size.width - self.avatarIV.frame.origin.x - 2 * self.avatarIV.frame.origin.x, 0)];
    self.infoView = infoView;
    [self addSubview: self.infoView];
    [infoView release];
    
}

-(void)setPerson:(CFPerson *)person
{
    // 设置属性
    [person retain];
    [_person release];
    _person = person;
    
    // 设置视图
    self.avatarIV.image = person.avatarImage;
    
    // ???:此处应该动态设置其高度!根据头像和标签的相对大小.
//    // 设置信息视图的边框.
//    CGRect originalOfInfowView = self.infoView.frame;
    
//    NSDictionary * textDic = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
//    CGRect rect  = [person.intro boundingRectWithSize:CGSizeMake(self.introLabel.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
//    
//    self.introLabel.frame = CGRectMake(originalOfIntrofoLabel.origin.x, originalOfIntrofoLabel.origin.y, originalOfIntrofoLabel.size.width, rect.size.height);
//    
//    self.infoView.frame = CGRectMake(originalOfInfowView.origin.x, originalOfInfowView.origin.y, originalOfInfowView.size.width, originalOfInfowView.size.height + self.introLabel.frame.size.height - originalOfIntrofoLabel.size.height);
}

- (CGFloat) height
{
    // ???: 存在太多魔数,非常不妥!
    CGFloat height = 2 * self.infoView.frame.origin.y + self.infoView.frame.size.height;
    return height;
}

@end
