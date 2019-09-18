//
//  FNcandiesConversionTopCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCandiesConversionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcandiesConversionTopCell : UICollectionViewCell
@property (nonatomic, strong)UILabel  *baseTitleLB;
@property (nonatomic, strong)UILabel  *hintLB;
@property (nonatomic, strong)UIButton *centreBtn;
@property (nonatomic, strong)UILabel  *candiesLB;
@property (nonatomic, strong)UILabel  *candiesValLB;
@property (nonatomic, strong)UILabel  *servantLB;
@property (nonatomic, strong)UILabel  *servantValLB; 
@property (nonatomic, strong)UIView *leftline;
@property (nonatomic, strong)UIView *rightline;

@property (nonatomic, strong)FNCandiesConversionModel *model;
@end

NS_ASSUME_NONNULL_END
