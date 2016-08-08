//
//  ButtonControllerViewController.m
//  PriceCalculator
//
//  Created by 1 on 20.07.16.
//  Copyright © 2016 PonomarevaYu. All rights reserved.
//

#import "ButtonControllerViewController.h"

@interface ButtonControllerViewController ()
@property (strong, nonatomic) IBOutlet UIButton *btnBegin;

@end

@implementation ButtonControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnBegin.layer.cornerRadius = 22;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
