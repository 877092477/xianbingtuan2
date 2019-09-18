//
//  FNpunchHomeAeModel.h
//  THB
//
//  Created by Jimmy on 2019/2/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNpunchHomeAeModel : NSObject
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *img_code;
@property(nonatomic,strong)NSString *top_title;
@property(nonatomic,strong)NSString *str1;
@property(nonatomic,strong)NSString *str2;
@property(nonatomic,strong)NSString *str3;
@property(nonatomic,strong)NSString *str4;
@property(nonatomic,strong)NSString *str5;
@property(nonatomic,strong)NSString *str6;
@property(nonatomic,strong)NSString *str7;
@property(nonatomic,strong)NSString *num_str;
@property(nonatomic,strong)NSString *num;
@property(nonatomic,strong)NSString *sum;
@property(nonatomic,strong)NSString *djs;
@property(nonatomic,strong)NSString *dk_money;

@property(nonatomic,strong)NSString *fontcolor;
@property(nonatomic,strong)NSString *num_color;
@property(nonatomic,strong)NSString *btn_color;
@property(nonatomic,strong)NSString *sign_bjimg;
@property(nonatomic,strong)NSString *sign_btnimg;
@property(nonatomic,strong)NSString *sign_moneyicon;
@property(nonatomic,strong)NSString *sign_detailimg;
@property(nonatomic,strong)NSString *sign_todayimg;
@property(nonatomic,strong)NSString *sign_dkthreebjimg;


@property(nonatomic,strong)NSArray  *head_img;
@property(nonatomic,strong)NSArray  *three_data;
@property(nonatomic,strong)NSArray  *list; 

@end


@interface FNpunchStepItemModel : NSObject

@property(nonatomic,strong)NSString *three_data;
@property(nonatomic,strong)NSString *str;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *ico;
@property(nonatomic,strong)NSString *font_color;

@end

@interface FNpunchListItemModel : NSObject

@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *img_str;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *head_img;
@property(nonatomic,strong)NSString *str;

@end

NS_ASSUME_NONNULL_END
