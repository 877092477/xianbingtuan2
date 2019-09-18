//
//  FNSpeciHeadNeCell.m
//  THB
//
//  Created by Jimmy on 2018/9/27.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNSpeciHeadNeCell.h"
#import "FNUpDetailsNModel.h"
@implementation FNSpeciHeadNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
-(void)setCompositionView{
    
    self.bgView=[UIView new];
    self.bgView.frame=CGRectMake(0, 10, FNDeviceWidth, 90);
    self.bgView.backgroundColor=FNWhiteColor;
    [self.contentView addSubview:self.bgView];
    
   
    
    //原价
    self.originPriceLabel=[UILabel new];
    [self.originPriceLabel sizeToFit];
    self.originPriceLabel.textColor=FNColor(246, 71, 111);
    self.originPriceLabel.font=kFONT15;
    [self.bgView addSubview:self.originPriceLabel];
    
    //库存
    self.repertoryLabel=[UILabel new];
    self.repertoryLabel.textColor=FNBlackColor;
    self.repertoryLabel.font=kFONT13;
    [self.bgView addSubview:self.repertoryLabel];
    
    //选择
    self.specificationLabel=[UILabel new];
    [self.specificationLabel sizeToFit];
    self.specificationLabel.textColor=FNBlackColor;
    self.specificationLabel.font=kFONT13;
    [self.bgView addSubview:self.specificationLabel];
    
    //消失
    self.closedBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.closedBtn setImage:IMAGE(@"btn_details_colse") forState:UIControlStateNormal];
    [self.closedBtn addTarget:self action:@selector(BouncedDismiss) forControlEvents:(UIControlEventTouchUpInside)];
    [self.bgView addSubview:_closedBtn];
    
    self.bgImageView=[UIView new];
    self.bgImageView.cornerRadius=10/2;
    self.bgImageView.frame=CGRectMake(10, 0, 90, 90);
    self.bgImageView.backgroundColor=FNWhiteColor;
    [self.contentView addSubview:self.bgImageView];
    //商品图片
    self.GoodsImage=[UIImageView new];
    self.GoodsImage.cornerRadius=10/2;
    self.GoodsImage.contentMode=UIViewContentModeScaleToFill;
    self.GoodsImage.image=IMAGE(@"APP底图.png");
    self.GoodsImage.backgroundColor=FNWhiteColor;
    [self.bgImageView addSubview:self.GoodsImage];
    
    [self initializedSubviews];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    
    CGFloat interval_10 = 10;
    self.bgView.sd_layout
    .topSpaceToView(self.contentView, 20).leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0);
    
    self.closedBtn.sd_layout
    .topSpaceToView(self.bgView, interval_10).rightSpaceToView(self.bgView, interval_10).heightIs(20).widthIs(20);
    
    //原价
    self.originPriceLabel.sd_layout
    .leftSpaceToView(self.bgView, 120).heightIs(25).topSpaceToView(self.bgView, interval_10/2);
    [self.originPriceLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    //商品库存
    self.repertoryLabel.sd_layout
    .topSpaceToView(self.originPriceLabel, interval_10/2).leftSpaceToView(self.bgView, 120).heightIs(20);
    [self.repertoryLabel setSingleLineAutoResizeWithMaxWidth:150];
    //规格
    self.specificationLabel.sd_layout
    .leftSpaceToView(self.bgView, 120).heightIs(20).topSpaceToView(self.repertoryLabel, 2.5);
    [self.specificationLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.bgImageView.sd_layout
    .topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, interval_10).widthIs(100).heightIs(100);
    //商品图片
    self.GoodsImage.sd_layout
    .topSpaceToView(self.bgImageView, 5).leftSpaceToView(self.bgImageView, 5).widthIs(90).heightIs(90);
    
    
}
-(void)setDatadic:(NSDictionary *)datadic{
    _datadic=datadic;
    if(datadic){
        FNUpDetailsNModel *model=[FNUpDetailsNModel mj_objectWithKeyValues:datadic];
        [self.GoodsImage setUrlImg:model.img];
        self.originPriceLabel.text=[NSString stringWithFormat:@"¥%@",model.price];//@"¥100.00";
        self.repertoryLabel.text=[NSString stringWithFormat:@"库存%@",model.stock];//@"库存178件";
        self.specificationLabel.text=@"选择颜色尺码";//@"选择颜色尺码";
    }
}
-(void)BouncedDismiss{
    if ( [self.delegate respondsToSelector:@selector(SpeciHeadNedisappear)] ) {
        [self.delegate SpeciHeadNedisappear];
    }
}
-(void)setSeleArray:(NSMutableArray *)seleArray{
    _seleArray=seleArray;
    if(seleArray.count>0){
        NSLog(@"seleArray:%@",seleArray);
        NSMutableArray *arr=[NSMutableArray array];
        for (NSInteger i = 0; i < seleArray.count; i++) {
            FNUpGoodsAttrNModel *model=seleArray[i];
            for (NSInteger j = 0; j < model.attr_val.count; j++) {
                FNUpGoodsAttrItemNModel *ExModel= model.attr_val[j];
                if (ExModel.isSelect == YES) {
                        [arr addObject:ExModel.name];
                }
            }
        }
        NSString *jointString=[arr componentsJoinedByString:@"，"];
        if(arr.count>0){
            self.specificationLabel.text=[NSString stringWithFormat:@"已选%@",jointString];
        }else{
            self.specificationLabel.text=@"选择";//@"选择颜色尺码";
        }
        
    }
}
@end
