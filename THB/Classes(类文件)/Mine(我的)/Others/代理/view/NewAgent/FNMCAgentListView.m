//
//  FNMCAgentListView.m
//  THB
//
//  Created by jimmy on 2017/8/28.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMCAgentListView.h"

@implementation FNMCAgentListView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.updateBtn];
        [self.updateBtn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
        [self.updateBtn autoSetDimension:(ALDimensionHeight) toSize:44];
    }
    return self;
}
- (UIButton *)updateBtn{
    if (_updateBtn == nil) {
        _updateBtn = [UIButton buttonWithTitle:@"升级" titleColor:FNWhiteColor font:[UIFont boldSystemFontOfSize:14] target:self action:@selector(updateBtnAction)];
        _updateBtn.backgroundColor = RGB(215, 40, 85);
        
    }
    return _updateBtn;
}
- (void)updateBtnAction{
    if (self.updateBtnBlock) {
        self.updateBtnBlock(self.selectedIndex);
    }
}
- (void)setupbtns{
    if (self.btns.count>=1) {
        [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.btns removeAllObjects];
    }
    CGFloat margin  = 10;
    CGFloat height = 34;
    @WeakObj(self);
    
    [self.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton* btn = [UIButton buttonWithTitle:obj titleColor:FNGlobalTextGrayColor font:[UIFont boldSystemFontOfSize:14] target:selfWeak action:@selector(btnAction:)];
        [btn setTitleColor:FNWhiteColor forState:(UIControlStateSelected)];
        [btn setBackgroundImage:[UIImage createImageWithColor:RGB(239, 239, 244)] forState:(UIControlStateNormal)];
        [btn setBackgroundImage:[UIImage createImageWithColor:RGB(217, 39, 57)] forState:(UIControlStateSelected)];
        btn.cornerRadius = 5;
        btn.selected = idx == 0;
        btn.tag  = idx+100;
        btn.frame = CGRectMake(margin*2, margin*(idx+1)+height*idx, FNDeviceWidth-margin*4, height);
        [selfWeak addSubview:btn];
        [selfWeak.btns addObject:btn];
    }];
    self.height = margin*(self.list.count+1) +height*self.list.count +44;
    CGFloat maxh = FNDeviceHeight-44*2;
    if (self.height>maxh) {
        self.height = maxh;
    }
    self.width = FNDeviceWidth;
    self.y =FNDeviceHeight -self.height;
}
- (void)btnAction:(UIButton *)btn{
    [self.btns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = btn == obj;
        if (btn == obj) {
            self.selectedIndex = idx;
        }
    }];
}
- (void)setList:(NSArray *)list{
    _list = list;
    if (_list.count>=1) {
        [self setupbtns];
    }else{
        if (self.btns.count>=1) {
            [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self.btns removeAllObjects];
        }
    }
}
- (NSMutableArray<UIButton *> *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray new];
    }
    return _btns;
}
@end
