//
//  FNUpRecommendNCell.m
//  THB
//
//  Created by Jimmy on 2018/9/25.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpRecommendNCell.h"
#import "FNUpgradeNMode.h"

@interface FNUpRecommendNCell()

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIView *vContent;

@property (nonatomic, strong) UIImageView *imgFan;
@property (nonatomic, strong) UILabel *lblFan;

@property (nonatomic, strong) UIButton *btnShare;

@end

@implementation FNUpRecommendNCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"RecommendCell";
    FNUpRecommendNCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}


-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}


-(void)initUI{
    
    self.vBackground = [[UIView alloc] init];
    [self.contentView addSubview: self.vBackground];
    
    
    self.vBackground.layer.backgroundColor = RGB(255, 255, 255).CGColor;
    self.vBackground.layer.shadowColor = RGBA(0, 0, 0, 0.1).CGColor;
    self.vBackground.layer.shadowOffset = CGSizeMake(0,1);
    self.vBackground.layer.shadowOpacity = 1;
    self.vBackground.layer.shadowRadius = 5;
    self.vBackground.layer.cornerRadius = 5;
    
    self.vContent = [[UIView alloc] init];
    [self.vBackground addSubview: self.vContent];
    self.vContent.layer.cornerRadius = 5;
    self.vContent.layer.masksToBounds = YES;
    
    //商品图片
    self.GoodsImage=[UIImageView new];
    self.GoodsImage.contentMode=UIViewContentModeScaleToFill;
    self.GoodsImage.userInteractionEnabled = YES;
//    self.GoodsImage.cornerRadius=5;
    [self.vContent addSubview:self.GoodsImage];
    
    self.btnShare = [[UIButton alloc] init];
    self.btnShare.titleLabel.font = kFONT11;
    [self.vContent addSubview: self.btnShare];
    
    //原价
    self.originPriceLabel = [UILabel new];
    self.originPriceLabel.textColor = FNColor(255, 72, 134);
    self.originPriceLabel.font = kFONT14;
//    self.originPriceLabel.textAlignment=NSTextAlignmentCenter;
    [self.vContent addSubview:self.originPriceLabel];
    
    self.imgFan = [[UIImageView alloc] init];
    [self.vContent addSubview:self.imgFan];
    
    self.lblFan = [[UILabel alloc] init];
    self.lblFan.font = [UIFont systemFontOfSize:9];
    [self.imgFan addSubview:self.lblFan];
    
    
    //商品标题
    self.GoodsTitleLabel=[UILabel new];
    //self.GoodsTitleLabel.numberOfLines=2;
    self.GoodsTitleLabel.textColor=FNBlackColor;
    self.GoodsTitleLabel.font=[UIFont boldSystemFontOfSize:12];;
    [self.vContent addSubview:self.GoodsTitleLabel];
    
    [self.vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.left.equalTo(@5);
        make.right.equalTo(@-5);
        make.bottom.equalTo(@-5);
    }];
    
    [self.vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    //商品图片
    [self.GoodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(self.GoodsImage.mas_width);
    }];
    
    [self.btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.GoodsImage);
        make.height.mas_equalTo(25);
    }];
    
    //原价
    [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@4);
        make.right.lessThanOrEqualTo(@-8);
        make.height.equalTo(@12);
        make.bottom.equalTo(@-10);
    }];
    
    //商品标题
    [self.GoodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@4);
        make.top.equalTo(self.GoodsImage.mas_bottom).offset(8);
        make.right.lessThanOrEqualTo(@-8);
        make.height.equalTo(@14);
    }];
    
    [self.imgFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsTitleLabel.mas_bottom).offset(6);
        make.left.equalTo(@5);
        make.height.mas_equalTo(14);
    }];
    
    [self.lblFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgFan).offset(5);
        make.right.equalTo(self.imgFan).offset(-5);
        make.center.equalTo(self.imgFan);
    }];

}

-(void)setModel:(FNRecommendNMode *)model{
    _model=model;
    if(model){
        [self.GoodsImage setUrlImg:model.img];
        //商品标题
        self.GoodsTitleLabel.text=model.title; 
        //原价
//        NSString *joint=@"推荐价:";
//        NSString *jointString=[NSString stringWithFormat:@"%@%@",joint,model.price];
        self.originPriceLabel.text=model.price;
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: jointString];
//        [attributedString addAttribute:NSForegroundColorAttributeName value:FNGlobalTextGrayColor range:NSMakeRange(0, joint.length)];
//        self.originPriceLabel.attributedText = attributedString;
        
        if([model.fxz kr_isNotEmpty]){
            if ([model.is_hide_sharefl isEqualToString:@"1"]) {
                self.btnShare.hidden = YES;
                
            }else{
                self.btnShare.hidden = NO;
                [self.btnShare setTitle:model.fxz forState:UIControlStateNormal];
                //                _shareButton.titleLabel.textColor = [UIColor colorWithHexString:model.goodssharestr_color];
                [self.btnShare setTitleColor:[UIColor colorWithHexString:model.goodssharestr_color] forState:UIControlStateNormal];
                [self.btnShare sd_setBackgroundImageWithURL:URL(model.goods_sharezhuan_img) forState:UIControlStateNormal];
            }
        }else{
            self.btnShare.hidden = YES;
        }
    }
    
    @weakify(self)
    [self.imgFan sd_setImageWithURL:URL(model.goods_fanli_bjimg) placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if(image){
            self.lblFan.text = model.f_str;
            self.lblFan.textColor = [UIColor colorWithHexString: model.goodsfcommissionstr_color];
        }
    }];
    self.imgFan.hidden = ![model.f_str kr_isNotEmpty];
    self.lblFan.hidden = ![model.f_str kr_isNotEmpty];
}
@end
