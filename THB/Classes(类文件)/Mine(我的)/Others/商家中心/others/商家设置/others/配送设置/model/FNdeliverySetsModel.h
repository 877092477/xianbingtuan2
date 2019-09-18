//
//  FNdeliverySetsModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNdeliverySetsModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* value;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* hint;
@property (nonatomic, copy)NSString* edType;
@property (nonatomic, assign)CGFloat rowHeight;
@property (nonatomic, assign)BOOL isLocation;
@property (nonatomic, assign)BOOL isSwitch;
@property (nonatomic, assign)BOOL isHsj;
@property (nonatomic, assign)BOOL isBearEd;
@property (nonatomic, copy)NSString* rightType;
@end

@interface FNdeliverySetSectionModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSArray*  list;
@property (nonatomic, assign)CGFloat rowHeight;
@end

@interface FNdeliveryDayModel : NSObject
@property (nonatomic, copy)NSString* value;
@property (nonatomic, copy)NSString* dayVal;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* seletedImg;
@property (nonatomic, assign)BOOL    state;

@end
NS_ASSUME_NONNULL_END
