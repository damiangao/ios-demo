//
//  DetailViewController.h
//  Contacts
//
//  Created by Cocout on 2018/4/1.
//  Copyright © 2018年 Damian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person+CoreDataClass.h"

@interface DetailViewController : UITableViewController
@property(weak,nonatomic) Person *theMan;
@property (weak, nonatomic) IBOutlet UIButton *name;
@property (weak, nonatomic) IBOutlet UIButton *phone;
@property (weak, nonatomic) IBOutlet UIButton *email;

@end
