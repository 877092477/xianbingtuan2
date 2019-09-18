//
//  FNUpAddressNeController.h
//  THB
//
//  Created by Jimmy on 2018/9/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNUpAddressNeModel.h"

@protocol FNUpAddressNeControllerDelegate <NSObject>

/** 选择返回地址 **/
-(void)selectChoiceofLocationAction:(id)model;

@end

@interface FNUpAddressNeController : SuperViewController
/** 1:订单详情界面无地址选择 否则为一般查看地址 **/
@property(nonatomic,assign)NSInteger notchoice;
/** delegate **/
@property(nonatomic ,weak) id<FNUpAddressNeControllerDelegate> delegate;
@end
