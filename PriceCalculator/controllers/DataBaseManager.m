//
//  DataBaseManager.m
//  PriceCalculator
//
//  Created by 1 on 19.07.16.
//  Copyright © 2016 PonomarevaYu. All rights reserved.
//

#import "DataBaseManager.h"
#import <CoreData/CoreData.h>
#import "Product.h"
#import "PriceSingletone.h"

@interface DataBaseManager()

@property (nonatomic, strong) NSManagedObjectContext * managedObjectcontext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation DataBaseManager

- (NSArray *)productsArray{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectcontext];
    [fetchRequest setEntity:entity];
    NSError *err = nil;
    NSArray *res =
    [self.managedObjectcontext executeFetchRequest:fetchRequest error:&err];
    return res;
}

- (void) deleteProduct:(Product *)product{
    [self.managedObjectcontext deleteObject:product];
    [self saveContext];
}


#pragma mark - CoreData Stack

- (NSURL *) applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
//переопределение геттера
- (NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel !=nil){
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PriceModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
//этот метод вызывывает геттер - предыдущий метод
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator != nil){
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PriceModel.sqlite"];
    NSError *error = nil;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        //NSLog(@"%@", error.localizedDescription);
        abort();
    }
    return _persistentStoreCoordinator;
    
}

- (NSManagedObjectContext *)managedObjectcontext {
    if (_managedObjectcontext !=nil){
        return _managedObjectcontext;
        
    }
    NSPersistentStoreCoordinator *coord = [self persistentStoreCoordinator];
    if (!coord){
        return nil;
    }
    _managedObjectcontext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectcontext setPersistentStoreCoordinator:coord];
    return _managedObjectcontext;
}

- (void) addProduct:(NSData *)photo productPrice:(NSNumber *)productPrice productCount:(NSNumber *)productCount{
    Product *product = (Product *) [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.managedObjectcontext];
    product.photo = photo;
    product.price = productPrice;
    product.countGood = productCount;
    [self saveContext];
}

- (NSNumber *) increaseCountGoods: (Product*)product{
    product.countGood = @(product.countGood.integerValue + 1);
    [self saveContext];
    return product.countGood;
}
- (BOOL) decreaseCountGoods: (Product*)product isMoreThanOne: (BOOL)isMoreThanOne{
    if (product.countGood.integerValue > 1){
        product.countGood = @(product.countGood.integerValue - 1);
        isMoreThanOne = true;
    }
    else{
        isMoreThanOne = false;
        }
    return  isMoreThanOne;
}


-(void) saveContext{
    NSManagedObjectContext *managerObjectContext = self.managedObjectcontext;
    if (managerObjectContext !=nil){
        NSError *error = nil;
        if ([managerObjectContext hasChanges] && ![managerObjectContext save:&error])
        {
            //NSLog(@"%@", error.localizedDescription);
            abort();
            
        }
    }
}
- (void) countGoods{
    double price = 0;
    for (int i = 0; i<self.productsArray.count; i++)
    {
        Product *prod = self.productsArray[i];
        price += [prod.price doubleValue] * [prod.countGood doubleValue];
    }
    [PriceSingletone singleton].boxPrice= [NSString stringWithFormat:@"%1.2f",price];
}

@end

/*
 
 - (void) addPlaylistWithTitle: (NSString *) title imageData: (NSData *)imageData{
 PlaylistModel *playlist = (PlaylistModel *) [NSEntityDescription insertNewObjectForEntityForName:@"PlaylistModel" inManagedObjectContext:self.managedObjectcontext];
 playlist.title = title;
 playlist.imageData = imageData;
 [self saveContext];
 
 }
 - (void)deletePlaylist:(PlaylistModel *)playlist{
 [self.managedObjectcontext deleteObject:playlist];
 [self saveContext];
 */
