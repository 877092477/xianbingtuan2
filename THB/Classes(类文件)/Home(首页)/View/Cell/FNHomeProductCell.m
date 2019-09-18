//
//  FNHomeProductCell.m
//  嗨如意
//
//  Created by zhongxueyu on 2018/8/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNHomeProductCell.h"


#define quanPadding 6
#define textPadding 5
@interface FNHomeProductCell()

@property (nonatomic, strong) UIImageView *imgPlay;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *discountsBg2;

@end

@implementation FNHomeProductCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"HomeViewGoodsCell";
    FNHomeProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}


-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        NSInteger goods_flstyle=[[FNBaseSettingModel settingInstance].goods_flstyle integerValue];
        if (goods_flstyle == 4) {
            [self initNewUI];
        } else {
            [self initUI];
        }
    }
    return self;
}


-(void)initUI{
    
    self.backgroundColor=FNColor(246, 246, 246);
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:_bgView];
    
    //分割线
    self.line_Top=[UILabel new];
//    self.line_Top.backgroundColor=FNColor(246, 246, 246);
    self.GoodsTitleLabel.textColor=FNBlackColor;
    [self.contentView addSubview:self.line_Top];


    self.line_Right=[UILabel new];
//    self.line_Right.backgroundColor=FNColor(246, 246, 246);
    self.line_Right.textColor=FNBlackColor;
    [self.contentView addSubview:self.line_Right];
    
    
    //商品图片
    self.GoodsImage=[UIImageView new];
    _GoodsImage.contentMode=UIViewContentModeScaleToFill;
    _GoodsImage.userInteractionEnabled = YES;
    [self.contentView addSubview:self.GoodsImage];
    
    self.imgPlay = [UIImageView new];
    self.imgPlay.image = IMAGE(@"button_play");
    self.imgPlay.hidden = YES;
    [self.contentView addSubview:self.imgPlay];
    
    //图片上分享赚的视图
    self.shareButton=[UIButton new];
    //    [self.shareButton setBackgroundColor:FNColor(255, 211, 211)];
    //    self.shareButton.cornerRadius=5;
    self.shareButton.titleLabel.font=kFONT12;
    [self.GoodsImage addSubview:self.shareButton];
    
    //商品分类图片
    self.GoodsTypeImage=[UIImageView new];
    self.GoodsTypeImage.contentMode=UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.GoodsTypeImage];
    
    //商品标题
    self.GoodsTitleLabel=[UILabel new];
    //self.GoodsTitleLabel.numberOfLines=2;
    self.GoodsTitleLabel.textColor=FNBlackColor;
    self.GoodsTitleLabel.font=kFONT12;
    [self.contentView addSubview:self.GoodsTitleLabel];
    
    //券背景View
    self.discountsBgView=[UIView new];
    [self.contentView addSubview:self.discountsBgView];
    
    
    //券面额背景
    self.discountsView=[UIImageView new];
    self.discountsView.cornerRadius=2;
    [self.discountsBgView addSubview:self.discountsView];
    
    
    //券
    self.ticketImg=[UIImageView new];
    [self.discountsBgView addSubview:self.ticketImg];
    
    //券面值
    self.ticketPriceLable=[UILabel new];
    self.ticketPriceLable.textColor=FNColor(246, 71, 111);
    self.ticketPriceLable.font=kFONT12;
    [self.discountsBgView addSubview:self.ticketPriceLable];
    
    //下单文字背景
    self.placeAnorderView=[UIImageView new];
    self.placeAnorderView.image=[UIImage imageNamed:@"today_multiple"];
    self.placeAnorderView.cornerRadius=2;
    [self.contentView addSubview:self.placeAnorderView];
    
    //下单标题
    self.placeAnOrderLable=[UILabel new];
    self.placeAnOrderLable.textColor=FNColor(246, 71, 111);
    self.placeAnOrderLable.font=kFONT12;
    self.placeAnOrderLable.textAlignment=NSTextAlignmentCenter;
    [self.placeAnorderView addSubview:self.placeAnOrderLable];
    
    
    //券后价标题
    self.qhPriceTitleLabel = [UILabel new];
    self.qhPriceTitleLabel.textColor = FNMainGobalControlsColor;
    self.qhPriceTitleLabel.font = kFONT12;
    [self.contentView addSubview:self.qhPriceTitleLabel];
    
    
    
    //券后价
    self.qhPriceLabel = [UILabel new];
    self.qhPriceLabel.textColor = FNMainGobalControlsColor;
    self.qhPriceLabel.font = kFONT14;
    [self.contentView addSubview:self.qhPriceLabel];
    
    //原价
    self.originPriceLabel = [UILabel new];
    self.originPriceLabel.textColor = FNGlobalTextGrayColor;
    self.originPriceLabel.font = kFONT12;
    //    self.originPriceLabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.originPriceLabel];
    
    //热销图片
    self.countIconImg=[UIImageView new];
    self.countIconImg.contentMode=UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.countIconImg];
    
    //月销量
    self.countLabel = [UILabel new];
    //        _countLabel.textAlignment=NSTextAlignmentCenter;
    self.countLabel.font = kFONT10;
    self.countLabel.textColor = FNGlobalTextGrayColor;
    [self.contentView addSubview:self.countLabel];
    
    //店铺icon
    self.shopIconImg=[UIImageView new];
    self.shopIconImg.contentMode=UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.shopIconImg];
    
    //店铺名
    self.shopNameLabel = [UILabel new];
    //self.shopNameLabel.textAlignment=NSTextAlignmentLeft;
    self.shopNameLabel.font = kFONT10;
    self.shopNameLabel.textColor = FNGlobalTextGrayColor;
    [self.contentView addSubview:self.shopNameLabel];
    
    
    
    [self initializedSubviews];
    
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    //分割线
    [self.line_Top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@2);
    }];

    [self.line_Right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.width.equalTo(@2);
        make.height.equalTo(self.contentView);
    }];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.GoodsImage);
        make.bottom.equalTo(@-2);
    }];

    //商品图片
    int w = XYScreenWidth / 2 - 2;
    [self.GoodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@2);
