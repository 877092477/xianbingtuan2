//
//  FNMCAgentApplyShowModel.h
//  THB
//
//  Created by jimmy on 2017/8/1.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FNAgentListModel;
@interface FNMCAgentApplyShowModel : NSObject
/**
 *  申请页面头部图片
 */
@property (nonatomic, copy)NSString* dl_bjt;
/**
 *  	代理必看url
 */
@property (nonatomic, copy)NSString* dl_url;
/**
 *  代理费用
 */
@property (nonatomic, copy)NSString* dl_price;
/**
 *  dl_list
 */
@property (nonatomic, strong)NSArray<FNAgentListModel *>* dl_list;
/**
 *  dl_hy_title
 */
@property (nonatomic, copy)NSString* dl_hy_title;
/**
 *  dl_zdjs
 */
@property (nonatomic, copy)NSString* dl_zdjs;
/**
 *  dl_hy_xz
 */
@property (nonatomic, copy)NSString* dl_hy_xz;
/**
 *  zhushi
 */
@property (nonatomic, copy)NSString* zhushi;
@end

@interface FNAgentListModel : NSObject
/**
 *  ID
 */
@property (nonatomic, copy)NSString* ID;
/**
 *  title
 */
@property (nonatomic, copy)NSString* title;

@end
