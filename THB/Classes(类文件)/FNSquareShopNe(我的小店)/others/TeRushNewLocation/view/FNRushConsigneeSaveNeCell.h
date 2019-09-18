//
//  FNRushConsigneeSaveNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/12/1.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

 
@protocol FNRushConsigneeSaveNeCellDelegate <NSObject>
// 保存
- (void)InConsigneeDefaultAction;
@end

@interface FNRushConsigneeSaveNeCell : UITableViewCell
/** 默认按钮 **/
@property (nonatomic, strong)UIButton *saveButton;

@property(nonatomic ,weak) id<FNRushConsigneeSaveNeCellDelegate> delegate;
@end

 
