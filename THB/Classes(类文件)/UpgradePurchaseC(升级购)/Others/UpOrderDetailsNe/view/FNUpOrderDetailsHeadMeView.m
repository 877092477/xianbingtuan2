//
//  FNUpOrderDetailsHeadMeView.m
//  THB
//
//  Created by Jimmy on 2018/9/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpOrderDetailsHeadMeView.h"

@implementation FNUpOrderDetailsHeadMeView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor lightGrayColor];
        [self initUI];
    }
    return self;
}
-(void)initUI{
    /** bgImageView **/
    self.bgImageView=[[UIImageView alloc]init];
    //self.bgImageView.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.bgImageView];
    /** 物流名字 **/
    self.logisticsLB=[UILabel new];
    //self.logisticsLB.backgroundColor=FNColor(240,240,240);
    self.logisticsLB.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.logisticsLB];
    /** 物流单号 **/
    self.logisticsNumberLB=[UILabel new];
    //self.logisticsNumberLB.backgroundColor=FNColor(240,240,240);
    self.logisticsNumberLB.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.logisticsNumberLB];
    /** 复制 **/
    self.duplicateButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.duplicateButton.backgroundColor=[UIColor whiteColor];
    [self.duplicateButton addTarget:self action:@selector(duplicateClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.duplicateButton];
    /** 状态图片 **/
    self.stateImageView=[[UIImageView alloc]init];
    //self.stateImageView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:self.stateImageView];
    
    [self inDistribution];
}
-(void)inDistribution{
    CGFloat interval_10=10;
    self.bgImageView.sd_layout
    .leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
    self.logisticsLB.sd_layout
    .leftSpaceToView(self.contentView, interval_10+5).topSpaceToView(self.contentView, interval_10*2).heightIs(25);
    [self.logisticsLB setSingleLineAutoResizeWithMaxWidth:100];
    self.logisticsNumberLB.sd_layout
    .leftSpaceToView(self.contentView, interval_10+5).topSpaceToView(self.logisticsLB, interval_10).heightIs(20);
    [self.logisticsNumberLB setSingleLineAutoResizeWithMaxWidth:200];
    self.duplicateButton.sd_layout
    .centerYEqualToView(self.logisticsNumberLB).widthIs(20).heightIs(20).leftSpaceToView(self.logisticsNumberLB, interval_10);
    self.stateImageView.sd_layout
    .rightSpaceToView(self.contentView, interval_10*2).centerYEqualToView(self).widthIs(70).heightIs(70);
    
    
    
}

-(void)duplicateClick{
    if ([self.delegate respondsToSelector:@selector(HeadMeViewDuplicateOdd)]) {
        [self.delegate HeadMeViewDuplicateOdd];
    } 
}
-(void)setModel:(FNUpOrderdetailitemNeHModel *)model{
    _model=model;
    if(model){ 
        self.bgImageView.image=IMAGE(@"img_brg_sel");
        self.logisticsLB.text=model.wl_company;//@"顺丰物流";
        self.stateImageView.image=IMAGE(@"img_tab_nor");
        if([model.wl_str kr_isNotEmpty]){
            // 物流单号
            self.logisticsNumberLB.text=[NSString stringWithFormat:@"物流单号:%@",model.wl_id];//@"物流单号: 20683771707218709";
            // 复制
            self.duplicateButton.hidden=NO;
            [self.duplicateButton setImage:[UIImage imageNamed:@"icon_copy_norNe"] forState:UIControlStateNormal];
        }else{
            self.duplicateButton.hidden=YES;
        }
    }
}

@end
