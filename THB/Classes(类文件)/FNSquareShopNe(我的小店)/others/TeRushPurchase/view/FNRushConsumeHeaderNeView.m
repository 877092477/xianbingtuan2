//
//  FNRushConsumeHeaderNeView.m
//  69橙子
//
//  Created by Jimmy on 2018/11/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//切换模式
#import "FNRushConsumeHeaderNeView.h"

@interface FNRushConsumeHeaderNeView()

@property (nonatomic, strong) UIView *vBg;
@property (nonatomic, strong) NSMutableArray<UIButton*> *buttons;

@end

@implementation FNRushConsumeHeaderNeView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        _buttons = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}
 
- (void)configUI {
    _vBg = [[UIView alloc] init];
    [self.contentView addSubview:_vBg];
    [_vBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(34);
        make.left.equalTo(@10);
        make.right.lessThanOrEqualTo(@-10);
        make.centerY.equalTo(@0);
    }];
    
    _vBg.backgroundColor = RGB(220, 220, 224);
    _vBg.cornerRadius = 17;
    
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = UIColor.whiteColor;
        view;
    });
}

-(void)setBuyArr:(NSArray *)buyArr{
    _buyArr=buyArr;
    for (UIButton *btn in _buttons) {
        [btn removeFromSuperview];
    }
    [_buttons removeAllObjects];
    
    for (NSInteger index = 0; index < buyArr.count; index++) {
        
        NSDictionary *dic  = buyArr[index];
        NSString* string = dic[@"str"];
        UIButton *button = [[UIButton alloc] init];
        [button setTitle: string forState: UIControlStateNormal];
        [button setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        button.cornerRadius = 17;
        
        CGRect rect = [string boundingRectWithSize:(CGSizeMake(JMScreenWidth-60, 34)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} context:nil];
        
        [self.vBg addSubview:button];
        [self.buttons addObject:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(self.buttons[index - 1].mas_right);
            }
            make.top.bottom.equalTo(@0);
            make.right.lessThanOrEqualTo(@0);
            make.width.mas_equalTo(rect.size.width + 30);
        }];
        [button addTarget:self action:@selector(onItemClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)setSelectAt:(NSInteger)index {
    for (UIButton *button in self.buttons) {
        button.backgroundColor = UIColor.clearColor;
    }
    if (index < _buttons.count) {
        _buttons[index].backgroundColor = RGB(255, 155, 48);
    }
}

- (void)onItemClick: (UIButton*)sender {
    NSInteger index = [_buttons indexOfObject:sender];
    [self setSelectAt: index];
    
    if ([_delegate respondsToSelector:@selector(consumeHeader:didItemSelectedAt:)]) {
        [_delegate consumeHeader:self didItemSelectedAt: index];
    }
}

@end
