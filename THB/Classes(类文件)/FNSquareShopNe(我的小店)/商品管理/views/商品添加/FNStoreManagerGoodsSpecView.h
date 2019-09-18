//
//  FNStoreManagerGoodsSpecView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreGoodsSpecManagerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreManagerGoodsSpecView : UIView

@property (nonatomic, strong) UILabel *lblTitle;

- (void)setSpec: (FNStoreGoodsSpecManagerModel*)model;

@end

NS_ASSUME_NONNULL_END
