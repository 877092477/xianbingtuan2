//
//  FNWebViewHeaderModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/5/22.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNWebViewHeaderModel : NSObject

@property (nonatomic, copy) NSString* outlink_style;
@property (nonatomic, copy) NSString* outlink_check_fontcolor;
@property (nonatomic, copy) NSString* outlink_check_bgcolor;
@property (nonatomic, copy) NSString* outlink_returnimg; //h5页面初始化返回图标
@property (nonatomic, copy) NSString* outlink_checkreturnimg;//h5页面滑动后返回图标
@property (nonatomic, copy) NSString* outlink_closeimg;//h5页面初始化关闭图标
@property (nonatomic, copy) NSString* outlink_checkcloseimg;//h5页面滑动后关闭图标
@property (nonatomic, copy) NSString* outlink_pull_onoff;//下拉刷新  0 关闭  1 开启
@property (nonatomic, copy) NSString* outlink_navhide_onoff;//导航栏显示隐藏  0 显示 1隐藏
@end

NS_ASSUME_NONNULL_END
