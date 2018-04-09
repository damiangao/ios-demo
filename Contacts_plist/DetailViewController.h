//
//  DetailViewController.h
//  Contacts
//
//  Created by Cocout on 2018/4/1.
//  Copyright © 2018年 Damian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController
@property(weak,nonatomic) NSMutableDictionary *theMan;
@property (weak, nonatomic) IBOutlet UIButton *name;
@property (weak, nonatomic) IBOutlet UIButton *phone;
@property (weak, nonatomic) IBOutlet UIButton *email;
@property (strong,nonatomic) NSUserDefaults *myUserDefaults;
@property (strong,nonatomic) NSMutableDictionary *boxdic;
@property (strong,nonatomic) NSString *boxpath;
@property (nonatomic,assign) NSString *uid;
@property (nonatomic,assign) NSString *url;
@property (nonatomic,assign) NSString *tel;
@property (nonatomic,assign) NSString *contact;
@end
