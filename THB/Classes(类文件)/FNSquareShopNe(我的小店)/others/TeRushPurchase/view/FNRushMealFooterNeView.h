//
//  FNRushMealFooterNeView.h
//  69橙子
//
//  Created by Jimmy on 2018/11/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNrushPurchaseNeModel.h"
@protocol FNRushMealFooterNeViewDelegate <NSObject>

// 编辑手机号码
- (void)storeCopyreaderCellphoneAction;

@end

@interface FNRushMealFooterNeView : UITableViewHeaderFooterView
/**  自取餐号      **/
@property(nonatomic, strong) UILabel *markTitle;
/**  餐号         **/
@property(nonatomic, strong) UILabel *markLb;
/**  预留手机      **/
@property(nonatomic, strong) UILabel *reservedLb;
/**  预留手机号    **/
@property(nonatomic, strong) UILabel *reservedPhoneLb; 
/**  centre      **/
@property(nonatomic, strong) UILabel *centreLB;
/**  编辑电话      **/
@property(nonatomic, strong) UIButton* duplicateBtn;
/**  delegate    **/
@property(nonatomic ,weak) id<FNRushMealFooterNeViewDelegate> delegate; 
/**  dicModel      **/
@property(nonatomic, strong) NSDictionary *dicModel;
/**  buymsg      **/
@property(nonatomic, strong) FNrushBuyMsgModel *buymsg;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;  

@end

 
