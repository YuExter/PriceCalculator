//
//  YuTableViewController.h
//  PriceCalculator
//
//  Created by 1 on 15.07.16.
//  Copyright © 2016 PonomarevaYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataBaseManager;

@interface YuTableViewController : UITableViewController
@property (nonatomic, strong) DataBaseManager *dataBaseManager;

@end
