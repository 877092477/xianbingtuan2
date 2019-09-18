//
//  FNDisHeaderView.m
//  THB
//
//  Created by jimmy on 2017/5/24.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNDisHeaderView.h"
#import "FNMineSingleSignUpView.h"
#import "FXCenterInfoModel.h"
@implementation FNDisHeaderView
- (NSMutableArray <FNMineSingleSignUpView *>*)views
{
    if (_views == nil) {
        _views = [NSMutableArray new];
    }
    return _views;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    CGFloat margin = (FNDeviceWidth*0.52- 60 - 44)*0.5;
    _avatarView = [UIView new];
    [self addSubview:_avatarView];
    

    _avatarImgView = [UIImageView new];
    _avatarImgView.cornerRadius = 30;
    _avatarImgView.backgroundColor = FNHomeBackgroundColor;
    [_avatarView addSubview:_avatarImgView];
    
    _IDImgview = [UIImageView new];
    _IDImgview.image = IMAGE(@"distribution_word_bj");
    [_IDImgview sizeToFit];
    [_avatarView addSubview:_IDImgview];
    
    _recommendIDLabel = [UILabel new];
    _recommendIDLabel.font = kFONT14;
    _recommendIDLabel.text = @"我的邀请码：----";
    _recommendIDLabel.textColor = FNColor(99, 47, 36);
    _recommendIDLabel.adjustsFontSizeToFitWidth = YES;
    [_avatarView addSubview:_recommendIDLabel];
    
    _tipsLabel = [UILabel new];
    _tipsLabel.font = kFONT14;
    _tipsLabel.textColor = FNColor(99, 47, 36);
    _tipsLabel.adjustsFontSizeToFitWidth = YES;
    _tipsLabel.text = [NSString stringWithFormat:@"快点加入一起推广赚%@吧！",[FNBaseSettingModel settingInstance].CustomUnit];
    [_avatarView addSubview:_tipsLabel];
    
    [_avatarView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:44+margin];
    [_avatarView autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [_avatarView autoSetDimension:(ALDimensionWidth) toSize:60 + 30 +_IDImgview.width];
    [_avatarView autoSetDimension:(ALDimensionHeight) toSize:60];
    
    [_avatarImgView autoSetDimensionsToSize:(CGSizeMake(60, 60))];
    [_avatarImgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_avatarImgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_IDImgview autoSetDimensionsToSize:_IDImgview.size];
    [_IDImgview autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_IDImgview autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_avatarImgView withOffset:30];
    
    [_recommendIDLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:_IDImgview withOffset:5];
    [_recommendIDLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_IDImgview withOffset:_jm_leftMargin];
    [_recommendIDLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_IDImgview withOffset:-5];
    
    [_tipsLabel autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_IDImgview withOffset:-5];
    [_tipsLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_IDImgview withOffset:_jm_leftMargin];
    [_tipsLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_IDImgview withOffset:-5];
    
    //
    _infonView = [[UIView alloc]initWithFrame:(CGRectMake(0, FNDeviceWidth*0.52, FNDeviceWidth, 64))];
    _infonView.backgroundColor = FNWhiteColor;
    [self addSubview:_infonView];
    
    
    NSArray* titles = @[@"推荐人数",@"累计收益",@"可提收益"];
    CGFloat width = (FNDeviceWidth-2)/3;
    NSArray *colors = @[FNColor(243, 164, 79),FNColor(248, 13, 27),FNColor(107, 192, 39)];
    [self.views removeAllObjects];
    @WeakObj(self);
    for (NSInteger i = 0; i<titles.count; i++) {
        FNMineSingleSignUpView* view = [[FNMineSingleSignUpView alloc]initWithFrame:CGRectMake(i*width, 0, width, 64) title:titles[i] andValue:@"0"];
        view.line.backgroundColor = colors[i];
        view.line.hidden = YES;
        view.valueLabel.textColor = colors[i];
        view.tag = i +100;
        [view addJXTouchWithObject:^(id obj) {
            FNMineSingleSignUpView* suview = obj;
            NSInteger tag = suview.tag -100;
            if (selfWeak.tapViewBlock) {
                selfWeak.tapViewBlock(tag);
            }
            
        }];
        [_infonView addSubview:view];
        [self.views addObject:view];
        
        if (i < 2) {
            UIView* line = [[UIView alloc]initWithFrame:(CGRectMake((i+1)*width, 0, 1.0, 64))];
            line.backgroundColor = FNHomeBackgroundColor;
            [_infonView addSubview:line];
        }
    }

    self.height = CGRectGetMaxY(_infonView.frame);
    
}

- (void)setModel:(FXCenterInfoModel *)model{
    _model = model;
    if (_model) {
        [_avatarImgView setUrlImg:_model.head_img];
        _recommendIDLabel.text = [NSString stringWithFormat:@"我的邀请码：%@",_model.tid];
        self.views[0].valueLabel.text = [NSString stringWithFormat:@"%@  个",_model.tjnum];
        [self.views[0].valueLabel addSingleAttributed:@{NSFontAttributeName:kFONT17} ofRange: [self.views[0].valueLabel.text rangeOfString:_model.tjnum]];
        
        self.views[1].valueLabel.text = [NSString stringWithFormat:@"%@  %@",_model.lj_commission,[FNBaseSettingModel settingInstance].CustomUnit];
        [self.views[1].valueLabel addSingleAttributed:@{NSFontAttributeName:kFONT17} ofRange: [self.views[1].valueLabel.text rangeOfString:_model.lj_commission]];
        
        self.views[2].valueLabel.text = [NSString stringWithFormat:@"%@  %@",_model.commission,[FNBaseSettingModel settingInstance].CustomUnit];
        [self.views[2].valueLabel addSingleAttributed:@{NSFontAttributeName:kFONT17} ofRange: [self.views[2].valueLabel.text rangeOfString:_model.commission]];
    }
}
@end
