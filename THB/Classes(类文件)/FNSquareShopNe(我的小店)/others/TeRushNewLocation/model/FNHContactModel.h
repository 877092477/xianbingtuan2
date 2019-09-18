//
//  FNHContactModel.h
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

 

@interface FNHContactModel : NSObject
/** 联系人姓名 */
@property (nonatomic, retain) NSString *name;
/** 联系人电话号码(数组) */
@property (strong, nonatomic) NSMutableArray *telArray;

@property (nonatomic, assign) int recordID;
//@property (nonatomic, retain) NSString *tel;
@end
 

@interface FNHsearchModel : NSObject
/** name */
@property (nonatomic,strong) NSString *name;

/** 地址 */
@property (nonatomic, strong) NSString *address;


@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) CGFloat  latitude;
@property (nonatomic, assign) CGFloat  longitude;

/** 省份 */
@property (nonatomic, strong) NSString *province;
/** 市级 */
@property (nonatomic, strong) NSString *city;
/** 区级 */
@property (nonatomic, strong) NSString *district;

@end
