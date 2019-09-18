//
//  FNmerchantIndentItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerchantIndentItemCell.h"

@implementation FNmerchantIndentItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.headImgView=[[UIImageView alloc]init];
    [self addSubview:self.headImgView];
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.nameTitleLB=[[UILabel alloc]init];
    [self addSubview:self.nameTitleLB];
    
    self.numberLB=[[UILabel alloc]init];
    [self addSubview:self.numberLB];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    self.stateLB=[[UILabel alloc]init];
    [self addSubview:self.stateLB];
    
    self.sumLB=[[UILabel alloc]init];
    [self addSubview:self.sumLB];
    
    self.lblType = [[UILabel alloc] init];
    [self addSubview:self.lblType];
    
    self.nameTitleLB.font=[UIFont systemFontOfSize:11];
    self.nameTitleLB.textColor=RGB(60, 60, 60);
    self.nameTitleLB.textAlignment=NSTextAlignmentLeft;
    
    self.numberLB.font=[UIFont systemFontOfSize:11];
    self.numberLB.textColor=RGB(140, 140, 140);
    self.numberLB.textAlignment=NSTextAlignmentRight;
    
    self.nameLB.font=[UIFont systemFontOfSize:14];
    self.nameLB.textColor=RGB(24, 24, 24);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.dateLB.font=[UIFont systemFontOfSize:11];
    self.dateLB.textColor=RGB(140, 140, 140);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.sumLB.font=[UIFont systemFontOfSize:12];
    self.sumLB.textColor=RGB(60, 60, 60);
    self.sumLB.textAlignment=NSTextAlignmentLeft;
    
    self.stateLB.font=[UIFont systemFontOfSize:12];
    self.stateLB.textColor=[UIColor whiteColor];
    self.stateLB.textAlignment=NSTextAlignmentCenter;
    self.stateLB.cornerRadius=2;
    
    self.lineView.backgroundColor=RGB(246, 245, 245);
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 33).rightSpaceToView(self, 10).heightIs(1);
    
    self.bgImgView.backgroundColor=[UIColor whiteColor];
    self.bgImgView.cornerRadius=5;
    self.bgImgView.clipsToBounds = YES;
    
    self.headImgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 10).heightIs(13).widthIs(13);
    
    self.headImgView.cornerRadius=13/2;
    self.headImgView.clipsToBounds = YES;
    
//    self.nameTitleLB.sd_layout
//    .leftSpaceToView(self.headImgView, 10).centerYEqualToView(self.headImgView).widthIs(130).heightIs(20);
    [self.nameTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgView.mas_right).offset(10);
        make.centerY.equalTo(self.headImgView);
        make.right.lessThanOrEqualTo(self.numberLB.mas_left).offset(-10);
    }];
    
//    self.numberLB.sd_layout
//    .centerYEqualToView(self.headImgView).rightSpaceToView(self.lblType, 10).heightIs(20);
    [self.numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lblType.mas_left).offset(-10);
        make.centerY.equalTo(self.headImgView);
    }];
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self.lineView, 10).widthIs(78).heightIs(78);
    self.imgView.cornerRadius=2;
    
//    self.stateLB.sd_layout
//    .bottomEqualToView(self.imgView).rightSpaceToView(self, 12).widthIs(50).heightIs(22);
    [self.stateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-12);
        make.bottom.equalTo(self.imgView);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(0);
    }];
    
    self.sumLB.sd_layout
    .leftSpaceToView(self.imgView, 10).bottomEqualToView(self.imgView).rightSpaceToView(self.stateLB, 10).heightIs(22);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.imgView, 10).topEqualToView(self.imgView).rightSpaceToView(self, 10).heightIs(20);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self.imgView, 10).topSpaceToView(self.nameLB, 4).rightSpaceToView(self, 10).heightIs(14);
    
    [self.lblType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.centerY.equalTo(self.numberLB);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(0);
    }];
    self.lblType.font = kFONT11;
    self.lblType.layer.cornerRadius = 10;
    self.lblType.layer.borderWidth = 1;
    self.lblType.textAlignment = NSTextAlignmentCenter;
    
    @weakify(self);
    [self.stateLB addJXTouch:^{
        @strongify(self);
    
        if ([self.delegate respondsToSelector:@selector(indentItemStateClick:)]) {
            [self.delegate indentItemStateClick:self ];
        }
    }];
}

-(void)setModel:(FNmerchantIndentItemModel *)model{
    _model=model;
    if(model){
        NSString *jointSumStr=[NSString stringWithFormat:@"%@  %@",model.income_str,model.income];
        
        //[self.bgImgView setUrlImg:model.img];
        [self.headImgView setUrlImg:model.head_img];
        [self.imgView setUrlImg:model.img];
        
        self.nameTitleLB.text=model.username;
        self.numberLB.text=model.order_id;
        self.nameLB.text=model.title;
        self.dateLB.text=model.create_date;
        self.sumLB.text=jointSumStr;
        self.stateLB.text=model.status_str;
        CGRect rectState = [model.status_str boundingRectWithSize:CGSizeMake(120, 22)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:kFONT11}
                                                   context:nil];
        [self.stateLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(rectState.size.width + 14);
        }];
        
        if ([model.type_str kr_isNotEmpty]) {
            self.lblType.hidden = NO;
            self.lblType.text = model.type_str;
            self.lblType.textColor = [UIColor colorWithHexString:model.type_str_color];
             self.lblType.layer.borderColor = [UIColor colorWithHexString:model.type_str_color].CGColor;
            
            self.stateLB.backgroundColor=[UIColor colorWithHexString:model.status_bj];
            self.stateLB.textColor=[UIColor colorWithHexString:model.status_color];
            
            CGRect rect = [model.type_str boundingRectWithSize:CGSizeMake(200, 20)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:kFONT11}
                                             context:nil];
            [self.lblType mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(rect.size.width + 10);
            }];
        } else {
            self.lblType.hidden = YES;
            [self.lblType mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];
        }
        
        if([model.income kr_isNotEmpty]){
           [self.sumLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:18] changeText:model.income];
           [self.sumLB fn_changeColorWithTextColor:[UIColor colorWithHexString:model.income_color] changeText:model.income];
        }
        
        
    }
}
 
@end
