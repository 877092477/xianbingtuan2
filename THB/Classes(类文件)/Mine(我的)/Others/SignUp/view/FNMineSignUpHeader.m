//
//  FNMineSignUpHeader.m
//  THB
//
//  Created by Jimmy on 2018/1/17.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNMineSignUpHeader.h"
#import "FNMineSignUpModel.h"
@interface FNMineSignUpHeaderCell:UICollectionViewCell
@property (nonatomic, strong)UIButton* iconBtn;
@property (nonatomic, strong)UIButton* lineBtn;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic,strong)NSIndexPath* indexPath;
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end
@implementation FNMineSignUpHeaderCell
- (UIButton *)iconBtn{
    if (_iconBtn == nil) {
        _iconBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_iconBtn setImage:IMAGE(@"sign_day_off") forState:(UIControlStateNormal)];
        [_iconBtn setImage:IMAGE(@"sign_day_on") forState:(UIControlStateSelected)];
        [_iconBtn sizeToFit];
        _iconBtn.size = CGSizeMake(15, 15);
    }
    return _iconBtn;
}
- (UIButton *)lineBtn{
    if (_lineBtn == nil) {
        _lineBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_lineBtn setBackgroundImage:[UIImage createImageWithColor:RGB(221, 221, 221)] forState:(UIControlStateNormal)];
        [_lineBtn setBackgroundImage:[UIImage createImageWithColor:RGB(252, 17, 90)] forState:(UIControlStateSelected)];
        
        
    }
    return _lineBtn;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = kFONT12;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jm_setupViews];
    }
    return self;
}
- (void)jm_setupViews{
    self.clipsToBounds = NO;
    [self.contentView addSubview:self.iconBtn];
    [self.iconBtn autoSetDimensionsToSize:self.iconBtn.size];
    [self.iconBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:2.5];
    [self.iconBtn autoConstrainAttribute:ALEdgeBottom toAttribute:ALAxisHorizontal ofView:self.contentView withOffset:-2.5];
    
    [self.contentView addSubview:self.lineBtn];
    [self.lineBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:2.5];
    [self.lineBtn autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.iconBtn];
    [self.lineBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.iconBtn withOffset:2.5];
    [self.lineBtn autoSetDimension:(ALDimensionHeight) toSize:2];
    
    [self.contentView addSubview:self.titleLabel];
//    [self.titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:2.5];
    [self.titleLabel autoAlignAxis:(ALAxisVertical) toSameAxisOfView:self.iconBtn];
    [self.titleLabel autoConstrainAttribute:ALEdgeTop toAttribute:ALAxisHorizontal ofView:self.contentView withOffset:2.5];
    [self.titleLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self.contentView withOffset:0.8];
    
}
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNMineSignUpHeaderCell";
    FNMineSignUpHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}
@end
@interface FNMineSignUpHeader()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UIImageView* bgimgview;
@property (nonatomic, strong)UIView* contentview;
@property (nonatomic, strong)UIImageView* titleImgView;
@property (nonatomic, strong)UILabel* whichDayLabel;
@property (nonatomic, strong)UIButton* signupBtn;

