//
//  FNneckRedPacketNaController.h
//  THB
//
//  Created by Jimmy on 2019/2/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNChatModel.h"
#import "FNopenRedPacketDeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNneckRedPacketNaControllerDelegate <NSObject>
//- (void)inWordString:(NSString*)content;
- (void)inReasonWordAlterHb:(FNChatModel*)model;
@end
@interface FNneckRedPacketNaController : SuperViewController
@property(nonatomic,assign)NSInteger neckState;//包状态(1:代表普通 2代表群)
@property(nonatomic,strong)NSString  *hb_id;//红包id
@property(nonatomic,strong)NSString  *uid;
@property(nonatomic,strong)NSString  *target;
@property(nonatomic,strong)NSString  *name;
@property(nonatomic,strong)NSString  *wordID;
@property(nonatomic,strong)FNChatModel *hbModel; 
@property(nonatomic,strong)FNopenRedPacketDeModel *dataModel;
/** delegate **/
@property (nonatomic, weak)id<FNneckRedPacketNaControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
