//
//  FNShareMutiplyView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNShareMutiplyView.h"
#import "FNShareMutiplyViewModel.h"
#import "FNCustomeTextView.h"
#import "FNFunctionBtnView.h"

@interface FNShareMutiplyCell:UICollectionViewCell
@property (nonatomic, strong)UIImageView* imgview;
@property (nonatomic, strong)UIButton* chooseBtn;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end
@implementation FNShareMutiplyCell
- (UIButton *)chooseBtn{
    if (_chooseBtn == nil) {
        _chooseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_chooseBtn setImage:IMAGE(@"share_choose_off") forState:(UIControlStateNormal)];
        [_chooseBtn setImage:IMAGE(@"gschoose_onNew") forState:(UIControlStateSelected)];
        _chooseBtn.userInteractionEnabled = NO;
        [_chooseBtn sizeToFit];
    }
    return _chooseBtn;
}
- (UIImageView *)imgview{
    if (_imgview  == nil) {
        _imgview = [UIImageView new];
        _imgview.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgview;
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
    [self.contentView addSubview:self.imgview];
    [self.imgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    [self.contentView addSubview:self.chooseBtn];
    
    self.chooseBtn.sd_layout.centerXEqualToView(self.imgview);
    [self.chooseBtn autoSetDimensionsToSize:self.chooseBtn.size];
    
   

    
    
    
    
}
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNShareMutiplyCell";
    FNShareMutiplyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}
@end



@interface FNShareMutiplyView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)FNShareMutiplyViewModel*  viewmodel;
@property (nonatomic, strong)UIView* topview;
@property (nonatomic, strong)UILabel* chooseLabel;

@property (nonatomic, strong)UIView* midview;
@property (nonatomic, strong)FNCustomeTextView* textview;
@property (nonatomic, strong)UIButton* copybtn;

@property (nonatomic, strong)UIView* btmview;


//line
@property (nonatomic, strong)UILabel *midline;
//商品详情View
@property (nonatomic, strong)UIView *productBgView;
//商品名字
@property (nonatomic, strong)UILabel *productName;
//商品价格
@property (nonatomic, strong)UILabel *productPrice;
//商品分享或升级
@property (nonatomic, strong)UIButton*sharebtn;
@end
@implementation FNShareMutiplyView
- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self.viewmodel =(FNShareMutiplyViewModel*) viewModel;
    return  [super initWithViewModel:viewModel];
}

