//
//  FNPartnerGoodsView.h
//  SuperMode
//
//  Created by jimmy on 2017/10/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"
#import "FNBaseProductModel.h"
@interface FNPartnerGoodsView : JMView

@property (nonatomic, copy)void (^PlShareType)(NSInteger shareType,NSString *shareFnuo_id);

@property(nonatomic,assign)BOOL isPL;
@property (nonatomic, copy)void (^selectCommodityType)(FNBaseProductModel *model);
@end
