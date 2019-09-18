//
//  FNNewConnenctionCateAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/11.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewConnenctionCateAlertView.h"
#import "FNNewConnectionCateAlertCell.h"

@interface FNNewConnenctionCateAlertView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIView *vTop;
@property (nonatomic, strong) UITableView *tbvAlert;

@property (nonatomic, strong) NSArray<NSString*> *titles;

@property (nonatomic, assign)  NSInteger index;

@property (nonatomic, strong) ClickBlock block;
@property (nonatomic, strong) CloseBlock closeBlock;

@end


static FNNewConnenctionCateAlertView * alertview = nil;

@implementation FNNewConnenctionCateAlertView

+ (instancetype)sharedInstance{
    if (alertview == nil) {
        alertview = [[FNNewConnenctionCateAlertView alloc]initWithFrame:FNKeyWindow.bounds];
    }
    return alertview;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void) configUI {
    _vTop = [[UIView alloc] init];
    [self addSubview: _vTop];
    _vBackground = [[UIView alloc] init];
    [self addSubview: _vBackground];
    
    _vBackground.backgroundColor = RGBA(51, 51, 51, 0.3);
    @weakify(self)
    [_vBackground addJXTouch:^{
        @strongify(self)
        [self dismiss];
    }];
    [_vTop addJXTouch:^{
        @strongify(self)
        [self dismiss];
    }];

    _tbvAlert = [[UITableView alloc] init];
    [self addSubview: _tbvAlert];
    
    _tbvAlert.delegate = self;
    _tbvAlert.dataSource = self;
    
    _tbvAlert.backgroundColor = [UIColor clearColor];
    _tbvAlert.estimatedRowHeight = 200;
    _tbvAlert.rowHeight = UITableViewAutomaticDimension;
    _tbvAlert.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tbvAlert.bounces = NO;
    [self addSubview:_tbvAlert];
    
    [_tbvAlert registerClass:[FNNewConnectionCateAlertCell class] forCellReuseIdentifier:@"FNNewConnectionCateAlertCell"];
    
    
    [_vBackground mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.tbvAlert);
    }];
    [_vTop mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.bottom.equalTo(self.tbvAlert);
    }];
    
    [_tbvAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FNNewConnectionCateAlertCell *cell = [tableView dequeueReusableCellWithIdentifier: @"FNNewConnectionCateAlertCell"];
    cell.lblTitle.text = _titles[indexPath.row];
    [cell setCheck:indexPath.row == _index];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismiss];
//    if ([self.delegate respondsToSelector:@selector(cateView:didSelect:)]) {
//        [self.delegate cateView: self didSelect:indexPath.row];
//    }
    if (_block) {
        _block(indexPath.row);
    }
}

- (void)showBelow: (UIView*)view titles: (NSArray<NSString*>*) titles block: (ClickBlock)block closeBlock: (CloseBlock)closeBlock{
    CGRect frame = [view convertRect:view.bounds toView:nil];
    [_tbvAlert mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0).offset(frame.origin.y + frame.size.height);
    }];
//    [_vTop mas_remakeConstraints: ^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(@0);
//        make.bottom.equalTo(view.mas_top);
//    }];
    
    self.titles = titles;
    [self.tbvAlert reloadData];
    
    [self removeFromSuperview];
    
    [FNKeyWindow addSubview:self];
    self.block = block;
    self.closeBlock = closeBlock;
}

- (void)dismiss {
    [self removeFromSuperview];
    if (_closeBlock) {
        _closeBlock();
    }
}

- (void)setSelectedIndex: (NSInteger)index {
    _index = index;
    [self.tbvAlert reloadData];
}

@end
