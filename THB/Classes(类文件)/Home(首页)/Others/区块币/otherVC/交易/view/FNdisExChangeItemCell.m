//
//  FNdisExChangeItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisExChangeItemCell.h"

@implementation FNdisExChangeItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews]; 
    }
    return self;
}

- (void)initializedSubviews{ 
    
    self.stateLine=[[UILabel alloc]init];
    [self addSubview:self.stateLine];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    //self.countLB=[[UILabel alloc]init];
    //[self addSubview:self.countLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    self.stateImg=[[UIImageView alloc]init];
    [self addSubview:self.stateImg];
    
    
    
    self.stateLine.font=[UIFont systemFontOfSize:11];
    self.stateLine.textColor=[UIColor whiteColor];
    self.stateLine.textAlignment=NSTextAlignmentCenter;
    
    self.nameLB.font=[UIFont systemFontOfSize:14];
    self.nameLB.textColor=RGB(102, 102, 102);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    //self.countLB.font=[UIFont systemFontOfSize:11];
    //self.countLB.textColor=RGB(153, 153, 153);
    //self.countLB.textAlignment=NSTextAlignmentLeft;
    
    self.dateLB.font=[UIFont systemFontOfSize:11];
    self.dateLB.textColor=RGB(153, 153, 153);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.stateLine.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 15).widthIs(30).heightIs(14);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.stateLine, 5).centerYEqualToView(self.stateLine).rightSpaceToView(self, 35).heightIs(16);
    
    //self.countLB.sd_layout
    //.leftSpaceToView(self, 110).centerYEqualToView(self.stateLine).widthIs(100).heightIs(16);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self, 35).topSpaceToView(self.stateLine, 4).rightSpaceToView(self, 15).heightIs(15);
    
    self.stateImg.sd_layout
    .topSpaceToView(self, 15).rightSpaceToView(self, 15).widthIs(16).heightIs(16);
    
    self.acrossview=[[FNdisExchangeAcrossView alloc]init];
    self.acrossview.frame=CGRectMake(30, 58, FNDeviceWidth-30, 40);
    self.acrossview.delegate=self;
    [self addSubview:self.acrossview];
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    self.rightBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.rightBtn setTitleColor:RGB(255, 108, 65) forState:UIControlStateNormal];
    self.rightBtn.borderWidth=1;
    self.rightBtn.borderColor = RGB(255, 108, 65);
    self.rightBtn.cornerRadius=10;
    self.rightBtn.clipsToBounds = YES;
    
    
    [self.rightBtn addTarget:self action:@selector(rightBtnAction)];
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 15).bottomSpaceToView(self, 26).widthIs(75).heightIs(33);
    
    UIView *line=[UIView new];
    line.backgroundColor=RGB(250, 250, 250);
    [self addSubview:line];
    line.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(12);
}
-(void)rightBtnAction{
        if ([self.delegate respondsToSelector:@selector(didExChangeItemCancelAction:)]) {
            [self.delegate didExChangeItemCancelAction:self.index];
        }
}
#pragma mark - FNdisExchangeAcrossViewDelegate
- (void)didExchangeAcrossAction{
    if ([self.delegate respondsToSelector:@selector(didExChangeItemAcrossAction:)]) {
        [self.delegate didExChangeItemAcrossAction:self.index];
    } 
}
-(void)setModel:(FNdisExchangeOddItemModel *)model{
    _model=model;
    if(model){
        self.stateLine.text=model.type_text;
        self.nameLB.text=model.username;
        self.dateLB.text=model.time;
        //self.countLB.text=model.transaction_number;
        [self.stateImg setUrlImg:model.icon];
        if([model.transaction_number kr_isNotEmpty]){
           NSString *jointStr=[NSString stringWithFormat:@"%@        %@",model.username,model.transaction_number];
           self.nameLB.text=jointStr;
           [self.nameLB fn_changeColorWithTextColor:RGB(153, 153, 153) changeText:model.transaction_number];
           [self.nameLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:11] changeText:model.transaction_number];
        }
        if([model.type_text isEqualToString:@"购买"]){
           self.stateLine.backgroundColor=RGB(255, 108, 65);
        }
        else if([model.type_text isEqualToString:@"出售"]){
          self.stateLine.backgroundColor=RGB(56, 236, 158);
        }
        else if([model.type_text isEqualToString:@"撤单"]){
           self.stateLine.backgroundColor=RGB(153, 153, 153);
        }else{
          self.stateLine.backgroundColor=RGB(255, 108, 65);
        }
       
        NSArray *bottomArr=model.bottom;
        
        NSMutableArray *tyArray=[NSMutableArray arrayWithCapacity:0];
        [bottomArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNdisExchangeAcrossItemModel *model=[FNdisExchangeAcrossItemModel mj_objectWithKeyValues:obj];
            if(idx==bottomArr.count){
               model.showInt=1;
            }else{
               model.showInt=0;
            }
            [tyArray addObject:model];
        }];
       
        if([model.btn_text kr_isNotEmpty]){
            self.rightBtn.hidden=NO;
            [self.rightBtn setTitle:model.btn_text forState:UIControlStateNormal];
        }else{
            self.rightBtn.hidden=YES;
        }
//            if([model.status  isEqualToString:@"0"]){
//               self.rightBtn.hidden=NO;
//            }else{
//               self.rightBtn.hidden=YES;
//            }
        
        self.acrossview.dataArr=tyArray;
    }
}

-(void)setType:(NSString *)type{
    _type=type;
    if(type){
        if([type isEqualToString:@"buy"]||[type isEqualToString:@"sell"]){
            self.stateLine.sd_layout
            .leftSpaceToView(self, 0).topSpaceToView(self, 15).widthIs(4).heightIs(14);
            
            self.nameLB.sd_layout
            .leftSpaceToView(self.stateLine, 18).centerYEqualToView(self.stateLine).rightSpaceToView(self, 35).heightIs(16);
            
            //self.countLB.sd_layout
            //.leftSpaceToView(self, 100).centerYEqualToView(self.stateLine).widthIs(100).heightIs(16);
            
            self.dateLB.sd_layout
            .leftSpaceToView(self, 18).topSpaceToView(self.stateLine, 4).rightSpaceToView(self, 15).heightIs(15);
            self.acrossview.frame=CGRectMake(18, 58, FNDeviceWidth-18, 40);
        }else{
            self.stateLine.sd_layout
            .leftSpaceToView(self, 0).topSpaceToView(self, 15).widthIs(30).heightIs(14);
            
            self.nameLB.sd_layout
            .leftSpaceToView(self.stateLine, 5).centerYEqualToView(self.stateLine).rightSpaceToView(self, 35).heightIs(16);
            
            //self.countLB.sd_layout
            //.leftSpaceToView(self, 110).centerYEqualToView(self.stateLine).widthIs(100).heightIs(16);
            
            self.dateLB.sd_layout
            .leftSpaceToView(self, 35).topSpaceToView(self.stateLine, 4).rightSpaceToView(self, 15).heightIs(15);
            self.acrossview.frame=CGRectMake(30, 58, FNDeviceWidth-30, 40);
        }
    }
}
@end
