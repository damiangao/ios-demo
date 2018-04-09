//
//  NewContactViewController.m
//  Contacts
//
//  Created by Cocout on 2018/4/1.
//  Copyright © 2018年 Damian. All rights reserved.
//

#import "NewContactViewController.h"
#import "Person+CoreDataClass.h"

@interface NewContactViewController ()<UITextFieldDelegate>{
    NSManagedObjectContext *context;
}

@end

@implementation NewContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screen=[[UIScreen mainScreen] bounds];
    
    self.view.backgroundColor=[UIColor whiteColor];

    //创建NavifationBarItems
    UIBarButtonItem* checkButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(SaveButtonPressed:)];

    self.navigationItem.title=@"New Contact";
    self.navigationItem.rightBarButtonItem=checkButton;

    
 
    //表单
    UILabel *NameLable=[[UILabel alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    NameLable.text=@"Name";
    [self.view addSubview:NameLable];
    UILabel *PhoneLable=[[UILabel alloc] initWithFrame:CGRectMake(50, 225, 50, 50)];
    PhoneLable.text=@"Phone";
    [self.view addSubview:PhoneLable];
    UILabel *EmailLable=[[UILabel alloc] initWithFrame:CGRectMake(50, 350, 50, 50)];
    EmailLable.text=@"Email";
    [self.view addSubview:EmailLable];

    UITextField *NameFiled=[[UITextField alloc] initWithFrame:CGRectMake(50, 150, screen.size.width-100, 50)];
    NameFiled.borderStyle=UITextBorderStyleRoundedRect;
    [NameFiled setTag:1];
    NameFiled.delegate=self;
    [self.view addSubview:NameFiled];

    UITextField *EmailField=[[UITextField alloc] initWithFrame:CGRectMake(50, 275, screen.size.width-100, 50)];
    EmailField.borderStyle=UITextBorderStyleRoundedRect;
    [EmailField setTag:2];
    EmailField.delegate=self;
    [self.view addSubview:EmailField];

    UITextField *PhoneField=[[UITextField alloc] initWithFrame:CGRectMake(50, 400, screen.size.width-100, 50)];
    PhoneField.borderStyle=UITextBorderStyleRoundedRect;
    [PhoneField setTag:3];
    PhoneField.delegate=self;
    [self.view addSubview:PhoneField];
    
    //CoreData
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回
-(void) backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存
-(void) SaveButtonPressed:(id)sender{
    UITextField *name = [self.view viewWithTag:1];
    UITextField *phone = [self.view viewWithTag:2];
    UITextField *url = [self.view viewWithTag:3];
    NSLog(@"%@",name);
    if(name==nil){
        [self.navigationController popViewControllerAnimated:YES];
    }
    NSString *uid = [NSUUID UUID].UUIDString;
    NSManagedObject *s = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    [s setValue:name.text forKey:@"name"];
    [s setValue:uid forKey:@"uid"];
    [s setValue:url.text forKey:@"url"];
    [s setValue:phone.text forKey:@"phone"];
    
    NSError *error = nil;
    
    if ([context save:&error]) {
        NSLog(@"Succeed!");
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [NSException raise:@"插入错误" format:@"%@", [error localizedDescription]];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return TRUE;
}


@end

