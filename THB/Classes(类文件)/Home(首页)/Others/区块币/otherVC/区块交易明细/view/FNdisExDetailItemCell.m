//
//  FNdisExDetailItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisExDetailItemCell.h"

@implementation FNdisExDetailItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews{
    
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    
    self.bgImg=[[UIImageView alloc]init];
    [self.bgView addSubview:self.bgImg];
    
    self.stateImg=[[UIImageView alloc]init];
    [self.bgView addSubview:self.stateImg];
    
    self.stateLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.stateLB];
    
    self.nameLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.nameLB];
    
    self.sumLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.sumLB];
    
    self.useLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.useLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.dateLB];
    
    
    
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.bgView.borderWidth=1.5;
    self.bgView.borderColor = RGB(242, 242, 242);
    self.bgView.cornerRadius=5;
    self.bgView.clipsToBounds = YES;
    
    //self.bgImg.backgroundColor=RGB(255, 109, 72);
    
    self.stateLB.font=[UIFont systemFontOfSize:15];
    self.stateLB.textColor=[UIColor whiteColor];
    self.stateLB.textAlignment=NSTextAlignmentLeft;
    
    self.nameLB.font=[UIFont systemFontOfSize:12];
    self.nameLB.textColor=[UIColor whiteColor];
    self.nameLB.textAlignment=NSTextAlignmentRight;
    
    self.sumLB.font=[UIFont systemFontOfSize:20];
    self.sumLB.textColor=[UIColor whiteColor];
    self.sumLB.textAlignment=NSTextAlignmentRight;
    
    self.useLB.font=[UIFont systemFontOfSize:15];
    self.useLB.textColor=RGB(51, 51, 51);
    self.useLB.textAlignment=NSTextAlignmentLeft;
    
    self.dateLB.font=[UIFont systemFontOfSize:10];
    self.dateLB.textColor=RGB(153, 153, 153);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 13).rightSpaceToView(self, 10).heightIs(140);
    
    self.bgImg.sd_layout
    .leftSpaceToView(self.bgView, 0).topSpaceToView(self.bgView, 0).rightSpaceToView(self.bgView, 0).heightIs(69);
    
    self.stateImg.sd_layout
    .leftSpaceToView(self.bgView, 15).topSpaceToView(self.bgView, 20).widthIs(30).heightIs(30);
    
    self.stateLB.sd_layout
    .leftSpaceToView(self.stateImg, 12).centerYEqualToView(self.stateImg).widthIs(80).heightIs(20);
    
    self.nameLB.sd_layout
    .rightSpaceToView(self.bgView, 13).topSpaceToView(self.bgView, 11).widthIs(120).heightIs(16);
    
    self.sumLB.sd_layout
    .rightSpaceToView(self.bgView, 13).topSpaceToView(self.bgView, 31).widthIs(120).heightIs(24);
    
    self.useLB.sd_layout
    .leftSpaceToView(self.bgView, 11).topSpaceToView(self.bgImg, 14).rightSpaceToView(self.bgView, 11).heightIs(19);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self.bgView, 11).topSpaceToView(self.useLB, 8).rightSpaceToView(self.bgView, 11).heightIs(14);
    
    
    self.bgImg.frame=CGRectMake(0, 0, FNDeviceWidth-20, 69);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgImg.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bgImg.bounds;
    maskLayer.path = maskPath.CGPath;
    self.bgImg.layer.mask = maskLayer;
    
    self.webTextView = [[UIWebView alloc]initWithFrame:CGRectMake(5, 70, FNDeviceWidth-30, 40)];
    self.webTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webTextView.scrollView.scrollEnabled = NO;
    self.webTextView.scalesPageToFit = YES;
    [self.bgView addSubview:self.webTextView];
    
}

-(void)setModel:(FNdisExDetailItemModel *)model{
    _model=model;
    if(model){
        self.bgImg.backgroundColor=[UIColor colorWithHexString:model.color];
        self.stateLB.textColor=[UIColor colorWithHexString:model.font_color];
        self.nameLB.textColor=[UIColor colorWithHexString:model.font_color];
        self.sumLB.textColor=[UIColor colorWithHexString:model.font_color];
        [self.stateImg setUrlImg:model.icon];
        self.stateLB.text=model.type_font;
        self.nameLB.text=model.qkb_name;
        self.sumLB.text=model.numbers;
        //self.useLB.text=model.detail;
        self.dateLB.text=[NSString stringWithFormat:@"%@        %@",model.time,model.worth];
        //XYLog(@"model.detail=%@",model.detail);
        NSString *detail=[NSString stringWithFormat:@"%@",model.detail];
        [self.webTextView loadHTMLString:detail baseURL:nil];
        
    }
}
@end
