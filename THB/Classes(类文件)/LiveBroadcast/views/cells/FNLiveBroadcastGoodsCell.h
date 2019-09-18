//
//  FNLiveBroadcastGoodsCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNLiveBroadcastGoodsCell;
@protocol FNLiveBroadcastGoodsCellDelegate <NSObject>

- (void)didBuyClick: (FNLiveBroadcastGoodsCell*)cell;

@end

@interface FNLiveBroadcastGoodsCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgHeader;

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UIImageView *imgQuan1;
@property (nonatomic, strong) UIImageView *imgQuan2;
@property (nonatomic, strong) UILabel *lblQuan;
@property (nonatomic, strong) UIButton *btnBuy;

@property (nonatomic, weak) id<FNLiveBroadcastGoodsCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
