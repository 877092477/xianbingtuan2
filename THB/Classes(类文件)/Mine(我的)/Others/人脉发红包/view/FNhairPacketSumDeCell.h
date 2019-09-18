//
//  FNhairPacketSumDeCell.h
//  THB
//
//  Created by Jimmy on 2019/2/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNRedPackageNaModel.h"
#import "FNRedPacketTextField.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNhairPacketSumDeCellDelegate <NSObject>
//编辑
- (void)inHairPacketCompileItemAction:(NSIndexPath*)indexPath withContent:(NSString*)content;

@end
@interface FNhairPacketSumDeCell : UICollectionViewCell<UITextFieldDelegate>

/** bgView **/
@property (nonatomic, strong)UIView* bgView;
/** 拼图片 **/
@property (nonatomic, strong)UIImageView* pinImg;
/** 名字标题 **/
@property (nonatomic, strong)UILabel* nameLB;
/** 编辑 **/
@property (nonatomic, strong)UITextField* compileText;
/** 单位 **/
@property (nonatomic, strong)UILabel* unitLB;
/** model **/
@property (nonatomic, strong)FNRedPackageNaModel* model;
/** indexPath **/
@property (nonatomic, strong)NSIndexPath* indexPath;
/** delegate **/
@property(nonatomic ,weak) id<FNhairPacketSumDeCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
