//
//  COFsingleDetailsController.h
//  THB
//
//  Created by Jimmy on 2018/8/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
@class CircleOfFriendsFrame;
@interface COFsingleDetailsController : SuperViewController

//详情数据
@property (nonatomic, strong)CircleOfFriendsFrame *detailsDictry;
@property(nonatomic,strong)NSString *DetailsID;
@end
