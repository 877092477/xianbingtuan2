//
//  FNCourseTeModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNCourseTeModel : NSObject
@property (nonatomic, copy) NSString *name;//    是    string    标题    标题
@property (nonatomic, copy) NSString *font_color;//    是    string    标题颜色    标题颜色
@property (nonatomic, copy) NSString *img;//    是    string    图片链接    图片链接
@property (nonatomic, copy) NSString *url;//    是    string    超链接    超链接
@property (nonatomic, copy) NSString *time;//    是    string    时间    2019-03-11 14:21:40
@property (nonatomic, copy) NSString *SkipUIIdentifier;//    是    string    跳转标识    跳转标识
@property (nonatomic, copy) NSString *ViewType;//    是    int    样式标识    样式标识
@property (nonatomic, copy) NSString *show_type_str;//    是    string
@property (nonatomic, copy) NSString *is_show_share;//    是    string    是否显示分享按钮    0否 1是
@property (nonatomic, copy) NSString *share_title;//    是    string    分享标题    分享标题
@property (nonatomic, copy) NSString *share_content ;//   是    string    分享内容    分享内容
@property (nonatomic, copy) NSString *share_img;//    是    string    分享图标    分享图标

//id": "2",
//"content": "",
//"img": "http://www.hairuyi.com/Upload/slide/1554800503_1_0.png",
//"url": "http://www.hairuyi.com/",
//"sort": "0",
//"time": "2019-04-09 17:02:54",
//"hide": "0",
//"title": "新版本更新",
//"SkipUIIdentifier": "pub_wailian",
//"font_color": "000000",
//"UIIdentifier": "",
//"name": "新版本更新",
//"type": "0",
//"view_type": "",
//"goodslist_img": "",
//"goodslist_str": "",
//"goods_detail": [],
//"is_need_login": "0",
//"integral_id": "",
//"fnuo_id": "",
//"shop_type": "buy_taobao",
//"start_price": "0",
//"end_price": "0",
//"commission": "0",
//"goods_sales": "0",
//"keyword": "",
//"yhq_onoff": "0",
//"goods_pd_onoff": "0",
//"dtk_goods_onoff": "0",
//"show_type_str": "1554800503_CourseList",
//"goods_type_name": "淘宝",
//"getGoodsType": "buy_taobao",
//"share_title": "分享",
//"share_content": "分享",
//"share_img": "http://www.hairuyi.com/Upload/slide/1554800503_2_1.png",
//"goods_msg": [],
//"goods_title": "",
//"goodsInfo": "",
//"show_name": "新版本更新",
//"is_show_share": "1"
@end

NS_ASSUME_NONNULL_END
