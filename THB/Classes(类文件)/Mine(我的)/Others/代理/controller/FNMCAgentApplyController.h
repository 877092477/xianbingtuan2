//
//  FNMCAgentApplyController.h
//  THB
//
//  Created by jimmy on 2017/7/27.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

typedef enum : NSUInteger {
    MCAgentTypeApplying = 0,
    MCAgentTypeAppliedSuccess,
    MCAgentTypeAppliedFailed,
    MCAgentTypeNone ,
} MCAgentType;
@interface FNMCAgentApplyController : SuperViewController
@property (nonatomic, assign)MCAgentType agentType;
@end
