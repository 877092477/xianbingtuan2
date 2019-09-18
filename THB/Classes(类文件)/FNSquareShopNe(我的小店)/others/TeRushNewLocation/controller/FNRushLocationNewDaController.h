//
//  FNRushLocationNewDaController.h
//  69橙子
//
//  Created by Jimmy on 2018/11/30.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

//model
#import "FNrushSiteDaNeModel.h"

@protocol FNRushLocationNewDaControllerDelegate <NSObject>

// 刷新
-(void)inLocationBackChoicegender;

@end

@interface FNRushLocationNewDaController : SuperViewController
//1:添加2:修改
@property(nonatomic,assign)NSInteger addState;

//地址
@property(nonatomic,strong)FNrushSiteDaNeModel *addressModel;

@property(nonatomic ,weak) id<FNRushLocationNewDaControllerDelegate> delegate;

@end


