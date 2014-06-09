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
@property (retain, nonatomic, readwrite) UIImageView * avatarView; //!< 相片视图.
@property (retain, nonatomic, readwrite) UITextField * nameTF; //!< 姓名编辑框
@property (retain, nonatomic, readwrite) UITextField * sexTF; //!< 性别编辑框
@property (retain, nonatomic, readwrite) UITextField * ageTF; //!< 年龄编辑框
@property (retain, nonatomic, readwrite) UITextField * telTF; //!< 联系方式编辑框
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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (nil == self.avatarView) { // 初始化
        // 头像
        CGFloat landscapeSpace = 30.0; // 头像距离边框的距离
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(landscapeSpace, 100, 80, 120)];
        imageView.image = [UIImage imageNamed: self.person.nameOfdefaultImg];
        self.avatarView= imageView;
        [imageView release];
        
        [self addSubview: self.avatarView];
        
        // 给头像视图添加手势
        self.avatarView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self.delegate action:@selector(handlAvatarViewTapGesture:)];
        
        [self.avatarView addGestureRecognizer: tapGesture];
        [tapGesture release];
        
        
        //几个编辑框
        CGFloat portraitSpace = landscapeSpace / 3; // 编辑框竖直方向的间距
        
        NSArray * placeHolders = @[@"请输入姓名", @"请输入性别", @"请输入年龄", @"请输入联系方式"];
        
        __block CGRect baseRect = CGRectMake(2 * self.avatarView.frame.origin.x + self.avatarView.frame.size.width, self.avatarView.frame.origin.y, self.frame.size.width - self.avatarView.frame.size.width - self.avatarView.frame.origin.x - 2 * self.avatarView.frame.origin.x, (self.avatarView.frame.size.height - portraitSpace * 3) / 4);
        
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

- (void) reset
{
//    self.avatarView.image = [UIImage imageNamed: self.person.nameOfdefaultImg];
//    
//    self.nameTF.text = @"";
//    self.sexTF.text = @"";
//    self.ageTF.text = @"";
//    self.telTF.text = @"";
}

- (void)setPerson:(CFPerson *)person
{
    [person retain];
    [_person release];
    _person = person;
    
    self.avatarView.image = self.person.avatarImage;
    self.nameTF.text = self.person.name;
    self.sexTF.text = self.person.sex;
    self.ageTF.text = [NSString stringWithFormat: @"%ld", self.person.age];
    self.telTF.text = self.person.tel;
}
@end