//
//  FNShareMutiplyViewModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"
#import "FNShareMutiplyModel.h"
@interface FNShareMutiplyViewModel : JMViewModel
/**
 *  fnuo_id
 */
@property (nonatomic, copy)NSString* fnuo_id;
@property (nonatomic, copy)NSString* getGoodsType;
@property (nonatomic, copy)NSString* SkipUIIdentifier;
@property (nonatomic, strong)FNShareMutiplyModel* model;
@property (nonatomic, strong)RACSubject* shareSubject;
@property (nonatomic, copy)NSString* yhq_url;
@end
