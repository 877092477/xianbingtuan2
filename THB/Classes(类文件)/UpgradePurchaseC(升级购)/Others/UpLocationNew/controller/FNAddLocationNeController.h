//
//  FNAddLocationNeController.h
//  THB
//
//  Created by Jimmy on 2018/9/29.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNUpAddressNeModel.h"

@protocol FNAddLocationNeControllerDelegate <NSObject>

/** 保存或者新建 **/
-(void)selectPreserveMaybeNewAction;

@end

@interface FNAddLocationNeController : SuperViewController
/** 1:编辑2:新建 **/
@property(nonatomic,assign)NSInteger editBo;
/** 地址model **/
@property(nonatomic,strong)FNUpAddressNeModel*editModel;
/** delegate **/
@property(nonatomic ,weak) id<FNAddLocationNeControllerDelegate> delegate;
@end
