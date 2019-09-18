//
//  FNHLFPayView.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 2017/1/9.
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
#import "FNHLFPayView.h"

@interface FNHLFPayViewCell : UITableViewCell
@property (nonatomic, weak) UIImageView* imgView;
@property (nonatomic, weak) UILabel* firstLabel;
@property (nonatomic, weak) UILabel* secondLabel;
@property (nonatomic, weak) UIButton * selectedBtn;
@property (nonatomic, strong)NSIndexPath* indexPath;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
@implementation FNHLFPayViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{

    
    UIImageView *imgView = [UIImageView new];
    [self.contentView addSubview:imgView];
    _imgView = imgView;
    
    UILabel* firstlable = [UILabel new];
    firstlable.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:firstlable];
    _firstLabel = firstlable;
    
    UILabel* secondLabel = [UILabel new];
    secondLabel.font = kFONT13;
    secondLabel.textColor = FNGlobalTextGrayColor;
    [self.contentView addSubview:secondLabel];
    _secondLabel = secondLabel;
    
    UIButton *selectedBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [selectedBtn setImage:[UIImage imageNamed:@"payc_yes"] forState:UIControlStateNormal];
    [selectedBtn sizeToFit];
    selectedBtn.hidden = YES;
    [self addSubview:selectedBtn];
    _selectedBtn = selectedBtn;
    
    //layout
    CGFloat width = 20;
    [_imgView autoSetDimensionsToSize:CGSizeMake(width, width)];
    [_imgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [_imgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_firstLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_imgView withOffset:LeftSpace];
    [_firstLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_secondLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_firstLabel withOffset:10];
    [_secondLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_selectedBtn autoSetDimensionsToSize:_selectedBtn.size];
    [_selectedBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_selectedBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:LeftSpace];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    _selectedBtn.hidden = !selected;
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNHLFPayViewCell";
    FNHLFPayViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNHLFPayViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}

@end
@implementation FNHLFPayView

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
    UIView *mainView = [UIView new];
    mainView.backgroundColor = FNWhiteColor;
    [self addSubview:mainView];
    _mainView = mainView;
    
    UIButton *closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [closeBtn setImage:[UIImage imageNamed:@"payc_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn sizeToFit];
    [_mainView addSubview:closeBtn];
    
    UILabel *label = [UILabel new];
    label.text = @"选择支付";
    label.font = kFONT16;
    [label sizeToFit];
    [_mainView addSubview:label];
    
    UIView* line = [UIView new];
    line.backgroundColor = FNHomeBackgroundColor;
    [_mainView addSubview:line];
    
    
    //layout
    CGFloat margin = 10;
    [closeBtn autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:margin];
    [closeBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [closeBtn autoSetDimensionsToSize:closeBtn.size];
    
    [label autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [label autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:margin];
    
    [line autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:closeBtn withOffset:margin];
    [line autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [line autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [line autoSetDimension:(ALDimensionHeight) toSize:1.0];
    
    
    _titleView = [UIView new];
    _titleView.backgroundColor = FNWhiteColor;
    
    _titleLable = [UILabel new];
    _titleLable.font = kFONT14;
    _titleLable.textAlignment = NSTextAlignmentCenter;
    [_titleView addSubview:_titleLable];
    
    [_titleLable autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:LeftSpace];
    [_titleLable autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [_titleLable autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:LeftSpace];
    
    _mValueLabel = [ UILabel new];
    _mValueLabel.font = [UIFont boldSystemFontOfSize:24];
    _mValueLabel.textAlignment = NSTextAlignmentCenter;
    [_titleView addSubview:_mValueLabel];
    [_mValueLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_titleLable withOffset:margin];
    [_mValueLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [_mValueLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:LeftSpace];
    
    _titleView.frame = CGRectMake(0, 0, FNDeviceWidth, 75);
    
    UIView *footerView = [UIView new];
    
    UIButton *payButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [payButton setImage:[UIImage imageNamed:@"payc_safe"] forState:UIControlStateNormal];
    [payButton setTitle:@"立即支付" forState:UIControlStateNormal];
    payButton.backgroundColor = FNMainGobalControlsColor;
    [payButton addTarget:self action:@selector(payRightNow) forControlEvents:UIControlEventTouchUpInside];
    payButton.cornerRadius = 5;
    
    [payButton setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    payButton.frame = CGRectMake(10, 30, FNDeviceWidth-20, 40);
    
    [footerView addSubview:payButton];
    footerView.frame = CGRectMake(0, 0, FNDeviceWidth, 90);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.scrollEnabled = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableHeaderView = _titleView;
    tableView.tableFooterView = footerView;
    [_mainView addSubview:tableView];
    _tableView = tableView;
    
    
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [_tableView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:line];
    
    [self layoutIfNeeded];
    _mainView.height = _titleView.height + footerView.height + 44*1 + closeBtn.height+20;
    _mainView.x = 0;
    _mainView.width = FNDeviceWidth;
    _mainView.y = FNDeviceHeight - _mainView.height;
    
}
- (void)closeBtnAction{
    [FNTipsView showTips:@"取消付款"];
    [self dismissWithFlag:NO];
}
- (void)payRightNow{
   
    if (self.choosed) {
        self.choosed(self.tableView.indexPathForSelectedRow.row);
        [self dismissWithFlag:YES];
    }
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNHLFPayViewCell *cell = [FNHLFPayViewCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.firstLabel.text = indexPath.row == 0  ?@"支付宝":@"余额支付";
    cell.secondLabel.text = indexPath.row == 0 ?@"安全快速的电子支付":[NSString stringWithFormat:@"(剩余%@元)",_balance];
    cell.imgView.image = [UIImage imageNamed:indexPath.row==0 ?@"pay_alipay":(self.balance.floatValue < self.mvalue.floatValue)?@"payc__wallet1":@"payc__wallet"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1 && ( _balance.floatValue <= 0 || _balance.floatValue < _mvalue.floatValue)) {
        [FNTipsView showTips:@"余额不足，请选择其他方式付款"];
        [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:(UITableViewScrollPositionMiddle)];
    }
}


#pragma mark -  override

- (void)setName:(NSString *)name{
    _name = name;
    _titleLable.text = _name;

}
- (void)setMvalue:(NSString *)mvalue{
    _mvalue = mvalue;
    _mValueLabel.text =[NSString stringWithFormat:@"¥%@", _mvalue];
}

#pragma mark - public method
- (void)showWihtBlock:(wayChoosed)choosed{
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:(UITableViewScrollPositionMiddle)];
    
    self.choosed = choosed;
    self.frame = FNKeyWindow.bounds;
    [FNKeyWindow addSubview:self];
    _mainView.y = self.height;
    [UIView animateWithDuration:0.3 animations:^{
        _mainView.y = FNDeviceHeight-_mainView.height;
        self.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.5];
    }];
}
- (void)dismissWithFlag:(BOOL)flag{
    @WeakObj(self);
    [UIView animateWithDuration:0.3 animations:^{
        _mainView.y = self.height;
        self.backgroundColor = self.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.0];;
    } completion:^(BOOL finished) {
        if (finished) {
            if (selfWeak.dismissBlock) {
                selfWeak.dismissBlock(flag);
            }
              [self removeFromSuperview];
        }
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[touches allObjects] firstObject];
    CGPoint point = [touch locationInView:touch.view];
    if (point.y < _mainView.y) {
        [FNTipsView showTips:@"取消付款"];
        [self dismissWithFlag:NO];
    }
}
@end
