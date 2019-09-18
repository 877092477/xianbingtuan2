//
//  FNdrawRedPacketNaView.h
//  THB
//
//  Created by Jimmy on 2019/2/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNdrawRedPacketNaView : UIView
@property (nonatomic, copy)void (^purchaseBlock) (id model);
+ (void)showWithModel:(id)model view:(UIView *)view purchaseblock:(void (^)(id model))block;
@end

NS_ASSUME_NONNULL_END
