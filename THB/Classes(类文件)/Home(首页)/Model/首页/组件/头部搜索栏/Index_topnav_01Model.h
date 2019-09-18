//
//  Index_topnav_01Model.h
//  THB
//
//  Created by zhongxueyu on 2018/8/17.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopNav_ImgArrModel.h"
@interface Index_topnav_01Model : NSObject

@property (nonatomic , copy) NSString              * img1;

@property (nonatomic , copy) NSString              * img2;

@property (nonatomic , copy) NSString              * end_color;

@property (nonatomic , copy) NSString              * keyword;

@property (nonatomic , copy) NSString              * str;

@property (nonatomic , copy) NSString              * top_bjimg;

@property (nonatomic, strong)NSArray<TopNav_ImgArrModel *>* imgArr;

@end
