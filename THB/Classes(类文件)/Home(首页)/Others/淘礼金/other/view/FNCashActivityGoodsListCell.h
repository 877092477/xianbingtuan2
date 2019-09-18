//
//  FNCashActivityGoodsListCell.h
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCashActivityListNeView.h"
#import "FNCashActivityNeModel.h"
@interface FNCashActivityGoodsListCell : UITableViewCell
/**  bgImageView  type:singlerow **/
@property (nonatomic, strong)UIImageView * bgImageView;
/**  bgTwoImageView **/
@property (nonatomic, strong)UIImageView * bgTwoImageView;
@property (nonatomic, strong)FNCashActivityListNeView* listNeView;
@property (nonatomic, assign)CGFloat* height;
@property (nonatomic, strong)NSArray* modelArray;
@property (nonatomic, strong)NSDictionary* modictry;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
