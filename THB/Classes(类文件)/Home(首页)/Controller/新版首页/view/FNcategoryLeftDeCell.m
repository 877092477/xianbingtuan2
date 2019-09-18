//
//  FNcategoryLeftDeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/17.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNcategoryLeftDeCell.h"

@implementation FNcategoryLeftDeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self inClassifyView];
    }
    return self;
}

-(void)inClassifyView{

    self.classifyLB=[[UILabel alloc]init];
    self.classifyLB.frame=CGRectMake(0, 0, FNDeviceWidth*0.25, 40);
    self.classifyLB.textAlignment=NSTextAlignmentCenter;
    self.classifyLB.numberOfLines=1;
    self.classifyLB.font=FNFontDefault(12);
    [self.contentView addSubview:self.classifyLB];

//    self.classifyLB.sd_layout
//    .leftSpaceToView(self.contentView, 1).rightSpaceToView(self.contentView, 1).topSpaceToView(self.contentView, 1).bottomSpaceToView(self.contentView, 1);



}

-(void)setEvaluate:(FNLeftclassifyModel *)evaluate{
    _evaluate=evaluate;
    if (evaluate) {
        XYLog(@"catename=:%@",evaluate.catename);
        self.classifyLB.text=evaluate.catename;

        if (evaluate.select_type==1) {
            self.classifyLB.textColor=[UIColor whiteColor];
            self.classifyLB.backgroundColor=RGB(249, 72, 155);
            if([[FNBaseSettingModel settingInstance].cates_check_color kr_isNotEmpty]){
                self.classifyLB.textColor=[UIColor colorWithHexString:[FNBaseSettingModel settingInstance].cates_check_color];
            }
            if([[FNBaseSettingModel settingInstance].cates_bj_color kr_isNotEmpty]){
                self.classifyLB.backgroundColor=[UIColor colorWithHexString:[FNBaseSettingModel settingInstance].cates_bj_color];
            }
        }else{
            self.classifyLB.textColor=RGB(140, 140, 140);
            self.classifyLB.backgroundColor=RGB(246, 245, 245);
            if([[FNBaseSettingModel settingInstance].cate_notcheck_color kr_isNotEmpty]){
                self.classifyLB.textColor=[UIColor colorWithHexString:[FNBaseSettingModel settingInstance].cate_notcheck_color];
            }
            if([[FNBaseSettingModel settingInstance].cates_nocheck_bj_color kr_isNotEmpty]){
                self.classifyLB.backgroundColor=[UIColor colorWithHexString:[FNBaseSettingModel settingInstance].cates_nocheck_bj_color];
            }
        }
        self.contentView.backgroundColor=RGB(246, 245, 245);
        [self.classifyLB updateLayout];
        [self.contentView setNeedsLayout];
        
    }

}

//-(void)classifyBtnClick:(NSInteger)sender{
//    if ([self.delegate respondsToSelector:@selector(categoryLeftDeCellAction:)]) {
//        [self.delegate categoryLeftDeCellAction:self.indexAc.row];
//    }
//}
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}


@end
