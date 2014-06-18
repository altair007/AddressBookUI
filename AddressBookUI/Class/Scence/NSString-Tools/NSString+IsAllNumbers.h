//
//  NSString+IsAllNumbers.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-13.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IsAllNumbers)
/**
 *  判断一个字符串是否全部是数字:0~9.
 *
 *  @param str 要判断的字符串.
 *
 *  @return 如果只含有0~9以外的字符,返回YES;str为nil或者空串,或者含有0~9以外的字符,返回NO.
 */
- (BOOL) isAllNumbers;
@end
