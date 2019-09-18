//
//  FNCashFootFloorNeView.h
//  THB
//
//  Created by Jimmy on 2018/10/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

@interface FNCashFootFloorNeView : UITableViewHeaderFooterView
/**  bgImageView  type:singlerow **/
@property (nonatomic, strong)UIImageView * bgImageView;
/**  leftView **/
@property (nonatomic, strong)UILabel * leftView;
/**  rightView **/
@property (nonatomic, strong)UILabel * rightView;
/**  foottitle **/
@property (nonatomic, strong)UILabel * floortitle;
/**  itemDic **/
@property (nonatomic, strong)NSDictionary * itemDic;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end

//NS_ASSUME_NONNULL_END
