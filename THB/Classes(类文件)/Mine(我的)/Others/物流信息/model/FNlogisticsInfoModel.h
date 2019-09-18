//
//  FNlogisticsInfoModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNlogisticsInfoModel : NSObject
@property (nonatomic, copy) NSString *img;//   是    string    头部背景图    头部背景图
@property (nonatomic, copy) NSString *wl_ico;//    是    string    物流图标    物流图标
@property (nonatomic, copy) NSString *return_img;//    是    string    返回图标    返回图标
@property (nonatomic, copy) NSString *wl_name;//    是    string    物流名称    物流名称
@property (nonatomic, copy) NSString *wl_name_color;//    是    string    物流名称颜色    物流名称颜色
@property (nonatomic, copy) NSString *title;//    是    string    头部标题    头部标题
@property (nonatomic, copy) NSString *title_color;//    是    string    头部标题颜色    头部标题颜色
@property (nonatomic, copy) NSString *str;//    是    string    文字    快递单号：
@property (nonatomic, copy) NSString *wl_num;//    是    string    快递单号    快递单号
@property (nonatomic, copy) NSString *status_str;//    是    string    文字    状态：
@property (nonatomic, copy) NSString *status;//    是    string    状态值    状态值
@property (nonatomic, copy) NSString *status_color;//    是    string    状态值颜色    状态值颜色
@property (nonatomic, copy) NSArray  *wl_data;
@end

@interface FNlogisticsInfoItemModel : NSObject
@property (nonatomic, copy) NSString *content;//   是    string    内容
@property (nonatomic, copy) NSString *time;//    是    string    时间
@property (nonatomic, assign) NSInteger state;//    状态
@end
NS_ASSUME_NONNULL_END
