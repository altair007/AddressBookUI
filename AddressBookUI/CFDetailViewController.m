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
#import "CFDetaiModel.h"

@interface CFDetailViewController ()

@end

@implementation CFDetailViewController

- (void)dealloc
{
    self.detailModel = nil;
    
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
    detailView.avatar.image = [UIImage imageNamed: self.detailModel.person.name];
    detailView.infoLabel.text = [[[NSString alloc] initWithFormat:@"%@\n%@\n%ld\n%@", self.detailModel.person.name, self.detailModel.person.sex, self.detailModel.person.age, self.detailModel.person.tel] autorelease];
    
    self.view = detailView;
    [detailView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.detailModel.person.name;
    
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
