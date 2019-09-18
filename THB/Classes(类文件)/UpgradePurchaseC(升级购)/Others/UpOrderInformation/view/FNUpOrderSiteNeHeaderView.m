//
//  FNUpOrderSiteNeHeaderView.m
//  THB
//
//  Created by Jimmy on 2018/9/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpOrderSiteNeHeaderView.h"

@implementation FNUpOrderSiteNeHeaderView 

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=FNWhiteColor;
        [self setCompositionView];
    }
    return self;
}
// 选择支付方式事件
-(void)siteBGviewClick:(UITapGestureRecognizer *)sender{
    if ([self.delegate respondsToSelector:@selector(OrderSelectAddressAction)] ) {
        [self.delegate OrderSelectAddressAction];
    }
}
-(void)setCompositionView{
    
    /** BGview **/
    self.siteBGview=[UIView new];
    self.siteBGview.frame=CGRectMake(0, 0, FNDeviceWidth, 100);
    self.siteBGview.backgroundColor=FNWhiteColor;
    self.siteBGview.userInteractionEnabled = YES;
    UITapGestureRecognizer *siteBGviewtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(siteBGviewClick:)];
    [self.siteBGview addGestureRecognizer:siteBGviewtap];
    [self addSubview:self.siteBGview];
    
    /** 图片 **/
    self.siteImage=[UIImageView new];
    self.siteImage.contentMode=UIViewContentModeScaleToFill;
    [self.siteBGview addSubview:self.siteImage];
    
    /** 方向图片 **/
    self.directionImage=[UIImageView new];
    [self.siteBGview addSubview:self.directionImage];
    
    /** 底部图片 **/
    self.bottomImage=[UIImageView new];
    [self.siteBGview addSubview:self.bottomImage];
    
    /** 名字 **/
    self.nameLabel=[UILabel new];
    self.nameLabel.textColor=FNBlackColor;
    self.nameLabel.font=kFONT12;
    [self.siteBGview addSubview:self.nameLabel];
    
    /** 电话号码 **/
    self.numberLabel=[UILabel new];
    self.numberLabel.textColor=FNBlackColor;
    self.numberLabel.font=kFONT12;
    [self.siteBGview addSubview:self.numberLabel];
    
    /** 地址 **/
    self.siteLabel=[UILabel new];
    self.siteLabel.numberOfLines=2;
    self.siteLabel.textColor=FNBlackColor;
    self.siteLabel.font=kFONT12;
    [self.siteBGview addSubview:self.siteLabel];
    
    /** 无地址 **/
    self.zeroAddress=[UILabel new];
    self.zeroAddress.textColor=FNBlackColor;
    self.zeroAddress.font=kFONT14;
    self.zeroAddress.textAlignment=NSTextAlignmentCenter;
    [self.siteBGview addSubview:self.zeroAddress];
    
    [self initializedSubviews];
}

#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    CGFloat interval_10 = 10;
    //商品BGView
    self.siteBGview.sd_layout
    .topSpaceToView(self, 0).leftSpaceToView(self, 0).heightIs(100).rightSpaceToView(self, 0).bottomSpaceToView(self,0);
    //商品图片
    self.siteImage.sd_layout
    .leftSpaceToView(self.siteBGview, interval_10).widthIs(18).heightIs(25).centerYEqualToView(self.siteBGview).topSpaceToView(self.siteBGview, 40);
    
    self.directionImage.sd_layout
    .rightSpaceToView(self.siteBGview, interval_10).widthIs(10).heightIs(15).centerYEqualToView(self.siteImage);
    
    self.bottomImage.sd_layout
    .leftSpaceToView(self.siteBGview, 0).heightIs(10).rightSpaceToView(self.siteBGview, 0).bottomSpaceToView(self.siteBGview,10);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.siteBGview, interval_10).leftSpaceToView(self.siteImage, interval_10).heightIs(20);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:120];
    
    self.numberLabel.sd_layout
    .topSpaceToView(self.siteBGview, interval_10).rightSpaceToView(self.directionImage, interval_10).heightIs(20);
    [self.numberLabel setSingleLineAutoResizeWithMaxWidth:120];
    
    self.siteLabel.sd_layout
    .topSpaceToView(self.numberLabel, interval_10)
    .leftSpaceToView(self.siteImage, interval_10).heightIs(30).rightSpaceToView(self.directionImage, interval_10);
    /** 无地址 **/
    self.zeroAddress.sd_layout
    .topSpaceToView(self.numberLabel, 0).leftSpaceToView(self.siteImage, interval_10).heightIs(30).rightSpaceToView(self.directionImage, interval_10).centerYEqualToView(self.siteBGview);

}

-(void)setModel:(NSDictionary *)model{
    _model=model;
    if(model){
        FNUpOrderAddressNModel *AddressNModel=[FNUpOrderAddressNModel mj_objectWithKeyValues:model];
        if([AddressNModel.name kr_isNotEmpty]){
            self.siteImage.image=IMAGE(@"icon_add_nor");// 图片
            self.directionImage.image=IMAGE(@"btn__more_nor");// 方向
            self.bottomImage.image=IMAGE(@"img_border_nor");// 底部图片
            self.nameLabel.text=[NSString stringWithFormat:@"收货人:%@",AddressNModel.name];//@"收货人:王小明";
            self.numberLabel.text=AddressNModel.phone;//@"1317754536";
            if([AddressNModel.address_msg kr_isNotEmpty]){
                self.siteLabel.text=[NSString stringWithFormat:@"收货地址:%@",AddressNModel.address_msg];//@"收货地址:广东省珠海市香洲区南屏镇南屏科技广场永和花园一栋六单元1421";
            }else{
                self.siteLabel.text=[NSString stringWithFormat:@"收货地址:%@",AddressNModel.address];//@"收货地址:广东省珠海市香洲区南屏镇南屏科技广场永和花园一栋六单元1421";
            }
           
            self.zeroAddress.hidden=YES;
        }else{
            self.zeroAddress.hidden=NO;
            self.zeroAddress.text=@"请选择地址";
        }
       
        
    }
}

@end
