//
//  FNMinePageModel.h
//  THB
//
//  Created by Jimmy on 2018/1/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuModel.h"

@interface JM_MPM_hhr:MenuModel
@property (nonatomic, copy)NSString* title1;
@property (nonatomic, copy)NSString* is_hhr;
@property (nonatomic, strong)NSArray<MenuModel *>* list;
@end
@interface JM_MPM_yq:NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* tgid;
@end

@interface JM_MPM_wallet:NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* title1;
@property (nonatomic, copy)NSString* is_tx;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, strong)NSArray<MenuModel *>* list;
@end

@interface FNMinePageModel : NSObject
@property (nonatomic, strong)JM_MPM_yq* yq;
@property (nonatomic, strong)JM_MPM_wallet* wallet;
@property (nonatomic, strong)JM_MPM_wallet* order;
@property (nonatomic, strong)JM_MPM_hhr* hhr;
@property (nonatomic, strong)JM_MPM_yq* hy_ico;

@property (nonatomic, copy)NSString* mem_font_color;
@property (nonatomic, copy)NSString* vip_btn_color;
@property (nonatomic, copy)NSString* vip_btn_fontcolor;
@property (nonatomic, copy)NSString* vip_btn_str;
@property (nonatomic, copy)NSString* vip_logo;
@property (nonatomic, copy)NSString* is_vip_btn_show;

@end