//        make.left.equalTo(@0);
//        make.right.equalTo(@-2);
        make.centerX.equalTo(@0);
        make.width.height.mas_equalTo(w);
        
//        make.height.equalTo(self.GoodsImage.mas_width);
    }];
    
    [self.imgPlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.GoodsImage);
        make.width.height.mas_equalTo(40);
    }];
    
    //分享
    
    //图片上分享赚的视图
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    //商品分类图片
    [self.GoodsTypeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.equalTo(self.GoodsImage.mas_bottom).offset(_jm_margin10);
        make.width.equalTo(@23);
        make.height.equalTo(@13);
    }];
    
    //商品标题
    [self.GoodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.GoodsTypeImage.mas_right).offset(2);
        make.top.equalTo(self.GoodsImage.mas_bottom).offset(_jm_margin10);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
        make.height.equalTo(@13);
        
    }];
    
    //券背景视图
    [self.discountsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(self.GoodsTitleLabel.mas_bottom).offset(_jm_margin10);
        make.height.equalTo(@15);
    }];
    
    //券
    [self.ticketImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@15);
        make.width.equalTo(@17.5);
    }];
    
    //优惠Bg
    [self.discountsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ticketImg.mas_right);
        make.top.equalTo(self.ticketImg.mas_top);
        make.height.equalTo(self.ticketImg);
        
    }];
    
    //券面值
    [self.ticketPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ticketImg.mas_right).offset(quanPadding);
        make.top.equalTo(self.ticketImg.mas_top);
        make.bottom.equalTo(self.ticketImg.mas_bottom);
    }];
    [self.ticketPriceLable setSingleLineAutoResizeWithMaxWidth:90];
    //    [self.ticketPriceLable setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    
    //下单文字背景
    [self.placeAnorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.discountsView.mas_right).offset(_jm_margin10);
        make.top.equalTo(self.discountsBgView.mas_top);
        make.height.equalTo(self.discountsBgView);
        
    }];
    //
    
    //setupAutoHeightWithBottomView
    //下单标题
    [self.placeAnOrderLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textPadding);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        
    }];
    [self.placeAnOrderLable setSingleLineAutoResizeWithMaxWidth:90];
    
    
