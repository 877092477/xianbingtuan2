//
//  TopNav_ImgArrModel.h
//  THB
//
//  Created by zhongxueyu on 2018/8/17.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopNav_ImgArrModel : NSObject

@property (nonatomic , copy) NSString              * type;

@property (nonatomic , copy) NSString              * title;

@property (nonatomic , copy) NSString              * url;

@property (nonatomic , copy) NSString              * fnuo_id;

@property (nonatomic , copy) NSString              * shop_type;

@property (nonatomic , copy) NSString              * search_keyword;

@property (nonatomic , copy) NSString              * skip_toptitle;

@property (nonatomic , copy) NSString              * skip_topimg;

@property (nonatomic , copy) NSString              * skip_topcolor;

@property (nonatomic , copy) NSString              * img;

@property (nonatomic , copy) NSString              * name;

@property (nonatomic , copy) NSString              * SkipUIIdentifier;

@property (nonatomic , copy) NSString              * view_type;

@property (nonatomic , copy) NSString              * goodslist_img;

@property (nonatomic , copy) NSString              * goodslist_str;

@property (nonatomic , copy) NSArray              * goods_detail;

@property (nonatomic , assign) NSInteger              is_need_login;

@property (nonatomic , copy) NSString              * font_color;

@end
