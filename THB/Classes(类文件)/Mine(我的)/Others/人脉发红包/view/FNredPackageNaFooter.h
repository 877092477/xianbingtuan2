//
//  FNredPackageNaFooter.h
//  THB
//
//  Created by Jimmy on 2019/2/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNRedPackageNaModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNredPackageNaFooterDelegate <NSObject>
//发红包状态
- (void)inWithRedPacketState:(NSInteger)state;

@end
@interface FNredPackageNaFooter : UICollectionReusableView
/** 内容 **/
@property (nonatomic, strong)UILabel* remarkLB;
/** 修改 **/
@property (nonatomic, strong)UIButton* alterBtn;
/** model **/
@property (nonatomic, strong)FNRedPackageNaModel* model;
/** stateInt **/
@property (nonatomic, assign)NSInteger stateInt;
/** delegate **/
@property(nonatomic ,weak) id<FNredPackageNaFooterDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
