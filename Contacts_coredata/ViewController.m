//
//  ViewController.m
//  Contects
//
//  Created by Damian on 2018/4/1.
//  Copyright © 2018年 Damian. All rights reserved.
//


#import "ViewController.h"
#import "Person+CoreDataClass.h"
#import "NewContactViewController.h"
#import "DetailViewController.h"
#import "sort.h"

@interface ViewController () {
    NSManagedObjectContext *context;
    NSArray *objs;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建添加联系人按钮
    UIBarButtonItem* newPersonButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(NewContactButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem=newPersonButton;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    NSError *error = nil;
    
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingString:@"Person.sqlite"]];
    
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    
    if (store == nil) {
        [NSException raise:@"DB Error" format:@"%@", [error localizedDescription]];
    }
    
    context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.persistentStoreCoordinator = psc;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid = %@",@"001"];
//    request.predicate = predicate;
    
    objs = [context executeFetchRequest:request error:&error];
    self.showData = [objs arrayWithPinYinFirstLetterFormat];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.showData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *group = self.showData[section];
    NSArray *array = group[@"content"];
    return [array count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *group = self.showData[section];
    return group[@"firstLetter"];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSDictionary *dict in self.showData) {
        NSString *title = dict[@"firstLetter"];
        [resultArray addObject:title];
    }
    return resultArray;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"CellIdentifier";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    NSDictionary * group = self.showData[section];
    NSArray *array = group[@"content"];
    cell.textLabel.text=[[array objectAtIndex:row] name];
    
    return cell;
}

//新建联系人按钮点击事件
-(void) NewContactButtonPressed:(id)sender{
    NSLog(@"新建联系人");
    NewContactViewController *myNewContactViewController=[[NewContactViewController alloc] init];
    [self.navigationController pushViewController:myNewContactViewController animated:YES];
}

//视图转换时重新加载数据，（生命周期方法）
- (void)viewWillAppear:(BOOL)animated{
    NSError *error = nil;
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingString:@"Person.sqlite"]];
    
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    
    if (store == nil) {
        [NSException raise:@"DB Error" format:@"%@", [error localizedDescription]];
    }    
    context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.persistentStoreCoordinator = psc;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];

    objs = [context executeFetchRequest:request error:&error];
    self.showData = [objs arrayWithPinYinFirstLetterFormat];
    [self.tableView reloadData];
}

//选中联系人事件
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ShowSelectedDetail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSInteger section = indexPath.section;
        NSInteger row = indexPath.row;
        
        DetailViewController *detailViewController = segue.destinationViewController;
        NSDictionary * group = self.showData[section];
        NSArray *array = group[@"content"];
        [[array objectAtIndex:row] name];
        NSString *name = [array[row] name];
        detailViewController.theMan = array[row];
        detailViewController.title = name;
    }
}
@end


