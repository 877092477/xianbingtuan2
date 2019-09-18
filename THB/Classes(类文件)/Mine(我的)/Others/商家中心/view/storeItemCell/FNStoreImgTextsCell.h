//
//  FNStoreImgTextsCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmeStoreImgTextView.h"
#import "FNMerchantMeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNStoreImgTextsCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIView        *verticalView;
@property (nonatomic, strong)UILabel       *nameLB;
@property (nonatomic, strong)UIView        *lineView;
@property (nonatomic, strong)FNmeStoreImgTextView  *listView;
@property (nonatomic, strong)FNMerchantMeModel  *model; 
@end

NS_ASSUME_NONNULL_END
