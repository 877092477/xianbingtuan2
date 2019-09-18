//
//  FNmeMemberEvaluatesMsgCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeMemberEvaluatesMsgCell.h"

@implementation FNmeMemberEvaluatesMsgCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.timeBtn];
    
    self.anonymityBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.anonymityBtn];
    
    self.bgOneView=[[UIView alloc]init];
    [self addSubview:self.bgOneView];
    
    self.hintLB=[[UILabel alloc]init];
    [self.bgOneView addSubview:self.hintLB];
    
    self.bgYellowView=[[UIView alloc]init];
    [self.bgOneView addSubview:self.bgYellowView];
    
    self.starStrLB=[[UILabel alloc]init];
    [self.bgOneView addSubview:self.starStrLB];
    
    self.starHintLB=[[UILabel alloc]init];
    [self.bgOneView addSubview:self.starHintLB];
    
    self.bgYellowView=[[UIView alloc]init];
    [self.bgOneView addSubview:self.bgYellowView];
    
    self.goodsimgView=[[UIImageView alloc]init];
    [self.bgYellowView addSubview:self.goodsimgView];
    
    self.goodsLB=[[UILabel alloc]init];
    [self.bgYellowView addSubview:self.goodsLB];
    
    self.bgTwoView=[[UIView alloc]init];
    [self addSubview:self.bgTwoView];
    
    self.capitaLB=[[UILabel alloc]init];
    [self.bgTwoView addSubview:self.capitaLB];
    
    self.goodsLB.font=[UIFont systemFontOfSize:13];
    self.goodsLB.textColor=RGB(24, 24, 24);
    self.goodsLB.textAlignment=NSTextAlignmentLeft;
    
    self.capitaLB.font=[UIFont systemFontOfSize:17];
    self.capitaLB.textColor=RGB(51, 51, 51);
    self.capitaLB.textAlignment=NSTextAlignmentLeft;
    
    self.starStrLB.font=[UIFont systemFontOfSize:14];
    self.starStrLB.textColor=RGB(51, 51, 51);
    self.starStrLB.textAlignment=NSTextAlignmentCenter;
    
    self.starHintLB.font=[UIFont systemFontOfSize:11];
    self.starHintLB.textColor=RGB(153, 153, 153);
    self.starHintLB.textAlignment=NSTextAlignmentCenter;
    
    self.nameLB.font=[UIFont systemFontOfSize:16];
    self.nameLB.textColor=RGB(24, 24, 24);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:17];
    self.hintLB.textColor=RGB(51, 51, 51);
    self.hintLB.textAlignment=NSTextAlignmentCenter; 
    
    self.bgOneView.backgroundColor=[UIColor whiteColor];
    self.bgOneView.cornerRadius=5;
    self.imgView.cornerRadius=39/2;
    
    self.bgYellowView.backgroundColor=RGB(253, 245, 234);
    self.bgYellowView.cornerRadius=5;
    self.goodsimgView.cornerRadius=5/2;
    
    self.bgTwoView.backgroundColor=[UIColor whiteColor];
    self.bgTwoView.cornerRadius=5;
    
    [self.timeBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    self.timeBtn.titleLabel.font=kFONT13;
    
    [self.anonymityBtn setTitleColor:RGB(151, 151, 151) forState:UIControlStateNormal];
    self.anonymityBtn.titleLabel.font=kFONT13;
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 7).widthIs(39).heightIs(39);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.imgView, 11).topSpaceToView(self, 8).rightSpaceToView(self, 85).heightIs(19);
    
    self.timeBtn.sd_layout
    .leftEqualToView(self.nameLB).topSpaceToView(self.nameLB, 1).heightIs(18).widthIs(157);
    self.timeBtn.imageView.sd_layout
    .rightSpaceToView(self.timeBtn, 0).widthIs(12).heightIs(12).centerYEqualToView(self.timeBtn);
    self.timeBtn.titleLabel.sd_layout
    .leftSpaceToView(self.timeBtn, 0).rightSpaceToView(self.timeBtn, 18).heightIs(17).centerYEqualToView(self.timeBtn);
    
    
    self.anonymityBtn.sd_layout
    .rightSpaceToView(self, 0).widthIs(85).heightIs(20).centerYEqualToView(self.imgView);
    
    self.anonymityBtn.imageView.sd_layout
    .leftSpaceToView(self.anonymityBtn, 0).widthIs(13).heightIs(13).centerYEqualToView(self.anonymityBtn);
    self.anonymityBtn.titleLabel.sd_layout
    .leftSpaceToView(self.anonymityBtn, 21).rightSpaceToView(self.anonymityBtn, 0).heightIs(17).centerYEqualToView(self.anonymityBtn);
    
    self.bgOneView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 56).heightIs(226);
    
    self.hintLB.sd_layout
    .rightSpaceToView(self.bgOneView, 10).leftSpaceToView(self.bgOneView, 10).heightIs(22).topSpaceToView(self.bgOneView, 28);
    
    self.bgYellowView.sd_layout
    .leftSpaceToView(self.bgOneView, 10).rightSpaceToView(self.bgOneView, 10).topSpaceToView(self.bgOneView, 68).heightIs(51);
    
    self.goodsimgView.sd_layout
    .leftSpaceToView(self.bgYellowView, 10).centerYEqualToView(self.bgYellowView).widthIs(30).heightIs(30);
    
    self.goodsLB.sd_layout
    .leftSpaceToView(self.goodsimgView, 10).centerYEqualToView(self.bgYellowView).rightSpaceToView(self.bgYellowView, 10).heightIs(20);
    
    self.starStrLB.sd_layout
    .leftSpaceToView(self.bgOneView, 10).rightSpaceToView(self.bgOneView, 10).topSpaceToView(self.bgYellowView, 18).heightIs(18);
    
    self.starHintLB.sd_layout
    .leftSpaceToView(self.bgOneView, 10).rightSpaceToView(self.bgOneView, 10).bottomSpaceToView(self.bgOneView, 6).heightIs(15);
    
    self.bgTwoView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self.bgOneView, 10).heightIs(48);
    
    self.capitaLB.sd_layout
    .leftSpaceToView(self.bgTwoView, 10).widthIs(110).centerYEqualToView(self.bgTwoView).heightIs(21);
    
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(115, 10, FNDeviceWidth-165, 30)];
    self.compileField.font = kFONT15;
    self.compileField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.bgTwoView addSubview:self.compileField];
    [self.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.compileField.sd_layout
    .leftSpaceToView(self.capitaLB, 5).rightSpaceToView(self.bgTwoView, 10).heightIs(30).centerYEqualToView(self.bgTwoView);
    
    self.starView=[[FNmeMemberStarView alloc]init];
    [self.bgOneView addSubview:self.starView];
    self.starView.frame=CGRectMake(0, 168, FNDeviceWidth-20, 30);
   
}

