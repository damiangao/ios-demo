//
//  NewContactViewController.h
//  Contacts
//
//  Created by Cocout on 2018/4/1.
//  Copyright © 2018年 Damian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewContactViewController : UIViewController
@property (strong,nonatomic) NSUserDefaults *myUserDefaults;
@property (strong,nonatomic) NSDictionary *boxdic;
@property (strong,nonatomic) NSString *boxpath;
@end
