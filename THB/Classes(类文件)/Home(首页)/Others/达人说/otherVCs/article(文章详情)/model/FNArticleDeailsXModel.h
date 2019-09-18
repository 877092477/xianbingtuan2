//
//  FNArticleDeailsXModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNArticleDeailsXModel : NSObject

@property (nonatomic , copy) NSString              * top_title;//    是    string    头部标题    达人文章
@property (nonatomic , copy) NSString              * title_color;
@property (nonatomic , copy) NSString              * author_color;
@property (nonatomic , copy) NSString              * visit_color;
@property (nonatomic , copy) NSString              * list_color;
@property (nonatomic , copy) NSString              * return_img;
@property (nonatomic , copy) NSString              * id;//    是    string    文章id
@property (nonatomic , copy) NSString              * title;//    是    string    文章标题
@property (nonatomic , copy) NSString              * shorttitle;//    是    string    短标题
@property (nonatomic , copy) NSString              * banner;//    是    string    文章banner
@property (nonatomic , copy) NSString              * readtimes;//    是    string    浏览量
@property (nonatomic , copy) NSString              * talent_name;//    是    string    达人名号
@property (nonatomic , copy) NSString              * talent_id;//    是    string    达人id
@property (nonatomic , copy) NSString              * head_img;//    是    string    达人头像    达人头像
@property (nonatomic , copy) NSString              * followtimes;//    是    string    点赞量
@property (nonatomic , copy) NSString              * time;//    是    string    时间    2019-04-03
@property (nonatomic , copy) NSString              * label;//    是    string    标签    标签
@property (nonatomic , copy) NSString              * info_url;//    是    string    链接    文章内容读链接
@property (nonatomic , copy) NSString              * more_str;//    是    string    更多推荐    文字图片
@property (nonatomic , copy) NSString              * article_str;//    是    string    好文推荐    文字图片

@property (nonatomic , copy) NSString              * bg_navcolor;
@property (nonatomic , copy) NSString              * bg_navfontcolor;

@property (nonatomic , copy) NSArray              * article;//好文推荐
@property (nonatomic , copy) NSArray              * more_goods;//更多推荐商品 字段跟商品列表一样
@property (nonatomic , copy) NSArray              * goods;

@end


@interface FNArticleItemXModel : NSObject
@property (nonatomic , copy) NSString              * id;//    是    string    文章id
@property (nonatomic , copy) NSString              * title;//    是    string    文章标题
@property (nonatomic , copy) NSString              * shorttitle;//    是    string    短标题
@property (nonatomic , copy) NSString              * article_banner;//    是    string    文章banner
@property (nonatomic , copy) NSString              * readtimes;//    是    string    浏览量
@property (nonatomic , copy) NSString              * talent_name;//    是    string    达人名号
@property (nonatomic , copy) NSString              * talent_id;//    是    string    达人id
@property (nonatomic , copy) NSString              * head_img;//    是    string    达人头像    达人头像
@property (nonatomic , copy) NSString              * followtimes;//    是    string    点赞量
@property (nonatomic , copy) NSString              * banner;//
@end

@interface FNArticleGoodsItemXModel : NSObject
@property (nonatomic , copy) NSString              * itemid;//
@property (nonatomic , copy) NSString              * itemshorttitle;//
@property (nonatomic , copy) NSString              * itemtitle;//
@property (nonatomic , copy) NSString              * itemendprice;//
@property (nonatomic , copy) NSString              * tkrates;//
@property (nonatomic , copy) NSString              * couponmoney;//
@property (nonatomic , copy) NSString              * itemsale;//
@property (nonatomic , copy) NSString              * tkmoney;//
@property (nonatomic , copy) NSString              * couponurl;//
@property (nonatomic , copy) NSString              * itempic;//
@end
NS_ASSUME_NONNULL_END
