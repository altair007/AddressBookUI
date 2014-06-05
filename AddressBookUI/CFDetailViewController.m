//
//  CFDetailViewController.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFDetailViewController.h"
#import "person.h"

@interface CFDetailViewController ()

@end

@implementation CFDetailViewController

- (void)dealloc
{
    self.person = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.person.name;
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.person.avatar]];
    // !!!:位置信息,不应该写死!
    imageView.frame = CGRectMake(0, 100, 100, 100);
    [self.view addSubview: imageView];
    [imageView release];
    
    // !!!: 位置信息,不应该写死!
    UILabel * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, 100, 100)];
    infoLabel.numberOfLines = 0;
    infoLabel.adjustsFontSizeToFitWidth = YES;
    infoLabel.text = [[[NSString alloc] initWithFormat:@"%@\n%@\n%ld\n%@", self.person.name, self.person.sex, self.person.age, self.person.tel] autorelease];
    [self.view addSubview:infoLabel];
    [infoLabel release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
