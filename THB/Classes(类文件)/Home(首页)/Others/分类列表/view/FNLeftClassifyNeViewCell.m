//
//  FNLeftClassifyNeViewCell.m
//  THB
//
//  Created by Jimmy on 2018/9/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNLeftClassifyNeViewCell.h"
#import "FNLeftclassifyModel.h"
@implementation FNLeftClassifyNeViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
 
-(void)setCompositionView{
    
    self.classifyBtn=[UIButton new];
    [self.classifyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.classifyBtn addTarget:self action:@selector(classifyBtnClick:)];
    self.classifyBtn.titleLabel.font=FNFontDefault(12);
    self.classifyBtn.cornerRadius=5;
    [self.contentView addSubview:self.classifyBtn];
    
    self.classifyBtn.sd_layout
    .leftSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 5).topSpaceToView(self.contentView, 5).bottomSpaceToView(self.contentView, 5);
    
}

-(void)setEvaluate:(FNLeftclassifyModel *)evaluate{
    
    
   
     [self.classifyBtn setTitle:evaluate.name forState:UIControlStateNormal];
   
     if (evaluate.select_type==1) {
        [self.classifyBtn setBackgroundImage:IMAGE(@"gs_bjNew") forState:UIControlStateNormal];
        [self.classifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     }else{
        [self.classifyBtn setBackgroundImage:IMAGE(@"") forState:UIControlStateNormal];
        [self.classifyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
     }
     [self.contentView setNeedsLayout];
}
 
-(void)classifyBtnClick:(NSInteger)sender{
    if ([self.delegate respondsToSelector:@selector(chooseBtnClickAction:)]) {
        [self.delegate chooseBtnClickAction:self.indexAc.row];
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

@end
