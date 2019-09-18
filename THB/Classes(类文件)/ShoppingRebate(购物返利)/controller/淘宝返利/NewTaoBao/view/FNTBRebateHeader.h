//
//  FNTBRebateHeader.h
//  THB
//
//  Created by jimmy on 2017/10/31.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherRebatetopListModel.h"

@interface FNTBRebateHeader : UIView
@property (nonatomic, copy)void (^searchBlock)(NSString* text);

@property (nonatomic, strong)OtherRebatetopListModel *Model;

@end
