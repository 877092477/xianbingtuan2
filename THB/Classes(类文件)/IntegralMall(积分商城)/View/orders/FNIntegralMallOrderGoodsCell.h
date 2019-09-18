//
//  FNIntegralMallOrderGoodsCell.h
//  THB
//
//  Created by Weller Zhao on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNIntegralMallOrderGoodsCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgGoods;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;

@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblCount;

@end

NS_ASSUME_NONNULL_END
