//
//  FNmemberMatterCell.m
//  THB
//
//  Created by Jimmy on 2018/9/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNmemberMatterCell.h"
#import "GradeMemberNModel.h"

@implementation FNmemberMatterCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=FNColor(245, 245, 245);
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    /** 获得广告 **/
    self.matterImageView=[UIImageView new];
    [self.contentView addSubview:self.matterImageView];
    [self setCompositionView];
    
}
-(void)setCompositionView{
    ///CGFloat space_10=10;
    
    self.matterImageView.sd_layout
    .leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 5).bottomSpaceToView(self.contentView, 5);
     self.matterImageView.image=IMAGE(@"vip_adv1");
    
    
}
#pragma mark - setter && getter
- (void)setModel:(GradeAdvertisingNModel *)model{
    _model = model;
    NSLog(@"url%@",model.url);
    if (model) {
        [self.matterImageView setUrlImg:model.img];

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
