//
//  FNPSDateCell.m
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPSDateCell.h"
#import "FNCmbDoubleTextButton.h"
#import "FNProfitStatisticsModel.h"
const CGFloat _psdc_cell_height = 120 + 50;
const CGFloat _psde_ele_height = 120;
const CGFloat _psdc_date_height =  50;
@interface FNPSDateElementView:UIView

@property (nonatomic, strong)UILabel*   titleLabel;
@property (nonatomic, strong)UIView* titleview;

@property (nonatomic, strong)UIView* btnview;
@property (nonatomic, strong)FNCmbDoubleTextButton* leftBtn;
@property (nonatomic, strong)FNCmbDoubleTextButton* rightBtn;
@end
@implementation FNPSDateElementView
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = kFONT14;
        _titleLabel.textColor = FNGlobalTextGrayColor;
    }
    return _titleLabel;
}
- (UIView *)titleview{
    if (_titleview == nil) {
        _titleview = [UIView new];
        
        UILabel *Label = [UILabel new];
        Label.font = kFONT14;
        Label.textColor = FNGlobalTextGrayColor;
        [_titleview addSubview:Label];
        [Label autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
        [Label autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        
        Label.text=@"预估收入：";
        [Label HttpLabelLeftImage:[FNBaseSettingModel settingInstance].mon_icon label:Label imageX:0 imageY:-1.5 imageH:13 atIndex:Label.text.length];
        
        [_titleview addSubview:self.titleLabel];
        [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:Label withOffset:0];
        [self.titleLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    }
    return _titleview;
}


- (FNCmbDoubleTextButton *)leftBtn{
    if (_leftBtn == nil) {
        _leftBtn = [[FNCmbDoubleTextButton alloc]init];
        [_leftBtn.bottomLabel setTitleColor:FNGlobalTextGrayColor forState:(UIControlStateNormal)];
        _leftBtn.bottomLabel.titleLabel.font = kFONT12;
        [_leftBtn.topLable setTitleColor:FNBlackColor forState:(UIControlStateNormal)];
        _leftBtn.topLable.titleLabel.font = kFONT12;
    }
    return _leftBtn;
}
- (FNCmbDoubleTextButton *)rightBtn{
    if (_rightBtn == nil) {
        _rightBtn = [[FNCmbDoubleTextButton alloc]init];
        [_rightBtn.bottomLabel setTitleColor:FNGlobalTextGrayColor forState:(UIControlStateNormal)];
        _rightBtn.bottomLabel.titleLabel.font = kFONT12;
        [_rightBtn.topLable setTitleColor:FNBlackColor forState:(UIControlStateNormal)];
        _rightBtn.topLable.titleLabel.font = kFONT12;
    }
    return _rightBtn;
}
- (UIView *)btnview{
    if (_btnview == nil) {
        _btnview = [UIView new];
        
        CGFloat width = (JMScreenWidth-15*2)*0.5;
        [_btnview addSubview:self.leftBtn];
        [self.leftBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
        [self.leftBtn autoSetDimension:(ALDimensionWidth) toSize:width*0.5];
        [self.leftBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.leftBtn autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionHeight) ofView:_btnview withMultiplier:0.7];
        
        [_btnview addSubview:self.rightBtn];
        [self.rightBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.leftBtn withOffset:0];
        [self.rightBtn autoSetDimension:(ALDimensionWidth) toSize:width*0.5];
        [self.rightBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.rightBtn autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionHeight) ofView:_btnview withMultiplier:0.7];

    }
    return _btnview;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self jm_setupViews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    //
    [self addSubview:self.titleview];
    [self.titleview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.titleview autoSetDimension:(ALDimensionHeight) toSize:40];
    
    [self addSubview:self.btnview];
    [self.btnview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.btnview autoSetDimension:(ALDimensionHeight) toSize:80];
    
}
@end

@interface FNPSDateCell()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView* scrollview;
@property (nonatomic, strong)FNPSDateElementView* todayInfoView;
@property (nonatomic, strong)FNPSDateElementView* yesterdayInfoView;

@property (nonatomic, strong)UIView* dateView;
@property (nonatomic, strong)UIButton* todaybtn;
@property (nonatomic, strong)UIButton* yesterdaybtn;
@end
@implementation FNPSDateCell
- (UIButton *)todaybtn{
    if (_todaybtn == nil) {
        
        _todaybtn = [UIButton buttonWithTitle:@"今天" titleColor:FNGlobalTextGrayColor font:kFONT14 target:self action:@selector(buttonClicked:)];
        [_todaybtn setTitleColor:FNMainGobalControlsColor forState:(UIControlStateSelected)];
        
        [_todaybtn sizeToFit];
    }
    return _todaybtn;
}
- (UIButton *)yesterdaybtn{
    if (_yesterdaybtn == nil) {
        _yesterdaybtn = [UIButton buttonWithTitle:@"昨天" titleColor:FNGlobalTextGrayColor font:kFONT14 target:self action:@selector(buttonClicked:)];
        [_yesterdaybtn setTitleColor:FNMainGobalControlsColor forState:(UIControlStateSelected)];
        [_yesterdaybtn sizeToFit];
    }
    return _yesterdaybtn;
}

- (UIView *)dateView{
    if (_dateView == nil) {
        _dateView = [UIView new];
        
        CGFloat margin = (JMScreenWidth - self.todaybtn.width*2)*0.25;
        [_dateView addSubview:self.todaybtn];
        [self.todaybtn autoSetDimensionsToSize:self.todaybtn.size];
        [self.todaybtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:margin];
        [self.todaybtn autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
        
        [_dateView addSubview:self.yesterdaybtn];
        [self.yesterdaybtn autoSetDimensionsToSize:self.yesterdaybtn.size];
        [self.yesterdaybtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin];
        [self.yesterdaybtn autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
    }
    return _dateView;
}
- (FNPSDateElementView *)todayInfoView{
    if (_todayInfoView == nil) {
        _todayInfoView = [[FNPSDateElementView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, _psde_ele_height))];
        _todayInfoView.titleLabel.text = [NSString stringWithFormat:@" 0.00"];
        [_todayInfoView.leftBtn.topLable setTitle:@" 0.00" forState:(UIControlStateNormal)];
        [_todayInfoView.leftBtn.bottomLabel setTitle:@"自己推广" forState:(UIControlStateNormal)];
        [_todayInfoView.rightBtn.topLable setTitle:@" 0.00" forState:(UIControlStateNormal)];
        [_todayInfoView.rightBtn.bottomLabel setTitle:@"团队推广" forState:(UIControlStateNormal)];
        
    }
    return _todayInfoView;
}
- (FNPSDateElementView *)yesterdayInfoView{
    if (_yesterdayInfoView == nil) {
        _yesterdayInfoView = [[FNPSDateElementView alloc]initWithFrame:(CGRectMake(JMScreenWidth, 0, JMScreenWidth, _psde_ele_height))];
        _yesterdayInfoView.titleLabel.text = [NSString stringWithFormat:@" 0.00"];
        [_yesterdayInfoView.leftBtn.topLable setTitle:@" 0.00" forState:(UIControlStateNormal)];
        [_yesterdayInfoView.leftBtn.bottomLabel setTitle:@"自己推广" forState:(UIControlStateNormal)];
        [_yesterdayInfoView.rightBtn.topLable setTitle:@" 0.00" forState:(UIControlStateNormal)];
        [_yesterdayInfoView.rightBtn.bottomLabel setTitle:@"团队推广" forState:(UIControlStateNormal)];
    }
    return _yesterdayInfoView;
}
- (UIScrollView *)scrollview{
    if (_scrollview == nil) {
        _scrollview = [[UIScrollView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, _psde_ele_height))];
        _scrollview.contentSize = CGSizeMake(JMScreenWidth*2, _psde_ele_height);
        _scrollview.pagingEnabled = YES;
        _scrollview.bounces = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        [_scrollview addSubview:self.todayInfoView];
        
        [_scrollview addSubview:self.yesterdayInfoView];
        
    }
    return _scrollview;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    //
    [self.contentView addSubview:self.dateView];
    [self.dateView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.dateView autoSetDimension:(ALDimensionHeight) toSize:_psdc_date_height];
    [self.contentView addSubview:self.scrollview];
    [self.scrollview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.scrollview autoSetDimension:(ALDimensionHeight) toSize:_psde_ele_height];
    
    [self buttonClicked:self.todaybtn];
    
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNPSDateCell";
    FNPSDateCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNPSDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}

- (void)setDatas:(NSArray<PStoday_yes *> *)datas{
    _datas = datas;
    if (_datas.count>=1) {
        _todayInfoView.titleLabel.text = [NSString stringWithFormat:@" %.2lf",[self.datas[0].hl_money floatValue]];
        _todayInfoView.titleLabel.attributedText = [NSString attributedStringWithString:_todayInfoView.titleLabel.text attributed:@{NSFontAttributeName:kFONT17} fromString:@" " toString:@"." isNotContainedFirst:YES];

        NSString* left = [NSString stringWithFormat:@" %.2lf",[self.datas[0].money floatValue]];
        NSString* right = [NSString stringWithFormat:@" %.2lf",[self.datas[0].teammoney floatValue]];
        [_todayInfoView.leftBtn.topLable setTitle:left forState:(UIControlStateNormal)];
        [_todayInfoView.leftBtn.topLable setAttributedTitle:[NSString attributedStringWithString:left attributed:@{NSFontAttributeName:kFONT17} fromString:@" " toString:@"." isNotContainedFirst:YES] forState:(UIControlStateNormal)];
        
        [_todayInfoView.rightBtn.topLable setTitle:[NSString stringWithFormat:@" %.2lf",[self.datas[0].teammoney floatValue]] forState:(UIControlStateNormal)];
        [_todayInfoView.rightBtn.topLable setAttributedTitle:[NSString attributedStringWithString:right attributed:@{NSFontAttributeName:kFONT17} fromString:@" " toString:@"." isNotContainedFirst:YES] forState:(UIControlStateNormal)];
        
        [self HttpImage:[FNBaseSettingModel settingInstance].mon_icon Btn:_todayInfoView.rightBtn.topLable];
        [self HttpImage:[FNBaseSettingModel settingInstance].mon_icon Btn:_todayInfoView.leftBtn.topLable];
        
        _yesterdayInfoView.titleLabel.text = [NSString stringWithFormat:@" %.2lf",[self.datas[1].hl_money floatValue]];
        _yesterdayInfoView.titleLabel.attributedText = [NSString attributedStringWithString:_yesterdayInfoView.titleLabel.text attributed:@{NSFontAttributeName:kFONT17} fromString:@" " toString:@"." isNotContainedFirst:YES];
        
        NSString* y_left = [NSString stringWithFormat:@" %.2lf",[self.datas[1].money floatValue]];
        NSString* y_right = [NSString stringWithFormat:@" %.2lf",[self.datas[1].teammoney floatValue]];
        [_yesterdayInfoView.leftBtn.topLable setTitle:y_left forState:(UIControlStateNormal)];
        [_yesterdayInfoView.leftBtn.topLable setAttributedTitle:[NSString attributedStringWithString:y_left attributed:@{NSFontAttributeName:kFONT17} fromString:@" " toString:@"." isNotContainedFirst:YES] forState:(UIControlStateNormal)];
        
        [_yesterdayInfoView.rightBtn.topLable setTitle:[NSString stringWithFormat:@" %.2lf",[self.datas[1].teammoney floatValue]] forState:(UIControlStateNormal)];
        [_yesterdayInfoView.rightBtn.topLable setAttributedTitle:[NSString attributedStringWithString:y_right attributed:@{NSFontAttributeName:kFONT17} fromString:@" " toString:@"." isNotContainedFirst:YES] forState:(UIControlStateNormal)];
        
        [self HttpImage:[FNBaseSettingModel settingInstance].mon_icon Btn:_yesterdayInfoView.rightBtn.topLable];
        [self HttpImage:[FNBaseSettingModel settingInstance].mon_icon Btn:_yesterdayInfoView.leftBtn.topLable];
    }
}

#pragma mark - action
- (void)buttonClicked:(UIButton *)btn{
    UIButton* otherbtn = [UIButton new];
    CGFloat value = 0;//scroll value
    if (btn == self.todaybtn) {
        self.todaybtn.selected = YES;
        self.yesterdaybtn.selected = NO;
        otherbtn = self.yesterdaybtn;
        value  = 0;
    }else{
        self.yesterdaybtn.selected = YES;
        self.todaybtn.selected = NO;
        otherbtn = self.todaybtn;
        value = JMScreenWidth;
    }
    [UIView animateWithDuration:0.3 animations:^{
        otherbtn.transform = CGAffineTransformIdentity;
        btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [self.scrollview setContentOffset:(CGPointMake(value, 0)) animated:YES];
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x >= JMScreenWidth) {
        [self buttonClicked:self.yesterdaybtn];
    }else{
        [self buttonClicked:self.todaybtn];
    }
}

//异步获取Label的图片
-(void)HttpImage:(NSString *)imgUrl Btn:(UIButton *)Btn{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL(imgUrl)]];
        img=[img scaleFromImage:img toSize:CGSizeMake(img.size.width/img.size.height*13, 13)];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [Btn setImage:img forState:UIControlStateNormal];
        });
    });
}
@end
