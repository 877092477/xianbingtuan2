//
//  FNmemberMessageHeaderview.m
//  THB
//
//  Created by Jimmy on 2018/9/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNmemberMessageHeaderview.h"

#import "GradeMemberNModel.h"

@implementation FNmemberMessageHeaderview

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=FNColor(245, 245, 245);
        
        [self initUI];
    }
    return self;
}
-(void)initUI{
    
    self.headerline=[UILabel new];
    self.headerline.backgroundColor =FNColor(237, 80, 36);
    [self.contentView addSubview:self.headerline];
    UIView *redview=[UIView new];
    [self.contentView addSubview:redview];
    redview.backgroundColor=FNColor(237, 80, 36);
    redview.sd_layout
    .topSpaceToView(self.headerline, 0).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(170);
    
    self.BgOneImageView=[UIImageView new];
    self.BgOneImageView.contentMode=UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.BgOneImageView];
    self.BgTwoImageView=[UIImageView new];
    self.BgTwoImageView.contentMode=UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.BgTwoImageView];
    [self.contentView bringSubviewToFront:self.BgTwoImageView];
    self.BgThreeImageView=[UIImageView new];
    [self.contentView addSubview:self.BgThreeImageView];
    
    /** 右边BGImage **/
    self.BgRightBlueImage=[UIImageView new];
    [self.BgTwoImageView addSubview:self.BgRightBlueImage];
   
    /** 等级 **/
    self.RightLB=[UILabel new];
    self.RightLB.textColor = [UIColor whiteColor];
    self.RightLB.font=[UIFont fontWithDevice:12];
    self.RightLB.textAlignment=NSTextAlignmentCenter;
    [self.BgRightBlueImage addSubview:self.RightLB];
    
    /** 邀请码 **/
    self.inviteNumberLB=[UILabel new];
    self.inviteNumberLB.textAlignment=NSTextAlignmentRight;
    [self  addOneLabelWithLab:self.inviteNumberLB TextColor:[UIColor whiteColor] fontSize:18];
    
    /** 复制按钮 **/
    self.stickvBtn = [UIButton new];
    [self.stickvBtn  setImage:IMAGE(@"vip_copy") forState:UIControlStateNormal];
    [self.BgTwoImageView addSubview:self.stickvBtn];
    //[self.BgTwoImageView bringSubviewToFront:self.stickvBtn];
    
    /** 邀请码文字 **/
    self.invitetitleLB=[UILabel new];
    self.invitetitleLB.textAlignment=NSTextAlignmentRight;
    [self  addOneLabelWithLab:self.invitetitleLB TextColor:[UIColor whiteColor] fontSize:12];
    
    /** 余额 **/
    self.balanceLB=[UILabel new];
    self.balanceLB.textAlignment=NSTextAlignmentCenter;
    [self  addOneLabelWithLab:self.balanceLB TextColor:[UIColor lightGrayColor] fontSize:12];
    
    /** line1 **/
    self.lineOne=[UILabel new];
    self.lineOne.backgroundColor=FNColor(221, 221, 221);
    [self  addOneLabelWithLab:self.lineOne TextColor:FNColor(221, 221, 221) fontSize:0];
    
    /** line2 **/
    //self.lineTwo=[UILabel new];
    //self.lineTwo.backgroundColor=FNColor(221, 221, 221);
    //[self  addOneLabelWithLab:self.lineTwo TextColor:FNColor(221, 221, 221) fontSize:0];
    
    /** 待收入红包 **/
    //self.treatLB=[UILabel new];
    //self.treatLB.numberOfLines=2;
    //self.treatLB.textAlignment=NSTextAlignmentCenter;
    //[self  addOneLabelWithLab:self.treatLB TextColor:FNColor(221, 221, 221) fontSize:12];
    
    self.balanceTitleLB=[UILabel new];
    self.balanceTitleLB.textAlignment=NSTextAlignmentCenter;
    [self  addOneLabelWithLab:self.balanceTitleLB TextColor:[UIColor lightGrayColor] fontSize:12];
    
     /** 邀请人数标题 **/
    self.invitePeopleLTitleLB=[UILabel new];
    self.invitePeopleLTitleLB.textAlignment=NSTextAlignmentCenter;
    [self  addOneLabelWithLab:self.invitePeopleLTitleLB TextColor:[UIColor lightGrayColor] fontSize:11];
    
    /** 邀请人数 **/
    self.invitePeopleLB=[UILabel new];
    self.invitePeopleLB.textAlignment=NSTextAlignmentCenter;
    [self  addOneLabelWithLab:self.invitePeopleLB TextColor:[UIColor lightGrayColor] fontSize:12];
    
    /** 今天已发红包数 **/
    self.todayLB=[UILabel new];
    self.todayLB.textColor = [UIColor whiteColor];
    self.todayLB.font=[UIFont fontWithDevice:11];
    self.todayLB.textAlignment=NSTextAlignmentLeft;
    [self.BgThreeImageView addSubview:self.todayLB];
    
    /** 数1BG **/
    self.placeOneBGImage=[UIImageView new];
    [self.BgThreeImageView addSubview:self.placeOneBGImage];
    
    /** 数2BG **/
    self.placeTwoBGImage=[UIImageView new];
    [self.BgThreeImageView addSubview:self.placeTwoBGImage];
    
    /** 数3BG **/
    self.placeThreeBGImage=[UIImageView new];
    [self.BgThreeImageView addSubview:self.placeThreeBGImage];
    
    /** 数4BG **/
    self.placeFourBGImage=[UIImageView new];
    [self.BgThreeImageView addSubview:self.placeFourBGImage];
    
    /** 数5BG **/
    self.placeFiveBGImage=[UIImageView new];
    [self.BgThreeImageView addSubview:self.placeFiveBGImage];
    
    /** 数6BG **/
    self.placeSixBGImage=[UIImageView new];
    [self.BgThreeImageView addSubview:self.placeSixBGImage];
    
    /** 数1LB **/
    self.placeOneLB=[UILabel new];
    [self  addOneLabelWithLabBottom:self.placeOneLB TextColor:[UIColor whiteColor] fontSize:16 addSub:self.placeOneBGImage];
    
    /** 数2LB **/
    self.placeTwoLB=[UILabel new];
    [self  addOneLabelWithLabBottom:self.placeTwoLB TextColor:[UIColor whiteColor] fontSize:16 addSub:self.placeTwoBGImage];
    
    /** 数3LB **/
    self.placeThreeLB=[UILabel new];
    [self  addOneLabelWithLabBottom:self.placeThreeLB TextColor:[UIColor whiteColor] fontSize:16 addSub:self.placeThreeBGImage];
    
    /** 数4LB **/
    self.placeFourLB=[UILabel new];
    [self  addOneLabelWithLabBottom:self.placeFourLB TextColor:[UIColor whiteColor] fontSize:16 addSub:self.placeFourBGImage];
    
    /** 数5LB **/
    self.placeFiveLB=[UILabel new];
    [self  addOneLabelWithLabBottom:self.placeFiveLB TextColor:[UIColor whiteColor] fontSize:16 addSub:self.placeFiveBGImage];
    
    /** 数6LB **/
    self.placeSixLB=[UILabel new];
    [self  addOneLabelWithLabBottom:self.placeSixLB TextColor:[UIColor whiteColor] fontSize:16 addSub:self.placeSixBGImage];
    
    /** 个 **/
    self.EntriesLB=[UILabel new];
    self.EntriesLB.textColor = [UIColor whiteColor];
    self.EntriesLB.font=[UIFont fontWithDevice:11];
    self.EntriesLB.textAlignment=NSTextAlignmentLeft;
    [self.BgThreeImageView addSubview:self.EntriesLB];
    
    
    [self initdistribute];
    
    
}
-(void)initdistribute{
   
    self.headerline.sd_layout
    .leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(20);
    
    self.BgOneImageView.sd_layout
    .topSpaceToView(self.headerline, 0).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(170);
    
    self.BgTwoImageView.sd_layout
    .topSpaceToView(self.headerline, 0).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(230);
    
    self.BgThreeImageView.sd_layout
    .leftSpaceToView(self.contentView, 35).rightSpaceToView(self.contentView, 35).heightIs(35).topSpaceToView(self.BgTwoImageView, 0);
    
    self.BgRightBlueImage.sd_layout
     .rightSpaceToView(self.BgTwoImageView, 7.5).heightIs(25).topSpaceToView(self.BgTwoImageView, 60).widthIs(80);
    
    /** 等级 **/
    self.RightLB.sd_layout
    .leftSpaceToView(self.BgRightBlueImage, 0).rightSpaceToView(self.BgRightBlueImage, 0).heightIs(20).centerYEqualToView(self.BgRightBlueImage).topSpaceToView(self.BgRightBlueImage, 0);
    
    /** 邀请码 **/
    self.inviteNumberLB.sd_layout
    .leftSpaceToView(self.BgTwoImageView, 20).heightIs(20).topSpaceToView(self.BgRightBlueImage, 10).widthIs(FNDeviceWidth/2-80);
    
    
    /** 复制按钮 **/
    self.stickvBtn.sd_layout
    .leftSpaceToView(self.inviteNumberLB, 5).heightIs(20).topSpaceToView(self.BgRightBlueImage, 10).widthIs(20);
    
    /** 邀请码文字 **/
    self.invitetitleLB.sd_layout
    .leftSpaceToView(self.BgTwoImageView, 20).heightIs(20).topSpaceToView(self.inviteNumberLB, 5).widthIs(FNDeviceWidth/2-55);
    
   
    
    /** line1 **/
    self.lineOne.sd_layout
    .heightIs(40).widthIs(1).bottomSpaceToView(self.BgTwoImageView, 15).centerXEqualToView(self.BgTwoImageView);
    
    /** 余额标题 **/
    self.balanceTitleLB.sd_layout
    .rightSpaceToView(self.lineOne, 0).heightIs(15).widthIs((FNDeviceWidth-40)/2).bottomSpaceToView(self.BgTwoImageView, 20);
    
    /** 余额 **/
    self.balanceLB.sd_layout
    .rightSpaceToView(self.lineOne, 0).heightIs(15).widthIs((FNDeviceWidth-40)/2).bottomSpaceToView(self.balanceTitleLB, 5);
    
   
    /** 邀请人数标题 **/
    self.invitePeopleLTitleLB.sd_layout
    .leftSpaceToView(self.lineOne, 0).heightIs(15).widthIs((FNDeviceWidth-40)/2).bottomSpaceToView(self.BgTwoImageView, 20);
    /** 邀请人数  **/
    self.invitePeopleLB.sd_layout
    .leftSpaceToView(self.lineOne, 0).heightIs(15).widthIs((FNDeviceWidth-40)/2).bottomSpaceToView(self.invitePeopleLTitleLB, 5);
    
    
    /** line2 **/
    //self.lineTwo.sd_layout
    //.leftSpaceToView(self.treatLB, 0).heightIs(40).widthIs(1).bottomSpaceToView(self.BgTwoImageView, 20);
    
    /** 待收入红包 **/
    //self.treatLB.sd_layout
    //.leftSpaceToView(self.lineTwo, 0).heightIs(20).widthIs((FNDeviceWidth-22)/3).bottomSpaceToView(self.BgTwoImageView, 30);
    
    /** 今天已发红包数 **/
    self.todayLB.sd_layout
    .leftSpaceToView(self.BgThreeImageView, 25).heightIs(20).centerYEqualToView(self.BgThreeImageView);
    [self.todayLB setSingleLineAutoResizeWithMaxWidth:100];
    
    /** 数1BG **/
    self.placeOneBGImage.sd_layout
    .leftSpaceToView(self.todayLB, 5).widthIs(20).topSpaceToView(self.BgThreeImageView, 5).bottomSpaceToView(self.BgThreeImageView, 5);
    
    /** 数2BG **/
    self.placeTwoBGImage.sd_layout
    .leftSpaceToView(self.placeOneBGImage, 5).widthIs(20).topSpaceToView(self.BgThreeImageView, 5).bottomSpaceToView(self.BgThreeImageView, 5);
    
    /** 数3BG **/
    self.placeThreeBGImage.sd_layout
    .leftSpaceToView(self.placeTwoBGImage, 5).widthIs(20).topSpaceToView(self.BgThreeImageView, 5).bottomSpaceToView(self.BgThreeImageView, 5);
    
    /** 数4BG **/
    self.placeFourBGImage.sd_layout
    .leftSpaceToView(self.placeThreeBGImage, 5).widthIs(20).topSpaceToView(self.BgThreeImageView, 5).bottomSpaceToView(self.BgThreeImageView, 5);
    
    /** 数5BG **/
    self.placeFiveBGImage.sd_layout
    .leftSpaceToView(self.placeFourBGImage, 5).widthIs(20).topSpaceToView(self.BgThreeImageView, 5).bottomSpaceToView(self.BgThreeImageView, 5);
    
    /** 数6BG **/
    self.placeSixBGImage.sd_layout
    .leftSpaceToView(self.placeFiveBGImage, 5).widthIs(20).topSpaceToView(self.BgThreeImageView, 5).bottomSpaceToView(self.BgThreeImageView, 5);
    
    /** 数1LB **/
    
    self.placeOneLB.sd_layout
    .leftSpaceToView(self.placeOneBGImage, 0).widthIs(20).topSpaceToView(self.placeOneBGImage, 0).bottomSpaceToView(self.placeOneBGImage, 0);
    
    /** 数2LB **/
    
    self.placeTwoLB.sd_layout
    .leftSpaceToView(self.placeTwoBGImage, 0).widthIs(20).topSpaceToView(self.placeTwoBGImage, 0).bottomSpaceToView(self.placeTwoBGImage, 0);
    
    /** 数3LB **/
    
    self.placeThreeLB.sd_layout
    .leftSpaceToView(self.placeThreeBGImage, 0).widthIs(20).topSpaceToView(self.placeThreeBGImage, 0).bottomSpaceToView(self.placeThreeBGImage,0);
    
    /** 数4LB **/
    
    self.placeFourLB.sd_layout
    .leftSpaceToView(self.placeFourBGImage, 0).widthIs(20).topSpaceToView(self.placeFourBGImage, 0).bottomSpaceToView(self.placeFourBGImage, 0);
    
    /** 数5LB **/
    
    self.placeFiveLB.sd_layout
    .leftSpaceToView(self.placeFiveBGImage, 0).widthIs(20).topSpaceToView(self.placeFiveBGImage, 0).bottomSpaceToView(self.placeFiveBGImage, 0);
    
    /** 数6LB **/
    
    self.placeSixLB.sd_layout
    .leftSpaceToView(self.placeSixBGImage, 0).widthIs(20).topSpaceToView(self.placeSixBGImage, 0).bottomSpaceToView(self.placeSixBGImage, 0);
    
    /** 个 **/
    
    self.EntriesLB.sd_layout
    .leftSpaceToView(self.placeSixBGImage, 5).heightIs(20).widthIs(15).centerYEqualToView(self.placeSixBGImage);
    
    self.BgTwoImageView.userInteractionEnabled = YES;
    [self.stickvBtn addTarget:self action:@selector(AcStickvBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.BgRightBlueImage.userInteractionEnabled = YES;
    self.RightLB.userInteractionEnabled = YES;
    UITapGestureRecognizer *RightBluetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RightBluetapClick)];
    [self.RightLB addGestureRecognizer:RightBluetap];
}
#pragma mark - setter && getter
- (void)setModel:(GradeMemberNModel *)model{
    _model = model;
    NSLog(@"str1%@",model.str1);
    if (model) {
        NSArray *syArr=model.sy;
        NSArray *hb_count=model.hb_count;
        GradeHbNModel *modeRMB=[GradeHbNModel mj_objectWithKeyValues:syArr[0]];
        GradeHbNModel *modeval=[GradeHbNModel mj_objectWithKeyValues:syArr[1]];
        self.BgOneImageView.image=IMAGE(@"vip_bj1");
        [self.BgOneImageView setUrlImg:model.bj_img];
        self.BgOneImageView.backgroundColor=FNColor(237, 80, 36);
        self.BgOneImageView.sd_layout
        .topSpaceToView(self.headerline, 10).leftSpaceToView(self.contentView, 17).rightSpaceToView(self.contentView, 17).heightIs(170);
        
        self.BgTwoImageView.image=IMAGE(@"vip_bj2");
        self.BgThreeImageView.image=IMAGE(@"vip_redbj");
        self.BgRightBlueImage.image=IMAGE(@"vip_grade_bj");
        self.RightLB.text=model.name;//@"V1 小金主";
        self.inviteNumberLB.text=model.tgid;
        self.invitetitleLB.text=model.str;//@"我的专属邀请码";
        //self.balanceLB.text=[NSString stringWithFormat:@"%@%@",modeRMB.val,modeRMB.unit];//@"0元";
        //self.treatLB.text=@"0元待收入红包";
        self.balanceTitleLB.text=modeRMB.name;
        self.invitePeopleLTitleLB.text=modeval.name;//@"邀请人数";
        //self.invitePeopleLB.text=[NSString stringWithFormat:@"%@%@",modeval.val,modeval.unit];//@"0元";
        self.todayLB.text=model.str1;
        self.placeOneLB.text=[NSString stringWithFormat:@"%@",hb_count[0]];//
        self.placeTwoLB.text=[NSString stringWithFormat:@"%@",hb_count[1]];//@"5";
        self.placeThreeLB.text=[NSString stringWithFormat:@"%@",hb_count[2]];//@"1";
        self.placeFourLB.text=[NSString stringWithFormat:@"%@",hb_count[3]];//@"2";
        self.placeFiveLB.text=[NSString stringWithFormat:@"%@",hb_count[4]];//@"3";
        self.placeSixLB.text=[NSString stringWithFormat:@"%@",hb_count[5]];//@"6";
        self.EntriesLB.text=model.unit;
        self.placeOneBGImage.image=IMAGE(@"vip_numbj");
        self.placeTwoBGImage.image=IMAGE(@"vip_numbj");
        self.placeThreeBGImage.image=IMAGE(@"vip_numbj");
        self.placeFourBGImage.image=IMAGE(@"vip_numbj");
        self.placeFiveBGImage.image=IMAGE(@"vip_numbj");
        self.placeSixBGImage.image=IMAGE(@"vip_numbj");
        self.EntriesLB.text=@"个";
        
        NSString *valString=[NSString stringWithFormat:@"%@ %@",modeRMB.val,modeRMB.unit];
        NSMutableAttributedString *valbutedString = [[NSMutableAttributedString alloc] initWithString: valString];
        [valbutedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, modeRMB.val.length)];
        self.balanceLB.attributedText = valbutedString;
        
        NSString *PeopleString=[NSString stringWithFormat:@"%@ %@",modeval.val,modeval.unit];
        NSMutableAttributedString *PeoplebutedString = [[NSMutableAttributedString alloc] initWithString: PeopleString];
        [PeoplebutedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, modeval.val.length)];
        self.invitePeopleLB.attributedText = PeoplebutedString;
        
    }
    
}

//TOPLB
-(void)addOneLabelWithLab:(UILabel *)label TextColor:(UIColor *)textColor fontSize:(float)fontSize{
    label.textColor = textColor;
    label.font=[UIFont fontWithDevice:fontSize];
    [self.BgTwoImageView addSubview:label];
    
}
//BottomLB
-(void)addOneLabelWithLabBottom:(UILabel *)label TextColor:(UIColor *)textColor fontSize:(float)fontSize addSub:(UIImageView *)imageView{
    label.textColor = textColor;
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont fontWithDevice:fontSize];
    [imageView addSubview:label];
    
}
//复制
-(void)AcStickvBtnClick{
    NSLog(@"复制");
    if (self.stickupClickString) {
        self.stickupClickString(self.model);
    }
}
-(void)RightBluetapClick{
    NSLog(@"VWV");
    if (self.SelectedGradeClick) {
        self.SelectedGradeClick(self.model);
    }
}

@end
