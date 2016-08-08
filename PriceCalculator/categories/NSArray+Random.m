//
//  NSArray+Random.m
//  PriceCalculator
//
//  Created by 1 on 19.07.16.
//  Copyright © 2016 PonomarevaYu. All rights reserved.
//

#import "NSArray+Random.h"

@implementation NSArray (Random)

- (id) randomObjects {
    NSUInteger myCount = [self count];
    if (myCount)
        return [self objectAtIndex:arc4random_uniform((int)myCount)];
    else
        return nil;
}

@end
