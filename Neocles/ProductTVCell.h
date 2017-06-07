//
//  ProductTVCell.h
//  Neocles
//
//  Created by Jeroen Dunselman on 07/06/2017.
//  Copyright © 2017 Jeroen Dunselman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;

@end
