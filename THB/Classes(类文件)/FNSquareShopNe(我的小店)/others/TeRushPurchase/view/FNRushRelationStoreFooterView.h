//
//  FNRushRelationStoreFooterView.h
//  69橙子
//
//  Created by Jimmy on 2018/11/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNrushPurchaseNeModel.h"
@protocol FNRushRelationStoreFooterViewDelegate <NSObject>

// 联系
- (void)storeRelationPhoneAction;

@end

@interface FNRushRelationStoreFooterView : UITableViewHeaderFooterView

/**  电话       **/
@property(nonatomic, strong) UIButton* phoneBtn;
/**  联系商家    **/
@property(nonatomic, strong) UIButton *relationBtn;
/**  金额       **/
@property(nonatomic, strong) UILabel *sumLb;
/**  topLine   **/
@property(nonatomic, strong) UILabel *topLineLb;
/**  delegate  **/
@property(nonatomic ,weak) id<FNRushRelationStoreFooterViewDelegate> delegate;
/**  dataModel   **/
@property(nonatomic, strong) NSDictionary *dataModel;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end


