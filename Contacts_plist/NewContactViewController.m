//
//  NewContactViewController.m
//  Contacts
//
//  Created by Cocout on 2018/4/1.
//  Copyright © 2018年 Damian. All rights reserved.
//

#import "NewContactViewController.h"

@interface NewContactViewController ()<UITextFieldDelegate>{
}

@end

@implementation NewContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.boxpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/Contacts.plist"];
    self.boxdic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.boxpath];
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
    
    [self.boxdic setValue:@{@"UUID":uid,@"Name":name.text,@"Email":url.text,@"PhoneNumber":phone.text} forKey:uid];
    //写入box
    [self.boxdic writeToFile:self.boxpath atomically:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return TRUE;
}


@end

