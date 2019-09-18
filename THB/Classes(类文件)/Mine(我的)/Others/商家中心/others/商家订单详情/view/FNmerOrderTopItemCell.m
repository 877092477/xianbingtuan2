//
//  FNmerOrderTopItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerOrderTopItemCell.h"

@implementation FNmerOrderTopItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.topBgView=[[UIView alloc]init];
    [self addSubview:self.topBgView];
    
//    self.twoBgView=[[UIView alloc]init];
//    [self addSubview:self.twoBgView];
//
//    self.bottomBgView=[[UIView alloc]init];
//    [self addSubview:self.bottomBgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self.topBgView addSubview:self.titleLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self.topBgView addSubview:self.hintLB];
    
    self.sumLB=[[UILabel alloc]init];
    [self.topBgView addSubview:self.sumLB];
    
    self.oneLineView=[[UIView alloc]init];
    [self.topBgView addSubview:self.oneLineView];
    
//    self.yardTitleLB=[[UILabel alloc]init];
//    [self.twoBgView addSubview:self.yardTitleLB];
//
//    self.stateLB=[[UILabel alloc]init];
//    [self.twoBgView addSubview:self.stateLB];
//
//    self.yardImgView=[[UIImageView alloc]init];
//    [self.twoBgView addSubview:self.yardImgView];
//
//    self.headImgView=[[UIImageView alloc]init];
//    [self.bottomBgView addSubview:self.headImgView];
//
//    self.nameLB=[[UILabel alloc]init];
//    [self.bottomBgView addSubview:self.nameLB];
//
//    self.twoLineView=[[UIView alloc]init];
//    [self.twoBgView addSubview:self.twoLineView];
//
//    self.threeLineView=[[UIView alloc]init];
//    [self.bottomBgView addSubview:self.threeLineView];
    
    self.topBgView.backgroundColor=[UIColor whiteColor];
//    self.twoBgView.backgroundColor=[UIColor whiteColor];
//    self.bottomBgView.backgroundColor=[UIColor whiteColor];
    self.oneLineView.backgroundColor=RGB(246, 245, 245);
//    self.twoLineView.backgroundColor=RGB(246, 245, 245);
//    self.threeLineView.backgroundColor=RGB(246, 245, 245);
    
    //self.twoLineView.backgroundColor=[UIColor orangeColor];
    //self.threeLineView.backgroundColor=[UIColor greenColor];
    
    self.titleLB.font=[UIFont systemFontOfSize:18];
    self.titleLB.textColor=RGB(24, 24, 24);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:14];
    self.hintLB.textColor=RGB(140, 140, 140);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.sumLB.font=[UIFont systemFontOfSize:14];
    self.sumLB.textColor=RGB(24, 24, 24);
    self.sumLB.textAlignment=NSTextAlignmentLeft;
    
//    self.yardTitleLB.font=[UIFont systemFontOfSize:16];
//    self.yardTitleLB.textColor=RGB(60, 60, 60);
//    self.yardTitleLB.textAlignment=NSTextAlignmentLeft;
//
//    self.stateLB.font=[UIFont systemFontOfSize:14];
//    self.stateLB.textColor=RGB(244, 47, 25);
//    self.stateLB.textAlignment=NSTextAlignmentRight;
//
//    self.nameLB.font=[UIFont systemFontOfSize:14];
//    self.nameLB.textColor=RGB(24, 24, 24);
//    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.topBgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(113);
    
//    self.twoBgView.sd_layout
//    .leftSpaceToView(self, 10).topSpaceToView(self.topBgView, 10).rightSpaceToView(self, 10).heightIs(216);
//
//    self.bottomBgView.sd_layout
//    .leftSpaceToView(self, 10).bottomSpaceToView(self, 0).rightSpaceToView(self, 10).heightIs(47);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.topBgView, 20).topSpaceToView(self.topBgView, 10).rightSpaceToView(self.topBgView, 20).heightIs(25);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self.topBgView, 20).topSpaceToView(self.titleLB, 1).rightSpaceToView(self.topBgView, 20).heightIs(17);
    
    self.sumLB.sd_layout
    .leftSpaceToView(self.topBgView, 20).bottomSpaceToView(self.topBgView, 12).rightSpaceToView(self.topBgView, 20).heightIs(20);
    
    self.oneLineView.sd_layout
    .leftSpaceToView(self.topBgView, 20).bottomSpaceToView(self.sumLB, 12).rightSpaceToView(self.topBgView, 20).heightIs(2);
    
//    self.yardTitleLB.sd_layout
//    .leftSpaceToView(self.twoBgView, 10).topSpaceToView(self.twoBgView, 10).widthIs(100).heightIs(25);
//
//    self.stateLB.sd_layout
//    .rightSpaceToView(self.twoBgView, 10).topSpaceToView(self.twoBgView, 10).widthIs(100).heightIs(25);
//
//    self.yardImgView.sd_layout
//    .centerXEqualToView(self.twoBgView).topSpaceToView(self.twoLineView, 15).widthIs(140).heightIs(140);
//
//    self.headImgView.sd_layout
//    .leftSpaceToView(self.bottomBgView, 10).centerYEqualToView(self.bottomBgView).widthIs(18).heightIs(18);
//
//    self.nameLB.sd_layout
//    .leftSpaceToView(self.headImgView, 10).centerYEqualToView(self.headImgView).rightSpaceToView(self.bottomBgView, 10).heightIs(20);
    
//    self.twoLineView.sd_layout
//    .leftSpaceToView(self.twoBgView, 10).topSpaceToView(self.twoBgView, 45).rightSpaceToView(self.twoBgView, 10).heightIs(2);
//
//    self.threeLineView.sd_layout
//    .leftSpaceToView(self.bottomBgView, 10).bottomSpaceToView(self.bottomBgView, 0).rightSpaceToView(self.bottomBgView, 10).heightIs(2);
    
}

-(void)setModel:(FNmerOrderZModel *)model{
    _model=model;
    if(model){
        NSDictionary *topDictry=model.top;
        FNmerOrderZZHModel *topModel=[FNmerOrderZZHModel mj_objectWithKeyValues:topDictry];
        FNmerOrderZZHModel *buyMsgModel=[FNmerOrderZZHModel mj_objectWithKeyValues:model.buy_msg];
        FNmerOrderZZHModel *centerModel=[FNmerOrderZZHModel mj_objectWithKeyValues:model.center];
        NSString *incomeJoint=[NSString stringWithFormat:@"%@  %@",topModel.str3,topModel.income];
        self.titleLB.text=topModel.str1;
        self.hintLB.text=topModel.str2;
        self.sumLB.text=incomeJoint;
        if([topModel.income kr_isNotEmpty]){
            [self.sumLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:18] changeText:topModel.income];
            [self.sumLB fn_changeColorWithTextColor:[UIColor colorWithHexString:topModel.income_color] changeText:topModel.income];
        }
//        self.yardTitleLB.text=@"商品二维码";
//        self.stateLB.text=buyMsgModel.str;
//        [self.headImgView setUrlImg:centerModel.head_img];
//        self.nameLB.text=centerModel.username;
    }
}
@end
