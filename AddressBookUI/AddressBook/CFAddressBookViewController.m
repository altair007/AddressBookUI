//
//  CFAddressBookViewController.m
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
#import "CFDetaiModel.h"
#import "CFMainViewController.h"

@interface CFAddressBookViewController ()
@end

@implementation CFAddressBookViewController

#pragma mark - 实例方法
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
    CFAddressBookView * addressBookView = [[CFAddressBookView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
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

- (NSArray *) personsInSection: (NSInteger)section
{
    // 获取按姓名首字母分组的字典
    NSDictionary * personsDict = self.addressBookModel.personsByGroups;
    
    // 获取keys数组
    NSArray * keys = personsDict.allKeys;
    
    // keys数组排序
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        return [obj1 compare: obj2];
    }];
    
    // 获取此分区对应的键
    NSString * key = [keys objectAtIndex:section];
    
    // 获取某分区对应的通讯录成员
    NSArray * personsArr = [personsDict objectForKey: key];

    return personsArr;
}

- (CFPerson *)personAtIndexPath:(NSIndexPath *)indexPath
{
    CFPerson * person;
    person = [[self personsInSection: indexPath.section] objectAtIndex: indexPath.row];

    return person;
}

- (NSString *) groupNameInSection: (NSInteger) section
{
    // 获取按姓名首字母分组的字典
    NSDictionary * personsDict = self.addressBookModel.personsByGroups;
    
    // 获取keys数组
    NSArray * keys = personsDict.allKeys;
    
    // keys数组排序
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        return [obj1 compare: obj2];
    }];
    
    // 获取此分区对应的键
    NSString * key = [keys objectAtIndex:section];
    
    return key;
}

-(void)dealloc
{
    self.addressBookModel = nil;
    
    [super dealloc];
}
#pragma mark - UITableViewDataSource协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger  count;
    count = self.addressBookModel.personsByGroups.allKeys.count;
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger  count;
    count = [self personsInSection: section].count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取次分区对应的通讯录成员
    CFPerson * person = [self personAtIndexPath: indexPath];
    
    // ???: 可以更改静态变量的值吗?
    // FIXME: 此处不止一个分区,很明显,不应该再使用同一cell标识符.
    static NSString * identifier = @"person";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    
    // 设置cell属性
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = person.tel;
    cell.imageView.image = [UIImage imageNamed:person.avatar];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * title;
    title = [self groupNameInSection: section];
    return title;
}

#pragma mark - UITableViewDelegate协议方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFMainViewController * mainVC = (CFMainViewController *)self.navigationController;
    
    if (nil == mainVC.detailVC) {
        mainVC.detailVC = [[[CFDetailViewController alloc] init] autorelease];
        mainVC.detailVC.detailModel = [[[CFDetaiModel alloc] init] autorelease];
    }
    
    mainVC.detailVC.detailModel.person = [self personAtIndexPath: indexPath];
    
    [self.navigationController pushViewController:mainVC.detailVC animated: YES];
}


@end