#pragma mark -下方label用Masonry布局在真机闪退，所以换成了SD布局
    //券后价标题
    //    [self.qhPriceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(@5);
    //        make.topMargin.equalTo(self.discountsBgView.mas_bottom);
    //        make.height.equalTo(@20);
    //    }];
    //    [self.qhPriceTitleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//    self.qhPriceTitleLabel.sd_layout
//    .leftSpaceToView(self.bgView, 4)
//    .topSpaceToView(self.discountsBgView, _jmsize_10)
//    .heightIs(20);
    [self.qhPriceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.discountsBgView);
        make.top.equalTo(self.discountsBgView.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    [self.qhPriceTitleLabel setSingleLineAutoResizeWithMaxWidth:90];
    
    //
    //券后价
    self.qhPriceLabel.sd_layout
    .leftSpaceToView(self.qhPriceTitleLabel, 5)
    .topSpaceToView(self.discountsBgView, _jmsize_10)
    .heightIs(20);
    [self.qhPriceLabel setSingleLineAutoResizeWithMaxWidth:120];
    //    [self.qhPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.qhPriceTitleLabel.mas_right).offset(5);
    //        make.top.equalTo(self.discountsView.mas_bottom).offset(_jm_margin10/2);
    //        make.height.equalTo(@20);
    //    }];
    //    [self.qhPriceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
   
    //    [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.self.qhPriceLabel.mas_right).offset(5);
    //        make.top.equalTo(self.discountsView.mas_bottom).offset(5);
    //        make.height.equalTo(@20);
    //    }];
    //    [self.originPriceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //
    //店铺icon
    [self.shopIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.qhPriceTitleLabel.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-_jmsize_10);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
        
    }];
    
    //    //店铺名
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopIconImg.mas_right).offset(2);
        make.top.equalTo(self.shopIconImg.mas_top);
        make.height.equalTo(@15);
        
    }];
    [self.shopNameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    //原价
    self.originPriceLabel.sd_layout
    .leftSpaceToView(self.qhPriceLabel, 5)
    .topSpaceToView(self.GoodsTitleLabel, 35)
    .heightIs(20);
    [self.originPriceLabel setSingleLineAutoResizeWithMaxWidth:90];
    //.topSpaceToView(self.discountsBgView, _jmsize_10)
    
    //月销量
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-_jm_margin10);
        make.top.equalTo(self.shopIconImg.mas_top);
        make.height.equalTo(@15);
    }];
    
    [self.countLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    //热销图片
    [self.countIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.countLabel.mas_left).offset(-2);
        make.top.equalTo(self.shopIconImg.mas_top);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
        
    }];
    
    
}

