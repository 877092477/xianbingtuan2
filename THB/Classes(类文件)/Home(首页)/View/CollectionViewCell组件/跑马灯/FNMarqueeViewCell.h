//
//  FNMarqueeViewCell.h
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNComponentBaseCell.h"
#import "FNScrollmonkeyView.h"

@interface FNMarqueeViewCell : FNComponentBaseCell
/** 跑马灯视图 **/
@property (nonatomic, strong)FNScrollmonkeyView* FNMarqueeView;;


//首页跑马灯（index_paomadeng_01）
@property (nonatomic, strong)NSMutableArray* index_paomadeng_01List;

@end
