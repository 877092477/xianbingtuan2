//
//  FNRushConsigneeOtherNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/12/1.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FNRushConsigneeOtherNeCellDelegate <NSObject>
// 编辑
- (void)InOtherCopyreaderAction:(NSIndexPath *)indexPath withContent:(NSString*)string;
- (void)InOtherRightButtonActionR:(NSIndexPath *)indexPathR;
@end

@interface FNRushConsigneeOtherNeCell : UITableViewCell<UITextFieldDelegate>
/** 图片 **/
@property (nonatomic, strong)UIImageView* directionImage;
/** 右边标题 **/
@property (nonatomic, strong)UILabel* leftLabel;
/** 编辑**/
@property (nonatomic, strong)UITextField* NameText;
/** line **/
@property (nonatomic, strong)UILabel* LineLB;
/** other **/
@property (nonatomic, strong)NSIndexPath *indexPath;
/** rightButton **/
@property (nonatomic, strong)UIButton *rightButton; 
/** rightState **/
@property (nonatomic, assign)NSInteger  rightState;

@property(nonatomic ,weak) id<FNRushConsigneeOtherNeCellDelegate> delegate;
@end


