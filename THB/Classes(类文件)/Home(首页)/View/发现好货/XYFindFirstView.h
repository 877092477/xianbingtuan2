//
//  XYFindFirstView.h
//  TestGoodsView
//
//  Created by zhongxueyu on 16/3/23.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYFindFirstView : UIView
@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *detailTitleLable;

-(id)initWithFrame:(CGRect)frame title:(NSString *)title detailTitle:(NSString *)detailTitle image1Str:(NSString *)image1 image2Str:(NSString *)image2;
    
@end
