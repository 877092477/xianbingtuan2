//
//  FNNewConnectionMemModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/6/10.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNewConnectionMemCommissionModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *val;

@end

@interface FNNewConnectionMemModel : NSObject

@property (nonatomic, copy) NSString *is_ingroup;
@property (nonatomic, copy) NSString *head_img;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *Vname;
@property (nonatomic, copy) NSString *phone_str;
@property (nonatomic, copy) NSString *Vname_color;
@property (nonatomic, copy) NSString *vip_logo;
@property (nonatomic, copy) NSString *lt_ico;
@property (nonatomic, copy) NSString *font;
@property (nonatomic, copy) NSString *font_color;
@property (nonatomic, copy) NSString *target;
@property (nonatomic, copy) NSString *room;
@property (nonatomic, copy) NSString *bj_img;
@property (nonatomic, copy) NSString *sendee_uid;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *next_uid;
@property (nonatomic, copy) NSString *team_str;
@property (nonatomic, copy) NSString *reg_str;
@property (nonatomic, copy) NSString *teamcount_str;
@property (nonatomic, copy) NSString *ordercount_str;
@property (nonatomic, strong) NSArray<FNNewConnectionMemCommissionModel*> *commission_arr;
@property (nonatomic, copy) NSString *is_jump;
@property (nonatomic, copy) NSString *tip_str;

@end

NS_ASSUME_NONNULL_END
