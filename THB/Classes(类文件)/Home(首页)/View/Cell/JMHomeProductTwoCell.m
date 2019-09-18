//
//  JMHomeProductTwoCell.m
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/6/14.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "JMHomeProductTwoCell.h"
#import "JMProgressView.h"
#import "DiscountLabel.h"
#import "FNBaseProductModel.h"

@interface JMHomeProductTwoCell ()

@property (nonatomic, weak) UIImageView* imgView;
@property (nonatomic, weak) UILabel* titleLabel;
@property (nonatomic, weak) UILabel* priceLabel;
@property (nonatomic, weak) UILabel* shop_title;
@property (nonatomic, weak) UILabel* from_sales;
@property (nonatomic, weak) UILabel* rebateLabel;
@property (nonatomic, weak) UIButton* couponimBtn;

@property (nonatomic, strong) UIView* rightView;
@property (nonatomic, strong) UIButton* operateBtn;
@property (nonatomic, strong) UILabel* rightLabel;

@end

@implementation JMHomeProductTwoCell

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

#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    static NSString *reuseIdentifier = @"JMHomeProductTwoCell";
    JMHomeProductTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[JMHomeProductTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initializedSubviews];
        
        UIView* line = [UIView new];
        line.backgroundColor = FNHomeBackgroundColor;
        [self addSubview:line];
        [line autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
        [line autoSetDimension:(ALDimensionHeight) toSize:1.0];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews{
    UIImageView *imgView = [UIImageView new];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.height.width.equalTo(@(JMHPCellImgHeight));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = kFONT13;
    titleLabel.numberOfLines = 2;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgView.mas_right).offset(10);
        make.right.equalTo(@-10);
        make.top.equalTo(@10);
    }];
    
    [self addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(@0);
        make.width.equalTo(@80);
        make.height.equalTo(@50);
    }];
    
    UILabel *priceLabel=[UILabel new];
    priceLabel.adjustsFontSizeToFitWidth = YES;
    priceLabel.textColor=FNMainGobalTextColor;
    priceLabel.font=kFONT17;
    [self addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgView.mas_right).offset(10);
        make.right.equalTo(self.rightView.mas_left).offset(-10);
        make.bottom.equalTo(@-5);
    }];
    
    UILabel *from_sales=[UILabel new];
    from_sales.textColor=FNGlobalTextGrayColor;
    from_sales.font=kFONT12;
    [self addSubview:from_sales];
    [from_sales mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgView.mas_right).offset(10);
        make.right.equalTo(self.rightView.mas_left).offset(-10);
        make.bottom.equalTo(priceLabel.mas_top).offset(-5);
    }];
    
    UILabel *shop_title=[UILabel new];
    shop_title.textColor=FNGlobalTextGrayColor;
    shop_title.font=kFONT12;
    [self addSubview:shop_title];
    [shop_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightView.mas_left).offset(-10);
        make.bottom.equalTo(from_sales.mas_top).offset(-2);
        make.left.equalTo(imgView.mas_right).offset(10);
    }];
    
    UIImage *quan_bj=IMAGE(@"quan_bj");
    quan_bj=[quan_bj scaleFromImage:quan_bj toSize:CGSizeMake(quan_bj.size.width/quan_bj.size.height*20, 20)];
    UIButton *couponimBtn=[UIButton new];
    couponimBtn.width=quan_bj.size.width;
    couponimBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [couponimBtn setBackgroundImage:quan_bj forState:UIControlStateNormal];
    [couponimBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    couponimBtn.titleLabel.font=kFONT11;
    [self addSubview:couponimBtn];
    [couponimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgView.mas_right).offset(10);
        make.bottom.equalTo(shop_title.mas_top).offset(-10);
        make.height.equalTo(@20);
        make.width.equalTo(@(couponimBtn.width));
    }];
    
    UILabel *rebateLabel = [UILabel new];
    rebateLabel.font = kFONT12;
    rebateLabel.textColor = FNMainGobalTextColor;
    rebateLabel.textAlignment = NSTextAlignmentLeft;
    rebateLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:rebateLabel];
    [rebateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(couponimBtn.mas_right).offset(10);
        make.centerY.equalTo(couponimBtn.mas_centerY);
        make.right.equalTo(self.rightView.mas_left).offset(-10);
    }];
    
    _imgView = imgView;
    _titleLabel = titleLabel;
    _shop_title=shop_title;
    _from_sales=from_sales;
    _priceLabel=priceLabel;
    _couponimBtn=couponimBtn;
    _rebateLabel=rebateLabel;
    
    if ([FNBaseSettingModel settingInstance].app_sharegoods_onoff.boolValue) {
        self.rightView.hidden=YES;
    }else{
        self.rightView.hidden=NO;
    }
}