- (void)textFieldDidChange:(id)sender{
    UITextField *field = (UITextField *)sender;
    if ([self.delegate respondsToSelector:@selector(didmeMeConsumeEdit:)]) {
        [self.delegate didmeMeConsumeEdit:field.text];
    }
}
-(void)anonymityBtnClick:(UIButton*)btn{
    btn.selected=!btn.selected;
    NSString *isanonymityc=@"0";
    if(btn.selected==YES){
        isanonymityc=@"1";
    }else{
        isanonymityc=@"0";
    }
    if ([self.delegate respondsToSelector:@selector(didmeMeAnonymityAction:)]) {
        [self.delegate didmeMeAnonymityAction:isanonymityc];
    } 
}

-(void)setModel:(FNmeMemberEvaluatesModel *)model{
    _model=model;
    if(model){
        self.nameLB.text=model.store_name;
        self.hintLB.text=model.order_tips;
        self.goodsLB.text=model.order_desc;
        self.starStrLB.text=@"";
        self.starHintLB.text=@"4-5颗星超赞，2-3颗星一般般，0-1颗星差评 "; 
        //[self.timeBtn setTitle:@"40分钟(12:32送达)" forState:UIControlStateNormal];
        [self.anonymityBtn setTitle:@"匿名评价" forState:UIControlStateNormal];
        [self.anonymityBtn setImage:IMAGE(@"FN_meMeNmNorIcon") forState:UIControlStateNormal];
        [self.anonymityBtn setImage:IMAGE(@"FN_meMeNmSeIcon") forState:UIControlStateSelected];
        //[self.timeBtn setImage:IMAGE(@"FN_meMemberBJicon") forState:UIControlStateNormal];
        [self.anonymityBtn addTarget:self action:@selector(anonymityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.capitaLB.text=@"人均消费  ￥";
        [self.capitaLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:15] changeText:@"￥"];
        [self.capitaLB fn_changeColorWithTextColor:RGB(102, 102, 102) changeText:@"￥"];
        self.compileField.placeholder=@"请输入人均消费";
        
        [self.imgView setUrlImg:model.store_img];
        [self.goodsimgView setUrlImg:model.order_img];
    }
}
-(void)setAlterModel:(FNmerchentReviewModel *)alterModel{
    _alterModel=alterModel;
    if(alterModel){
        self.compileField.text=alterModel.average_price;
        if([alterModel.username containsString:@"匿名"]){
            self.anonymityBtn.selected=YES;
        }else{
            self.anonymityBtn.selected=NO;
        }
        NSInteger starInt=[alterModel.star integerValue];
        self.starView.starStr=alterModel.star;
    }
}
@end
