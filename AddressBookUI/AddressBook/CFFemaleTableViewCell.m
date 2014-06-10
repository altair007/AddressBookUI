//
//  CFFemaleTableViewCell.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-10.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFFemaleTableViewCell.h"

@implementation CFFemaleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGFloat xOfAvater = self.avatarIV.frame.origin.x;
        CGFloat xOfInfoView = self.infoView.frame.origin.x;
        self.infoView.frame = CGRectMake(xOfAvater, self.infoView.frame.origin.y, self.infoView.frame.size.width, self.infoView.frame.size.height);
        self.avatarIV.frame = CGRectMake(xOfInfoView + self.infoView.frame.size.width - self.avatarIV.frame.size.width, self.avatarIV.frame.origin.y, self.avatarIV.frame.size.width, self.avatarIV.frame.size.height);
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
