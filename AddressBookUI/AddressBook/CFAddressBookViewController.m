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
#import "CFMainViewController.h"
#import "CFEditPersonViewController.h"

@interface CFAddressBookViewController ()
@end

static CFAddressBookViewController * sharedObj = nil;
@implementation CFAddressBookViewController
+ (instancetype) sharedInstance
{
    @synchronized(self)
    {
        if (nil == sharedObj) {
            [[self alloc] init];
        }
    }
    
    return sharedObj;
}

+ (instancetype) allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self){
        if (nil == sharedObj) {
            sharedObj = [super allocWithZone:zone];
            return sharedObj;
        }
    }
    return nil;
}

- (instancetype) copyWithZone: (NSZone *) zone
{
    return  self;
}

- (instancetype)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return UINT_MAX;
}

- (oneway void)release
{
    
}

- (instancetype) autorelease
{
    return self;
}

- (id)init
{
    @synchronized(self){
        self = [self initWithNibName:nil bundle:nil];
        return self;
    }
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
    CFAddressBookView * addressBookView = [[CFAddressBookView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    addressBookView.dataSource = self;
    addressBookView.delegate = self;
    self.view = addressBookView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view
    // 设置标题
    self.navigationItem.title = @"通讯录";
    
    // 设置"添加"按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didClickAddButtonItem:)];
    
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
    NSDictionary * personsDict = ((CFMainViewController *)self.navigationController).model.personsByGroups;
    
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
    NSDictionary * personsDict = ((CFMainViewController *)self.navigationController).model.personsByGroups;
    
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

- (void) didClickAddButtonItem: (UIBarButtonItem *) aButtonItem
{
    CFPerson * person = [[CFPerson alloc] init];
    [self switchToEditViewWithData: person editing: YES];
    [person release];
}

- (void) switchToEditViewWithData: (CFPerson *) aPerson
                          editing: (BOOL) editing
{
    CFEditPersonViewController * editPersonVC = [CFEditPersonViewController sharedInstance];
    editPersonVC.person = aPerson;
    [editPersonVC setEditing: editing animated: YES];
    [self.navigationController pushViewController: editPersonVC animated:YES];
    
}

-(void)dealloc
{
    
    [super dealloc];
}

#pragma mark - UITableViewDataSource协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger  count;
    count = ((CFMainViewController *)self.navigationController).model.personsByGroups.allKeys.count;
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
    
    static NSString * identifier = @"person";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    
    // 设置cell属性
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = person.tel;
    cell.imageView.image = person.avatarImage;
    
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
    CFPerson * person= [self personAtIndexPath: indexPath];
    [self switchToEditViewWithData: person editing: NO];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        // 先获取此分区所有成员
        NSArray * personsArray = [self personsInSection: indexPath.section];
        
        // 删除数据
        [((CFMainViewController *)self.navigationController).model removePerson: [self personAtIndexPath: indexPath]];
        
        // 根据分区成员数量来决定是删除行,还是直接删除分区
        if (1 == personsArray.count) { // 可以直接删除分区了
            [tableView deleteSections:[NSIndexSet indexSetWithIndex: indexPath.section] withRowAnimation: UITableViewRowAnimationAutomatic];
        }else{ // 只删除行
            [tableView deleteRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
        }
    }
}

@end
