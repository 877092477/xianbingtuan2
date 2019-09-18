//
//  FNmemberFicheItemsCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmeFicheisModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmemberFicheItemsCellDelegate <NSObject>

-(void)inMarketBerFicheItemswithIndex:(NSIndexPath*)index;

@end
@interface FNmemberFicheItemsCell : UICollectionViewCell
@property (nonatomic, strong)UILabel *sumLB;
@property (nonatomic, strong)UILabel *sumHintLB;
@property (nonatomic, strong)UILabel *nameLB;
@property (nonatomic, strong)UILabel *dateLB;
@property (nonatomic, strong)UILabel *hintLB;
@property (nonatomic, strong)UIButton  *employBtn; 
@property (nonatomic, strong)FNmeFicheItemisModel  *model;
@property (nonatomic, strong)NSIndexPath  *index;
@property (nonatomic, weak)id<FNmemberFicheItemsCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
