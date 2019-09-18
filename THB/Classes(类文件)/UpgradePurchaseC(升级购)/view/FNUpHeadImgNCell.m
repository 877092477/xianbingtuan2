//
//  FNUpHeadImgNCell.m
//  THB
//
//  Created by Jimmy on 2018/9/25.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpHeadImgNCell.h"
#import "FNUpgradeNMode.h"

@implementation FNUpHeadImgNCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    //标题图片
    self.titleImage=[UIImageView new];
    self.titleImage.contentMode=UIViewContentModeScaleToFill;
    //self.titleImage.image=IMAGE(@"APP底图.png");
    [self.contentView addSubview:self.titleImage];
    //CGFloat interval_10 = 10;
    self.titleImage.sd_layout
    .topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(50);
    
}
-(void)setPreferential:(NSDictionary *)preferential{
    _preferential=preferential;
    if(preferential){
        FNrecommendNMode *model=[FNrecommendNMode mj_objectWithKeyValues:preferential];
        [self.titleImage setUrlImg:model.img];
    }
}
@end
