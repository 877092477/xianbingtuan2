//
//  FNSomeTimeTeController.h
//  THB
//
//  Created by 李显 on 2019/1/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FNSomeTimeTeControllerDelegate <NSObject>
- (void)someTimeDoteyList:(NSMutableArray*)list;

@end
@interface FNSomeTimeTeController : SuperViewController
@property(nonatomic,strong)NSString * SkipUIIdentifier;
/** delegate **/
@property (nonatomic, weak)id<FNSomeTimeTeControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
