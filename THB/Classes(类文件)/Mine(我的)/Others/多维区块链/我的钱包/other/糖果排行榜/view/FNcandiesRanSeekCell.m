//
//  FNcandiesRanSeekCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesRanSeekCell.h"

@implementation FNcandiesRanSeekCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView];
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    self.seekbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.seekbtn];
    
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(190, 68, 100, 25)];
    self.compileField.font = kFONT12;
    [self addSubview:self.compileField];
    
    self.compileField.textColor=[UIColor whiteColor];
    
    self.dateLB.font=[UIFont systemFontOfSize:15]; 
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.bgImgView.cornerRadius=25/2;
    self.bgImgView.clipsToBounds = YES;
    
    self.bgImgView.sd_layout
    .rightSpaceToView(self, 17).bottomSpaceToView(self, 10).heightIs(25).widthIs(200);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self, 15).centerYEqualToView(self.bgImgView).heightIs(16).rightSpaceToView(self.bgImgView, 2);
    
    self.seekbtn.sd_layout
    .rightSpaceToView(self, 22).widthIs(25).heightIs(25).centerYEqualToView(self.bgImgView);
    
    self.seekbtn.imageView.sd_layout
    .centerXEqualToView(self.seekbtn).centerYEqualToView(self.seekbtn).widthIs(14).heightIs(14);
    
    self.compileField.sd_layout
    .rightSpaceToView(self.seekbtn, 5).centerYEqualToView(self.bgImgView).heightIs(25).leftSpaceToView(self.dateLB, 25);
    
    [self.seekbtn addTarget:self action:@selector(seekbtnClick)];
}
-(void)seekbtnClick{
    if([self.compileField.text kr_isNotEmpty]){
        if ([self.delegate respondsToSelector:@selector(didRanSeekWithcontent:)]) {
            [self.delegate didRanSeekWithcontent:self.compileField.text];
        }
    }
}
-(void)setModel:(FNcandiesRankingModel *)model{
    _model=model;
    if(model){
        self.compileField.placeholder=model.dwqkb_rank_search_tips;
        self.dateLB.text=model.dwqkb_rank_tips;
        self.dateLB.textColor=[UIColor colorWithHexString:model.dwqkb_rank_search_color];
        self.compileField.textColor=[UIColor colorWithHexString:model.dwqkb_rank_search_color];
        [self.bgImgView setUrlImg:model.dwqkb_rank_search_bj];
        [self.seekbtn sd_setImageWithURL:URL(model.dwqkb_rank_search_icon) forState:UIControlStateNormal];
        if([model.dwqkb_rank_search_tips kr_isNotEmpty]){
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:model.dwqkb_rank_search_tips attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:model.dwqkb_rank_search_color],NSFontAttributeName:[UIFont systemFontOfSize:12]}];
            self.compileField.attributedPlaceholder = attrString;
        } 
    }
}
@end
