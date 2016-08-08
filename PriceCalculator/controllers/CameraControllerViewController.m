//
//  CameraControllerViewController.m
//  PriceCalculator
//
//  Created by 1 on 14.07.16.
//  Copyright © 2016 PonomarevaYu. All rights reserved.
//

#import "CameraControllerViewController.h"
#import "YuTableViewController.h"
#import "NSArray+Random.h"
#import "Product.h"
#import "DataBaseManager.h"
#import "PriceSingletone.h"

@interface CameraControllerViewController ()

- (BOOL) isFloatValue: (NSString *) enterString;
@property (strong, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (strong, nonatomic) IBOutlet UIButton *saveChangesButton;
@property (nonatomic, strong) UIImage *chosenImage;
@property BOOL showBoxPrice;
@end

@implementation CameraControllerViewController

//NSString * const kPrices[] = {
//    @"44.90", @"84.99", @"22.90", @"9.90", @"33.33", @"99.99", @"159.99", @"120.00", @"60.90", @"5.00", @"67.89", @"89.90", @"42.00", @"134.90", @"145.80", @"345.00", @"285.80", @"209.90", @"299.90", @"399.90"
//};
//+ (NSArray *)labelNames
//{
//    static NSArray *prices;
//    if (prices == nil) {
//        prices = [[NSArray alloc] initWithObjects:kPrices count:20];
//    }
//    return prices;
//}

- (void)viewDidLoad{
    _showBoxPrice = false;
    self.takePhotoButton.layer.cornerRadius = 15;
    self.saveChangesButton.layer.cornerRadius = 15;
    _dataBaseManager = [DataBaseManager new];
    [_dataBaseManager countGoods];
    _priceTextField.enabled = false;
    //_priceTextField.text = [NSString stringWithFormat:@"Стоимость вашей корзины: %@",[PriceSingletone singleton].boxPrice];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_showBoxPrice == false)
    {
        [_dataBaseManager countGoods];
        _priceTextField.text = [NSString stringWithFormat:@"Стоимость вашей корзины: %@",[PriceSingletone singleton].boxPrice];

    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dismissKeyboard {
    [_priceTextField resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveChanges:(UIButton *)sender {
    NSString *tempStringPrice = _priceTextField.text;
    BOOL  isValid;
    
    if (_priceTextField.text != NULL)
    {
        if ([[NSScanner scannerWithString: tempStringPrice] scanFloat: NULL]){
            isValid = true;

        }
        else isValid = false;

        if (isValid == true){
            //СОХРАНЕНИЕ В БД!!!!!!!
            
//            Product *prod = [Product new];
//            prod.photo = UIImagePNGRepresentation(_imageViewHidden.image);
//            prod.photo = UIImagePNGRepresentation(_chosenImage);
//            prod.price = [NSNumber numberWithFloat: [_priceTextField.text floatValue]];
//            prod.countGood = [NSNumber numberWithInteger: [@"1" integerValue]];
            [_dataBaseManager addProduct:UIImagePNGRepresentation(_chosenImage) productPrice:[NSNumber numberWithFloat: [_priceTextField.text floatValue]] productCount:[NSNumber numberWithInteger: [@"1" integerValue]]];
            

            _imageViewHidden.image = nil;
            _imageViewHidden.hidden = true;
            _imageView.hidden = false;
            _saveChangesButton.hidden = true;
            _takePhotoButton.hidden = false;
            [_dataBaseManager countGoods];
            _priceTextField.text = [NSString stringWithFormat:@"Стоимость вашей корзины: %@",[PriceSingletone singleton].boxPrice];
            UIAlertController* alert= [UIAlertController alertControllerWithTitle:@""
                                                                          message:@"Товар добавлен в корзину!" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Хорошо" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
            _priceTextField.enabled = true;
            _showBoxPrice = false;
            
        }
        else{
            UIAlertController* alert= [UIAlertController alertControllerWithTitle:@"Ошибка!"
                                                                          message:@"Не верно введена цена! Она должна вводиться через точку!" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Хорошо" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    else{
        UIAlertController* alert= [UIAlertController alertControllerWithTitle:@"Ошибка!"
                                                                      message:@"Вы не ввели цену! Введите цену для продолжения работы!" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Хорошо" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)takePhoto:(UIButton *)sender {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIAlertController* alert= [UIAlertController alertControllerWithTitle:@"Ошибка!"
                                                                      message:@"На вашем устройстве не поддерживается камера" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Понятно" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    else{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:NULL];
    picker = nil;
    _showBoxPrice = true;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _chosenImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //UIImage *chosenImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    _imageView.hidden = true;
    _imageViewHidden.hidden = false;
    self.imageViewHidden.image = _chosenImage;
    _takePhotoButton.hidden = true;
    _saveChangesButton.hidden = false;
    NSArray *prices = [[NSArray alloc] initWithObjects:@"44.90", @"84.99", @"22.90", @"9.90", @"33.33", @"99.99", @"159.99", @"120.00", @"60.90", @"5.00", @"67.89", @"89.90", @"42.00", @"134.90", @"145.80", @"345.00", @"285.80", @"209.90", @"299.90", @"399.90", nil];
    NSString *randomObject = [prices randomObjects];
    _priceTextField.textColor = [UIColor blackColor];
    _priceTextField.text = randomObject;
    _priceTextField.enabled = true;
    _priceTextField.hidden = false;
    
//    NSString *uuid = [[NSUUID UUID] UUIDString];
//    chosenImage = [UIImage imageNamed:uuid];
    [picker dismissViewControllerAnimated:YES completion:NULL];

}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (BOOL)isFloatValue: (NSString *)enterString{
    BOOL trueVersion = false;
    if ([[NSScanner scannerWithString: enterString] scanFloat: NULL]){
        trueVersion = true;
        return trueVersion;
    }
    else return false;
}


@end
