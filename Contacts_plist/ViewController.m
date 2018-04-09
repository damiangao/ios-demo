//
//  ViewController.m
//  Contects
//
//  Created by Damian on 2018/4/1.
//  Copyright © 2018年 Damian. All rights reserved.
//


#import "ViewController.h"
#import "NewContactViewController.h"
#import "DetailViewController.h"
#import "sort.h"

@interface ViewController () {
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myUserDefaults=[NSUserDefaults standardUserDefaults];
    
    NSBundle *bundle=[NSBundle mainBundle];
    
    //字典路径
    NSString *plistPath=[bundle pathForResource:@"Contacts"ofType:@"plist"];
    //数据字典
    self.dict=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    //沙盒
    self.boxpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/Contacts.plist"];
    [self.dict writeToFile:self.boxpath atomically:YES];
    
    //沙盒中的字典
    self.boxdic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.boxpath];
    self.demoArray=[self.boxdic allValues];
    NSLog(@"%@",self.demoArray);
    //按首拼音排序
    self.demoArray = [self.demoArray arrayWithPinYinFirstLetterFormat];
//        NSLog(@"%@",self.demoArray);
    //创建添加联系人按钮
    UIBarButtonItem* newPersonButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(NewContactButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem=newPersonButton;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.demoArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dict = self.demoArray[section];
    NSMutableArray *array = dict[@"content"];
    return [array count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dict = self.demoArray[section];
    NSString *title = dict[@"firstLetter"];
    return title;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSDictionary *dict in self.demoArray) {
        NSString *title = dict[@"firstLetter"];
        [resultArray addObject:title];
    }
    return resultArray;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"CellIdentifier";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *dict = self.demoArray[indexPath.section];
    NSMutableArray *array = dict[@"content"];
    cell.textLabel.text=[[array objectAtIndex:[indexPath row] ] objectForKey:@"Name"];
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
    self.boxdic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.boxpath];
    self.demoArray=[self.boxdic allValues];
    self.demoArray = [self.demoArray arrayWithPinYinFirstLetterFormat];
    NSLog(@"%@",self.demoArray);
    [self.tableView reloadData];
}

//选中联系人事件
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ShowSelectedDetail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *dict = self.demoArray[indexPath.section];
        NSMutableArray *array = dict[@"content"];
        
        DetailViewController *detailViewController = segue.destinationViewController;

        NSString *name = [array[indexPath.row] valueForKey:@"Name"];
        detailViewController.theMan = array[indexPath.row];
        detailViewController.title = name;
    }
}
@end


