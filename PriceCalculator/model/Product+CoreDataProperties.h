//
//  Product+CoreDataProperties.h
//  PriceCalculator
//
//  Created by 1 on 15.07.16.
//  Copyright © 2016 PonomarevaYu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Product.h"

NS_ASSUME_NONNULL_BEGIN

@interface Product (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *photo;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSNumber *countGood;

@end

NS_ASSUME_NONNULL_END
