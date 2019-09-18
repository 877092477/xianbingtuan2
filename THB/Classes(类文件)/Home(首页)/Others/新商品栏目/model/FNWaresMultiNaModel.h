//
//  FNWaresMultiNaModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNWaresMultiNaModel : NSObject
@property (nonatomic , copy) NSString              * bg_navimg;//    是    string    头部导航背景图    头部导航背景图
@property (nonatomic , copy) NSString              * str;//    是    string    文字    为你挑选最划算的好物
@property (nonatomic , copy) NSString              * font_color;//    是    string    文字颜色    文字颜色
@property (nonatomic , copy) NSString              * return_img;//    是    string    返回图标    返回图标
@property (nonatomic , copy) NSString              * bg_img;//    是    string    背景图    背景图
@property (nonatomic , copy) NSArray              * ico_list;//    是    array    入口图标    参数判断跟首页快速入口一致
@property (nonatomic , copy) NSArray              * cate_list;//
@end

@interface FNWaresScreenAModel : NSObject
@property (nonatomic , copy) NSArray              * cate;
@property (nonatomic , copy) NSArray              * sort;
@end

@interface FNWaresSortAModel : NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * img1;
@property (nonatomic , assign) NSInteger             sortid;
@property (nonatomic , assign) NSInteger             state;
@property (nonatomic , assign) NSInteger             bothState;

@property (nonatomic , copy) NSString              * id; 

@end

@interface FNWaresMultiIcoItemModel : NSObject
@property (nonatomic , copy) NSString              *title;
@property (nonatomic , copy) NSString              *img;
//@property (nonatomic , copy) NSString              *description;
@property (nonatomic , copy) NSString              *SkipUIIdentifier;
@property (nonatomic , copy) NSString              *ktype;
@property (nonatomic , copy) NSString              *url;
@property (nonatomic , copy) NSString              *UIIdentifier;
@property (nonatomic , copy) NSString              *name;
@property (nonatomic , copy) NSString              *type;
@property (nonatomic , copy) NSString              *view_type;
@property (nonatomic , copy) NSString              *goodslist_img;
@property (nonatomic , copy) NSString              *goodslist_str;
@property (nonatomic , copy) NSString              *goods_detail;
@property (nonatomic , copy) NSString              *is_need_login;
@property (nonatomic , copy) NSString              *integral_id;
@property (nonatomic , copy) NSString              *fnuo_id;
@property (nonatomic , copy) NSString              *shop_type;
@property (nonatomic , copy) NSString              *start_price;
@property (nonatomic , copy) NSString              *end_price;
@property (nonatomic , copy) NSString              *commission;
@property (nonatomic , copy) NSString              *goods_sales;
@property (nonatomic , copy) NSString              *keyword;
@property (nonatomic , copy) NSString              *yhq_onoff;
@property (nonatomic , copy) NSString              *goods_pd_onoff;
@property (nonatomic , copy) NSString              *dtk_goods_onoff;
@property (nonatomic , copy) NSString              *show_type_str;
@property (nonatomic , copy) NSString              *goods_type_name;
@property (nonatomic , copy) NSString              *getGoodsType;
@property (nonatomic , copy) NSString              *share_title;
@property (nonatomic , copy) NSString              *share_content;
@property (nonatomic , copy) NSString              *share_img;
@property (nonatomic , copy) NSString              *goods_msg;
@property (nonatomic , copy) NSString              *goods_title;
@property (nonatomic , copy) NSString              *goodsInfo;
@property (nonatomic , copy) NSString              *jsonInfo;
@property (nonatomic , copy) NSString              *check_font_color;
@property (nonatomic , copy) NSString              *font_color;
@property (nonatomic , copy) NSString              *show_name;
@end

@interface FNWaresMultiCateItemModel : NSObject
@property (nonatomic , copy) NSString              *id;//
@property (nonatomic , copy) NSString              *img;//
@property (nonatomic , copy) NSString              *check_img;//
@property (nonatomic , copy) NSString              *name;//
@property (nonatomic , copy) NSString              *show_type_str;//
@property (nonatomic , copy) NSString              *check_font_color;//
@property (nonatomic , copy) NSString              *font_color;//
@end
NS_ASSUME_NONNULL_END
