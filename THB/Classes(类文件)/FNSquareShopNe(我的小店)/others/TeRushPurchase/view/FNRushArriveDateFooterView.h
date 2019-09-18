//
//  FNRushArriveDateFooterView.h
//  69橙子
//
//  Created by Jimmy on 2018/11/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//送达时间
#import <UIKit/UIKit.h>

#import "FNrushPurchaseNeModel.h"

@interface FNRushArriveDateFooterView : UITableViewHeaderFooterView
/**  送达时间   **/
@property(nonatomic, strong) UILabel *sendTitle;
/**  时间      **/
@property(nonatomic, strong) UILabel *sendDateLb;
/**  dicModel      **/
@property(nonatomic, strong) NSDictionary *dicModel;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end


