//
//  DetailViewController.m
//  Contacts
//
//  Created by Cocout on 2018/4/1.
//  Copyright © 2018年 Damian. All rights reserved.
//

#import "DetailViewController.h"
#import "Person+CoreDataClass.h"
#import "AppDelegate.h"

@interface DetailViewController (){
    NSManagedObjectContext *context;
    NSArray *objs;
    AppDelegate *appdelegate;
}


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置信息
    [self.name setTitle:self.theMan.name forState:UIControlStateNormal];
    [self.phone setTitle:self.theMan.phone forState:UIControlStateNormal];
    [self.email setTitle:self.theMan.url forState:UIControlStateNormal];
    
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
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    
    //获取当前联系人
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid = %@",self.theMan.uid];
    request.predicate = predicate;
    objs = [context executeFetchRequest:request error:&error];
    
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
    NSError *error = nil;
    for (NSManagedObject *obj in objs) {
        NSLog(@"name = %@, uid = %@, url = %@, phone = %@", [obj valueForKey:@"name"], [obj valueForKey:@"uid"], [obj valueForKey:@"url"], [obj valueForKey:@"phone"]);
        [context deleteObject:obj];
        [context save:&error];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
                
                NSLog(@"%@",envirnmentNameTextField.text);
                NSError *error = nil;
                for (NSManagedObject *obj in objs) {
                    [obj setValue:envirnmentNameTextField.text forKey:@"name"];
                    [context save:&error];
                    [appdelegate saveContext];
                    [self.name setTitle:[obj valueForKey:@"name"] forState:UIControlStateNormal];
                }
                
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
            
            NSLog(@"%@",envirnmentNameTextField.text);
            NSError *error = nil;
            for (NSManagedObject *obj in objs) {
                [obj setValue:envirnmentNameTextField.text forKey:@"phone"];
                [context save:&error];
                [appdelegate saveContext];
                [self.phone setTitle:[obj valueForKey:@"phone"] forState:UIControlStateNormal];
            }
            
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
            
            NSLog(@"%@",envirnmentNameTextField.text);
            NSError *error = nil;
            for (NSManagedObject *obj in objs) {
                [obj setValue:envirnmentNameTextField.text forKey:@"url"];
                [context save:&error];
                [appdelegate saveContext];
                [self.email setTitle:[obj valueForKey:@"url"] forState:UIControlStateNormal];
            }
            
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
