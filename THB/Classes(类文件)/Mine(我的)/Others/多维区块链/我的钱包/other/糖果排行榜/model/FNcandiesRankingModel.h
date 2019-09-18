//
//  FNcandiesRankingModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNcandiesRankingModel : NSObject
@property (nonatomic, copy)NSString* dwqkb_rank_title;//    string    页面标题
@property (nonatomic, copy)NSString* dwqkb_rank_return_btn;//    string    返回按钮
@property (nonatomic, copy)NSString* dwqkb_rank_top_color;//    string    标题颜色
@property (nonatomic, copy)NSString* dwqkb_rank_top_bj;//    string    顶部背景图
@property (nonatomic, copy)NSString* top_bili;//    float    背景图比例
@property (nonatomic, copy)NSString* dwqkb_rank_tips;//    string    右侧提示
@property (nonatomic, copy)NSString* dwqkb_rank_search_bj;//    string    搜索框背景图片
@property (nonatomic, copy)NSString* dwqkb_rank_search_icon;//    string    搜索按钮图
@property (nonatomic, copy)NSString* dwqkb_rank_search_tips;//    string    搜索框提示文字
@property (nonatomic, copy)NSString* dwqkb_rank_search_color;//    string    搜索框提示文字颜色
@property (nonatomic, copy)NSString* dwqkb_rank_top_three_bj;//    string    前三名背景图
@property (nonatomic, copy)NSArray* top_three;//    arr    前三名
@property (nonatomic, copy)NSArray* rank_list;//    arr    排名列表
@end

@interface FNcandiesRankItemModel : NSObject
@property (nonatomic, copy)NSString* nickname;
@property (nonatomic, copy)NSString* head_img;
@property (nonatomic, copy)NSString* qkb_count;
@property (nonatomic, copy)NSString* vip_name;
@property (nonatomic, copy)NSString* vip_img;
@property (nonatomic, copy)NSString* rank_str;
@property (nonatomic, copy)NSString* rank_color;
@property (nonatomic, copy)NSString* count_color;
@property (nonatomic, copy)NSString* str;

@end
NS_ASSUME_NONNULL_END