- (void)setModel:(FNBaseProductModel *)model{
    _model = model;
    if (_model) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [_imgView setUrlImg:_model.goods_img];
        });
        
        _titleLabel.text = [NSString stringWithFormat:@" %@",_model.goods_title];
        [_titleLabel HttpLabelLeftImage:_model.shop_img label:_titleLabel imageX:0 imageY:-1.5 imageH:13 atIndex:0];
        
        _from_sales.text = [NSString stringWithFormat:@"%@ 热销%@",_model.provcity,_model.goods_sales];
        
        _shop_title.text = [NSString stringWithFormat:@"%@",_model.shop_title];
        if (_model.shop_title.length!=0) {
            UIImage *shopImg=IMAGE(@"detail_shop");
            [_shop_title addAttchmentImage:shopImg andBounds:CGRectMake(0, -2, 13*shopImg.size.width/shopImg.size.height, 13) atIndex:0];
        }

        [_couponimBtn setTitle:[NSString stringWithFormat:@"  %@  ",_model.yhq_span] forState:UIControlStateNormal];
        
        if ([FNBaseSettingModel settingInstance].app_fanli_onoff.boolValue) {
            if (_model.is_hide_fl.integerValue==1) {
                _rebateLabel.text = @"";
            }else{
                if ([_model.fcommission floatValue]<=0) {
                    _rebateLabel.text = @"";
                }else{
                    _rebateLabel.text=[NSString stringWithFormat:@" ¥%.2f",[_model.fcommission floatValue]];
                    [_rebateLabel HttpLabelLeftImage:_model.ico label:_rebateLabel imageX:0 imageY:-3 imageH:15 atIndex:0];
                }
            }
        }else{
            if ([[FNBaseSettingModel settingInstance].app_choujiang_onoff integerValue]==1) {
                _rebateLabel.text=_model.app_fanli_off_str;
                [_rebateLabel HttpLabelLeftImage:_model.ico label:_rebateLabel imageX:0 imageY:-3 imageH:15 atIndex:0];
            }else{
                _rebateLabel.text = @"";
            }
        }
        
        if (![NSString checkIsSuccess:_model.yhq andElement:@"1"]) {
            _couponimBtn.hidden=YES;
            _priceLabel.text = [NSString stringWithFormat:@"%@%.2f",[FNBaseSettingModel settingInstance].app_daoshoujia_name,[_model.goods_price floatValue]];
            [_priceLabel addSingleAttributed:@{NSFontAttributeName:kFONT12} ofRange:[_priceLabel.text rangeOfString:[FNBaseSettingModel settingInstance].app_daoshoujia_name]];
            
            [_rebateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_imgView.mas_right).offset(10);
                make.centerY.equalTo(_couponimBtn.mas_centerY);
                make.right.equalTo(self.rightView.mas_left).offset(-10);
            }];
        }else{
            _couponimBtn.hidden=NO;
            _priceLabel.text = [NSString stringWithFormat:@"%@%.2f",[FNBaseSettingModel settingInstance].app_quanhoujia_name,[_model.goods_price floatValue]];
            [_priceLabel addSingleAttributed:@{NSFontAttributeName:kFONT12} ofRange:[_priceLabel.text rangeOfString:[FNBaseSettingModel settingInstance].app_quanhoujia_name]];
            
            [_rebateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_couponimBtn.mas_right).offset(10);
                make.centerY.equalTo(_couponimBtn.mas_centerY);
                make.right.equalTo(self.rightView.mas_left).offset(-10);
            }];
        }
        
        if ([FNBaseSettingModel settingInstance].all_fx_onoff.boolValue) {
            if (_model.is_hide_sharefl.integerValue==1) {
                _rightLabel.text=[NSString stringWithFormat:@"%@",[FNBaseSettingModel settingInstance].hhrshare_noflstr];
            }else{
                _rightLabel.text=[NSString stringWithFormat:@"%@%@",[FNBaseSettingModel settingInstance].hhrshare_flstr,model.fcommission];
            }
        }else{
            _rightLabel.text=[NSString stringWithFormat:@"%@",[FNBaseSettingModel settingInstance].hhrshare_noflstr];
        }
    }
}

@end
