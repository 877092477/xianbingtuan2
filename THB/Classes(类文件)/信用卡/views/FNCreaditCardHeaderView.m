//
//  FNCreaditCardHeaderView.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardHeaderView.h"
#import "FNFunctionView.h"

@interface FNCreaditCardHeaderView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *imgBackground;

@property (nonatomic, strong)FNFunctionView* functionview;//圆形按钮模块

@end

@implementation FNCreaditCardHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgBackground = [[UIImageView alloc] init];
    
    [self addSubview:_imgBackground];
    
    
    [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        make.height.mas_equalTo(200);
    }];
    
    _imgBackground.cornerRadius = 10;
    _imgBackground.backgroundColor = UIColor.whiteColor;
    
    _functionview = [[FNFunctionView alloc]initWithFrame:(CGRectMake(20, 20, JMScreenWidth - 40, 180))];
    _functionview.backgroundColor=FNWhiteColor;
    _functionview.column = 3;
    _functionview.row = 2;
    _functionview.singleH = 70;
    _functionview.scrollview.pagingEnabled=YES;
    _functionview.scrollview.bounces = NO;
    [_functionview setPageColor: RGB(0, 0, 250)];
    [self addSubview: _functionview];
    
}

-(void)setImages:(NSArray *)images names: (NSArray*)names {
    if (images == nil || images.count != names.count) {
        return;
    }
    
    self.functionview.titles = names;
    self.functionview.images = images;
    
    @weakify(self)
    self.functionview.btnClickedBlock = ^(NSInteger index) {
        @strongify(self)
        if ([self.delegate respondsToSelector:@selector(didIconClick:)]) {
            [self.delegate didIconClick:index];
        }
    };

    [self setNeedsLayout];
    
    
    [self.functionview setBtnviews];
    
}


@end
