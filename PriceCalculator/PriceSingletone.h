//
//  PriceSingletone.h
//  PriceCalculator
//
//  Created by 1 on 20.07.16.
//  Copyright © 2016 PonomarevaYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceSingletone : NSObject

@property (nonatomic, strong) NSString *boxPrice;

+ (PriceSingletone *) singleton;


@end