#pragma mark - initializedSubviews
//商品详情
-(void)productDetails{
    self.productBgView=[UIView new];
    [self addSubview:self.productBgView];
    UIImageView *productType=[UIImageView new];
    [self.productBgView addSubview:productType];
    self.productName=[UILabel new];
    self.productName.font=kFONT14;
    self.productName.numberOfLines=2;
    [self.productBgView addSubview:self.productName];
    self.productPrice=[UILabel new];
    self.productPrice.font=kFONT16;
    self.productPrice.textColor=RGB(255, 21, 101);
    [self.productBgView addSubview:self.productPrice];
    self.sharebtn = [UIButton buttonWithTitle:@"分享赚¥1.48" titleColor:FNWhiteColor font:kFONT12 target:self action:@selector(copybtnAction)];
    [self.sharebtn setBackgroundImage:IMAGE(@"gs_bjNew") forState:UIControlStateNormal];
    [self.sharebtn sizeToFit];
    self.sharebtn.cornerRadius=5;
    [self.productBgView addSubview:self.sharebtn];
    UILabel *line=[UILabel new];
    line.backgroundColor=RGB(238, 238, 238);
    [self.productBgView addSubview:line];
    
    self.productBgView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topEqualToView(self).heightIs(100);
    
    self.productName.sd_layout
    .leftSpaceToView(self.productBgView, _jmsize_10).topSpaceToView(self.productBgView,_jmsize_10).rightSpaceToView(self.productBgView, _jmsize_10).heightIs(40);
    
    self.productPrice.sd_layout
    .leftSpaceToView(self.productBgView, _jmsize_10).topSpaceToView(self.productName,_jmsize_10).heightIs(40);
    [self.productPrice setSingleLineAutoResizeWithMaxWidth:100];
    
    self.sharebtn.sd_layout
    .rightSpaceToView(self.productBgView, _jmsize_10).heightIs(20).centerYEqualToView(self.productPrice).widthIs(100);
    //[self.sharebtn autoSetDimensionsToSize:self.sharebtn.size];
    
    line.sd_layout
    .bottomEqualToView(self.productBgView).leftSpaceToView(self.productBgView, _jmsize_10).rightSpaceToView(self.productBgView, _jmsize_10).heightIs(1);
    
   
    
}
- (UILabel *)chooseLabel{
    if (_chooseLabel == nil) {
        _chooseLabel = [UILabel new];
        _chooseLabel.font = kFONT14;
        
    }
    return _chooseLabel;
}
- (UIView *)topview{
    if (_topview == nil) {
        _topview = [UIView new];
        //修改位置到底部
        //UILabel * tmplabel  =[ UILabel new];
        //tmplabel.font = kFONT14;
        //tmplabel.text = @"选择图片";
        //[_topview addSubview:tmplabel];
        //[tmplabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        //[tmplabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jmsize_10];
        
        //[_topview addSubview:self.chooseLabel];
        //[self.chooseLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        //[self.chooseLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:tmplabel];
        
        UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
        flowlayout.minimumLineSpacing = 10;
        flowlayout.minimumInteritemSpacing = 10;
        flowlayout.sectionInset = UIEdgeInsetsZero;
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
        self.jm_collectionview.dataSource = self;
        self.jm_collectionview.delegate = self;
        [_topview addSubview:self.jm_collectionview];
        [self.jm_collectionview registerClass:[FNShareMutiplyCell class] forCellWithReuseIdentifier:@"FNShareMutiplyCell"];
        [self.jm_collectionview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:_topview withOffset:_jmsize_10];
        [self.jm_collectionview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [self.jm_collectionview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.jm_collectionview autoSetDimension:(ALDimensionHeight) toSize:0.4*JMScreenHeight];
        
        
    }
    return _topview;
}

//mid view
- (FNCustomeTextView *)textview{
    if (_textview == nil) {
        _textview = [FNCustomeTextView new];
        _textview.placeholder = @"编辑分享文案";
        //_textview.backgroundColor = RGB(233, 233, 233);
        //_textview.textView.backgroundColor = RGB(233, 233, 233);
        _textview.backgroundColor = [UIColor whiteColor];
        _textview.textView.backgroundColor=[UIColor whiteColor];
        _textview.cornerRadius = 5;
        
    }
    return _textview;
}
- (UIButton *)copybtn{
    if (_copybtn == nil) {
        _copybtn = [UIButton buttonWithTitle:@" 复制文案" titleColor:FNMainGobalControlsColor font:kFONT14 target:self action:@selector(copybtnAction)];
        [_copybtn setImage:IMAGE(@"share_copy1") forState:(UIControlStateNormal)];
        [_copybtn sizeToFit];
    }
    return _copybtn;
}
- (UIView *)midview{
    if (_midview == nil) {
        _midview = [UIView new];
        _midview.backgroundColor=[UIColor whiteColor];
        //UILabel * tmplabel  =[ UILabel new];
        //tmplabel.font = kFONT14;
        //tmplabel.text = @"编辑分享文案";
        //[_midview addSubview:tmplabel];
        //[tmplabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        //[tmplabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jmsize_10];
        
        [_midview addSubview:self.textview];
        //[self.textview autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:tmplabel];
        [self.textview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [self.textview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:_midview withOffset:_jmsize_10];
        [self.textview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.textview autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionWidth) ofView:self.textview withMultiplier:0.3];
        
        self.midline=[UILabel new];
        self.midline.backgroundColor=RGB(238, 238, 238);
        [self.midview addSubview:self.midline];
        self.midline.sd_layout
        .leftSpaceToView(self.midview, 0).rightSpaceToView(self.midview, 0).heightIs(5).topSpaceToView(self.textview, _jmsize_10);
        
        [_midview addSubview:self.copybtn];
        [_midview bringSubviewToFront:self.copybtn];
        [self.copybtn autoSetDimensionsToSize:self.copybtn.size];
        [self.copybtn autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.textview];
        //[self.copybtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.textview withOffset:_jmsize_10];
        [self.copybtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.midview withOffset:-_jmsize_10*4];
        
       
        
    }
    return _midview;
}

- (UIView *)btmview{
    if (_btmview == nil) {
        _btmview = [UIView new];
        
        /*UILabel * tmplabel  =[ UILabel new];
        tmplabel.font = kFONT14;
        tmplabel.text = @"图文分享到";
        [tmplabel sizeToFit];
        [_btmview addSubview:tmplabel];
        [tmplabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jmsize_10];
        [tmplabel autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        
        UIView* leftLine = [UIView new];
        leftLine.backgroundColor = FNHomeBackgroundColor;
        [_btmview addSubview:leftLine];
        [leftLine autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [leftLine autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:tmplabel];
        [leftLine autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:tmplabel withOffset:-_jmsize_10];
        [leftLine autoSetDimension:(ALDimensionHeight) toSize:1];
        
        UIView* rightLine = [UIView new];
        rightLine.backgroundColor = FNHomeBackgroundColor;
        [_btmview addSubview:rightLine];
        [rightLine autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [rightLine autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:tmplabel];
        [rightLine autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:tmplabel withOffset:_jmsize_10];
        [rightLine autoSetDimension:(ALDimensionHeight) toSize:1];*/
        
        
        
        //NSArray* images = @[@"invite_wechat",@"invite_circle",@"invite_qq",@"share_sina",@"share_Qzone"];
        //NSArray* titles = @[@"微信",@"朋友圈",@"QQ",@"新浪",@"QQ空间"];
        NSArray* images = @[@"FJ_pyimg",@"FJ_wximg",@"FJ_wbimg",@"FJ_wximg", @"FJ_bcimg"];
        NSArray* titles = @[@"朋友圈",@"微信",@"微博",@"QQ", @"存至相册"];
        CGFloat width = FNDeviceWidth/images.count;
        CGFloat btnH = 80;
        [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // CGRectGetMaxY(rightLine.frame)
            FNFunctionBtnView * btn = [[FNFunctionBtnView alloc]initWithFrame:(CGRectMake(width*idx,_jmsize_10, width, btnH)) btnImage:IMAGE(images[idx]) andTitle:titles[idx]];
            btn.tag = idx+100;
            @weakify(self);
            [btn addJXTouchWithObject:^(id obj) {
                @strongify(self);
       
                [[UIPasteboard generalPasteboard] setString:self.viewmodel.model.str?:@""];
                NSMutableArray<NSString*>* images = [NSMutableArray new];

                [self.viewmodel.model.images enumerateObjectsUsingBlock:^(SMMImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (obj.isselected) {
//                        XYLog(@"缓存:%@",[UIImage imageWithData:[NSData dataWithContentsOfURL:URL(obj.image)]]);
                        [images addObject:obj.image];
                    }
//
                }];
                UMSocialPlatformType type=UMSocialPlatformType_WechatSession;
                if (idx==1) {
                    type=UMSocialPlatformType_WechatSession;
                }else if (idx==0) {
                    type=UMSocialPlatformType_WechatTimeLine;
                }else if (idx==3) {
                    //type=UMSocialPlatformType_Qzone;
                    type=UMSocialPlatformType_QQ;
                } else if (idx==2) {
                    type=UMSocialPlatformType_Sina;
                } else if (idx==4) {
                    type = -1;
                }

                if ([_delegate respondsToSelector:@selector(didImageShare:withImages:atType:)]) {
                    [_delegate didImageShare: self withImages: images atType: type];
                }

                
            }];
            [_btmview addSubview:btn];
        }];
        //_btmview.height =_jmsize_10*3+_jmsize_10*2+btnH+30;
        _btmview.height =btnH+20;
    }
    return _btmview;
}
- (void)jm_setupViews
{
    self.alpha = 0;
    [self productDetails];
    
    
    
    //信息文本
    [self addSubview:self.midview];
    [self.midview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.midview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    //[self.midview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.topview];
    [self.midview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.productBgView];
    //[self.midview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.copybtn];
    [self.midview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.midline];
    
    
    //图片
    [self addSubview:self.topview];
    //[self.topview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.topview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.topview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.topview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.jm_collectionview];
    [self.topview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.midview];
    
    
    //分享view
    [self addSubview:self.btmview];
    [self.btmview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
    [self.btmview autoSetDimension:(ALDimensionHeight) toSize:self.btmview.height];
    [self.btmview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self];
    
}
- (void)jm_bindViewModel{
    @weakify(self);
    [self.viewmodel.refreshDataCommand execute:nil];
    [[self.viewmodel.refreshUI takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        self.textview.textView.text = self.viewmodel.model.str;
        self.productName.text= [NSString stringWithFormat:@" %@",self.viewmodel.model.goods_title];
        [self.productName HttpLabelLeftImage:self.viewmodel.model.shop_img label:self.productName imageX:0 imageY:-1.5 imageH:13 atIndex:0];
        self.productPrice.text= [NSString stringWithFormat:@" ¥ %.2f",self.viewmodel.model.goods_price.floatValue];
        [self.sharebtn setTitle:self.viewmodel.model.fxz forState:UIControlStateNormal];
        self.textview.placeHolderLabel.hidden = YES;
        [self.jm_collectionview reloadData];
        [UIView animateWithDuration:1.0 animations:^{
            self.alpha = 1;
        }];
    }];
}

#pragma mark - action
- (void)copybtnAction{
    [[UIPasteboard generalPasteboard] setString:self.viewmodel.model.str?:@""];
    [FNTipsView showTips:@"已复制"];
}
#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewmodel.model.images.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNShareMutiplyCell* cell = [FNShareMutiplyCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    XYLog(@"分享图:%@",self.viewmodel.model.images[indexPath.item].image);
    [cell.imgview setUrlImg:self.viewmodel.model.images[indexPath.item].image];
    cell.chooseBtn.selected = self.viewmodel.model.images[indexPath.item].isselected;
    
    return cell;
}

#pragma mark - Collection view delegate && flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(JMScreenWidth*0.35, JMScreenHeight*0.4);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.viewmodel.model.images[indexPath.item].isselected = !self.viewmodel.model.images[indexPath.item].isselected;
    [self.jm_collectionview reloadData];
}


@end
