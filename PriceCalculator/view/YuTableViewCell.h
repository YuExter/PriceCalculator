//
//  YuTableViewCell.h
//  PriceCalculator
//
//  Created by 1 on 15.07.16.
//  Copyright © 2016 PonomarevaYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;

@interface YuTableViewCell : UITableViewCell

- (void) configureWithProduct: (Product *) product;
@property (weak, nonatomic) IBOutlet UIButton *decreasePoductCount;
@property (weak, nonatomic) IBOutlet UIButton *increaseProductCount;


@end
