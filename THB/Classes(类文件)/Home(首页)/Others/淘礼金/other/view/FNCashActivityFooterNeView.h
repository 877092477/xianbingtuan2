//
//  FNCashActivityFooterNeView.h
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCashActivityNeModel.h"
@interface FNCashActivityFooterNeView : UITableViewHeaderFooterView
/**  bgImageView  type:singlerow **/
@property (nonatomic, strong)UIImageView * bgImageView;
/**  bgTwoImageView **/
@property (nonatomic, strong)UIImageView * bgTwoImageView;
/**  headImage **/
@property (nonatomic, strong)UIImageView * headImageView;
/**  itemDic **/
@property (nonatomic, strong)NSDictionary * itemDic;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
