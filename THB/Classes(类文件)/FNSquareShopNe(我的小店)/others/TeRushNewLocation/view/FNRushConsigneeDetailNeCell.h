//
//  FNRushConsigneeDetailNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/12/1.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FNRushConsigneeDetailNeCellDelegate <NSObject>
// 编辑
- (void)InConsigneeDetailAction:(NSIndexPath *)indexPath withSite:(NSString*)string;

@end

@interface FNRushConsigneeDetailNeCell : UITableViewCell<UITextViewDelegate> 
/** 右边标题 **/
@property (nonatomic, strong)UILabel* leftLabel;
/** 输出的内容 **/
@property (strong, nonatomic) UITextView *siteView;
/** placeholderLabel **/
@property (strong, nonatomic) UILabel *placeholderLabel;
/** line **/
@property (nonatomic, strong)UILabel* LineLB; 
/** other **/
@property (nonatomic, strong)NSIndexPath *indexPath;

@property(nonatomic ,weak) id<FNRushConsigneeDetailNeCellDelegate> delegate;
@end