-(void)initNewUI{
    
    _bgView = [[UIView alloc] init];
    [self.contentView addSubview:_bgView];
    _bgView.backgroundColor = UIColor.whiteColor;
    _bgView.cornerRadius = 6;
    [self.contentView addSubview:_bgView];
    
    
    self.backgroundColor = FNColor(246, 246, 246);
    
//    //分割线
//    self.line_Top=[UILabel new];
//    self.line_Top.backgroundColor=FNColor(246, 246, 246);
//    self.GoodsTitleLabel.textColor=FNBlackColor;
//    [self.contentView addSubview:self.line_Top];
//
//
//    self.line_Right=[UILabel new];
//    self.line_Right.backgroundColor=FNColor(246, 246, 246);
//    self.line_Right.textColor=FNBlackColor;
//    [self.contentView addSubview:self.line_Right];
    
    
    //商品图片
    self.GoodsImage=[UIImageView new];
    _GoodsImage.contentMode=UIViewContentModeScaleToFill;
    _GoodsImage.userInteractionEnabled = YES;
    [_bgView addSubview:self.GoodsImage];
    
    self.imgPlay = [UIImageView new];
    self.imgPlay.image = IMAGE(@"button_play");
    self.imgPlay.hidden = YES;
    [_bgView addSubview:self.imgPlay];
    
    //图片上分享赚的视图
    self.shareButton=[UIButton new];
    //    [self.shareButton setBackgroundColor:FNColor(255, 211, 211)];
    //    self.shareButton.cornerRadius=5;
    self.shareButton.titleLabel.font=kFONT12;
    [self.GoodsImage addSubview:self.shareButton];
    
    //商品分类图片
    self.GoodsTypeImage=[UIImageView new];
    self.GoodsTypeImage.contentMode=UIViewContentModeScaleToFill;
    [_bgView addSubview:self.GoodsTypeImage];
    
    //商品标题
    self.GoodsTitleLabel=[UILabel new];
    //self.GoodsTitleLabel.numberOfLines=2;
    self.GoodsTitleLabel.textColor=FNBlackColor;
    self.GoodsTitleLabel.font=kFONT12;
    [_bgView addSubview:self.GoodsTitleLabel];
    
    //券背景View
    self.discountsBgView=[UIView new];
    [_bgView addSubview:self.discountsBgView];
    
    
    //券面额背景
    self.discountsView=[UIImageView new];
    self.discountsView.cornerRadius=2;
    [_bgView addSubview:self.discountsView];
    
    
    //券
    self.ticketImg=[UIImageView new];
    self.ticketImg.hidden = YES;
    [self.discountsBgView addSubview:self.ticketImg];
    
    //券面值
    self.ticketPriceLable=[UILabel new];
    self.ticketPriceLable.textColor=FNColor(246, 71, 111);
    self.ticketPriceLable.font=kFONT12;
    [self.discountsView addSubview:self.ticketPriceLable];
    
    //下单文字背景
    self.placeAnorderView=[UIImageView new];
    self.placeAnorderView.image=[UIImage imageNamed:@"today_multiple"];
    self.placeAnorderView.cornerRadius=2;
    [_bgView addSubview:self.placeAnorderView];
    
    //下单标题
    self.placeAnOrderLable=[UILabel new];
    self.placeAnOrderLable.textColor=FNColor(246, 71, 111);
    self.placeAnOrderLable.font=kFONT12;
    self.placeAnOrderLable.textAlignment=NSTextAlignmentCenter;
    [self.placeAnorderView addSubview:self.placeAnOrderLable];
    
    
    //券后价标题
    self.qhPriceTitleLabel = [UILabel new];
    self.qhPriceTitleLabel.textColor = FNMainGobalControlsColor;
    self.qhPriceTitleLabel.font = kFONT12;
    [_bgView addSubview:self.qhPriceTitleLabel];
    
    
    
    //券后价
    self.qhPriceLabel = [UILabel new];
    self.qhPriceLabel.textColor = FNMainGobalControlsColor;
    self.qhPriceLabel.font = kFONT14;
    [self.contentView addSubview:self.qhPriceLabel];
    
    //原价
    self.originPriceLabel = [UILabel new];
    self.originPriceLabel.textColor = FNGlobalTextGrayColor;
    self.originPriceLabel.font = kFONT12;
    //    self.originPriceLabel.textAlignment=NSTextAlignmentLeft;
    [_bgView addSubview:self.originPriceLabel];
    
    //热销图片
    self.countIconImg=[UIImageView new];
    self.countIconImg.contentMode=UIViewContentModeScaleToFill;
    [_bgView addSubview:self.countIconImg];
    
    //月销量
    self.countLabel = [UILabel new];
    //        _countLabel.textAlignment=NSTextAlignmentCenter;
    self.countLabel.font = kFONT10;
    self.countLabel.textColor = FNGlobalTextGrayColor;
    [_bgView addSubview:self.countLabel];
    
    //店铺icon
    self.shopIconImg=[UIImageView new];
    self.shopIconImg.contentMode=UIViewContentModeScaleToFill;
    [_bgView addSubview:self.shopIconImg];
    
    //店铺名
    self.shopNameLabel = [UILabel new];
    //self.shopNameLabel.textAlignment=NSTextAlignmentLeft;
    self.shopNameLabel.font = kFONT10;
    self.shopNameLabel.textColor = FNGlobalTextGrayColor;
    [_bgView addSubview:self.shopNameLabel];
    
    
    
    [self initializedNewSubviews];
    
}

