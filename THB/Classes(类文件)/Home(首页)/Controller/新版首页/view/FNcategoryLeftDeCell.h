//
//  FNcategoryLeftDeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/17.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNLeftclassifyModel.h"

@protocol FNcategoryLeftDeCellDelegate <NSObject> 
// 点击
- (void)categoryLeftDeCellAction:(NSInteger)sender;
@end

@interface FNcategoryLeftDeCell : UITableViewCell

@property(nonatomic, strong) FNLeftclassifyModel *evaluate;

@property (nonatomic, strong)UIButton *classifyBtn;

@property (nonatomic, strong)UILabel *classifyLB;

@property(nonatomic, strong)NSIndexPath *indexAc;

@property(nonatomic ,weak) id<FNcategoryLeftDeCellDelegate> delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end


