//
//  FNmerDeliveryEditorCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNdeliverySetsModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmerDeliveryEditorCellDelegate <NSObject>
// 编辑
- (void)didmerDeliveryEditorAction:(NSIndexPath*)index withContent:(NSString*)content;
// 右边点击
- (void)didmerDeliveryRightAction:(NSIndexPath*)index;
@end
@interface FNmerDeliveryEditorCell : UICollectionViewCell<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong)UILabel   *leftTitleLB;
@property (nonatomic, strong)UILabel   *rightLB;
@property (nonatomic, strong)UIImageView  *rightImgView;
@property (nonatomic, strong)UITextField  *compileField;
@property (nonatomic, strong)UITextView   *siteView;
@property (nonatomic, strong)UILabel      *siteHint;
@property (nonatomic, strong)UIButton     *rightBtn;
@property (nonatomic, strong)FNdeliverySetsModel      *model;
@property (nonatomic, strong)NSIndexPath  *index; 
@property (nonatomic, weak)id<FNmerDeliveryEditorCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
