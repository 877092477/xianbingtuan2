//
//  FNdisExTopUpModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNdisExTopUpModel : NSObject
@property (nonatomic , copy) NSString              *title;
@property (nonatomic , copy) NSString              *commission_tips;
@property (nonatomic , copy) NSString              *commission;
@property (nonatomic , copy) NSString              *money_tips;
@property (nonatomic , copy) NSString              *pay_tips;
@property (nonatomic , copy) NSString              *pay_type_font;
@property (nonatomic , copy) NSString              *pay_type;
@property (nonatomic , copy) NSString              *btn_font;
@property (nonatomic , copy) NSString              *qkb_qr_btn;
@property (nonatomic , copy) NSString              *qkb_qr_check_btn;
@property (nonatomic , copy) NSString              *qkb_qr_fcolor;
@property (nonatomic , copy) NSString              *qkb_qr_check_fcolor;
@end

@interface FNdisExTopUpItemModel : NSObject
@property (nonatomic , copy) NSString              *money;
@property (nonatomic , copy) NSString              *time;
@property (nonatomic , copy) NSString              *icon;
@property (nonatomic , copy) NSString              *type;
@end
NS_ASSUME_NONNULL_END
