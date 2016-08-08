//
//  DataBaseManager.h
//  PriceCalculator
//
//  Created by 1 on 19.07.16.
//  Copyright © 2016 PonomarevaYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PriceSingletone.h"

@class Product;

@interface DataBaseManager : NSObject

- (NSArray *)productsArray;
- (void) addProduct: (NSData *) photo productPrice: (NSNumber *)productPrice productCount: (NSNumber *)productCount;
//- (void) addProduct: (Product *)product;
- (void) deleteProduct: (Product *)product;
- (NSNumber *) increaseCountGoods: (Product*)product;
- (BOOL) decreaseCountGoods: (Product*)product isMoreThanOne: (BOOL)isMoreThanOne;
- (void) countGoods;

@end


