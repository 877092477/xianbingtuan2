//
//  FNPartnerGoodsCell.m
//  SuperMode
//
//  Created by jimmy on 2017/10/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerGoodsCell.h"
const CGFloat _pgc_cell_height = 140;

@interface FNPartnerGoodsCell()

@property (nonatomic, weak)UIImageView *GoodsImage;

@property (nonatomic, weak)UILabel *GoodsName;

@property (nonatomic, weak)UILabel *Price;

@property (nonatomic, weak)UILabel *promptPrice;

@property (nonatomic, strong)UIView* couponview;
@property (nonatomic, strong)UIButton* couponBtn;
@property (nonatomic, strong)UIImageView* couponImg;

@property (nonatomic, strong) UIView* rightView;
@property (nonatomic, strong) UIButton* operateBtn;
@property (nonatomic, strong) UILabel* rightLabel;

@end
@implementation FNPartnerGoodsCell

- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
        _rightLabel = [UILabel new];
        _rightLabel.font = kFONT12;
        _rightLabel.textColor = RED;
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _rightLabel;
}
- (UIButton *)operateBtn{
    if (_operateBtn == nil) {
        _operateBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_operateBtn setImage:IMAGE(@"home_share") forState:(UIControlStateNormal)];
        [_operateBtn sizeToFit];
        _operateBtn.titleLabel.font = kFONT14;
        _operateBtn.userInteractionEnabled = NO;
    }
    return _operateBtn;
}
- (UIView *)rightView{
    if (_rightView == nil) {
        _rightView = [UIView new];
        
        [_rightView addSubview:self.operateBtn];
        [self.operateBtn autoSetDimensionsToSize:(self.operateBtn.size)];
        [self.operateBtn autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        [self.operateBtn autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        @weakify(self);
        [_rightView addJXTouch:^{
            @strongify(self);
            if (self.sharerightNow) {
                self.sharerightNow(self.model);
            }
        }];
        
        [_rightView addSubview:self.rightLabel];
        [self.rightLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [self.rightLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.rightLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.operateBtn withOffset:5];
        
    }
    return _rightView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self jm_setupViews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews{
    UIButton* chooseBtn=[UIButton new];
    chooseBtn.hidden=YES;
    chooseBtn.userInteractionEnabled=NO;
    [chooseBtn setImage:IMAGE(@"vip_choose_off") forState:UIControlStateNormal];
    [chooseBtn setImage:IMAGE(@"vip_choose_on") forState:UIControlStateSelected];
    [self addSubview:chooseBtn];
    [chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.equalTo(@20);
    }];
    self.chooseBtn=chooseBtn;
    
    UIImageView *GoodsImage=[UIImageView new];
    [self addSubview:GoodsImage];
    [GoodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.bottom.equalTo(@-10);
        make.width.equalTo(GoodsImage.mas_height);
    }];
    self.GoodsImage=GoodsImage;
    
    UILabel *GoodsName=[UILabel new];
    GoodsName.numberOfLines=1;
    GoodsName.font=kFONT13;
    [self addSubview:GoodsName];
    [GoodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(GoodsImage.mas_right).offset(5);
        make.top.equalTo(@12);
        make.right.equalTo(@-5);
    }];
    self.GoodsName=GoodsName;
    
    //月销 或 ¥
    UILabel *promptPrice=[UILabel new];
    promptPrice.textColor=FNMainGobalTextColor;
    promptPrice.font=kFONT13;
    [self addSubview:promptPrice];
    [promptPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(GoodsImage.mas_right).offset(5);
        make.bottom.equalTo(@-12);
        make.right.equalTo(@-5);
    }];
    self.promptPrice=promptPrice;
    //券后价
    UILabel *Price=[UILabel new];
    Price.adjustsFontSizeToFitWidth = YES;
    Price.textColor=FNMainGobalTextColor;
    Price.font=kFONT15;
    [self addSubview:Price];
    [Price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(promptPrice.mas_top).offset(-10);
        make.left.equalTo(GoodsImage.mas_right).offset(5);
    }];
    self.Price=Price;
    
    //旧版优惠券
    _couponview = [UIView new];
    [self.contentView addSubview:_couponview];

    UIImageView* couponImg = [[UIImageView alloc]init];
    couponImg.image = IMAGE(@"left_ticket");
    [couponImg sizeToFit];
    [_couponview addSubview:couponImg];
    _couponImg = couponImg;

    UILabel* tmpLabel = [UILabel new];
    tmpLabel.textColor = FNWhiteColor;
    tmpLabel.text = @"领券";
    tmpLabel.textAlignment = NSTextAlignmentCenter;
    tmpLabel.adjustsFontSizeToFitWidth = YES;
    tmpLabel.font = kFONT12;
    [_couponImg addSubview:tmpLabel];
    [tmpLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];

    UIButton * couponBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    couponBtn.userInteractionEnabled = NO;
    [couponBtn setBackgroundImage:[IMAGE(@"right_ticket") stretchableImageWithLeftCapWidth:10 topCapHeight:0]  forState:UIControlStateNormal];
    couponBtn.titleLabel.font = kFONT12;
    [_couponview addSubview:couponBtn];
    _couponBtn = couponBtn;

    [_couponview autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:GoodsName];
    [_couponview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:Price withOffset:-10];
    [_couponview autoSetDimension:(ALDimensionHeight) toSize:_couponImg.height];
    [_couponview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];

    [_couponImg autoSetDimensionsToSize:_couponImg.size];
    [_couponImg autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_couponImg autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];

    [_couponBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_couponImg];
    [_couponBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_couponBtn autoSetDimension:(ALDimensionHeight) toSize:_couponImg.height];
    [_couponBtn autoSetDimension:(ALDimensionWidth) toSize:(FNDeviceWidth-_couponImg.width  -_jm_margin10*3) relation:(NSLayoutRelationLessThanOrEqual)];
    
    [self addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(@0);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];

    UIView* line = [UIView new];
    line.backgroundColor = FNHomeBackgroundColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.bottom.equalTo(@-10);
        make.height.equalTo(@35);
        make.right.equalTo(@-100);
    }];

    if ([FNBaseSettingModel settingInstance].app_sharegoods_onoff.boolValue) {
        line.hidden=YES;
        self.rightView.hidden=YES;
    }else{
        line.hidden=NO;
        self.rightView.hidden=NO;
    }
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNPartnerGoodsCell";
    FNPartnerGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNPartnerGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}

