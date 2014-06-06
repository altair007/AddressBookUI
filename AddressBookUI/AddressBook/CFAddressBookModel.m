//
//  CFAddressBookModel.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-6.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFAddressBookModel.h"
#import "CFPerson.h"

@implementation CFAddressBookModel
#pragma mark - 实例方法
- (instancetype)initWithFile:(NSString *)path
{
    if (self = [super init]) {
        self.pathOfData = path;
        
        self.persons = [NSKeyedUnarchiver unarchiveObjectWithFile: self.pathOfData];
        
        if (nil == self.persons) {
            return nil;
        }
    }
    
    return self;
}

- (BOOL) update
{
    BOOL result = [NSKeyedArchiver archiveRootObject: self.persons toFile: self.pathOfData];
    
    return result;
}

-(void)dealloc
{
    self.persons = nil;
    self.pathOfData = nil;
    
    [super dealloc];
}
@end
