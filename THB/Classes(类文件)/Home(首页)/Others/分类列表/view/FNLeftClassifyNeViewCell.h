//
//  FNLeftClassifyNeViewCell.h
//  THB
//
//  Created by Jimmy on 2018/9/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNLeftclassifyModel.h"

@protocol FNLeftClassifyNeViewCellDelegate <NSObject>

// 点击
- (void)chooseBtnClickAction:(NSInteger)sender;


@end
@interface FNLeftClassifyNeViewCell : UITableViewCell

@property(nonatomic, strong) FNLeftclassifyModel *evaluate;

@property (nonatomic, strong)UIButton *classifyBtn;

@property(nonatomic, strong)NSIndexPath *indexAc;

@property(nonatomic ,weak) id<FNLeftClassifyNeViewCellDelegate> delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