- (void)setModel:(FNPartnerGoodsModel *)model{
    _model = model;
    if (_model) {
        self.chooseBtn.selected=model.isChoose;
        [self.GoodsImage setUrlImg:model.goods_img];
        
        self.GoodsName.text = model.goods_title;
        [self.GoodsName HttpLabelLeftImage:_model.shop_img label:self.GoodsName imageX:0 imageY:-1.5 imageH:13 atIndex:0];
        
        if ([FNBaseSettingModel settingInstance].app_fanli_onoff.boolValue) {//judge the switch of fan li
            if (_model.is_hide_fl.integerValue==1) {
                self.promptPrice.textColor=FNGlobalTextGrayColor;
                self.promptPrice.text=[NSString stringWithFormat:@"月销%@",model.goods_sales];
            }else{
                if ([_model.fcommission floatValue]<=0) {
                    self.promptPrice.textColor=FNGlobalTextGrayColor;
                    self.promptPrice.text=[NSString stringWithFormat:@"月销%@",model.goods_sales];
                }else{
                    self.promptPrice.text=[NSString stringWithFormat:@" ¥%.2f",[model.fcommission floatValue]];
                    [self.promptPrice HttpLabelLeftImage:model.ico label:self.promptPrice imageX:0 imageY:-3 imageH:15 atIndex:0];
                }
            }
        }else{
            if ([[FNBaseSettingModel settingInstance].app_choujiang_onoff integerValue]==1) {
                self.promptPrice.text=[FNBaseSettingModel settingInstance].app_fanli_off_str;
                [self.promptPrice HttpLabelLeftImage:model.ico label:self.promptPrice imageX:0 imageY:-3 imageH:15 atIndex:0];
            }else{
                self.promptPrice.textColor=FNGlobalTextGrayColor;
                self.promptPrice.text=[NSString stringWithFormat:@"月销%@",model.goods_sales];
            }
        }
        
        [_couponBtn setTitle:[NSString stringWithFormat:@"  %@元  ",model.yhq_price] forState:UIControlStateNormal];
        if (![NSString checkIsSuccess:model.yhq andElement:@"1"]) {
            _couponview.hidden = YES;
            self.Price.text = [NSString stringWithFormat:@"%@%.2f",[FNBaseSettingModel settingInstance].app_daoshoujia_name,[_model.goods_price floatValue]];
            [self.Price addSingleAttributed:@{NSFontAttributeName:kFONT10} ofRange:[self.Price.text rangeOfString:[FNBaseSettingModel settingInstance].app_daoshoujia_name]];
        }else{
            _couponview.hidden = NO;
            self.Price.text = [NSString stringWithFormat:@"%@%.2f",[FNBaseSettingModel settingInstance].app_quanhoujia_name,[_model.goods_price floatValue]];
            [self.Price addSingleAttributed:@{NSFontAttributeName:kFONT10} ofRange:[self.Price.text rangeOfString:[FNBaseSettingModel settingInstance].app_quanhoujia_name]];
        }
        
        if ([FNBaseSettingModel settingInstance].all_fx_onoff.boolValue) {
            if (model.is_hide_sharefl.integerValue==1) {
                _rightLabel.text=[NSString stringWithFormat:@"%@",[FNBaseSettingModel settingInstance].hhrshare_noflstr];
            }else{
                _rightLabel.text=[NSString stringWithFormat:@"%@%@",[FNBaseSettingModel settingInstance].hhrshare_flstr,model.fcommission];
            }
        }else{
            _rightLabel.text=[NSString stringWithFormat:@"%@",[FNBaseSettingModel settingInstance].hhrshare_noflstr];
        }
    }
}

-(void)setOnlyChangeStyle:(BOOL)OnlyChangeStyle{
    self.chooseBtn.selected=self.model.isChoose;
    if (OnlyChangeStyle==YES) {
        self.chooseBtn.hidden=NO;
        [self.GoodsImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.chooseBtn.mas_right).offset(10);
            make.top.equalTo(@10);
            make.bottom.equalTo(@-10);
            make.width.equalTo(self.GoodsImage.mas_height);
        }];
    }else{
        self.chooseBtn.hidden=YES;
        [self.GoodsImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.top.equalTo(@10);
            make.bottom.equalTo(@-10);
            make.width.equalTo(self.GoodsImage.mas_height);
        }];
    }
}

@end
