//
//  FNmerConsumeSeekHCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerConsumeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmerConsumeSeekHCellDelegate <NSObject>
// 编辑
- (void)didmerConsumeSeekHActionwithContent:(NSString*)content withIndex:(NSIndexPath*)index;

@end
@interface FNmerConsumeSeekHCell : UICollectionViewCell<UITextFieldDelegate>
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UITextField  *compileField;
@property (nonatomic, strong)UIView  *lineView;
@property (nonatomic, strong)UIButton  *rightBtn;
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)NSIndexPath  *index;
@property (nonatomic, strong)FNmerConsumeModel  *model;
@property (nonatomic, weak)id<FNmerConsumeSeekHCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
