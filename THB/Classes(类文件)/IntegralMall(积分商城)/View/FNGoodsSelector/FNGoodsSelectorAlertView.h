//
//  FNGoodsSelectorAlertView.h
//  THB
//
//  Created by Weller Zhao on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNGoodsSelectorAlertView : UIView

@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UIButton *btnClose;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblDesc;

@property (nonatomic, assign) int count;
//@property (nonatomic, assign) int maxCount;


/**
 设置上限

 @param maxCount 最大购买数量
 @param stock 库存
 */
- (void)setMaxCount: (int)maxCount withStock: (int)stock;

- (void)setTitles: (NSArray<NSString*>*) titles withDatas: (NSArray<NSArray<NSString*>*>*) datas;
//- (void)setMaxCount: (int)maxCount;
- (void)show;
- (void)dismiss;
- (NSArray*)getSelectedArray;

@end

NS_ASSUME_NONNULL_END
