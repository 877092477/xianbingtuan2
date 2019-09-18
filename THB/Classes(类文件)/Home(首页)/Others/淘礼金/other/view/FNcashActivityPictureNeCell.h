//
//  FNcashActivityPictureNeCell.h
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCashActivityNeModel.h"
@interface FNcashActivityPictureNeCell : UITableViewCell
/** bgImage **/
@property (nonatomic, strong)UIImageView * bgImageView;
/** 图片Image **/
@property (nonatomic, strong)UIImageView * contentImageView;
/** 活动规则 **/
@property (nonatomic, strong)UIButton * regulationBtn;

/** itemDic **/
@property (nonatomic, strong)NSDictionary* itemDic;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
