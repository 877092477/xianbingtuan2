//
//  FNCreaditCardModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNCreaditCardModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *b_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, strong) NSArray<NSString*> *rights;
@property (nonatomic, copy) NSString *commission;
@property (nonatomic, copy) NSString *rights_bg;
@property (nonatomic, copy) NSString *rights_color;
@property (nonatomic, copy) NSString *zgz;
@property (nonatomic, copy) NSString *fxz;
@property (nonatomic, copy) NSString *zgz_str;
@property (nonatomic, copy) NSString *fxz_str;
@property (nonatomic, copy) NSString *zgz_color;
@property (nonatomic, copy) NSString *fxz_color;
@property (nonatomic, copy) NSString *zgz_bg;
@property (nonatomic, copy) NSString *fxz_bg;

@end

@interface FNCreaditCardDetailModel : FNCreaditCardModel

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *is_recommend;

@property (nonatomic, copy) NSString *fxz_str1;
@property (nonatomic, copy) NSString *fxz_str2;
@property (nonatomic, copy) NSString *zgz_str1;
@property (nonatomic, copy) NSString *zgz_str2;
@property (nonatomic, copy) NSString *str1;
@property (nonatomic, copy) NSString *str2;
@property (nonatomic, copy) NSString *index_icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *top_bg;
@property (nonatomic, copy) NSString *back;
@property (nonatomic, copy) NSString *top_color;
@property (nonatomic, copy) NSString *zgz_url;

@property (nonatomic, strong) NSArray<NSString*> *rule;

@end

@interface FNCreaditCardShareIconModel : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSString *type;

@end

@interface FNCreaditCardShareModel : FNCreaditCardModel

@property (nonatomic, copy) NSString *card_name;
@property (nonatomic, copy) NSString *copywriting;
@property (nonatomic, copy) NSString *share_img;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *top_bg;
@property (nonatomic, copy) NSString *back;
@property (nonatomic, copy) NSString *top_color;
@property (nonatomic, strong) NSArray<FNCreaditCardShareIconModel*> *shar_btn;

@end

NS_ASSUME_NONNULL_END
