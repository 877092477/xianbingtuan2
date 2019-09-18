//
//  FNLocationItemNameNeCell.h
//  THB
//
//  Created by Jimmy on 2018/9/29.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FNLocationItemNameNeCellDelegate <NSObject>
// 编辑
- (void)InHeadCopyreaderAction:(NSIndexPath *)indexPath withContent:(NSString*)string;

@end

@interface FNLocationItemNameNeCell : UITableViewCell<UITextFieldDelegate>

/** 图片 **/
@property (nonatomic, strong)UIImageView* directionImage;

/** 右边标题 **/
@property (nonatomic, strong)UILabel* rightLabel;

/** 编辑**/
@property (nonatomic, strong)UITextField* NameText;

/** line **/
@property (nonatomic, strong)UILabel* LineLB;

/** other **/
@property (nonatomic, strong)NSIndexPath *indexPath;

@property(nonatomic ,weak) id<FNLocationItemNameNeCellDelegate> delegate;

@end