- (void)setIsLeft: (BOOL)isLeft {
    NSInteger goods_flstyle=[[FNBaseSettingModel settingInstance].goods_flstyle integerValue ];
    if (goods_flstyle != 4) {
        return;
    }
    if (isLeft) {
        [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@6);
            make.left.equalTo(@8);
            make.right.equalTo(@-4);
            make.bottom.equalTo(@0);
        }];
    } else {
        [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@6);
            make.left.equalTo(@4);
            make.right.equalTo(@-8);
            make.bottom.equalTo(@0);
        }];
    }
}

- (void)initializedNewSubviews {
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@6);
        make.left.equalTo(@8);
        make.right.equalTo(@-8);
        make.bottom.equalTo(@0);
    }];

    
    //分割线
//    [self.line_Top mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@0);
//        make.left.equalTo(@0);
//        make.right.equalTo(@0);
//        make.height.equalTo(@2);
//    }];
//
//    [self.line_Right mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@0);
//        make.right.equalTo(@0);
//        make.width.equalTo(@2);
//        make.height.equalTo(self.contentView);
//    }];
    
    //商品图片
    [self.GoodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        
        make.height.equalTo(self.GoodsImage.mas_width);
    }];
    
    [self.imgPlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.GoodsImage);
        make.width.height.mas_equalTo(40);
    }];
    
    //分享
    
    //图片上分享赚的视图
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@28);
    }];
    
//    //商品分类图片
//    [self.GoodsTypeImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@5);
//        make.top.equalTo(self.GoodsImage.mas_bottom).offset(_jm_margin10);
//        make.width.equalTo(@23);
//        make.height.equalTo(@13);
//    }];
    
    //商品标题
    [self.GoodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.GoodsImage.mas_bottom).offset(_jm_margin10);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
        
    }];
    
    //券背景视图
    [self.discountsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.GoodsTitleLabel.mas_bottom).offset(_jm_margin10);
        make.height.equalTo(@15);
    }];
    
    
    //券
    [self.ticketImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@15);
        make.width.equalTo(@17.5);
    }];
    
    //优惠Bg
    [self.discountsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.ticketImg.mas_top);
        make.height.equalTo(self.ticketImg);
        
    }];
    
    //券面值
    [self.ticketPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.discountsView).offset(quanPadding);
        make.right.equalTo(self.discountsView).offset(-quanPadding);
        make.centerY.equalTo(self.discountsView);
//        make.top.equalTo(self.ticketImg.mas_top);
//        make.bottom.equalTo(self.ticketImg.mas_bottom);
    }];
    [self.ticketPriceLable setSingleLineAutoResizeWithMaxWidth:90];
    //    [self.ticketPriceLable setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    
    //下单文字背景
    [self.placeAnorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.discountsView.mas_right).offset(_jm_margin10);
        make.top.equalTo(self.discountsBgView.mas_top);
        make.height.equalTo(self.discountsBgView);
        
    }];
    //
    
    //setupAutoHeightWithBottomView
    //下单标题
    [self.placeAnOrderLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textPadding);
        make.right.mas_equalTo(@-textPadding);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        
    }];
    [self.placeAnOrderLable setSingleLineAutoResizeWithMaxWidth:90];
    

    //券后价标题
    //    [self.qhPriceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(@5);
    //        make.topMargin.equalTo(self.discountsBgView.mas_bottom);
    //        make.height.equalTo(@20);
    //    }];
    //    [self.qhPriceTitleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    self.qhPriceTitleLabel.sd_layout
    .leftSpaceToView(self.bgView, 10)
    .topSpaceToView(self.discountsBgView, _jmsize_10)
    .heightIs(20);
    [self.qhPriceTitleLabel setSingleLineAutoResizeWithMaxWidth:90];
    
    //
    //券后价
