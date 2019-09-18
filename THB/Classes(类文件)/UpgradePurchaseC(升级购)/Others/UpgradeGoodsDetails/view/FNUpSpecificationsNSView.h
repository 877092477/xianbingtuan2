//
//  FNUpSpecificationsNSView.h
//  THB
//
//  Created by Jimmy on 2018/9/27.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNUpSpecificationsNSView : UIView

/* bgView */
@property (nonatomic, strong) UIView* bgView;
/* 确定 */
@property (nonatomic, strong) UIButton*  confirmBtn;
/* tableView */
@property (nonatomic, strong) UITableView*  tableView;
/* contionView */
@property (strong , nonatomic)UICollectionView* collectionView;

@property (nonatomic,strong)NSDictionary* dataDic;
@property (nonatomic,strong)NSMutableArray* dataArr;
@property (nonatomic,strong)NSMutableArray* seleArray;
@property (nonatomic, copy)void (^selectSpecificationBlock) (id model);
@property (nonatomic, copy)void (^selectSpecificationAndAmountBlock) (id model,NSString* amountString);
//+ (void)showWithModel:(id)model view:(UIView *)view backblock:(void (^)(id model))block;
+ (void)showWithModel:(id)model selectWithProperty:(id)Arr view:(UIView *)view backblock:(void (^)(id model,NSString* amountString))block;
@end
