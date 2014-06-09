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

@interface CFEditPersonView ()
@property (retain, nonatomic, readwrite) UIImageView * avatarImageView; //!< 相片视图.
@property (retain, nonatomic, readwrite) UITextField * nameTF; //!< 姓名编辑框
@property (retain, nonatomic, readwrite) UITextField * sexTF; //!< 性别编辑框
@property (retain, nonatomic, readwrite) UITextField * ageTF; //!< 年龄编辑框
@property (retain, nonatomic, readwrite) UITextField * telTF; //!< 联系方式编辑框
@end

@implementation CFEditPersonView
-(void)dealloc
{
    self.person = nil;
    self.avatarImageView = nil;
    self.nameTF = nil;
    self.sexTF = nil;
    self.ageTF = nil;
    self.telTF = nil;
    
    [super dealloc];
}

- (instancetype) initWithFrame: (CGRect)frame
                      delegate: (id) delegate
{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.delegate = delegate;
        [self setupSubviews: frame];
    }
    return self;
}

- (void)setupSubviews: (CGRect) rect
{
    if (nil == self.avatarImageView) { // 初始化
        self.backgroundColor = [UIColor whiteColor];
        
        // 头像
        CGFloat landscapeSpace = 30.0; // 头像距离边框的距离
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(landscapeSpace, 100, 80, 120)];
        self.avatarImageView= imageView;
        [imageView release];
        
        [self addSubview: self.avatarImageView];
        
        // 给头像视图添加手势
        self.avatarImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self.delegate action:@selector(handlAvatarViewTapGesture:)];
        
        [self.avatarImageView addGestureRecognizer: tapGesture];
        [tapGesture release];
        
        
        //几个编辑框
        CGFloat portraitSpace = landscapeSpace / 3; // 编辑框竖直方向的间距
        
        NSArray * placeHolders = @[@"请输入姓名", @"请输入性别", @"请输入年龄", @"请输入联系方式"];
        
        __block CGRect baseRect = CGRectMake(2 * self.avatarImageView.frame.origin.x + self.avatarImageView.frame.size.width, self.avatarImageView.frame.origin.y, rect.size.width - self.avatarImageView.frame.size.width - self.avatarImageView.frame.origin.x - 2 * self.avatarImageView.frame.origin.x, (self.avatarImageView.frame.size.height - portraitSpace * 3) / 4);
        
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
    }
}

- (void)setPerson:(CFPerson *)person
{
    [person retain];
    [_person release];
    _person = person;
    
    self.avatarImageView.image = self.person.avatarImage;
    self.nameTF.text = self.person.name;
    self.sexTF.text = self.person.sex;
    self.ageTF.text = [NSString stringWithFormat: @"%ld", self.person.age];
    self.telTF.text = self.person.tel;
    
    if (YES == self.ageTF.enabled && 0 == person.age) {
        self.ageTF.text = @"";
    }
}

@end