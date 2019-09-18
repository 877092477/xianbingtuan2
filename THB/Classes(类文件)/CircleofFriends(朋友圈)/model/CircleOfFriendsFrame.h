//
//  CircleOfFriendsFrame.h
//  THB
//
//  Created by 李显 on 2018/8/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CircleOfFriendsModel,CircleOfFriendsProductModel;
@interface CircleOfFriendsFrame : NSObject


// commit 模型
@property(nonatomic, strong) CircleOfFriendsModel *CircleOfFriends;

// commit 模型
@property(nonatomic, strong) CircleOfFriendsProductModel *productModel;

// 头像
@property(nonatomic, assign) CGRect iconFrame;

// 昵称
@property(nonatomic, assign) CGRect nameFrame;

// 商品分类
@property(nonatomic, assign) CGRect goodsClassifyFrame;

// 评论内容
@property(nonatomic, assign) CGRect contentFrame;

// 喜欢
@property(nonatomic, assign) CGRect likeFrame;

// 不喜欢
@property(nonatomic, assign) CGRect disLikeFrame;

// 时间
@property(nonatomic, assign) CGRect timeFrame;

// 删除
@property(nonatomic ,assign) CGRect deleteFrame;

// 配图
@property(nonatomic, assign) CGRect photosFrame;

// 星级
@property(nonatomic, assign) CGRect starFrame;

// 查看详情
@property(nonatomic, assign) CGRect detailsFrame;

// 链接
@property(nonatomic, assign) CGRect slinkFrame;

//总高度
@property(nonatomic, assign) CGFloat cellHeight;

@end
