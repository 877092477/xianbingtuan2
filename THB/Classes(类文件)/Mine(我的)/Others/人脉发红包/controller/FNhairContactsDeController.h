//
//  FNhairContactsDeController.h
//  THB
//
//  Created by Jimmy on 2019/2/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNChatModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FNhairContactsDeControllerDelegate <NSObject>

- (void)didRedPackCreate: (FNChatModel*)model;

@end

@interface FNhairContactsDeController : SuperViewController
@property(nonatomic,strong)NSString   *uid;//uid
@property(nonatomic,strong)NSString   *room;//房间
@property(nonatomic,assign)NSInteger  statePacket;//包状态(1:代表普通 2代表群)
@property(nonatomic, weak)id<FNhairContactsDeControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
