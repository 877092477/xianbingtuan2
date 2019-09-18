//
//  teamPullNewModel.h
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/5/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "teamPullNewListModel.h"

@class teamPullNewListModel;
@interface teamPullNewModel : NSObject

@property(nonatomic,copy)NSString *p_headcount;

@property(nonatomic,copy)NSString *qrcode_url;

@property(nonatomic,copy)NSString *sum_peo;

@property(nonatomic,copy)NSString *team_headcount;

@property(nonatomic,copy)NSString *team_num;

@property(nonatomic,copy)NSString *user_img;

@property(nonatomic,copy)NSString *username;

@property(nonatomic,strong)NSArray<teamPullNewListModel *>* list;

@end
