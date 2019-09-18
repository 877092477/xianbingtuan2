//
//  FNpunchCardAeCell.m
//  THB
//
//  Created by Jimmy on 2019/2/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNpunchCardAeCell.h"

@implementation FNpunchCardAeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.btns = [NSMutableArray new];
        [self initializedSubviews]; 
    }
    return self;
}

- (void)initializedSubviews
{ 
    self.bgImg=[[UIImageView alloc]init];
    self.bgImg.image=IMAGE(@"FN_punch_BGimg");
    self.bgImg.contentMode=UIViewContentModeScaleAspectFill;
    [self addSubview:self.bgImg];
    
    self.titleLB=[[UILabel alloc]init];
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textColor=[UIColor whiteColor];
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.titleLB];
    
    self.sumLB=[[UILabel alloc]init];
    self.sumLB.font=[UIFont systemFontOfSize:30];
    self.sumLB.textColor=[UIColor whiteColor];
    self.sumLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.sumLB];
    
    self.omitLB=[[UILabel alloc]init];
    self.omitLB.font=[UIFont systemFontOfSize:13];
    self.omitLB.textColor=[UIColor whiteColor];
    [self addSubview:self.omitLB];
    
    self.amountLB=[[UILabel alloc]init];
    self.amountLB.font=[UIFont systemFontOfSize:13];
    self.amountLB.textColor=[UIColor whiteColor];
    self.amountLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.amountLB];
    
    self.detailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.detailBtn.titleLabel.font=kFONT12;
    //[self.detailBtn setBackgroundImage:IMAGE(@"FN_fhBopaque_img") forState:UIControlStateNormal];
    [self addSubview:self.detailBtn];
    
    self.ruleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.ruleBtn.titleLabel.font=kFONT12;
    [self addSubview:self.ruleBtn]; 
    
    self.participationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.participationBtn.titleLabel.font=kFONT17;
    self.participationBtn.adjustsImageWhenHighlighted = NO;
    //[self.participationBtn setBackgroundImage:IMAGE(@"FN_fhBopaque_img") forState:UIControlStateNormal];
    [self addSubview:self.participationBtn];
    [self.moneyicoBtn setTitleColor:RGB(255, 127, 2) forState:UIControlStateNormal];
    self.moneyicoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.moneyicoBtn.adjustsImageWhenHighlighted = NO;
    //self.moneyicoimg.cornerRadius=20/2;
    //self.moneyicoimg.hidden=YES;
    self.moneyicoBtn.titleLabel.font=kFONT15;
    [self addSubview:self.moneyicoBtn];
    
    self.baseWhiteView=[[UIView alloc]init];
    self.baseWhiteView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.baseWhiteView];
    
    self.demonstrationBgImg=[[UIImageView alloc]init];
    //self.demonstrationBgImg.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.demonstrationBgImg];
    
    
//    self.demonstrationimg=[[UIImageView alloc]init];
//    [self.demonstrationBgImg addSubview:self.demonstrationimg];
    
    self.stepLB=[[UILabel alloc]init];
    self.stepLB.font=[UIFont systemFontOfSize:14];
    //self.stepLB.textColor=[UIColor whiteColor];
    self.stepLB.textAlignment=NSTextAlignmentCenter;
    [self.demonstrationBgImg addSubview:self.stepLB];
    
