//
//  CFDetailView.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-6.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFPerson;

/**
 *  联系人详细信息视图
 */
@interface CFDetailView : UIView
@property (retain ,nonatomic) CFPerson * person; //!< 联系人
@property (retain, nonatomic, readonly) UIImageView * avatar; //!< 头像.
@property (retain, nonatomic, readonly) UILabel * infoLabel; //!< 练习人详细信息.

@end
