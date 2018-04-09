//
//  ViewController.h
//  Contacts
//
//  Created by Cocout on 2018/4/1.
//  Copyright © 2018年 Damian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController
@property (strong,nonatomic) NSArray *demoArray;
@property (strong,nonatomic) NSUserDefaults *myUserDefaults;
@property (nonatomic,strong) NSDictionary *dict;//数据字典
@property (nonatomic,strong) NSString *boxpath;
@property (nonatomic,strong) NSMutableDictionary *boxdic;//不可变长字典
@end

