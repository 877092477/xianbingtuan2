//
//  FNAdView.h
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"

@interface FNAdView : UIView
/** 广告位 **/
@property (nonatomic, strong)UIImageView* posterImgView;

@property (nonatomic, strong)NSMutableArray* imgArr;

@property (nonatomic, copy)void (^adViewClicked) (NSInteger index);




@end
