//
//  CFDetaiModel.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-6.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFDetaiModel.h"

@implementation CFDetaiModel
-(instancetype) initWithPerson: (CFPerson *) person
{
    if (self = [super init]) {
        self.person = person;
    }
    
    return self;
}
@end
