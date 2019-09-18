//
//  FNcashActivityPictureNeCell.m
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNcashActivityPictureNeCell.h"

@implementation FNcashActivityPictureNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    
    self.bgImageView=[UIImageView new];
    self.bgImageView.userInteractionEnabled=YES;
    [self.contentView addSubview:self.bgImageView];
    
    self.contentImageView=[UIImageView new];
    [self.bgImageView addSubview:self.contentImageView];
    
    self.regulationBtn=[[UIButton alloc]init]; 
    self.regulationBtn.backgroundColor=FNColor(255, 184, 113);
    self.regulationBtn.titleLabel.font=kFONT12;
    self.regulationBtn.layer.cornerRadius=25/2;
    [self.regulationBtn setTitle:@"活动规则" forState:UIControlStateNormal];
    [self.bgImageView addSubview:self.regulationBtn];
    
    
    self.bgImageView.sd_layout
    .topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0);
    
    self.contentImageView.sd_layout
    .centerXEqualToView(self.bgImageView).widthIs(260).heightIs(125).topSpaceToView(self.bgImageView, 40);
    
    self.regulationBtn.sd_layout
    .topSpaceToView(self.bgImageView, 10).rightSpaceToView(self.bgImageView, 10).heightIs(25).widthIs(80);
    
    
    //self.bgImageView.image=IMAGE(@"activity_bg_nor");
    //self.contentImageView.image=IMAGE(@"h5_font_nor");
    
}
-(void)setItemDic:(NSDictionary *)itemDic{
    _itemDic=itemDic;
    if(itemDic){
        FNCashActivitySetModel *mode=[FNCashActivitySetModel mj_objectWithKeyValues:itemDic];
        
        //self.bgImageView.image=IMAGE(@"activity_bg_nor");
        [self.bgImageView setUrlImg:mode.tlj_top_img];
        //self.contentImageView.image=IMAGE(@"h5_font_nor");
    }
}
@end
