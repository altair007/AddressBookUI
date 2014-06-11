//
//  CFPersonCellInfoView.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-11.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFPersonCellInfoView.h"
#import "CFPerson.h"

@interface CFPersonCellInfoView ()
@property (retain, nonatomic, readwrite) UILabel * nameLabel; //!< 姓名.
@property (retain, nonatomic, readwrite) UILabel * telLabel; //!< 联系方式.
@property (retain, nonatomic, readwrite) UILabel * introLabel; //!< 简介.
@end

@implementation CFPersonCellInfoView
+ (CGFloat) heightWithPerson: (CFPerson *) aPerson
{
    NSDictionary * textDic = @{NSFontAttributeName: [UIFont systemFontOfSize: DEFAULT_FONT_SIZE]};
    
    CGRect rect  = [aPerson.intro boundingRectWithSize:CGSizeMake(DEFAULT_WIDTH, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];

    CGFloat height = DEFAULT_HEIGHT + rect.size.height;
    
    return height;
}

- (void)dealloc
{
    self.person = nil;
    self.nameLabel = nil;
    self.telLabel = nil;
    self.introLabel = nil;
    
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    // 视图的高度和宽度使用预定义的值.
    CGRect realRect = CGRectMake(frame.origin.x, frame.origin.y, DEFAULT_WIDTH, DEFAULT_HEIGHT);
    
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
        
        // 单独处理"简介"框的框架高度:设为0.0;
        if ([aKey isEqualToString: kIntroLabel]) {
            tempLabel.frame = CGRectMake(tempLabel.frame.origin.x, tempLabel.frame.origin.y, tempLabel.frame.size.width, 0.0);
        }
    
        tempLabel.numberOfLines = 0;
        tempLabel.font = [UIFont systemFontOfSize: DEFAULT_FONT_SIZE];
        
        [self setValue: tempLabel forKey: aKey];
        [self addSubview: tempLabel];
        [tempLabel release];
        
        baseRect = CGRectMake(baseRect.origin.x, baseRect.origin.y + baseRect.size.height, baseRect.size.width, baseRect.size.height);
    }];
    
}

- (CGFloat) height
{
    CGFloat height = [[self class] heightWithPerson: self.person];
    
    return height;
}
- (void)setPerson:(CFPerson *)person
{
    // 设置属性
    [person retain];
    [_person release];
    _person = person;
    
    // 更新视图内容
    [self updateContentOfView];
}

- (void) updateContentOfView
{
    self.nameLabel.text = self.person.name;
    self.telLabel.text = self.person.tel;
    self.introLabel.text = self.person.intro;
    
    // 更新视图边框信息.
    [self updateFrameOfView];
}

- (void)updateFrameOfView
{
    // 更新简介"标签的边框信息
    self.introLabel.frame = CGRectMake(self.introLabel.frame.origin.x, self.introLabel.frame.origin.y, self.introLabel.frame.size.width, self.height - DEFAULT_HEIGHT);
    
    // 更新视图的边框信息
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.height);
}
@end
