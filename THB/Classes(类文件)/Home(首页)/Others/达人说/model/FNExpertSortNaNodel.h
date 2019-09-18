//
//  FNExpertSortNaNodel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNExpertSortNaNodel : NSObject

@property (nonatomic , copy) NSString              * name;//    是    string    分类名    分类名
@property (nonatomic , copy) NSString              * cid;//    是    string    分类id    分类id
@property (nonatomic , copy) NSString              * color;//    是    string    未选中颜色    未选中颜色
@property (nonatomic , copy) NSString              * check_color;//    是    string    选中颜色    选中颜色

@end


@interface FNExpertNaModel : NSObject
@property (nonatomic , copy) NSString              * top_checkimg;
@property (nonatomic , copy) NSString              * top_img;
@property (nonatomic , copy) NSString              * second_title;
@property (nonatomic , copy) NSString              * bg_img;
@property (nonatomic , copy) NSString              * top_title;
@property (nonatomic , copy) NSString              * top_title_color;
@property (nonatomic , copy) NSArray              * topdata;
@property (nonatomic , copy) NSArray              * newdata;
@property (nonatomic , copy) NSArray              * cate;

@property (nonatomic , copy) NSString              * bg_navimg;
@property (nonatomic , copy) NSString              * extend_title;


@end

@interface FNExpertTopdataItemModel : NSObject
@property (nonatomic , copy) NSString              * id;//    是    string    文章id
@property (nonatomic , copy) NSString              * title;//    是    string    文章标题
@property (nonatomic , copy) NSString              * shorttitle;//    是    string    短标题
@property (nonatomic , copy) NSString              * app_image;//    是    string    置顶图片
@property (nonatomic , copy) NSString              * article_banner;//    是    string    文章banner
@end

@interface FNExpertNewdataItemModel : NSObject
@property (nonatomic , copy) NSString              * id;//    是    string    文章id
@property (nonatomic , copy) NSString              * title;//    是    string    文章标题
@property (nonatomic , copy) NSString              * shorttitle;//    是    string    短标题
@property (nonatomic , copy) NSString              * article_banner;//    是    string    文章banner
@property (nonatomic , copy) NSString              * readtimes;//    是    string    浏览量
@property (nonatomic , copy) NSString              * talent_name;//    是    string    达人名号
@property (nonatomic , copy) NSString              * talent_id;//    是    string    达人id
@property (nonatomic , copy) NSString              * head_img;//    是    string    达人头像    达人头像
@end


@interface FNEssayItemDModel : NSObject

@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * label;
@property (nonatomic , copy) NSString              * followtimes;
@property (nonatomic , copy) NSString              * head_img;
@property (nonatomic , copy) NSString              * article;
@property (nonatomic , copy) NSString              * readtimes;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * banner;
@property (nonatomic , copy) NSString              * shorttitle;
@property (nonatomic , copy) NSString              * talent_id;
@property (nonatomic , copy) NSString              * talent_name;
@property (nonatomic , copy) NSString              * app_image;
@property (nonatomic , copy) NSString              * goodscount_str;
@property (nonatomic , copy) NSString              * bg_img;
@property (nonatomic , copy) NSArray               * goods;
@property (nonatomic , copy) NSString              * list_str;

@end
NS_ASSUME_NONNULL_END
