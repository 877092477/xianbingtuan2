//
//  FNdisExDetailItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNdisExDetailItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNdisExDetailItemCell : UICollectionViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *bgImg;
@property(nonatomic,strong)UIImageView *stateImg;
@property(nonatomic,strong)UILabel *stateLB;
@property(nonatomic,strong)UILabel *nameLB;
@property(nonatomic,strong)UILabel *sumLB;
@property(nonatomic,strong)UILabel *useLB;
@property(nonatomic,strong)UILabel *dateLB;
@property(nonatomic,strong)UIWebView *webTextView;
@property(nonatomic,strong)FNdisExDetailItemModel *model;
@end

NS_ASSUME_NONNULL_END