//    self.qhPriceLabel.sd_layout
//    .leftSpaceToView(self.qhPriceTitleLabel, 5)
//    .topSpaceToView(self.discountsBgView, _jmsize_10)
//    .heightIs(20);
    [self.qhPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.qhPriceTitleLabel.mas_right).offset(5);
        make.centerY.equalTo(self.qhPriceTitleLabel);
        make.height.equalTo(@20);
        //        make.width.equalTo(@15);
        
    }];
    [self.qhPriceLabel setSingleLineAutoResizeWithMaxWidth:120];
    //    [self.qhPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.qhPriceTitleLabel.mas_right).offset(5);
    //        make.top.equalTo(self.discountsView.mas_bottom).offset(_jm_margin10/2);
    //        make.height.equalTo(@20);
    //    }];
    //    [self.qhPriceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    
    //    [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.self.qhPriceLabel.mas_right).offset(5);
    //        make.top.equalTo(self.discountsView.mas_bottom).offset(5);
    //        make.height.equalTo(@20);
    //    }];
    //    [self.originPriceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //
    //店铺icon
    [self.shopIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.qhPriceTitleLabel.mas_left);
        make.bottom.equalTo(@-10);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
        
    }];
    
    //    //店铺名
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopIconImg.mas_right).offset(2);
        make.top.equalTo(self.shopIconImg.mas_top);
        make.height.equalTo(@15);
        make.right.lessThanOrEqualTo(self.countLabel.mas_left).offset(-10);
    }];
    [self.shopNameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    //原价
    self.originPriceLabel.sd_layout
    .leftSpaceToView(self.qhPriceLabel, 5)
    .topSpaceToView(self.GoodsTitleLabel, 35)
    .heightIs(20);
//    [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.qhPriceLabel.mas_right).offset(5);
//        make.centerY.equalTo(self.qhPriceLabel.mas_bottom);
//        make.height.equalTo(@15);
////        make.width.equalTo(@15);
//
//    }];
    [self.originPriceLabel setSingleLineAutoResizeWithMaxWidth:90];
    //.topSpaceToView(self.discountsBgView, _jmsize_10)
    
    //月销量
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-_jm_margin10);
        make.top.equalTo(self.shopIconImg.mas_top);
        make.height.equalTo(@15);
    }];
    
    [self.countLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    //热销图片
    [self.countIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.countLabel.mas_left).offset(-2);
        make.top.equalTo(self.shopIconImg.mas_top);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
        
    }];
    
    
}


