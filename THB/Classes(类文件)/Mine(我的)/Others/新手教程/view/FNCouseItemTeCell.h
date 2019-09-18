//
//  FNCouseItemTeCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCourseTeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNCouseItemTeCellDegate <NSObject>
// 点击分享
- (void)inCouseItemShareAction:(NSIndexPath *)indexPath;

@end
@interface FNCouseItemTeCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *imgView;
@property (nonatomic, strong)UILabel  *dateLB;
@property (nonatomic, strong)UILabel  *contentLB;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIView   *bgView;
@property (nonatomic, strong)FNCourseTeModel *model;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property(nonatomic ,weak) id<FNCouseItemTeCellDegate> delegate;
@end

NS_ASSUME_NONNULL_END
