//
//  DetailViewController.m
//  Contacts
//
//  Created by Cocout on 2018/4/1.
//  Copyright © 2018年 Damian. All rights reserved.
//

#import "DetailViewController.h"

#import "AppDelegate.h"

@interface DetailViewController (){
}


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置信息
    self.contact = [self.theMan valueForKey:@"Name"];
    self.uid = [self.theMan valueForKey:@"UUID"];
    self.url=[self.theMan valueForKey:@"Email"];
    self.tel=[self.theMan valueForKey:@"PhoneNumber"];
    [self.name setTitle:self.contact forState:UIControlStateNormal];
    [self.phone setTitle:self.tel forState:UIControlStateNormal];
    [self.email setTitle:self.url forState:UIControlStateNormal];
    
    self.boxpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/Contacts.plist"];
    self.boxdic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.boxpath];
    
    self.myUserDefaults=[NSUserDefaults standardUserDefaults];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return TRUE;
}

//删除联系人
- (IBAction)DeleteButtonOressed:(id)sender {
    [self.boxdic removeObjectForKey:self.uid];
    [self.boxdic writeToFile:self.boxpath atomically:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}
//detail内容点击
//名字
- (IBAction)NamePressed:(id)sender {
    UIAlertController* actionSheetController = [[UIAlertController alloc]init];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        NSLog(@"cancel");
    }];
    UIAlertAction* Edit = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action)
        {
            NSLog(@"edit");
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Edit" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            //在AlertView中添加输入框
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"Input name,please.";
            }];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
                
                [self.boxdic setValue:@{@"UUID":self.uid,@"Email":self.url,@"PhoneNumber":self.tel,@"Name":envirnmentNameTextField.text} forKey:self.uid];
                [self.boxdic writeToFile:self.boxpath atomically:YES];
                self.title = envirnmentNameTextField.text;
                self.contact = envirnmentNameTextField.text;
                [self.name setTitle:envirnmentNameTextField.text forState:UIControlStateNormal];
                
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alertController animated:true completion:nil];
    }];

    [actionSheetController addAction:cancelAction];
    [actionSheetController addAction:Edit];
    
    [self presentViewController:actionSheetController animated:YES completion:nil];
}
//电话
- (IBAction)PhonePressed:(id)sender {
    UIAlertController* actionSheetController = [[UIAlertController alloc]init];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        NSLog(@"cancel");
    }];
    UIAlertAction* Call = [UIAlertAction actionWithTitle:@"Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"call");
    }];
    UIAlertAction* Edit = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        NSLog(@"edit");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Edit" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        //在AlertView中添加输入框
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"Input phone,please.";
        }];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
            
            [self.boxdic setValue:@{@"UUID":self.uid,@"Email":self.url,@"PhoneNumber":envirnmentNameTextField.text,@"Name":self.contact} forKey:self.uid];
            [self.boxdic writeToFile:self.boxpath atomically:YES];
            self.tel = envirnmentNameTextField.text;
            [self.phone setTitle:envirnmentNameTextField.text forState:UIControlStateNormal];

        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alertController animated:true completion:nil];
    }];
    
    [actionSheetController addAction:cancelAction];
        [actionSheetController addAction:Edit];
    [actionSheetController addAction:Call];

    
    [self presentViewController:actionSheetController animated:YES completion:nil];
}
//邮箱
- (IBAction)EmailPressed:(id)sender {
    UIAlertController* actionSheetController = [[UIAlertController alloc]init];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        NSLog(@"cancel");
    }];
    UIAlertAction* Email = [UIAlertAction actionWithTitle:@"Email" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"email");
    }];
    UIAlertAction* Edit = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        NSLog(@"edit");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Edit" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        //在AlertView中添加输入框
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"Input email,please.";
        }];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
            
            [self.boxdic setValue:@{@"UUID":self.uid,@"Email":envirnmentNameTextField.text,@"PhoneNumber":self.tel,@"Name":self.contact} forKey:self.uid];
            [self.boxdic writeToFile:self.boxpath atomically:YES];
            self.url = envirnmentNameTextField.text;
            [self.email setTitle:envirnmentNameTextField.text forState:UIControlStateNormal];
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alertController animated:true completion:nil];
    }];
    
    [actionSheetController addAction:cancelAction];
    [actionSheetController addAction:Edit];
    [actionSheetController addAction:Email];

    
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

@end
