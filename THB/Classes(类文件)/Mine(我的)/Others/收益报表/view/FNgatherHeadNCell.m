//
//  FNgatherHeadNCell.m
//  THB
//
//  Created by 李显 on 2018/9/11.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNgatherHeadNCell.h"

@implementation FNgatherHeadNCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    /** 本月预估 **/
    self.monthLB=[UILabel new];
    self.monthLB.textAlignment=NSTextAlignmentRight;
    [self addOneLabelWithLabView:self.monthLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    /** 结算收入 **/
    self.accountLB=[UILabel new];
    self.accountLB.textAlignment=NSTextAlignmentRight;
    [self addOneLabelWithLabView:self.accountLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    /** 上月预估 **/
    self.lastMonthLB=[UILabel new];
    self.lastMonthLB.textAlignment=NSTextAlignmentRight;
    [self addOneLabelWithLabView:self.lastMonthLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    
    /** 本月预估Image **/
    self.monthImage=[UIImageView new];
    [self.contentView addSubview:self.monthImage];
    /** 结算Image **/
    self.accountImage=[UIImageView new];
    [self.contentView addSubview:self.accountImage];
    /** 上月预估Image **/
    self.lastMonthImage=[UIImageView new];
    [self.contentView addSubview:self.lastMonthImage];
    
    /** 本月佣金Image **/
    self.brokeragemage=[UIImageView new];
    [self.contentView addSubview:self.brokeragemage];
    /**  上月预估Image **/
    self.lastbrokerageImage=[UIImageView new];
    [self.contentView addSubview:self.lastbrokerageImage];
    
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
    self.paymentTitleLB.textAlignment=NSTextAlignmentLeft;
    [self addOneLabelWithLabView:self.paymentTitleLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    //预估佣金
    self.commissionTitleLB=[UILabel new];
    self.commissionTitleLB.textAlignment=NSTextAlignmentLeft;
    [self addOneLabelWithLabView:self.commissionTitleLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    //分享赚(预估)
    self.shareTitleLB=[UILabel new];
    self.shareTitleLB.textAlignment=NSTextAlignmentLeft;
    [self addOneLabelWithLabView:self.shareTitleLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    //付款笔数Number
    self.paymentNuLB=[UILabel new];
    self.paymentNuLB.textAlignment=NSTextAlignmentCenter;
    [self addOneLabelWithLabView:self.paymentNuLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.contentView];
    //预估佣金Number
    self.commissionNuLB=[UILabel new];
    self.commissionNuLB.textAlignment=NSTextAlignmentCenter;
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
    
  
 
    /** 本月预估Image **/
    self.monthImage.sd_layout.rightSpaceToView(self.oneline, 25).topSpaceToView(self.contentView, interval10*2).heightIs(10).widthIs(15);
    /** 结算Image **/
    self.accountImage.sd_layout.rightSpaceToView(self.twoline, 25).topSpaceToView(self.contentView, interval10*2).heightIs(10).widthIs(15);
     /** 上月预估Image **/
     self.lastMonthImage.sd_layout.rightSpaceToView(self.contentView,25).topSpaceToView(self.contentView, interval10*2).heightIs(10).widthIs(15);
    
    /** 本月预估 **/
    self.monthLB.sd_layout
    .rightSpaceToView(self.monthImage, interval10).topSpaceToView(self.contentView, interval10+5).heightIs(20).leftSpaceToView(self.contentView, interval10);
    //    /** 结算收入 **/
    self.accountLB.sd_layout
    .rightSpaceToView(self.accountImage, interval10).topSpaceToView(self.contentView, interval10+5).heightIs(20).leftSpaceToView(self.oneline, interval10);
    //    /** 上月预估 **/
    self.lastMonthLB.sd_layout
    .rightSpaceToView(self.lastMonthImage, interval10).topSpaceToView(self.contentView, interval10+5).heightIs(20).leftSpaceToView(self.twoline, interval10);
    

     /** 本月佣金Image **/
    self.brokeragemage.sd_layout.leftSpaceToView(self.contentView, 30).topSpaceToView(self.monthLB, interval10*2-2.5).heightIs(15).widthIs(20);
    /** 结算币Image **/
    self.coinImage.sd_layout.leftSpaceToView(self.oneline, 30).topSpaceToView(self.accountLB, interval10*2-2.5).heightIs(15).widthIs(20);
     /**  上月预估Image **/
    self.lastbrokerageImage.sd_layout.leftSpaceToView(self.twoline, 30).topSpaceToView(self.lastMonthLB, interval10*2-2.5).heightIs(15).widthIs(20);
    
    
    /** ImageOne **/
   // self.symbolOneImage.sd_layout.leftSpaceToView(self.contentView, intervalWith/2-40).topSpaceToView(self.monthLB, interval10+5).heightIs(15).widthIs(20);
   
    /** 上月预估Image  **/
    //self.symbolTwoImage.sd_layout.leftSpaceToView(self.twoline, intervalWith/2-40).topSpaceToView(self.lastMonthLB, interval10+5).heightIs(15).widthIs(20);
  
    //本月预估金额
    self.paymentTitleLB.sd_layout
    .leftSpaceToView(self.brokeragemage, interval10/2).topSpaceToView(self.monthLB, interval10+5).heightIs(20).rightSpaceToView(self.oneline, 0);
    //预估佣金
    self.commissionTitleLB.sd_layout
    .rightSpaceToView(self.twoline, 0).topSpaceToView(self.accountLB, interval10+5).heightIs(20).leftSpaceToView(self.coinImage, interval10/2);
    //分享赚(预估)
    self.shareTitleLB.sd_layout
    .rightSpaceToView(self.contentView, interval10/2).topSpaceToView(self.lastMonthLB, interval10+5).heightIs(20).leftSpaceToView(self.lastbrokerageImage, interval10/2);
    
    
    
    
    //付款笔数Number
    self.paymentNuLB.sd_layout
    .leftSpaceToView(self.contentView, interval10/2).topSpaceToView(self.commissionTitleLB, interval10).heightIs(20).rightSpaceToView(self.oneline, interval10/2);
    
    //预估佣金Number
    self.commissionNuLB.sd_layout
    .rightSpaceToView(self.twoline, interval10/2).topSpaceToView(self.paymentTitleLB, interval10).heightIs(20).leftSpaceToView(self.oneline, interval10/2);
    
    //分享赚(预估)number
    self.shareNuLB.sd_layout
    .leftSpaceToView(self.twoline, interval10/2).topSpaceToView(self.shareTitleLB, interval10).heightIs(20).rightSpaceToView(self.contentView, interval10/2);
    
  
   
    
}

-(void)setModelArr:(NSMutableArray *)modelArr{
    
  
    
    if(modelArr.count>0){
        NSLog(@"modelArr:%@",modelArr);
        FNEarnigsItemNModel *modelOne=modelArr[0];
        FNEarnigsItemNModel *modelTwo=modelArr[1];
        FNEarnigsItemNModel *modelThree=modelArr[2];
        /** 1本月预估Image **/
        self.monthImage.image=IMAGE(@"agent_problem");
        /** 1结算Image **/
        self.accountImage.image=IMAGE(@"agent_problem");
        /** 1上月预估Image **/
        self.lastMonthImage.image=IMAGE(@"agent_problem");
        
        NSString*monicon= [FNBaseSettingModel settingInstance].mon_icon;
        /**  2Image **/
        [self.brokeragemage setUrlImg:monicon];
        /**  2Image **/
        [self.coinImage setUrlImg:monicon];
        /**  2Image **/
        [self.lastbrokerageImage  setUrlImg:monicon];
        
        //本月预估
        self.monthLB.text=modelOne.str;
        //结算收入
        self.accountLB.text=modelTwo.str;
        //上月预估
        self.lastMonthLB.text=modelThree.str;
        
        //付款笔数
        self.paymentTitleLB.text=modelOne.val;
        //预估佣金
        self.commissionTitleLB.text=modelTwo.val;
        //分享赚(预估)
        self.shareTitleLB.text=modelThree.val;
        
        //本月佣金
        self.paymentNuLB.text=modelOne.str1;
        //上月佣金
        self.commissionNuLB.text=modelTwo.str1;
        //上月佣金
        self.shareNuLB.text=modelThree.str1;
    }
}
//AddLB
-(void)addOneLabelWithLabView:(UILabel *)label TextColor:(UIColor *)textColor fontSize:(float)fontSize addSub:(UIView *)View{
    label.textColor = textColor;
    //label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont fontWithDevice:fontSize];
    [View addSubview:label];
    
}
@end
