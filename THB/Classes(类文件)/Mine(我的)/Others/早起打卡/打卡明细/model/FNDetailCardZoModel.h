//
//  FNDetailCardZoModel.h
//  THB
//
//  Created by 李显 on 2019/2/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNDetailCardZoModel : NSObject
@property(nonatomic,strong)NSString *bj_img;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *str1;
@property(nonatomic,strong)NSString *head_img;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *str;


@property(nonatomic,strong)NSArray *sy_list;

@end

@interface FNDayCardZoModel : NSObject

@property(nonatomic,strong)NSString *str;
@property(nonatomic,strong)NSString *val;

@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *fp_money;

@end

NS_ASSUME_NONNULL_END
