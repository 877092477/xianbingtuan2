//
//  FNstoreInformationDaNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/11/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNstoreInformationDaNeCell.h"

@implementation FNstoreInformationDaNeCell
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    
    
    
    //店铺
    self.storeName=[UILabel new];
    [self.storeName sizeToFit];
    self.storeName.textColor=[UIColor blackColor];
    self.storeName.font=kFONT17;
    [self.contentView addSubview:self.storeName];
    
    //赏
    self.rewardLB=[UILabel new];
    self.rewardLB.textColor=FNColor(140, 140, 140);
    self.rewardLB.font=kFONT14;
    [self.rewardLB sizeToFit];
    [self.contentView addSubview:self.rewardLB];
    //self.rewardLB.backgroundColor=[UIColor grayColor];
    
    //人均消费
    self.consumeLB=[UILabel new];
    self.consumeLB.textColor=FNColor(140, 140, 140);
    self.consumeLB.font=kFONT13;
    [self.consumeLB sizeToFit];
    [self.contentView addSubview:self.consumeLB];
    //self.consumeLB.backgroundColor=[UIColor blackColor];
    
    //店铺位置图片
    self.locationImage=[UIImageView new];
    [self.contentView addSubview:self.locationImage];
    
    //店铺位置
    self.locationLB=[UILabel new];
    self.locationLB.textColor=[UIColor blackColor];
    self.locationLB.font=kFONT14;
    [self.locationLB sizeToFit];
    [self.contentView addSubview:self.locationLB];
    
    //店铺电话图片
    self.phoneImage=[UIImageView new];
    [self.contentView addSubview:self.phoneImage];
    self.phoneImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *phoneImagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneClick)];
    [self.phoneImage addGestureRecognizer:phoneImagetap];
    
    //店铺电话
    self.phoneLB=[UILabel new];
    self.phoneLB.textColor=[UIColor blackColor];
    self.phoneLB.font=kFONT14;
    [self.phoneLB sizeToFit];
    [self.contentView addSubview:self.phoneLB];
    self.phoneLB.userInteractionEnabled = YES;
    UITapGestureRecognizer *phonetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneClick)];
    [self.phoneLB addGestureRecognizer:phonetap];
    
    self.lineLB=[UILabel new];
    self.lineLB.backgroundColor=FNColor(244, 244, 244);
    [self.contentView addSubview:self.lineLB];
    
    [self initPlaceSubviews];
    
    
}
#pragma mark - initPlaceSubviews
- (void)initPlaceSubviews {
    CGFloat space_10=10;
    CGFloat space_7=7;
    
    self.storeName.sd_layout.heightIs(20).leftSpaceToView(self.contentView, space_10).rightSpaceToView(self.contentView, space_10).topSpaceToView(self.contentView, space_10*2);
    
    self.rewardLB.sd_layout.heightIs(20).leftSpaceToView(self.contentView, space_10).topSpaceToView(self.storeName, space_10).rightSpaceToView(self.contentView, space_10);
    //[self.rewardLB setSingleLineAutoResizeWithMaxWidth:100];
    
//    self.consumeLB.sd_layout.topSpaceToView(self.storeName, space_10).leftSpaceToView(self.rewardLB, space_10).heightIs(20).widthIs(self.consumeLB.width);
//    [self.consumeLB setSingleLineAutoResizeWithMaxWidth:100];
    
    self.locationImage.sd_layout.leftSpaceToView(self.contentView, space_10).topSpaceToView(self.contentView, 80).heightIs(16.5).widthIs(13.5);
    
    self.locationLB.sd_layout.heightIs(20).leftSpaceToView(self.locationImage, space_10).rightSpaceToView(self.contentView, space_10).centerYEqualToView(self.locationImage);
    
    self.phoneImage.sd_layout.leftSpaceToView(self.contentView, space_10).topSpaceToView(self.locationImage, space_10+2).heightIs(15).widthIs(15);
    
    self.phoneLB.sd_layout.heightIs(20).leftSpaceToView(self.phoneImage, space_10).rightSpaceToView(self.contentView, space_10).centerYEqualToView(self.phoneImage);
    
    self.lineLB.sd_layout.heightIs(5).leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0);
    
    
    
}
-(void)setDicModel:(NSDictionary *)dicModel{
    _dicModel=dicModel;
    if(dicModel){
        FNstoreInformationDaModel *model=[FNstoreInformationDaModel mj_objectWithKeyValues:dicModel];
        self.storeName.text=model.name;//@"虾兵蟹将海鲜自助餐";
        
        if (![FNCurrentVersion isEqualToString:Setting_checkVersion]) {
            self.rewardLB.text=model.str;//@"赏3.2%";
            self.rewardLB.text=[NSString stringWithFormat:@"%@  %@",model.str,model.str2];
            if([model.str kr_isNotEmpty]){
               [self.rewardLB fn_changeColorWithTextColor:FNColor(255, 17, 29) changeText:model.str];
            }
        }else{
            NSString *str1=@"消费";
            NSString *joint=[NSString stringWithFormat:@"%@  %@",str1,model.str2];
            self.rewardLB.text=joint;//@"赏3.2%";
            [self.rewardLB fn_changeColorWithTextColor:FNColor(255, 17, 29) changeText:str1];
        }
        //self.consumeLB.text=model.str2;//@"78/人份";
        self.locationLB.text=model.address;//@"广东省广州市天河区体育西路天河又一城7楼";
        self.phoneLB.text=model.phone;//@"热线电话: 13589200697";
        self.locationImage.image=IMAGE(@"details_orientation");
        self.phoneImage.image=IMAGE(@"details_photo");
         
        //kr_getWidthWithTextHeight
        //NSString* price = [NSString stringWithFormat:@"%.2lf",[model.goods_price floatValue]];
        //self.qhPriceLabel.text = [NSString stringWithFormat:@"券后¥%@",price];
        //[self.rewardLB addSingleAttributed:@{NSFontAttributeName:kFONT16} ofRange:[self.rewardLB.text rangeOfString:price]];
        
    }
}

-(void)phoneClick{
    if ([self.delegate respondsToSelector:@selector(ringUpStoreCommodityAction)]) {
        [self.delegate ringUpStoreCommodityAction];
    }
}
@end