//    self.stepOneLB=[[UILabel alloc]init];
//    self.stepOneLB.font=[UIFont systemFontOfSize:12];
//    self.stepOneLB.textAlignment=NSTextAlignmentCenter;
//    [self addSubview:self.stepOneLB];
//
//    self.stepTwoLB=[[UILabel alloc]init];
//    self.stepTwoLB.font=[UIFont systemFontOfSize:12];
//    self.stepTwoLB.textAlignment=NSTextAlignmentCenter;
//    [self addSubview:self.stepTwoLB];
//
//    self.stepThreeLB=[[UILabel alloc]init];
//    self.stepThreeLB.font=[UIFont systemFontOfSize:12];
//    self.stepThreeLB.textAlignment=NSTextAlignmentCenter;
//    [self addSubview:self.stepThreeLB];
    
    self.itemOneView=[[FNStepItemAeView alloc]init];
    [self.demonstrationBgImg addSubview:self.itemOneView];
    
    self.itemTwoView=[[FNStepItemAeView alloc]init];
    [self.demonstrationBgImg addSubview:self.itemTwoView];
    
    self.itemThreeView=[[FNStepItemAeView alloc]init];
    [self.demonstrationBgImg addSubview:self.itemThreeView];
    
    self.boultOneImg=[[UIImageView alloc]init];
    [self.demonstrationBgImg addSubview:self.boultOneImg];
    
    self.boultTwoImg=[[UIImageView alloc]init];
    [self.demonstrationBgImg addSubview:self.boultTwoImg];
    
    
    
    
    self.todayBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.todayBtn.titleLabel.font=kFONT16;
    [self.baseWhiteView addSubview:self.todayBtn];
    
    self.inviteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.inviteBtn.titleLabel.font=kFONT12;
    [self.inviteBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    [self.inviteBtn sizeToFit];
    self.inviteBtn.size = CGSizeMake(self.inviteBtn.width, 40);
    [self.baseWhiteView addSubview:self.inviteBtn];
    
    
    CGFloat sizeW=FNDeviceWidth/3;
    self.bestView=[[FNCardItemAeView alloc]init];
    self.bestView.frame=CGRectMake(0, 60, sizeW, 170);
    [self.baseWhiteView addSubview:self.bestView];
    
    self.firstView=[[FNCardItemAeView alloc]init];
    self.firstView.frame=CGRectMake(sizeW, 60, sizeW, 170);
    self.firstView.headImg.sd_layout
    .centerXEqualToView(self.firstView).topSpaceToView(self.firstView, 17).heightIs(78).widthIs(78);
    self.firstView.describeImg.sd_layout
    .centerXEqualToView(self.firstView).topSpaceToView(self.firstView, 73).heightIs(28).widthIs(85);
    [self.baseWhiteView addSubview:self.firstView];
    
    self.longestView=[[FNCardItemAeView alloc]init];
    self.longestView.frame=CGRectMake(sizeW+sizeW, 60, sizeW, 170);
    [self.baseWhiteView addSubview:self.longestView];
    
//    self.itemOneView.backgroundColor=[UIColor lightGrayColor];
//    self.itemTwoView.backgroundColor=[UIColor lightGrayColor];
//    self.itemThreeView.backgroundColor=[UIColor lightGrayColor];
//    self.bestView.backgroundColor=[UIColor lightGrayColor];
//    self.firstView.backgroundColor=[UIColor grayColor];
//    self.longestView.backgroundColor=[UIColor lightGrayColor];
    
    [self incomposition]; 
    
}
-(void)incomposition{
    CGFloat inter_5=5;
    CGFloat inter_15=15;
    CGFloat inter_20=20;
    
    CGFloat inter_Top=SafeAreaTopHeight;
    
    self.bgImg.sd_layout
    .leftSpaceToView(self,0).rightSpaceToView(self,0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, inter_20).rightSpaceToView(self, inter_20).topSpaceToView(self, 130).heightIs(17);
    
    self.detailBtn.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, inter_Top).heightIs(27).widthIs(67);
    
    self.ruleBtn.sd_layout
    .rightSpaceToView(self, inter_15).topSpaceToView(self, inter_Top).heightIs(20).widthIs(65);
    
    self.sumLB.sd_layout
    .leftSpaceToView(self, inter_20).rightSpaceToView(self, inter_20).topSpaceToView(self, 165).heightIs(35);
    
//    self.omitLB.sd_layout
//    .centerXEqualToView(self).topSpaceToView(self, 200).heightIs(25).widthIs(35);
    
//    self.amountLB.sd_layout
//    .leftSpaceToView(self.omitLB, 15).rightSpaceToView(self, 15).topSpaceToView(self, 200).heightIs(25);
    
    self.amountLB.sd_layout
    .leftSpaceToView(self, 15).rightSpaceToView(self, 15).topSpaceToView(self, 210).heightIs(25);
    
    self.participationBtn.sd_layout
    .centerXEqualToView(self).topSpaceToView(self, 265).heightIs(55).widthIs(247);
    
    //self.moneyicoimg.sd_layout
    //.centerXEqualToView(self).topSpaceToView(self, 270).heightIs(55).widthIs(57);
    
    [self.moneyicoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_participationBtn.mas_right).offset(-25);
        make.width.mas_equalTo(57);
        make.height.mas_equalTo(55);
        make.centerY.equalTo(_participationBtn);
    }];
    
    self.baseWhiteView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(229);
    
    self.demonstrationBgImg.sd_layout
    .leftSpaceToView(self, inter_20).rightSpaceToView(self, inter_20).bottomSpaceToView(self.baseWhiteView, inter_20).heightIs(155);
    