@end
@implementation FNMineSignUpHeader
- (UIImageView *)bgimgview{
    if (_bgimgview == nil) {
        UIImage* img = IMAGE(@"sign_day_bj");
        _bgimgview = [UIImageView new];
        _bgimgview.image = img;
        _bgimgview.size = CGSizeMake(JMScreenWidth,img.size.height/img.size.width*JMScreenWidth);
        _bgimgview.userInteractionEnabled = YES;
        
        [_bgimgview addSubview:self.contentview];
        [self.contentview autoCenterInSuperview];
        [self.contentview autoSetDimension:(ALDimensionWidth) toSize:self.jm_collectionview.width];
        [self.contentview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.signupBtn ];
        
    }
    return _bgimgview;
}
- (UIView *)contentview{
    if (_contentview==nil) {
        _contentview = [UIView new];
        
        [_contentview addSubview:self.titleImgView];
        [self.titleImgView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        [self.titleImgView autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        [self.titleImgView autoSetDimensionsToSize:self.titleImgView.size];
        
        [_contentview addSubview:self.whichDayLabel];
        [self.whichDayLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [self.whichDayLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.whichDayLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleImgView withOffset:_jmsize_10];
        [self.whichDayLabel autoSetDimension:(ALDimensionHeight) toSize:35];
        
        CGFloat tmp = 0.87*JMScreenWidth;
        CGFloat cellw = tmp*0.13;
        CGFloat width = cellw*7;
        
        UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
        flowlayout.minimumLineSpacing = 0;
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowlayout.minimumInteritemSpacing = 0;
        flowlayout.sectionInset = UIEdgeInsetsZero;
        
        self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectMake(0, 0, width, cellw)) collectionViewLayout:flowlayout];
        self.jm_collectionview.dataSource  = self;
        self.jm_collectionview.delegate = self;
        self.jm_collectionview.clipsToBounds = NO;
        self.jm_collectionview.emptyDataSetSource = nil;
        self.jm_collectionview.emptyDataSetDelegate = nil;
        [self.jm_collectionview registerClass:[FNMineSignUpHeaderCell class] forCellWithReuseIdentifier:@"FNMineSignUpHeaderCell"];
        [_contentview addSubview:self.jm_collectionview];
        [self.jm_collectionview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.whichDayLabel withOffset:_jmsize_10];
        [self.jm_collectionview autoSetDimensionsToSize:self.jm_collectionview.size];
        [self.jm_collectionview autoAlignAxis:(ALAxisVertical) toSameAxisOfView:_contentview withOffset:_jmsize_10];
        
        [_contentview addSubview:self.signupBtn];
        [self.signupBtn autoSetDimensionsToSize:self.signupBtn.size];
        [self.signupBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.jm_collectionview withOffset: self.bgimgview.height*0.1];
        [self.signupBtn autoAlignAxisToSuperviewAxis:(ALAxisVertical)];

    }
    return _contentview;
}
- (UIImageView *)titleImgView{
    if (_titleImgView == nil) {
        _titleImgView = [[UIImageView alloc]initWithImage:IMAGE(@"sign_continuous_bj")];
        UILabel* titleLabel  =[UILabel new];
        titleLabel.textColor  = FNWhiteColor;
        titleLabel.font = kFONT14;
        titleLabel.text = @"已连续签到";
        [_titleImgView addSubview:titleLabel];
        [titleLabel autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        [titleLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:_titleImgView withOffset:-5];
    }
    return _titleImgView;
}
- (UILabel *)whichDayLabel{
    if (_whichDayLabel == nil) {
        _whichDayLabel = [UILabel new];
        _whichDayLabel.font = kFONT15;
        _whichDayLabel.textAlignment = NSTextAlignmentCenter;
        _whichDayLabel.textColor = FNGlobalTextGrayColor;
    }
    return _whichDayLabel;
}
- (UIButton *)signupBtn{
    if (_signupBtn == nil) {
        _signupBtn = [UIButton buttonWithTitle:@"签到领积分" titleColor:FNWhiteColor font:kFONT15 target:self action:@selector(sginupBtnAction)];
        [_signupBtn setBackgroundImage:IMAGE(@"sign_brn") forState:(UIControlStateNormal)];
        [_signupBtn sizeToFit];
    }
    return _signupBtn;
}
- (void)jm_setupViews{
    
    self.height = self.bgimgview.height;
    [self addSubview:self.bgimgview];
    [self.bgimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    [self.bgimgview autoSetDimension:(ALDimensionHeight) toSize:self.bgimgview.height];
}
#pragma mark - Colleciton view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.week.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNMineSignUpHeaderCell* cell = [FNMineSignUpHeaderCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    cell.titleLabel.text = self.model.week[indexPath.item].name;
    cell.iconBtn.selected = self.model.week[indexPath.item].is_check.boolValue;
    cell.lineBtn.selected = self.model.week[indexPath.item].is_check.boolValue;
    cell.lineBtn.hidden = indexPath.item == self.model.week.count-1;
    return cell;
}
#pragma mark - Collection view delegate flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellw = self.jm_collectionview.width/7-2;
    CGFloat cellh = cellw;
    CGSize size = CGSizeMake(cellw, cellh);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - action
- (void)sginupBtnAction{
    if (self.signUpClicked) {
        self.signUpClicked();
    }
}
- (void)setModel:(FNMineSignUpModel *)model{
    _model = model;
    if (_model) {
        [self.jm_collectionview reloadData];
        [self.signupBtn setTitle:self.model.str  forState:(UIControlStateNormal)];
        self.whichDayLabel.text = [NSString stringWithFormat:@"第   %@  天",self.model.tianshu];
        if (![NSString isEmpty:self.model.tianshu]) {
            [self.whichDayLabel addSingleAttributed:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:30],NSForegroundColorAttributeName:FNMainGobalControlsColor} ofRange:[self.whichDayLabel.text rangeOfString:self.model.tianshu]];
        }
    }
}
@end
