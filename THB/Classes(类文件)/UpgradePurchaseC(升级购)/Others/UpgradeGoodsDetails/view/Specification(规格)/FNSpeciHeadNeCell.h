//
//  FNSpeciHeadNeCell.h
//  THB
//
//  Created by Jimmy on 2018/9/27.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FNSpeciHeadNeCellDelegate <NSObject>

@optional

- (void)SpeciHeadNedisappear;

@end

@interface FNSpeciHeadNeCell : UITableViewCell

/** BG **/
@property (nonatomic, strong)UIView *bgView;

/** 商品图片BG **/
@property (nonatomic, strong)UIView *bgImageView;

/** 商品图片 **/
@property (nonatomic, strong)UIImageView* GoodsImage;

/** 商品库存 **/
@property (nonatomic, strong)UILabel* repertoryLabel;

/** 原价 **/
@property (nonatomic, strong)UILabel* originPriceLabel;

/** 选择的规格 **/
@property (nonatomic, strong)UILabel* specificationLabel;

/** 消失 **/
@property (nonatomic, strong)UIButton* closedBtn;

/** 数据 **/
@property (nonatomic, strong)NSDictionary* datadic;

/** 数据 **/
@property (nonatomic, strong)NSMutableArray* seleArray;

@property (nonatomic, weak) id<FNSpeciHeadNeCellDelegate> delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
