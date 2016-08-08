//
//  YuTableViewController.m
//  PriceCalculator
//
//  Created by 1 on 15.07.16.
//  Copyright © 2016 PonomarevaYu. All rights reserved.
//

#import "YuTableViewController.h"
#import "YuTableViewCell.h"
#import "Product.h"
#import "DataBaseManager.h"

@interface YuTableViewController ()

@property (nonatomic, strong) NSArray *products;

@end

@implementation YuTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _dataBaseManager = [DataBaseManager new];
    [self reloadData];
    [self.tableView reloadData];
}

//- (IBAction)unwind:(UIStoryboardSegue *)sender {
//    
//}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    [self.tableView setEditing:NO];
//    UIViewController *destinationVC = segue.destinationViewController;
//    if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
//        destinationVC = ((UINavigationController *)segue.destinationViewController).topViewController;
//    }
//}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YuTableViewCell" forIndexPath:indexPath];
    
    /*
     [myButton addTarget:self
     action:@selector(myAction)
     forControlEvents:UIControlEventTouchUpInside];
     */
    [cell configureWithProduct:self.products[indexPath.row]];
    //cell.decreasePoductCount.tag = self.products[indexPath.row];
    //[cell.decreasePoductCount addTarget:self action: @selector(decreaseCount:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    [self deleteProductAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView endUpdates];
}

#pragma mark - Logic

- (void)reloadData {
    self.products = [self.dataBaseManager productsArray];
}

- (void)deleteProductAtIndex:(NSInteger)index {
    [self.dataBaseManager deleteProduct: self.products[index]];
    [self reloadData];
}

- (void)decreaseCount: (UIButton *) decreaseButton{
    BOOL *isMoreThanOne = false;
    [self.dataBaseManager decreaseCountGoods:self.products[decreaseButton.tag] isMoreThanOne:isMoreThanOne];
    if (isMoreThanOne == false){
        UIAlertController* alert= [UIAlertController alertControllerWithTitle:@""
                                                                      message:@"Если вы хотите удалить товар, проведите справа налево от правого края экрана" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Хорошо" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else [self reloadData];
}

- (void) increaseCount: (NSInteger) index{
    [self.dataBaseManager increaseCountGoods:self.products[index]];
    [self reloadData];
}


@end
