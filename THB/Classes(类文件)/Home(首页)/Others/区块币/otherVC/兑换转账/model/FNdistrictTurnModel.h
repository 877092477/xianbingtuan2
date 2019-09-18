//
//  FNdistrictTurnModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNdistrictTurnModel : NSObject
@property (nonatomic , copy) NSString              *qkb_comm_name;//: "区块币",
@property (nonatomic , copy) NSString              *qkb_zzsxf;//: "0.01",
@property (nonatomic , copy) NSString              *qkb_cbsm;//: "您当前的持有的区块币",
@property (nonatomic , copy) NSString              *qkb_page_color;//: "FF6C41",
@property (nonatomic , copy) NSString              *qkb_qr_btn;//: "http://127.0.0.1/fnuoos_qkb/Upload/qkb/1556015804_1_0.png",
@property (nonatomic , copy) NSString              *qkb_qr_fcolor;//:"C0C0C0",
@property (nonatomic , copy) NSString              *qkb_qr_check_btn;//: "http://127.0.0.1/fnuoos_qkb/Upload/qkb/1556015804_1_1.png",
@property (nonatomic , copy) NSString              *qkb_qr_check_fcolor;//:"FFFFFF",
@property (nonatomic , copy) NSString              *qkb_zz_phone_tips;//: "请输入转账人手机号码",
@property (nonatomic , copy) NSString              *qkb_zzsl_tips;//: "最高可转883.0000个",
@property (nonatomic , copy) NSString              *qkb_zzsl_btn;//: "确认转账",
@property (nonatomic , copy) NSString              *qkb_phone_icon;//: "http://127.0.0.1/fnuoos_qkb/Upload/qkb/1556017820_1_2.png",
@property (nonatomic , copy) NSString              *qkb_sxfsm_zz;//: "额外扣除$区块币服务费（费率1%）",
@property (nonatomic , copy) NSString              *qkb_count;//: "883.0000",
@property (nonatomic , copy) NSString              *compute_type;//: "int"
@property (nonatomic , copy) NSString              *max_count;
@end

@interface FNdistrictTurnPeopleModel : NSObject
@property (nonatomic , copy) NSString              *id;//: "区块币",
@property (nonatomic , copy) NSString              *nickname;//: "0.01",
@property (nonatomic , copy) NSString              *phone;//: "您当前的持有的区块币",
@property (nonatomic , copy) NSString              *head_img;//: "FF6C41",
@end

NS_ASSUME_NONNULL_END
