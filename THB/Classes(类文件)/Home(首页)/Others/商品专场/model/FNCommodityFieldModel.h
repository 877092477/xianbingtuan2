//
//  FNCommodityFieldModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNCommodityFieldModel : NSObject
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * mac;
@property (nonatomic , copy) NSString              * jiange;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * show_type_str;
@property (nonatomic , copy) NSArray               * list;
@property (nonatomic , assign) CGFloat              rowHeight;
@property (nonatomic , strong) NSArray              *imageUrls;
@end

@interface FNCommodityFieldTopModel : NSObject
@property (nonatomic , copy) NSString              * top_fontcolor;
@property (nonatomic , copy) NSString              * return_img;
@property (nonatomic , copy) NSString              * bj_img;
@property (nonatomic , copy) NSString              * info;
@end

@interface FNCommoditySortItemModel : NSObject

@property (nonatomic , copy) NSString              * bgimg; 
@property (nonatomic , copy) NSString              * img1;
@property (nonatomic , assign) NSInteger             sortid;
@property (nonatomic , assign) NSInteger             state; 

@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * catename;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * check_tip_img;
@property (nonatomic , copy) NSString              * tip_img;
@property (nonatomic , copy) NSString              * tip_fontcolor;
@property (nonatomic , copy) NSString              * check_tip_fontcolor;
@end
NS_ASSUME_NONNULL_END
