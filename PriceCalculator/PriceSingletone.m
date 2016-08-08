//
//  PriceSingletone.m
//  PriceCalculator
//
//  Created by 1 on 20.07.16.
//  Copyright © 2016 PonomarevaYu. All rights reserved.
//

#import "PriceSingletone.h"

@implementation PriceSingletone

#pragma mark - Singleton Methods

+(PriceSingletone *) singleton
{
    static PriceSingletone *priceSingletone = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        priceSingletone = [[self alloc] init];
    });
    return priceSingletone;
}

@end