//    self.demonstrationimg.sd_layout
//    .leftSpaceToView(self.demonstrationBgImg, inter_20).rightSpaceToView(self.demonstrationBgImg, inter_20).topSpaceToView(self.demonstrationBgImg, 55).heightIs(60);
    
    self.stepLB.sd_layout
    .leftSpaceToView(self.demonstrationBgImg, inter_20).rightSpaceToView(self.demonstrationBgImg, inter_20).topSpaceToView(self.demonstrationBgImg, 10).heightIs(15);
    
//    CGFloat stepOneW=[self getWidthWithText:self.stepOneLB.text height:15 font:12];
//    CGFloat stepTwoW=[self getWidthWithText:self.stepTwoLB.text height:15 font:12];
//    CGFloat stepThreeW=[self getWidthWithText:self.stepThreeLB.text height:15 font:12];
//    self.stepOneLB.sd_layout
//    .leftSpaceToView(self.demonstrationBgImg, 35).heightIs(15).widthIs(50).topSpaceToView(self.demonstrationimg, inter_5);
//    self.stepTwoLB.sd_layout
//    .centerXEqualToView(self.demonstrationBgImg).widthIs(50).heightIs(15).topSpaceToView(self.demonstrationimg, inter_5);
//    self.stepThreeLB.sd_layout
//    .rightSpaceToView(self.demonstrationBgImg, 35).heightIs(15).widthIs(50).topSpaceToView(self.demonstrationimg, inter_5);
    
    
    self.itemOneView.sd_layout
    .leftSpaceToView(self.demonstrationBgImg, 20).heightIs(120).widthIs(80).bottomSpaceToView(self.demonstrationBgImg, 0);
    
    self.itemTwoView.sd_layout
    .centerXEqualToView(self.demonstrationBgImg).heightIs(120).widthIs(80).bottomSpaceToView(self.demonstrationBgImg, 0);
    
    self.itemThreeView.sd_layout
    .rightSpaceToView(self.demonstrationBgImg, 20).heightIs(120).widthIs(80).bottomSpaceToView(self.demonstrationBgImg, 0);
    
    self.boultOneImg.sd_layout
    .bottomSpaceToView(self.demonstrationBgImg, 50).rightSpaceToView(self.itemTwoView, 0).widthIs(45).heightIs(45);
    
    self.boultTwoImg.sd_layout
    .bottomSpaceToView(self.demonstrationBgImg, 50).leftSpaceToView(self.itemTwoView, 0).widthIs(45).heightIs(45);
    
    
    self.todayBtn.sd_layout
    .leftSpaceToView(self.baseWhiteView,0).topSpaceToView(self.baseWhiteView, inter_20).heightIs(40).widthIs(92);
    
    self.firstView.sd_layout
    .centerXEqualToView(self.baseWhiteView).topSpaceToView(self.baseWhiteView, 60).widthIs(100).heightIs(170);
    
    self.bestView.sd_layout
    .rightSpaceToView(self.firstView, 20).topSpaceToView(self.baseWhiteView, 60).widthIs(95).heightIs(170);
    
    self.longestView.sd_layout
    .leftSpaceToView(self.firstView, 20).topSpaceToView(self.baseWhiteView, 60).widthIs(95).heightIs(170);
    
   
}

- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
-(void)setModel:(FNpunchHomeAeModel *)model{
    _model=model;
    if(model){
        //self.bgImg.image=IMAGE(@"FN_punch_BGimg");
        [self.bgImg setUrlImg:model.sign_bjimg];
        self.titleLB.text=model.str3;//@"早上打卡瓜分奖励金总额（元）";
        self.titleLB.textColor=[UIColor colorWithHexString:model.fontcolor];
        self.sumLB.text=model.sum;//@"2423702.00";
        self.sumLB.textColor=[UIColor colorWithHexString:model.fontcolor];
        //self.omitLB.text=@"...";
        
        self.stepLB.textColor=[UIColor colorWithHexString:model.fontcolor];
        self.stepLB.text=model.str5;//@"早起打卡三步骤";
        //self.demonstrationBgImg.image=IMAGE(@"FN_BWcolor_bgimg");
        [self.demonstrationBgImg setUrlImg:model.sign_dkthreebjimg];
        [self.detailBtn setTitleColor:[UIColor colorWithHexString:model.fontcolor] forState:UIControlStateNormal];
        [self.detailBtn setTitle:model.str1 forState:UIControlStateNormal];//挑战明细
        [self.detailBtn sd_setBackgroundImageWithURL:URL(model.sign_detailimg) forState:UIControlStateNormal];
        self.ruleBtn.cornerRadius=20/2;
        self.ruleBtn.borderWidth=1;
        self.ruleBtn.borderColor =[UIColor whiteColor];
        [self.ruleBtn setTitleColor:[UIColor colorWithHexString:model.fontcolor] forState:UIControlStateNormal];
        [self.ruleBtn setTitle:model.str2 forState:UIControlStateNormal];//活动规则
        [self.participationBtn sd_setBackgroundImageWithURL:URL(model.sign_btnimg) forState:UIControlStateNormal];
        [self.ruleBtn setTitleColor:[UIColor colorWithHexString:model.fontcolor] forState:UIControlStateNormal];
        [self.participationBtn setTitleColor:RGB(171, 62, 6) forState:UIControlStateNormal];
        [self.participationBtn setTitleColor:[UIColor colorWithHexString:model.btn_color] forState:UIControlStateNormal];
       
        if([model.type isEqualToString:@"buy"]){
            self.moneyicoBtn.hidden=YES;
           [self.participationBtn setTitle:model.str4 forState:UIControlStateNormal];//@"立即参与瓜分奖励金"
        }else if([model.type isEqualToString:@"wait_sign"]){
            if ([model.djs kr_isNotEmpty]) {
                NSString *datestr=[NSString getTimeStr:model.djs withFormat:@"yyyy-MM-dd HH:mm"];
                //@"2019-04-02 20:50"
                [[[ZQCountdownTime alloc]init]countDownViewWithEndString:datestr timeType:ZQMinuteTime returnBlock:^(NSString *time) {
                    NSString *jointStr=[NSString stringWithFormat:@"%@ %@",model.str4,time];
                    self.participationBtn.titleLabel.font=[UIFont systemFontOfSize:12];
                    [self.participationBtn setTitle:jointStr forState:UIControlStateNormal];//@"立即参与瓜分奖励金"
                }];
                
                self.moneyicoBtn.hidden=NO;
                [self.moneyicoBtn sd_setBackgroundImageWithURL:URL(model.sign_moneyicon) forState:UIControlStateNormal];
                [self.moneyicoBtn setTitleColor:[UIColor colorWithHexString:model.btn_color] forState:UIControlStateNormal];
                [self.moneyicoBtn setTitle:[NSString stringWithFormat:@"%@",model.dk_money] forState:UIControlStateNormal];
                //[self.moneyicoBtn setBackgroundImage:IMAGE(@"fnDK_jbimg") forState:UIControlStateNormal];
            }
        }else if([model.type isEqualToString:@"start_sign"]){
           [self.participationBtn setTitle:model.str4 forState:UIControlStateNormal];//@"立即参与瓜分奖励金"
            self.moneyicoBtn.hidden=NO;
            [self.moneyicoBtn sd_setBackgroundImageWithURL:URL(model.sign_moneyicon) forState:UIControlStateNormal];
            [self.moneyicoBtn setTitleColor:[UIColor colorWithHexString:model.btn_color] forState:UIControlStateNormal];
            [self.moneyicoBtn setTitle:[NSString stringWithFormat:@"%@",model.dk_money] forState:UIControlStateNormal];
        }
        
        [self.todayBtn setTitleColor:[UIColor colorWithHexString:model.fontcolor] forState:UIControlStateNormal];
        [self.todayBtn setTitle:model.str6 forState:UIControlStateNormal];//@"今日战况"
        [self.todayBtn sd_setBackgroundImageWithURL:URL(model.sign_todayimg) forState:UIControlStateNormal];
        //[self.todayBtn setBackgroundImage:IMAGE(@"FN_jrzk_img") forState:UIControlStateNormal];
        [self.inviteBtn setTitle:model.str7 forState:UIControlStateNormal];//@"立即邀请好友参与早起打卡"
        [self.inviteBtn setImage:IMAGE(@"FN_dk_rightimg") forState:UIControlStateNormal];
        CGFloat stepOneW=160;
        if([model.str7 kr_isNotEmpty]){
           stepOneW=[self getWidthWithText:model.str7 height:40 font:12];
        }
        self.inviteBtn.sd_layout
        .rightSpaceToView(self.baseWhiteView, 10).topSpaceToView(self.baseWhiteView, 20).heightIs(40).widthIs(stepOneW+20);
        [self.inviteBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5.0f];
        
        NSArray *three_dataS=model.three_data;
        if (three_dataS.count>0) {
            FNpunchStepItemModel *oneModel=[FNpunchStepItemModel mj_objectWithKeyValues:three_dataS[0]];
            [self.itemOneView.describeImg setNoPlaceholderUrlImg:oneModel.img];
            self.itemOneView.nameLB.text=oneModel.str;
            [self.boultOneImg setUrlImg:oneModel.ico];
            [self.boultTwoImg  setUrlImg:oneModel.ico];
        }
        if (three_dataS.count>1) {
            FNpunchStepItemModel *twoModel=[FNpunchStepItemModel mj_objectWithKeyValues:three_dataS[1]];
            [self.itemTwoView.describeImg setNoPlaceholderUrlImg:twoModel.img];
            self.itemTwoView.nameLB.text=twoModel.str;
        }
        if (three_dataS.count>2) {
            FNpunchStepItemModel *threeModel=[FNpunchStepItemModel mj_objectWithKeyValues:three_dataS[2]];
            [self.itemThreeView.describeImg setNoPlaceholderUrlImg:threeModel.img];
            self.itemThreeView.nameLB.text=threeModel.str;
        }
        
        if (self.btns.count>=1) {
            [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self.btns removeAllObjects];
        }
        
        NSArray *listS=model.list;
        
        if(listS.count>0){
            FNpunchListItemModel *listOne=[FNpunchListItemModel mj_objectWithKeyValues:listS[0]];
            [self.bestView.headImg setNoPlaceholderUrlImg:listOne.head_img];
            [self.bestView.describeImg setTitle:listOne.img_str forState:UIControlStateNormal];
            [self.bestView.describeImg sd_setBackgroundImageWithURL:URL(listOne.img) forState:UIControlStateNormal];
            self.bestView.nameLB.text=listOne.nickname;
            self.bestView.sumLB.text=listOne.str;
        }
        if(listS.count>1){
            FNpunchListItemModel *listTwo=[FNpunchListItemModel mj_objectWithKeyValues:listS[1]];
            [self.firstView.headImg setNoPlaceholderUrlImg:listTwo.head_img];
            [self.firstView.describeImg setTitle:listTwo.img_str forState:UIControlStateNormal];
            [self.firstView.describeImg sd_setBackgroundImageWithURL:URL(listTwo.img) forState:UIControlStateNormal];
            self.firstView.nameLB.text=listTwo.nickname;
            self.firstView.sumLB.text=listTwo.str;
        }
        if(listS.count>2){
            FNpunchListItemModel *listThree=[FNpunchListItemModel mj_objectWithKeyValues:listS[2]];
            [self.longestView.headImg setNoPlaceholderUrlImg:listThree.head_img];
            [self.longestView.describeImg setTitle:listThree.img_str forState:UIControlStateNormal];
            [self.longestView.describeImg sd_setBackgroundImageWithURL:URL(listThree.img) forState:UIControlStateNormal];
            self.longestView.nameLB.text=listThree.nickname;
            self.longestView.sumLB.text=listThree.str;
            
        }
        
        CGFloat width = 25;
        CGFloat headrY = 210;
        NSArray *heads=model.head_img;
        CGFloat headSwidth=FNDeviceWidth/2+2;
        NSInteger headscount=0;
        if (heads.count>7) {
            headscount=7;
        }else{
            headscount=heads.count;
        }
        CGFloat headSpace=headSwidth-((width-6)*headscount);
        NSString* num = model.num;
        NSString* apply = @"人报名";
        
        if(heads.count>0){//headscount
            for(NSInteger i=0;i<headscount;i++){
                UIImageView* headItem = [[UIImageView alloc]init];
                //headItem.backgroundColor=[UIColor lightGrayColor];
                [headItem setUrlImg:heads[i]];
                headItem.frame=CGRectMake(headSpace+(width-6)*i, headrY, width, width);
                headItem.cornerRadius=width/2;
                [self addSubview:headItem];
                [self.btns addObject:headItem];
            }
            self.amountLB.textAlignment=NSTextAlignmentLeft;
            self.amountLB.text =[NSString stringWithFormat:@"...    %@ %@",num,apply];//@"1,211,851人报名";
            self.amountLB.sd_layout
            .leftSpaceToView(self, headSwidth+15).rightSpaceToView(self, 15).topSpaceToView(self, 210).heightIs(25);
        }else{
            self.amountLB.textAlignment=NSTextAlignmentCenter;
            self.amountLB.text =[NSString stringWithFormat:@"%@ %@",num,apply];//@"1,211,851人报名";
            self.amountLB.sd_layout
            .leftSpaceToView(self, 15).rightSpaceToView(self, 15).topSpaceToView(self, 210).heightIs(25);
        }
        
        
        [self.amountLB addSingleAttributed:@{NSForegroundColorAttributeName:RGB(255, 245, 172)} ofRange:[self.amountLB.text rangeOfString:num]];
        //self.omitLB.sd_layout
        //.leftSpaceToView(self, headSwidth+15).topSpaceToView(self, headrY).heightIs(25).widthIs(35);
        
        
        
    }
}
@end
