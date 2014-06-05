//
//  CFMainViewController.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFMainViewController.h"
#import "Person.h"
#import "CFDetailViewController.h"

@interface CFMainViewController ()

@end

@implementation CFMainViewController

-(void)dealloc
{
    self.persons = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // FIXME: 应该由单独的model类来提供数据.
        self.persons = [[[NSMutableArray alloc] initWithCapacity: 42] autorelease];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#pragma mark - 数据区
    for (int i = 0; i < 30; i++) {
        Person * person = [[Person alloc] initWithName: @"颜风" avatar:@"颜风.png" sex:@"男" age:21 tel:@"18238802518"];
        [self.persons addObject:person];
        
        [person release];
    }

    self.navigationItem.title = @"通讯录";

    UITableView * addressBookVT = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    addressBookVT.dataSource = self;
    addressBookVT.delegate = self;
    [self.view addSubview: addressBookVT];
    
    [addressBookVT release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && nil == self.view.window) {
        self.view = nil;
    }
    
}

#pragma mark - 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"person";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    Person * person = [self.persons objectAtIndex: indexPath.row];
    cell.textLabel.text = person.name;
    cell.imageView.image = [UIImage imageNamed:person.avatar];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFDetailViewController * detailVC = [[CFDetailViewController alloc] init];
    detailVC.person = [self.persons objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated: YES];
}
@end
