//
//  FNteIndentAddressNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//下单的地址 130
#import "FNteIndentAddressNeCell.h"

@implementation FNteIndentAddressNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    self.contentView.backgroundColor=FNColor(240,240,240);
    self.bgView=[[UIView alloc]init];
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    //状态
    self.nameLB=[UILabel new];
    self.nameLB.font=kFONT14;
    [self.bgView addSubview:self.nameLB];
    
    //地址
    self.addressLB=[UILabel new];
    self.addressLB.font=[UIFont boldSystemFontOfSize:16];
    self.addressLB.numberOfLines=2;
    //self.addressLB.backgroundColor=[UIColor lightGrayColor];
    [self.bgView addSubview:self.addressLB];
    
    //送达时间
    self.titleLB=[UILabel new];
    self.titleLB.font=[UIFont boldSystemFontOfSize:15];
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.titleLB];
    
    //送达时间
    self.dateLB=[UILabel new];
    self.dateLB.font=kFONT14;
    self.dateLB.textColor=RGB(70, 146, 250);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.dateLB];
    
    
    [self placeViewFrame];
}
-(void)placeViewFrame{
    CGFloat space_20=20;
    CGFloat space_10=10;
    CGFloat space_5=5;
    
    self.bgView.sd_layout
    .topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, space_10).rightSpaceToView(self.contentView, space_10).bottomSpaceToView(self.contentView, space_10);
    
    self.nameLB.sd_layout
    .topSpaceToView(self.bgView, space_10).rightSpaceToView(self.bgView, space_10).heightIs(20).leftSpaceToView(self.bgView, space_10);
    
    self.addressLB.sd_layout
    .topSpaceToView(self.nameLB, space_5).rightSpaceToView(self.bgView, space_10).heightIs(40).leftSpaceToView(self.bgView, space_10);
    
    self.titleLB.sd_layout
    .bottomSpaceToView(self.bgView, space_10).leftSpaceToView(self.bgView, space_10).heightIs(20);
    [self.titleLB setSingleLineAutoResizeWithMaxWidth:100];
    
    self.dateLB.sd_layout
    .bottomSpaceToView(self.bgView, space_10).rightSpaceToView(self.bgView, space_10).heightIs(20);
    [self.dateLB setSingleLineAutoResizeWithMaxWidth:180];
    
   
    
}
-(void)recurButtonAction{
    
}
-(void)setModel:(FNtendOrderDetailsDeModel *)model{
    _model=model;
    if(model){
        FNtendDetailsBuyMsgModel *buymsgModel=[FNtendDetailsBuyMsgModel mj_objectWithKeyValues:model.buy_msg];
        self.nameLB.text=[NSString stringWithFormat:@"%@  %@",buymsgModel.name,buymsgModel.phone];//@"邓先生 131777889941";
        self.addressLB.text=buymsgModel.address;//@"广东省珠海市香洲区南屏镇南屏大桥十二村";//正街三巷107铺
        self.titleLB.text=@"送达时间";
        //self.dateLB.text=@"尽快送达(17:24s送达)";
        
//        NSString *describeString=@"尽快送达";
//        NSString *dateString=@"(17:24s送达)";
//        NSString *jointString=[NSString stringWithFormat:@"%@%@",describeString,dateString];
//        NSMutableAttributedString *valbutedString = [[NSMutableAttributedString alloc] initWithString: jointString];
//        [valbutedString addAttribute:NSForegroundColorAttributeName value:RGB(70, 187, 250) range:NSMakeRange(describeString.length, dateString.length)];
//        self.dateLB.attributedText=valbutedString;
        
        self.dateLB.text=buymsgModel.str;
    }
    
}
@end
