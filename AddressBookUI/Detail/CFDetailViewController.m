//
//  CFDetailViewController.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFDetailViewController.h"
#import "CFPerson.h"
#import "CFDetailView.h"

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

- (void)loadView
{
    CFDetailView * detailView = [[CFDetailView alloc] init];
    self.view = detailView;
    [detailView release];
}

- (void)viewWillAppear:(BOOL)animated
{    
    CFDetailView * detailView = (CFDetailView *)self.view;
    detailView.avatar.image = [UIImage imageNamed: self.person.name];
    detailView.infoLabel.text = [[[NSString alloc] initWithFormat:@"%@\n%@\n%ld\n%@", self.person.name, self.person.sex, self.person.age, self.person.tel] autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.person.name;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && nil == self.view.window) {
        self.view = nil;
    }
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
