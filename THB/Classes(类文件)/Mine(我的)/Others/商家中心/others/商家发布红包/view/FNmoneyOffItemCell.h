//
//  FNmoneyOffItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerIssueocModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FNmoneyOffItemCellDelegate <NSObject>
// 编辑
- (void)didMerMoneyOffEditOneView:(NSIndexPath*)index withContent:(NSString*)content;
- (void)didMerMoneyOffEditTwoView:(NSIndexPath*)index withContent:(NSString*)content;
// LeftBtnClick
- (void)didMerMoneyOffLeftIndex:(NSIndexPath*)index;
// RightBtnClick
- (void)didMerMoneyOffRightIndex:(NSIndexPath*)index;

@end
@interface FNmoneyOffItemCell : UICollectionViewCell<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic, strong)UIView    *bgOneView;
@property (nonatomic, strong)UIView    *bgTwoView;
@property (nonatomic, strong)UIView    *bgThreeView;
@property (nonatomic, strong)UILabel   *leftOneLB;
@property (nonatomic, strong)UILabel   *leftTwoLB;
@property (nonatomic, strong)UILabel   *rightOneLB;
@property (nonatomic, strong)UILabel   *rightTwoLB;
@property (nonatomic, strong)UITextField  *compileOneField;
@property (nonatomic, strong)UITextField  *compileTwoField;

@property (nonatomic, strong)UIButton  *leftBtn;
@property (nonatomic, strong)UIButton  *rightBtn;
@property (nonatomic, strong)UIView    *lineView;
@property (nonatomic, strong)UILabel   *hintLB;

@property (nonatomic, strong)FNmoneyOffOItemModel   *model;

@property (nonatomic, strong)NSIndexPath  *index;

@property (nonatomic, weak)id<FNmoneyOffItemCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
