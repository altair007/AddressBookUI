//
//  CFMainViewController.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFAddressBookViewController.h"
#import "CFAddressBookModel.h"
#import "CFAddressBookView.h"
#import "CFPerson.h"
#import "CFDetailViewController.h"

@interface CFAddressBookViewController ()

@end

@implementation CFAddressBookViewController

#pragma mark - 实例方法
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // 初始化模型
        NSString * path;
        path = [NSBundle pathForResource:@"addressBookData" ofType: nil inDirectory:[NSBundle mainBundle].bundlePath];
        CFAddressBookModel * addressBookModel = [[CFAddressBookModel alloc] initWithFile:path];
        self.addressBookModel = addressBookModel;
        [addressBookModel release];
        
    }
    
    return self;
}

- (void)loadView
{
    CFAddressBookView * addressBookView = [[CFAddressBookView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    addressBookView.dataSource = self;
    addressBookView.delegate = self;
    self.view = addressBookView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.navigationItem.title = @"通讯录";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && nil == self.view.window) {
        self.view = nil;
    }
    
}

-(void)dealloc
{
    self.addressBookModel = nil;
    
    [super dealloc];
}
#pragma mark - UITableViewDataSource协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressBookModel.persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"person";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    CFPerson * person = [self.addressBookModel.persons objectAtIndex: indexPath.row];
    cell.textLabel.text = person.name;
    cell.imageView.image = [UIImage imageNamed:person.avatar];
    
    return cell;
}

#pragma mark - UITableViewDelegate协议方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFDetailViewController * detailVC = [[CFDetailViewController alloc] init];
    detailVC.person = [self.addressBookModel.persons objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated: YES];
}


@end
