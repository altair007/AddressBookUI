//
//  CFAddPersonView.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-8.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFAddPersonView.h"

@interface CFAddPersonView ()
@property (retain, nonatomic, readwrite) NSString * nameOfdefaultImg; //!< 默认显示的图片
@property (retain, nonatomic, readwrite) UIImageView * avatar; //!< 相片视图.
@property (retain, nonatomic, readwrite) UITextField * nameTF; //!< 姓名编辑框
@property (retain, nonatomic, readwrite) UITextField * sexTF; //!< 性别编辑框
@property (retain, nonatomic, readwrite) UITextField * ageTF; //!< 年龄编辑框
@property (retain, nonatomic, readwrite) UITextField * telTF; //!< 联系方式编辑框
@end
@implementation CFAddPersonView

-(void)dealloc
{
    self.nameOfdefaultImg = nil;
    self.avatar = nil;
    self.nameTF = nil;
    self.sexTF = nil;
    self.ageTF = nil;
    self.telTF = nil;
    
    [super dealloc];
}

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

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (nil == self.avatar) { // 初始化
        // 头像
        CGFloat landscapeSpace = 30.0; // 头像距离边框的距离
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(landscapeSpace, 100, 80, 120)];
        
        self.avatar= imageView;
        [imageView release];
        
        [self addSubview: self.avatar];
        
        //几个编辑框
        CGFloat portraitSpace = landscapeSpace / 3; // 编辑框竖直方向的间距
        
        NSArray * placeHolders = @[@"请输入姓名", @"请输入性别", @"请输入年龄", @"请输入联系方式"];
        
        __block CGRect baseRect = CGRectMake(2 * self.avatar.frame.origin.x + self.avatar.frame.size.width, self.avatar.frame.origin.y, self.frame.size.width - self.avatar.frame.size.width - self.avatar.frame.origin.x - 2 * self.avatar.frame.origin.x, (self.avatar.frame.size.height - portraitSpace * 3) / 4);
        
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
                self.ageTF = tempTF;
            }
            
            if ([placeHolder isEqualToString: @"请输入联系方式"]) {
                self.telTF = tempTF;
            }
            
            [self addSubview: tempTF];
            
            [tempTF release];
            
            baseRect = CGRectMake(baseRect.origin.x, baseRect.origin.y + baseRect.size.height + portraitSpace, baseRect.size.width, baseRect.size.height);
        }];
    }
    
    // 恢复默认设置
    self.avatar.image = [UIImage imageNamed: self.nameOfdefaultImg];
    
    self.nameTF.text = @"";
    self.sexTF.text = @"";
    self.ageTF.text = @"";
    self.telTF.text = @"";
    
}


@end
