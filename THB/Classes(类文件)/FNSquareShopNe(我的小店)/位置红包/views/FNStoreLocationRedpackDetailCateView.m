//
//  FNStoreLocationRedpackDetailCateView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/29.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreLocationRedpackDetailCateView.h"

@interface FNStoreLocationRedpackDetailCateView()

@property (nonatomic, strong) UIScrollView *scvCates;
@property (nonatomic, strong) NSMutableArray<UIButton*> *cates;
@property (nonatomic, strong) NSMutableArray<UIView*> *lines;

@end

@implementation FNStoreLocationRedpackDetailCateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _cates = [[NSMutableArray alloc] init];
        _lines = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    self.backgroundColor = UIColor.whiteColor;
    
    _scvCates = [[UIScrollView alloc] init];
    [self addSubview: _scvCates];
    [_scvCates mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

- (void)setModel: (FNStoreLocationRedpackReceiveDetailModel*)model {
    for (UIView *v in _cates) {
        [v removeFromSuperview];
    }
    for (UIView *v in _lines) {
        [v removeFromSuperview];
    }
    [_cates removeAllObjects];
    [_lines removeAllObjects];
    
    NSArray *list = model.store.cate;
    for (NSInteger index = 0; index < list.count; index++) {
        UIButton *button = [[UIButton alloc] init];
        [self.scvCates addSubview: button];
        [self.cates addObject: button];
        
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@24);
            } else {
                make.left.equalTo(self.cates[index - 1].mas_right).offset(30);
            }
            make.top.bottom.equalTo(@0);
            make.right.lessThanOrEqualTo(@0);
            make.height.mas_equalTo(44);
        }];
        
        [button setTitle: list[index][@"name"] forState: UIControlStateNormal];
        [button setTitleColor: RGB(51, 51, 51) forState: UIControlStateNormal];
        button.titleLabel.font = kFONT15;
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (index != 0) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = RGB(51, 51, 51);
            [self.lines addObject:line];
            [self.scvCates addSubview: line];
            
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(button.mas_left).offset(-15);
                make.centerY.equalTo(@0);
                make.height.mas_equalTo(14);
                make.width.mas_equalTo(1);
            }];
        }
    }
}

- (void) setSelectedAt: (NSInteger) index {
    for (NSInteger i = 0; i < _cates.count; i ++) {
        UIButton *button = _cates[index];
        if (index == i) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        } else {
            button.titleLabel.font = kFONT15;
        }
    }
}

- (void)onClick: (UIButton*)sender {
    NSInteger index = [_cates indexOfObject:sender];
    if ([_delegate respondsToSelector:@selector(cateView:didItemSelectedAt:)]) {
        [_delegate cateView:self didItemSelectedAt: index];
    }
}

@end
