//
//  FNopenRedPacketDeModel.h
//  THB
//
//  Created by Jimmy on 2019/2/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNopenRedPacketDeModel : NSObject
@property(nonatomic,strong)NSString *type;//    类型 已领取 已领完 开红包 类型为开红包时 交互推送下领取记录
@property(nonatomic,strong)NSString *send_hb_user_head_img;//  发红包人头像
@property(nonatomic,strong)NSString *send_hb_user_nickname;//  发红包人昵称
@property(nonatomic,strong)NSString *sum_money;//  红包总金额
@property(nonatomic,strong)NSString *hb_type;//  红包类型 默认 default 手气 shouqi
@property(nonatomic,strong)NSString *ylw_str_1;//已领完提示1 手慢了, 红包派完了 看看大家手气
@property(nonatomic,strong)NSString *ylw_str_2;//已领完提示2
@property(nonatomic,strong)NSString *head_img;//    头像
@property(nonatomic,strong)NSString *nickname;//    昵称
@property(nonatomic,strong)NSString *money;//    领取金额
@property(nonatomic,strong)NSString *info;//    红包祝福语 大吉大利
@property(nonatomic,strong)NSString *str1;//    字符1 —- 已存入零钱,可直接提现
@property(nonatomic,strong)NSString *str2;//    字符2 —- 10个红包
@property(nonatomic,strong)NSArray *list;//    领取记录列表

@end

@interface FNopenRedPacketRecordModel : NSObject
@property(nonatomic,strong)NSString *uid;//         会员id
@property(nonatomic,strong)NSString *money;//       领取金额
@property(nonatomic,strong)NSString *time;//        时间
@property(nonatomic,strong)NSString *head_img;//    头像
@property(nonatomic,strong)NSString *nickname;//    昵称
@end

NS_ASSUME_NONNULL_END
