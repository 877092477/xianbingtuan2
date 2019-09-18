//
//  FNRushConsigneeNameNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/12/1.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNrushSiteDaNeModel.h"

@protocol FNRushConsigneeNameNeCellDelegate <NSObject>
// 编辑
- (void)InConsigneeNameAction:(NSIndexPath *)indexPath withContent:(NSString*)string;
//选择性别
-(void)inConsigneechoicegender:(NSInteger)send; 

@end

@interface FNRushConsigneeNameNeCell : UITableViewCell<UITextFieldDelegate>
/** 图片 **/
@property (nonatomic, strong)UIImageView* directionImage;
/** 左边标题 **/
@property (nonatomic, strong)UILabel* leftLabel;
/** 编辑**/
@property (nonatomic, strong)UITextField* NameText;
/** line **/
@property (nonatomic, strong)UILabel* LineLB;
/** other **/
@property (nonatomic, strong)NSIndexPath *indexPath;
/** 先生 **/
@property (nonatomic, strong)UIButton *maleButton;
/** 女士 **/
@property (nonatomic, strong)UIButton *ladyButton;

@property(nonatomic ,weak) id<FNRushConsigneeNameNeCellDelegate> delegate;

/** model **/
@property (nonatomic, strong)FNrushSiteDaNeModel *model;

/** model **/
@property (nonatomic, assign)NSInteger isSex;

@end


