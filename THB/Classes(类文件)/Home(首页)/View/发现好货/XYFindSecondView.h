//
//  XYFindSecondView.h
//  TestGoodsView
//
//  Created by zhongxueyu on 16/3/23.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYFindSecondView : UIView
@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *detailTitleLable;
-(id)initWithFrame:(CGRect)frame title:(NSString *)title detailTitle:(NSString *)detailTitle imageStr:(NSString *)imageStr;
@end
