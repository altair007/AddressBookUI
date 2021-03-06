//
//  CFEditPersonView.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-9.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFEditPersonView.h"
#import "CFEditPersonViewController.h"
#import "CFPerson.h"
#import "UIImage+AssetUrl.h"
#import "CFAvatarView.h"

@interface CFEditPersonView ()
@property (retain, nonatomic, readwrite) CFAvatarView * avatarView; //!< 相片视图.
@property (retain, nonatomic, readwrite) UITextField * nameTF; //!< 姓名编辑框
@property (retain, nonatomic, readwrite) UITextField * sexTF; //!< 性别编辑框
@property (retain, nonatomic, readwrite) UITextField * ageTF; //!< 年龄编辑框
@property (retain, nonatomic, readwrite) UITextField * telTF; //!< 联系方式编辑框
@property (retain, nonatomic, readwrite) UITextView * introTV; //!< 简介编辑
@end

@implementation CFEditPersonView
-(void)dealloc
{
    self.person = nil;
    self.avatarView = nil;
    self.nameTF = nil;
    self.sexTF = nil;
    self.ageTF = nil;
    self.telTF = nil;
    
    [super dealloc];
}

- (instancetype) initWithFrame:(CGRect)frame
{
    return [self initWithFrame: frame delegate: nil];
}

- (instancetype) initWithFrame: (CGRect)frame
                      delegate: (id) delegate
{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.delegate = delegate;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    
    // 头像
    CGFloat landscapeSpace = 30.0; // 头像距离边框的距离
    
    CFAvatarView * avatarView = [[CFAvatarView alloc] initWithFrame:CGRectMake(landscapeSpace, 100, 80, 120)];
    self.avatarView= avatarView;
    [avatarView release];
    
    [self addSubview: self.avatarView];
    
    // 给头像视图添加手势
    self.avatarView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self.delegate action:@selector(handlAvatarViewTapGesture:)];
    
    [self.avatarView addGestureRecognizer: tapGesture];
    [tapGesture release];
    
    
    //头像左边的几个编辑框
    NSArray * placeHolders = @[@"请输入姓名", @"请输入性别", @"请输入年龄", @"请输入联系方式"];
    
    CGFloat portraitSpace = landscapeSpace / (placeHolders.count - 1); // 编辑框竖直方向的间距
    
    __block CGRect baseRect = CGRectMake(2 * self.avatarView.frame.origin.x + self.avatarView.frame.size.width, self.avatarView.frame.origin.y, self.frame.size.width - self.avatarView.frame.size.width - self.avatarView.frame.origin.x - 2 * self.avatarView.frame.origin.x, (self.avatarView.frame.size.height - portraitSpace * (placeHolders.count - 1)) / placeHolders.count);
    
    [placeHolders enumerateObjectsUsingBlock:^(NSString * placeHolder, NSUInteger idx, BOOL *stop) {
        UITextField * tempTF = [[UITextField alloc] initWithFrame:baseRect];
        tempTF.placeholder = placeHolder;
        tempTF.borderStyle = UITextBorderStyleRoundedRect;
        tempTF.delegate = self.delegate;
        
        if ([placeHolder isEqualToString: @"请输入姓名"]) {
            self.nameTF = tempTF;
        }
        
        if ([placeHolder isEqualToString: @"请输入性别"]) {
            self.sexTF = tempTF;
        }
        
        if ([placeHolder isEqualToString: @"请输入年龄"]) {
            tempTF.keyboardType = UIKeyboardTypeNumberPad;
            self.ageTF = tempTF;
        }
        
        if ([placeHolder isEqualToString: @"请输入联系方式"]) {
            tempTF.keyboardType = UIKeyboardTypeNumberPad;
            self.telTF = tempTF;
        }
        
        [self addSubview: tempTF];
        
        [tempTF release];
        
        baseRect = CGRectMake(baseRect.origin.x, baseRect.origin.y + baseRect.size.height + portraitSpace, baseRect.size.width, baseRect.size.height);
    }];
    
    // 个人简介编辑框
    CGRect rectOfIntro = CGRectMake(self.avatarView.frame.origin.x, self.avatarView.frame.origin.y + self.avatarView.frame.size.height + portraitSpace, self.frame.size.width - 2 * self.avatarView.frame.origin.x, self.frame.size.height - self.avatarView.frame.size.height - self.avatarView.frame.origin.y - 2 * portraitSpace);
    UITextView * introTV = [[UITextView alloc] initWithFrame: rectOfIntro];
    introTV.backgroundColor = [UIColor lightGrayColor];
    self.introTV = introTV;
    [self addSubview: introTV];
    [introTV release];
}

- (void)setPerson:(CFPerson *)person
{
    // 设置属性.
    [person retain];
    [_person release];
    _person = person;
    
    // 设置视图内容.
    if (nil != person) {
        self.avatarView.avatarName = self.person.avatar;
        self.nameTF.text = self.person.name;
        self.sexTF.text = (NO == self.person.sex) ? @"男": @"女";
        self.ageTF.text = [NSString stringWithFormat:@"%lu", self.person.age];
        self.telTF.text = self.person.tel;
        self.introTV.text = self.person.intro;
    }
}
@end