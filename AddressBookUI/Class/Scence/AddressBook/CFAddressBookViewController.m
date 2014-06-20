//
//  CFAddressBookViewController.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFAddressBookViewController.h"
#import "CFAddressBookModel.h"
#import "CFPerson.h"
#import "CFPersonTableViewCell.h"
#import "CFMaleTableViewCell.h"
#import "CFFemaleTableViewCell.h"
#import "RIButtonItem.h"
#import "UIActionSheet+Blocks.h"
#import "CFEditPersonViewController.h"
#import "CFAddPersonViewController.h"

@interface CFAddressBookViewController ()
@property (retain, nonatomic, readwrite) CFEditPersonViewController * editPersonVC; //!< 编辑联系人页面视图控制器
@end

@implementation CFAddressBookViewController
#pragma mark - 实例方法.

-(void)dealloc
{
    // 将自身从联系人模型的观察者中移除.
    [[CFAddressBookModel sharedInstance] removeObserver: self forKeyPath:@"persons"];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // 添加自身为联系人模型的观察者.
        [[CFAddressBookModel sharedInstance] addObserver: self forKeyPath:@"persons" options:    NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
        
        CFEditPersonViewController * editPersonVC = [[CFEditPersonViewController alloc] init];
        self.editPersonVC = editPersonVC;
        [editPersonVC release];
    }
    
    return self;
}

- (void)loadView
{
    CFAddressBookView * addressBookView = [[CFAddressBookView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    [addressBookView registerClass:[CFMaleTableViewCell class] forCellReuseIdentifier:@"male"];
    [addressBookView registerClass:[CFFemaleTableViewCell class] forCellReuseIdentifier:@"female"];
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
    NSDictionary * personsDict = [[CFAddressBookModel sharedInstance] persons];
    
    NSString * groupName = [self groupNameInSection: section];
    
    // 获取某分区对应的通讯录成员
    NSArray * personsArr = [personsDict objectForKey: groupName];

    return personsArr;
}

- (CFPerson *)personAtIndexPath:(NSIndexPath *)indexPath
{
    CFPerson * person;
    NSArray * persons = [self personsInSection: indexPath.section];
    person = persons[indexPath.row];

    return person;
}

- (NSString *) groupNameInSection: (NSInteger) section
{
    // 获取此分区对应的组名
    NSString * groupName = [self.groups objectAtIndex:section];
    
    return groupName;
}

- (void) didClickAddButtonItem: (UIBarButtonItem *) aButtonItem
{
    CFAddPersonViewController * addPersonVC = [[CFAddPersonViewController alloc] init];
    [self.navigationController pushViewController: addPersonVC animated:YES];
}

- (void) switchToEditViewWithPerson: (CFPerson *) aPerson
                            editing: (BOOL) editing
{
    self.editPersonVC.person = aPerson;
    [self.editPersonVC setEditing: editing animated: YES];
    [self.navigationController pushViewController: self.editPersonVC animated:YES];
}

- (NSArray *) groups
{
    // 获取按姓名首字母分组的字典
    NSDictionary * personsDict = [[CFAddressBookModel sharedInstance] persons];
    
    // 获取keys数组
    NSArray * groups = personsDict.allKeys;

    groups = [groups sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        return [obj1 compare: obj2];
    }];
    
    return groups;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self.view reloadData];
}

#pragma mark - UITableViewDataSource协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger  count;
    count = [CFAddressBookModel sharedInstance].persons.allKeys.count;
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
    // 获取此分区对应的通讯录成员
    CFPerson * person = [self personAtIndexPath: indexPath];
    
    if (NO == person.sex) {
        static NSString * identifierOfMale = @"male";
        CFMaleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierOfMale forIndexPath:indexPath];
        
        // 设置cell属性
        cell.person = person;
        return cell;
    }
    
    static NSString * identifierOfFemale = @"female";
    CFFemaleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierOfFemale forIndexPath: indexPath];

    // 设置cell属性
    cell.person = person;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * title;
    title = [self groupNameInSection: section];
    return title;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return  self.groups;
}

#pragma mark - UITableViewDelegate协议方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFPerson * person= [self personAtIndexPath: indexPath];
    
    // !!!:等待替代方案!
    //TODO: 迭代到这!
//    [[CFMainController sharedInstance] switchToPersonDetailViewWithPerson: person];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        // 获取要操作的数据.
        CFPerson * person = [self personAtIndexPath: indexPath];
        
        // 是不是用户的误操作?
        RIButtonItem * cancelItem = [RIButtonItem itemWithLabel:@"取消"
                                        action:^{/* 不做任何操作 */}];
        RIButtonItem * deleteItem = [RIButtonItem itemWithLabel: @"确定"
                                                         action:^{            //删除联系人                            
             // 删除数据
             [[CFAddressBookModel sharedInstance] removePersonWithTel: person.tel];
                                                         }];
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:[NSString    stringWithFormat:@"确定删除联系人 %@ ?", person.name]
                                                          cancelButtonItem:cancelItem
                                                     destructiveButtonItem:deleteItem otherButtonItems: nil];
        [actionSheet showInView: self.view];
        [actionSheet release];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CFPerson * person = [self personAtIndexPath: indexPath]; // 联系人

    CGFloat height = 0.0; // 行高
    
    // 不同性别的人行高可能不同.
    if (NO == person.sex) {
        height = [CFMaleTableViewCell heightWithPerson: person];
        
        return height;
    }
    
    height = [CFFemaleTableViewCell heightWithPerson: person];
    
    return height;
}
@end
