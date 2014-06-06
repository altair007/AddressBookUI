//
//  CFDetaiModel.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-6.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CFPerson;

/**
 *  联系人详情模型类
 */
@interface CFDetaiModel : NSObject
@property (retain, nonatomic) CFPerson * person;
-(instancetype) initWithPerson: (CFPerson *) person;
@end