-(void)setModel:(FNBaseProductModel *)model{
    _model = model;
    
    if (model) {
        [_shareButton addTarget:self action:@selector(shareBtnMethod)];
        //商品图片
        [self.GoodsImage setUrlImg:model.goods_img];
        self.imgPlay.hidden = ![model.video kr_isNotEmpty];
        if([model.fxz kr_isNotEmpty]){
            if ([model.is_hide_sharefl isEqualToString:@"1"]) {
                _shareButton.hidden = YES;
                
            }else{
                _shareButton.hidden = NO;
                [_shareButton setTitle:model.fxz forState:UIControlStateNormal];
//                _shareButton.titleLabel.textColor = [UIColor colorWithHexString:model.goodssharestr_color];
                [_shareButton setTitleColor:[UIColor colorWithHexString:model.goodssharestr_color] forState:UIControlStateNormal];
                [_shareButton sd_setBackgroundImageWithURL:URL(model.goods_sharezhuan_img) forState:UIControlStateNormal];
            }
        }else{
            _shareButton.hidden = YES;
        }
        
        
        
        //商品来源
        [self.GoodsTypeImage setUrlImg:model.shop_img];
        
        //商品标题
        self.GoodsTitleLabel.text=model.goods_title;
        
        
        
        //判断优惠券,没有就隐藏
        if ([model.yhq_span kr_isNotEmpty]&&![model.yhq_price isEqualToString:@"0"]) {
            
            
            self.discountsBgView.hidden = NO;
            [self.discountsBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(self.ticketImg.width + self.discountsView.width);
            }];
            //优惠券logo
            [self.ticketImg setUrlImg:model.goods_quanfont_bjimg];
            //显示券后价标题
            _qhPriceTitleLabel.text=[FNBaseSettingModel settingInstance].app_quanhoujia_name;
            //优惠券金额
            self.ticketPriceLable.text=model.yhq_span;
            //优惠券金额字体颜色
            self.ticketPriceLable.textColor = [UIColor colorWithHexString:model.goodsyhqstr_color];
            
            
            //优惠券面额的背景，根据券价格的长度来计算券背景的宽度
            [_discountsView setUrlImg:model.goods_quanbj_bjimg];
            //券
            [self.ticketImg mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@0);
                make.top.equalTo(@0);
                make.height.equalTo(@15);
                make.width.equalTo(@17.5);
                
            }];
            [self.discountsView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.ticketImg.mas_right);
                make.top.equalTo(self.ticketImg.mas_top);
                make.height.equalTo(self.ticketImg);
                make.width.mas_equalTo(self.ticketPriceLable.width+quanPadding*2+2);
                
            }];
            
            [self.discountsBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@5);
                make.top.equalTo(self.GoodsTitleLabel.mas_bottom).offset(_jm_margin10);
                make.height.equalTo(@15);
                make.width.mas_equalTo(self.ticketImg.width + self.discountsView.width);
                
            }];
            
        }else{
            //显示到手价标题
            _qhPriceTitleLabel.text=[FNBaseSettingModel settingInstance].app_daoshoujia_name;
            [self.discountsBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(@0);
                
            }];
            [self.discountsView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(@0);
                
            }];
            
            [self.ticketImg mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(@0);
                
            }];
            
            self.discountsBgView.hidden = YES;
            [self.discountsBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];
            
        }
        
        
        
        //返利样式
        NSInteger goods_flstyle=[[FNBaseSettingModel settingInstance].goods_flstyle integerValue ];
        [_placeAnorderView setUrlImg:model.goods_fanli_bjimg];
        
        //判断模式
        if([FNBaseSettingModel settingInstance].app_choujiang_onoff.boolValue){//判断是否是抽奖模式
            self.placeAnorderView.hidden = NO;
            
            _placeAnOrderLable.text=[NSString stringWithFormat:@"%@",[FNBaseSettingModel settingInstance].app_fanli_off_str];//抽奖模式文字
            [self.placeAnorderView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.discountsView.mas_right).offset(self.discountsBgView.hidden?0:_jm_margin10);
                make.top.equalTo(self.discountsBgView.mas_top);
                make.height.equalTo(self.discountsBgView);
                make.width.mas_equalTo(self.placeAnOrderLable.width+textPadding*2);
                
            }];
            
        }else{
            // goods_flstyle:0.有返利样式，1.无返利样式
            if (goods_flstyle == 0) {
                if ([model.fcommission kr_isNotEmpty]&&![model.fcommission isEqualToString:@"0"]) {
                    if ([model.is_hide_fl isEqualToString:@"1"]) {
                        self.placeAnorderView.hidden = YES;
                        
                    }else{
                        self.placeAnorderView.hidden = NO;
                        _placeAnOrderLable.text=[NSString stringWithFormat:@"%@%@",model.fan_all_str,model.fcommission];//返回佣金
                        _placeAnOrderLable.textColor = [UIColor colorWithHexString:model.goodsfcommissionstr_color];
                        
                        [self.placeAnorderView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            if (self.discountsBgView.hidden) {
                                make.left.equalTo(self.ticketImg);
                            } else {
                                make.left.equalTo(self.discountsView.mas_right).offset(_jm_margin10);
                            }
                            make.top.equalTo(self.discountsBgView.mas_top);
                            make.height.equalTo(self.discountsBgView);
                            make.width.mas_equalTo(self.placeAnOrderLable.width+textPadding*2);
                            
                        }];
                    }
                    
                    
                }else{
                    self.placeAnorderView.hidden = YES;
                }
            }else{
                self.placeAnorderView.hidden = YES;
                
            }
            
            
        }
        
        
        
        
        //价格
        _qhPriceLabel.text = [NSString stringWithFormat:@"¥ %@",model.goods_price];
        
        //原价
