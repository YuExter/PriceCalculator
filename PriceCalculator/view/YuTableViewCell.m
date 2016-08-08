//
//  YuTableViewCell.m
//  PriceCalculator
//
//  Created by 1 on 15.07.16.
//  Copyright © 2016 PonomarevaYu. All rights reserved.
//

#import "YuTableViewCell.h"
#import "Product.h"

@interface YuTableViewCell()

@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@end

@implementation YuTableViewCell

- (void) configureWithProduct:(Product *)product{
    self.photoImageView.image = [UIImage imageWithData:product.photo];
    self.priceTextField.text = [product.price stringValue];
    self.countLabel.text = [product.countGood stringValue];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

