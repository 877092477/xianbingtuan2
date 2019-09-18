//
//  FNUpChoiceSpecificationCell.h
//  THB
//
//  Created by Jimmy on 2018/9/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNUpChoiceSpecificationCell : UITableViewCell

/** 标题 **/
@property (nonatomic, strong)UILabel* TitleLB;

/** 内容 **/
@property (nonatomic, strong)UILabel* contentLabel;

/** 图片 **/
@property (nonatomic, strong)UIImageView* directionImage;

/** line **/
@property (nonatomic, strong)UIView* LineView;

@property (nonatomic, strong)NSMutableArray *dataArr;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
