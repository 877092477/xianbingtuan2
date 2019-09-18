//
//  FNFunctionView.h
//  SuperMode
//
//  Created by jimmy on 2017/11/3.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"
#import "FNHomeFunctionBtn.h"
@interface FNFunctionView : JMView
@property (nonatomic, strong)NSArray* titles;
@property (nonatomic, strong)NSArray* images;
@property (nonatomic, strong)NSArray* font_Colors;
@property (nonatomic, strong)NSMutableArray<FNHomeFunctionBtn*>* btns;
@property (nonatomic, assign)NSInteger column;
@property (nonatomic, assign)NSInteger row;
@property (nonatomic, assign)NSInteger singleH;
@property (nonatomic, assign)NSInteger viewh;
@property (nonatomic, strong)UIScrollView* scrollview;
@property (nonatomic, copy)void (^btnClickedBlock)(NSInteger index);

@property (nonatomic, assign)CGFloat imageW;
@property (nonatomic, assign)CGFloat singFont;

- (void)setPageColor: (UIColor*)color;
- (void)setBtnviews;
@end
