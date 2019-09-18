//
//  ModifyPasswordController.h
//  THB
//
//  Created by Weller Zhao on 2019/2/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class ModifyPasswordController;
@protocol ModifyPasswordControllerDelegate <NSObject>

- (void)didModify: (BOOL)success;

@end

@interface ModifyPasswordController : SuperViewController

@property (nonatomic, copy) NSString *code;
@property (nonatomic, weak) id<ModifyPasswordControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
