//
//  CameraControllerViewController.h
//  PriceCalculator
//
//  Created by 1 on 14.07.16.
//  Copyright © 2016 PonomarevaYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceSingletone.h"

@class DataBaseManager;

@interface CameraControllerViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewHidden;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap;

@property (nonatomic, strong) DataBaseManager *dataBaseManager;


- (IBAction)saveChanges:(UIButton *)sender;

- (IBAction)takePhoto:(UIButton *)sender;

@end
