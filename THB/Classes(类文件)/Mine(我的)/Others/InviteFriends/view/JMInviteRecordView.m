//
//  JMInviteRecordView.m
//  THB
//
//  Created by jimmy on 2017/4/7.
//  Copyright © 2017年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "JMInviteRecordView.h"
#import "JMInviteFriendModel.h"
@interface JMInviteRecordSingleView : UIView
@property (nonatomic, weak)UILabel* firstLabel;
@property (nonatomic, weak)UILabel* secondLabel;
@property (nonatomic, weak)UILabel* thirdLabel;
@end
@implementation JMInviteRecordSingleView
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
    UILabel* firstLabel = [UILabel new];
    firstLabel.adjustsFontSizeToFitWidth = YES;
    firstLabel.font =kFONT14;
    firstLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:firstLabel];
    _firstLabel = firstLabel;
    
    UILabel* secondLabel = [UILabel new];
    secondLabel.adjustsFontSizeToFitWidth = YES;
    secondLabel.font =kFONT14;
    secondLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:secondLabel];
    _secondLabel = secondLabel;
    
    UILabel* thirdLabel = [UILabel new];
    thirdLabel.adjustsFontSizeToFitWidth = YES;
    thirdLabel.font =kFONT14;
    thirdLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:thirdLabel];
    _thirdLabel = thirdLabel;
    
    [_firstLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(5, 5, 5, 5)) excludingEdge:(ALEdgeBottom)];
    
    [_thirdLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(5, 5, 5, 5)) excludingEdge:(ALEdgeTop)];
    
    [_secondLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
    [_secondLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
    [_secondLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
}

@end
@interface JMInviteRecordView ()
@property (nonatomic, weak) UIImageView*  bgImgView;
@property (nonatomic, weak) UIImageView*  titleImgView;
@property (nonatomic, weak) UIImageView* coinImgView;
@property (nonatomic, strong)NSMutableArray<JMInviteRecordSingleView *>* recordViews;
@end
@implementation JMInviteRecordView

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
    UIImageView* bgImgView = [UIImageView new];
    bgImgView.image = IMAGE(@"invite_record_bj");
    [self addSubview:bgImgView];
    _bgImgView = bgImgView;
    
    UIImageView* titleImgView = [UIImageView new];
    titleImgView.image = IMAGE(@"invite_record_word");
    [titleImgView sizeToFit];
    [self addSubview:titleImgView];
    _titleImgView = titleImgView;
    
    UIImageView*  coinImgView = [UIImageView new];
    coinImgView.image = IMAGE(@"invite_record_coin");
    [coinImgView sizeToFit];
    [self addSubview:coinImgView];
    _coinImgView  = coinImgView;
    
    NSArray* firsts = @[@"成功邀请",@"已获得",@"已获得"];
    NSString* second = @"0";
    NSArray* thirds = @[@"位好友",@"元返利",@"次抢红包机会"];
  
    @WeakObj(self);
    [firsts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JMInviteRecordSingleView* view = [[JMInviteRecordSingleView alloc]init];
        view.firstLabel.text = obj;
        view.secondLabel.text = second;
        view.thirdLabel.text = thirds[idx];
        view.firstLabel.font = kFONT12;
        view.thirdLabel.font = kFONT12;
        view.secondLabel.font = [UIFont boldSystemFontOfSize:25];
        view.secondLabel.textColor = RED;
        [selfWeak addSubview:view];
        [selfWeak.recordViews addObject:view];
    }];
    
    //layout
    [_bgImgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    
    [_coinImgView autoSetDimensionsToSize:(_coinImgView.size)];
    [_coinImgView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    [_coinImgView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    
    
    [_titleImgView autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_bgImgView withOffset:_jm_leftMargin];
    [_titleImgView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_coinImgView withOffset:0];
    [_titleImgView autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_bgImgView withOffset:-_jm_leftMargin];
    [_titleImgView autoSetDimension:(ALDimensionHeight) toSize:(_titleImgView.height*FNDeviceWidth-_jm_leftMargin*2)/(_titleImgView.width-_jm_leftMargin*2)];
    

    CGFloat width = self.width/3;
    CGFloat height = 15*4 + 30;
    [self.recordViews enumerateObjectsUsingBlock:^(JMInviteRecordSingleView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:selfWeak.titleImgView withOffset: _jm_leftMargin];
        [obj autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:idx*width];
        [obj autoSetDimensionsToSize:(CGSizeMake(width, height))];
    }];
    
    [self.bgImgView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.recordViews[0] withOffset:_jm_margin10];
    [self layoutIfNeeded];
    self.height = CGRectGetMaxY(self.bgImgView.frame);
    self.viewHeight = self.height;
}

- (NSMutableArray <JMInviteRecordSingleView *>*)recordViews
{
    if (_recordViews == nil) {
        _recordViews = [NSMutableArray new];
    }
    return _recordViews;
}
- (void)setModel:(JMInviteFriendModel *)model{
    _model = model;
    if (_model ) {
        self.recordViews[0].secondLabel.text = _model.yqcount;
        
        self.recordViews[1].secondLabel.text = [NSString stringWithFormat:@"%.2f",[_model.flmoney floatValue]];
        self.recordViews[1].thirdLabel.text =  _model.mon_str;
        self.recordViews[2].secondLabel.text = _model.hbcount;
        XYLog(@"flmoney:%@",_model.flmoney);
    }
}
@end
