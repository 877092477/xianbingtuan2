//
//  FNEarningsDayNCell.m
//  THB
//
//  Created by 李显 on 2018/9/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNEarningsDayNCell.h"
#import "FNEarnigsNModel.h"
@implementation FNEarningsDayNCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    
    //oneline
    self.oneline=[UILabel new];
    [self addOneLabelWithLabView:self.oneline TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    //twolineline
    self.twoline=[UILabel new];
    [self addOneLabelWithLabView:self.twoline TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    
    /** ImageOne **/
    self.symbolOneImage=[UIImageView new];
    [self.contentView addSubview:self.symbolOneImage];
    /** ImageTwo **/
    self.symbolTwoImage=[UIImageView new];
    [self.contentView addSubview:self.symbolTwoImage];
    /** 币Image **/
    self.coinImage=[UIImageView new];
    [self.contentView addSubview:self.coinImage];
    //付款笔数
    self.paymentTitleLB=[UILabel new];
    self.paymentTitleLB.textAlignment=NSTextAlignmentRight;
    [self addOneLabelWithLabView:self.paymentTitleLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    //预估佣金
    self.commissionTitleLB=[UILabel new];
    self.commissionTitleLB.textAlignment=NSTextAlignmentRight;
    [self addOneLabelWithLabView:self.commissionTitleLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    //分享赚(预估)
    self.shareTitleLB=[UILabel new];
    self.shareTitleLB.textAlignment=NSTextAlignmentCenter;
    [self addOneLabelWithLabView:self.shareTitleLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    //付款笔数Number
    self.paymentNuLB=[UILabel new];
    self.paymentNuLB.textAlignment=NSTextAlignmentCenter;
    [self addOneLabelWithLabView:self.paymentNuLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    //预估佣金Number
    self.commissionNuLB=[UILabel new];
    self.commissionNuLB.textAlignment=NSTextAlignmentLeft;
    [self addOneLabelWithLabView:self.commissionNuLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    //分享赚(预估)number
    self.shareNuLB=[UILabel new];
    self.shareNuLB.textAlignment=NSTextAlignmentCenter;
    [self addOneLabelWithLabView:self.shareNuLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    
    
    
    [self setCompositionView];
    
    UILabel *lineLB=[UILabel new];
    lineLB.backgroundColor=FNColor(245, 245, 245);
    [self addOneLabelWithLabView:lineLB TextColor:[UIColor whiteColor] fontSize:0 addSub:self.contentView];
    lineLB.sd_layout
    .heightIs(10).bottomEqualToView(self.contentView).leftEqualToView(self.contentView).rightSpaceToView(self.contentView, 0);
    
}
-(void)setCompositionView{
    CGFloat intervalWith =FNDeviceWidth/3;
    CGFloat interval10 =10;
    //oneline
    self.oneline.sd_layout
    .topSpaceToView(self.contentView, 5).leftSpaceToView(self.contentView, intervalWith-1).widthIs(1).bottomSpaceToView(self.contentView, 5);
    //twoline
    self.twoline.sd_layout
    .topSpaceToView(self.contentView, 5).leftSpaceToView(self.oneline, intervalWith-1).widthIs(1).bottomSpaceToView(self.contentView, 5);
    
   
    /** ImageOne **/
    self.symbolOneImage.sd_layout.rightSpaceToView(self.oneline, interval10+5).topSpaceToView(self.contentView, interval10*2).heightIs(10).widthIs(15);
    
    /** ImageTwo **/
    self.symbolTwoImage.sd_layout.rightSpaceToView(self.twoline, interval10+5).topSpaceToView(self.contentView, interval10*2).heightIs(10).widthIs(15);
    
    //付款笔数
    self.paymentTitleLB.sd_layout
    .rightSpaceToView(self.symbolOneImage, interval10).topSpaceToView(self.contentView, interval10+5).heightIs(20).leftSpaceToView(self.contentView, interval10);
    //预估佣金
    self.commissionTitleLB.sd_layout
    .rightSpaceToView(self.symbolTwoImage, interval10).topSpaceToView(self.contentView, interval10+5).heightIs(20).leftSpaceToView(self.oneline, interval10);
    //分享赚(预估)
    self.shareTitleLB.sd_layout
    .rightSpaceToView(self.contentView, interval10).topSpaceToView(self.contentView, interval10+5).heightIs(20).leftSpaceToView(self.twoline, interval10);
    //付款笔数Number
    self.paymentNuLB.sd_layout
    .rightSpaceToView(self.oneline, interval10).topSpaceToView(self.paymentTitleLB, interval10).heightIs(20).leftSpaceToView(self.contentView, interval10);
    
    /** 币Image **/
    self.coinImage.sd_layout.leftSpaceToView(self.oneline, 40).topSpaceToView(self.commissionTitleLB, interval10+2.5).heightIs(15).widthIs(20);
    //预估佣金Number
    self.commissionNuLB.sd_layout
    .leftSpaceToView(self.coinImage, interval10/2).topSpaceToView(self.commissionTitleLB, interval10).heightIs(20).rightSpaceToView(self.twoline, interval10);
    
    //分享赚(预估)number
    self.shareNuLB.sd_layout
    .leftSpaceToView(self.twoline, interval10).topSpaceToView(self.shareTitleLB, interval10).heightIs(20).rightSpaceToView(self.contentView, interval10);
    
    
    
    
}
-(void)setModelArr:(NSMutableArray *)modelArr{
    
    if(modelArr.count>0){
        NSLog(@"modelArr:%@",modelArr);
        FNEarnigsItemNModel *modelOne=modelArr[0];
        FNEarnigsItemNModel *modelTwo=modelArr[1];
        FNEarnigsItemNModel *modelThree=modelArr[2];
        //付款笔数
        self.paymentTitleLB.text=modelOne.str;
        //预估佣金
        self.commissionTitleLB.text=modelTwo.str;
        //分享赚(预估)
        self.shareTitleLB.text=modelThree.str;
        //付款笔数Number
        self.paymentNuLB.text=modelOne.val;
        //预估佣金Number
        self.commissionNuLB.text=modelTwo.val;
        //分享赚(预估)number
        self.shareNuLB.text=modelThree.val;
        /** ImageOne **/
        self.symbolOneImage.image=IMAGE(@"agent_problem");
        /** ImageTwo **/
        self.symbolTwoImage.image=IMAGE(@"agent_problem");
        NSString*monicon= [FNBaseSettingModel settingInstance].mon_icon;
        /** 币Image **/
        [self.coinImage setUrlImg:monicon];
        
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//AddLB
-(void)addOneLabelWithLabView:(UILabel *)label TextColor:(UIColor *)textColor fontSize:(float)fontSize addSub:(UIView *)View{
    label.textColor = textColor;
    //label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont fontWithDevice:fontSize];
    [View addSubview:label];
    
}
@end
