//
//  OrderListCell.m
//  THB
//
//  Created by zhongxueyu on 16/4/6.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "OrderListCell.h"

@implementation OrderListCell
- (UIView *)awardView{
    if (_awardView == nil) {
        _awardView = [[UIView alloc]initWithFrame:(CGRectZero)];
        
        [_awardView addSubview:self.tbdImgView];
        [self.tbdImgView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        [self.tbdImgView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.tbdImgView autoSetDimensionsToSize:self.tbdImgView.size];
        
        [_awardView addSubview:self.doneImgView];
        [self.doneImgView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        [self.doneImgView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.doneImgView autoSetDimensionsToSize:self.doneImgView.size];
        
        [_awardView addSubview:self.awardImgView];
        [self.awardImgView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
        [self.awardImgView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.awardImgView autoSetDimensionsToSize:self.awardImgView.size];
    }
    return _awardView;
}
- (UIImageView *)tbdImgView{
    if (_tbdImgView == nil) {
        _tbdImgView = [[UIImageView alloc]initWithImage:IMAGE(@"order_raffle_bj1")];
    }
    return _tbdImgView;
}
- (UIImageView *)doneImgView{
    if (_doneImgView == nil) {
        _doneImgView = [[UIImageView alloc]initWithImage:IMAGE(@"order_raffle_bj2")];
    }
    return _doneImgView;
}
- (UIImageView *)awardImgView{
    if (_awardImgView == nil) {
        _awardImgView = [[UIImageView alloc]initWithImage:IMAGE(@"order_raffle_bj3")];
    }
    return _awardImgView;
}
-(UILabel *)imgLabel{
    if (_imgLabel == nil) {
        _imgLabel = [UILabel new];
        _imgLabel.textColor = FNWhiteColor;
        _imgLabel.font = kFONT13;
        _imgLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _imgLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.productImg.alpha = 0.f;
    // 执行动画
    [UIView animateWithDuration:IMGDuration animations:^{
        self.productImg.alpha = 1.f;
    }];
    self.returnLB=[UILabel new];
    self.returnLB.layer.cornerRadius=2.5;
    self.returnLB.adjustsFontSizeToFitWidth = YES;
    self.returnLB.textColor=[UIColor whiteColor];
    self.returnLB.font=kFONT11;
    self.returnLB.backgroundColor=RED;
    self.returnLB.textAlignment=NSTextAlignmentCenter;
    [self.infoView addSubview:self.returnLB];
    self.returnLB.sd_layout
    .topSpaceToView(self.title, 12.5).leftSpaceToView(self.productImg, 10).heightIs(15).widthIs(15);
    self.rebates.sd_layout
    .topSpaceToView(self.title, 10).leftSpaceToView(self.returnLB, 10).heightIs(20);
    [self.rebates setSingleLineAutoResizeWithMaxWidth:100];
    self.rebates.textAlignment=NSTextAlignmentLeft;
    
    self.followLabel.adjustsFontSizeToFitWidth = YES;
    self.daozhangInfo = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.daozhangInfo setTitleColor:FNColor(41, 211, 163) forState:UIControlStateNormal];
    self.daozhangInfo.borderColor = FNColor(41, 211, 163);
    self.daozhangInfo.cornerRadius = 10;
    self.daozhangInfo.borderWidth = 1.0;
    self.daozhangInfo.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.daozhangInfo.titleLabel.font = kFONT12;
    self.daozhangInfo.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [self.infoView addSubview:self.daozhangInfo];
    [self.daozhangInfo autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.rebates withOffset:5];
    [self.daozhangInfo autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.rebates];
    [self.daozhangInfo autoSetDimension:(ALDimensionHeight) toSize:20];
    [self.daozhangInfo autoSetDimension:(ALDimensionWidth) toSize:50 relation:(NSLayoutRelationGreaterThanOrEqual)];
    self.daozhangInfo.sd_layout
    .leftSpaceToView(self.rebates, 10).heightIs(20).topSpaceToView(self.title, 10).widthIs(50);

    if (self.infoView.subviews.count>0) {
        [self.infoView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UILabel class]]) {
                UILabel*    lable = obj;
                lable.font = kFONT14;
            }
        }];
    }
    if (self.contentView.subviews.count>0) {
        [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UILabel class]]) {
                UILabel*    lable = obj;
                lable.font = kFONT14;
            }
        }];
    }
    
    [self.infoView addSubview:self.awardView];
    [self.awardView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:self.rebates];
    [self.awardView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.followLabel];
    [self.awardView autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:self.arrowImgView withOffset:-10];
    [self.awardView autoSetDimension:(ALDimensionWidth) toSize:XYScreenWidth*0.3];
    self.followLabel.sd_layout
    .leftSpaceToView(self.productImg, 10).rightSpaceToView(self.infoView, 10).heightIs(20).bottomEqualToView(self.productImg);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setModel:(OrderModel *)Model{
    _Model=Model;
    if (_Model) {
        self.shopName.adjustsFontSizeToFitWidth = YES;
        self.rebates.adjustsFontSizeToFitWidth = YES;
        self.orderNum.adjustsFontSizeToFitWidth = YES;
        self.detailDate.adjustsFontSizeToFitWidth = YES;
        self.followLabel.text=@"";
        if ([Model.is_daozhang isEqualToString:@"待付款"]) {
            self.followLabel.text = Model.order_setstr1;
        }
        else if([Model.is_daozhang containsString:@"失效"]){
            self.followLabel.text =@"已失效";
        }
        else if([Model.is_daozhang containsString:@"未到账"]){
            self.followLabel.text =Model.order_setstr2;
        }
        else if([Model.is_daozhang containsString:@"已到账"]){
            self.followLabel.text =@"已到账";
        }
        else{
            self.followLabel.text =Model.is_daozhang;
        }
        
        
        self.detailDate.text =[NSString stringWithFormat:@"下单日期：%@",[NSString getTimeStr:Model.createDate]];
        
        if ([Model.goods_img kr_isNotEmpty]) {
            [self.productImg setUrlImg:Model.goods_img];
        }else{
            self.productImg.image = DEFAULT;
        }
        if (Model.ads_name) {
            self.shopName.text = Model.ads_name;
        }else{
            self.shopName.text = @"";
        }
        
        [self.daozhangInfo setTitle:[NSString stringWithFormat:@" %@ ",Model.is_daozhang ] forState:UIControlStateNormal] ;
        self.rebates.textColor = RED;
        
        self.title.text = Model.goodsInfo;
        self.orderNum.text = [NSString stringWithFormat:@"订单号：%@",Model.orderId];
        
        [self.imgLabel removeFromSuperview];
        NSInteger status = Model.choujiang_status.integerValue;
        if (status == 0 || ![FNBaseSettingModel settingInstance].app_choujiang_onoff.boolValue) {
            self.awardView.hidden = YES;
        }else{
            self.awardView.hidden = NO;
        }
        
        NSInteger choujiangInt=[[FNBaseSettingModel settingInstance].app_choujiang_onoff integerValue];
       
        if(choujiangInt==0){
            //NSInteger returnfb=[Model.returnfb integerValue];
            CGFloat returnfb=[Model.returnfb floatValue];
            if(returnfb>0){
                self.returnLB.text=@"返";
                self.rebates.text=Model.returnfb;
                self.returnLB.hidden=NO;
                [self.returnLB mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.productImg.mas_right).offset(10);
                    make.top.equalTo(self.title.mas_bottom).offset(12.5);
                    make.height.equalTo(@15);
                    make.width.equalTo(@15);
                }];
                [self.rebates mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.returnLB.mas_right).offset(10);
                    make.top.equalTo(self.title.mas_bottom).offset(10);
                    make.height.equalTo(@20);
                }];
                [self.rebates setSingleLineAutoResizeWithMaxWidth:100];
                
            }else{
                self.returnLB.text=@"";
                self.returnLB.hidden=YES;
                self.rebates.text=Model.is_daozhang;
                [self.returnLB mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.productImg.mas_right).offset(10);
                    make.top.equalTo(self.title.mas_bottom).offset(12.5);
                    make.height.equalTo(@15);
                }];
                [self.returnLB setSingleLineAutoResizeWithMaxWidth:15];
                [self.rebates mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.productImg.mas_right).offset(5);
                    make.top.equalTo(self.title.mas_bottom).offset(10);
                    make.height.equalTo(@20);
                }];
                [self.rebates setSingleLineAutoResizeWithMaxWidth:100];
            }
        }
        
        self.imgLabel.text = Model.app_fanli_off_str;
    }
     [self.contentView setNeedsLayout];
}

@end
