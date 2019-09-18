//
//  FNMinuteLocationNeCell.h
//  THB
//
//  Created by Jimmy on 2018/9/29.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FNMinuteLocationNeCellDelegate <NSObject>
// 编辑
- (void)InDetaileRedactSiteAction:(NSIndexPath *)indexPath withSite:(NSString*)string;

@end

@interface FNMinuteLocationNeCell : UITableViewCell<UITextViewDelegate>

/** 输出的内容 **/
@property (strong, nonatomic) UITextView *siteView;

/** placeholderLabel **/
@property (strong, nonatomic) UILabel *placeholderLabel;

/** line **/
@property (nonatomic, strong)UILabel* LineLB;

/** other **/
@property (nonatomic, strong)NSIndexPath *indexPath;

@property(nonatomic ,weak) id<FNMinuteLocationNeCellDelegate> delegate;

@end
