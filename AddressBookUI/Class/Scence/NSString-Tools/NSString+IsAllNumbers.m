//
//  NSString+IsAllNumbers.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-13.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "NSString+IsAllNumbers.h"

@implementation NSString (IsAllNumbers)
- (BOOL) isAllNumbers
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self MATCHES '^[0-9]+$'"];
    
    BOOL result = [predicate evaluateWithObject: self];
    
    return result;
}
@end
