//
//  FNMerchantOrderMeCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerchantOrderListView.h"
#import "FNMerchantMeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNMerchantOrderMeCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIView        *verticalView;
@property (nonatomic, strong)UILabel       *nameLB;
@property (nonatomic, strong)UIButton      *moreBtn;
@property (nonatomic, strong)UIView        *lineView;
@property (nonatomic, strong)FNmerchantOrderListView        *listView;
@property (nonatomic, strong)FNMerchantMeModel  *model; 
@end

NS_ASSUME_NONNULL_END