//        _originPriceLabel.text=[NSString stringWithFormat:@"¥ %@",model.goods_cost_price];//原价
        _originPriceLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %@",model.goods_cost_price] attributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle)}];
        
        //销量logo
        [_countIconImg setUrlImg:model.goods_sales_ico];
        
        
        if (goods_flstyle==0 || goods_flstyle==1) {
            _countLabel.text=[NSString stringWithFormat:@"热销 %@",model.goods_sales];//@"热销5111";
        }else{
            _countLabel.text=[NSString stringWithFormat:@"%@人已买",model.goods_sales];//@"热销5111";
        }
        
        if ([model.shop_title kr_isNotEmpty]) {
            _shopIconImg.hidden = NO;
            _shopNameLabel.hidden = NO;
            //店铺logo
            [_shopIconImg setUrlImg:model.goods_store_img];// 店铺Icon;
            
            //店铺名
            _shopNameLabel.text=[NSString stringWithFormat:@"%@ %@",model.shop_title,model.provcity];//@"倩倩旗舰店 上海";
            
            [self.shopNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shopIconImg.mas_right).offset(2);
                make.top.equalTo(self.shopIconImg.mas_top);
                make.height.equalTo(@15);
                make.right.lessThanOrEqualTo(self.countIconImg.mas_left).offset(-3);
                
            }];
        }else{
            _shopIconImg.hidden = YES;
            _shopNameLabel.hidden = YES;
        }
        
        // ========================
        if (goods_flstyle == 4) {
            [self.discountsBg2 sd_setImageWithURL:URL(model.goods_quanbj_bjimg)];
            self.placeAnorderView.hidden = ![model.fcommission_str kr_isNotEmpty];
            
            _placeAnOrderLable.text=model.fcommission_str;
            _placeAnOrderLable.textColor = [UIColor colorWithHexString:model.goodsfcommissionstr_color];
            
            [_placeAnorderView setUrlImg:model.goods_fanli_bjimg];
            _countLabel.text=[NSString stringWithFormat:@"热销:%@",model.goods_sales];//@"热销5111";
            _countIconImg.hidden = YES;
            
            //            price_fontcolor
            _qhPriceTitleLabel.textColor = [UIColor colorWithHexString:model.price_fontcolor];
            _qhPriceLabel.textColor = [UIColor colorWithHexString:model.price_fontcolor];
            _shopNameLabel.textColor = [UIColor colorWithHexString:model.shoptitle_color];
            [self.shopIconImg setUrlImg:model.shop_img];
            
            [self.placeAnorderView mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (self.discountsBgView.hidden) {
                    make.left.equalTo(self.discountsView);
                } else {
                    make.left.equalTo(self.discountsView.mas_right).offset(_jm_margin10);
                }
                make.top.equalTo(self.ticketImg.mas_top);
                make.height.equalTo(self.ticketImg);
                make.width.mas_equalTo(self.placeAnOrderLable.width+textPadding*2);
                
            }];
            
            [self.shopNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shopIconImg.mas_right).offset(2);
                make.top.equalTo(self.shopIconImg.mas_top);
                make.height.equalTo(@15);
                make.right.lessThanOrEqualTo(self.countLabel.mas_left).offset(-3);
                
            }];
        }
        
    }
    
    [self.contentView setNeedsLayout];
}


//分享赚点击方法
-(void)shareBtnMethod{
    
    if (self.sharerightNow) {
        self.sharerightNow(self.model);
    }
}
@end
