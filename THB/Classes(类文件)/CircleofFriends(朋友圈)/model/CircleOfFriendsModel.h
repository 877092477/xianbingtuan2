//
//  CircleOfFriendsModel.h
//  THB
//
//  Created by 李显 on 2018/8/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CircleOfFriendsModel : NSObject

@property(nonatomic, copy) NSString     *comments_id;
@property(nonatomic, copy) NSString     *supper_parent_id;
@property(nonatomic, copy) NSString     *parent_id;
@property(nonatomic, copy) NSString     *uid;
@property(nonatomic, copy) NSString     *ttype;
@property(nonatomic, copy) NSString     *avatar;
@property(nonatomic, copy) NSString     *rating;
@property(nonatomic, copy) NSString     *nickname;
@property(nonatomic, copy) NSString     *content;
@property(nonatomic, copy) NSString     *add_time;
@property(nonatomic, copy) NSString     *like_id;
@property(nonatomic, copy) NSString     *like_count;
@property(nonatomic, copy) NSString     *unlike_count;
@property(nonatomic, copy) NSString     *is_show;
@property(nonatomic, copy) NSString     *img_data;
@property(nonatomic, copy) NSString     *like_type;
@property(nonatomic, strong) NSArray    *pic_urls;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)commitWithDict:(NSDictionary *)dict;
@end


@interface CircleTypeModel : NSObject

@property(nonatomic, strong) NSString     *name;
@property(nonatomic, strong) NSString     *SkipUIIdentifier;

@end

@interface CircleOfFriendsProductShareModel : NSObject

@property(nonatomic, copy) NSString     *str;
@property(nonatomic, copy) NSString     *img;
@property(nonatomic, copy) NSString     *is_onoff;
@property(nonatomic, copy) NSString     *is_transfer;
@property(nonatomic, copy) NSString     *share_type;
@property(nonatomic, copy) NSString     *color;

@end

@class CircleOfFriendsImageModel;
@interface CircleOfFriendsProductModel : FNBaseProductModel
@property(nonatomic, copy) NSString             *uid;
@property(nonatomic, copy) NSString             *content;
@property(nonatomic, strong) NSArray<NSString*> *img;
@property(nonatomic, copy) NSString             *thumbs_num;
@property(nonatomic, copy) NSString             *evaluate_num;
@property(nonatomic, copy) NSString             *time;
@property(nonatomic, copy) NSString             *nickname;
@property(nonatomic, copy) NSString             *head_img;
@property(nonatomic, copy) NSString             *url;
@property(nonatomic, copy) NSString             *is_thumb;
@property(nonatomic, copy) NSString             *is_need_js;
@property(nonatomic, copy) NSString             *jsurl;
    //广告=>pub_guanggao 一个商品=>pub_one_goods 多个商品=>pub_more_goods
@property(nonatomic, copy) NSString             *type;
@property(nonatomic, strong) NSArray<CircleOfFriendsImageModel*>            *imgData;
@property(nonatomic, strong) NSArray<CircleOfFriendsProductShareModel*> *share_content;
@property(nonatomic, strong) NSArray<NSString*> *share_img;

@property(nonatomic, copy) NSString             *btn1_img;
@property(nonatomic, copy) NSString             *btn2_img;
@property(nonatomic, copy) NSString             *commission_str;
    
@property(nonatomic, copy) NSString             *wenan_color;

@end
//CofshareView
//CofshareBtn
@interface CircleOfFriendsImageModel : FNBaseProductModel

    @property(nonatomic, copy) NSString     *img;
    @property(nonatomic, copy) NSString     *type;
    
    @property(nonatomic, copy) NSString     *is_show_price;//  是否显示价格  0否 1是
    @property(nonatomic, copy) NSString     *price_bgcolor;//  价格背景颜色
    @property(nonatomic, copy) NSString     *price_fontcolor;// 价格文字颜色

@end

@interface StoreModel : NSObject

@property(nonatomic, copy) NSString     *name;
@property(nonatomic, copy) NSString     *type;

@end


