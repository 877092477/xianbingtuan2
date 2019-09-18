//
//  JMPProductCVCell.h
//  THB
//
//  Created by jimmy on 2017/5/24.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMPProductCVCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView* proImgView;
@property (nonatomic, strong)UILabel* desLabel;
@property (nonatomic, strong)UILabel* priceLabel;
@property (nonatomic, strong)UILabel* rebateLabel;
- (void)initializedSubviews;
@end
