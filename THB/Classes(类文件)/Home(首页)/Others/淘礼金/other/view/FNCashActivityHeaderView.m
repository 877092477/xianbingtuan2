//
//  FNCashActivityHeaderView.m
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNCashActivityHeaderView.h"

@implementation FNCashActivityHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor= [UIColor whiteColor];
        
        [self initUI];
    }
    return self;
}
-(void)initUI{
    
    self.bgImageView=[UIImageView new];
    //self.bgImageView.contentMode=UIViewContentModeTop;
    [self.contentView addSubview:self.bgImageView];
    self.bgTwoImageView=[UIImageView new];
    [self.bgImageView addSubview:self.bgTwoImageView];
    self.headImageView=[UIImageView new];
    [self.contentView addSubview:self.headImageView];
    [self.contentView bringSubviewToFront:self.headImageView];
    self.headTitle=[UILabel new];
    self.headTitle.textAlignment=NSTextAlignmentCenter;
    self.headTitle.font=kFONT15;
    self.headTitle.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];//加粗
    [self.headImageView addSubview:self.headTitle];
    [self initdistribute];
    
}
-(void)initdistribute{
    self.bgImageView.sd_layout
    .leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0);
    self.bgTwoImageView.sd_layout
    .leftSpaceToView(self.bgImageView, 10).bottomSpaceToView(self.bgImageView, 0).rightSpaceToView(self.bgImageView, 10).heightIs(35);
    self.headImageView.sd_layout
    .bottomSpaceToView(self.contentView, 0).widthIs(198).centerXEqualToView(self.contentView).heightIs(55);
    
    self.headTitle.sd_layout
    .bottomSpaceToView(self.headImageView, 5).topSpaceToView(self.headImageView, 0).leftSpaceToView(self.headImageView, 0).rightSpaceToView(self.headImageView, 0);
    
}
-(void)setItemDic:(NSDictionary *)itemDic{
    _itemDic=itemDic;
    if(itemDic){
        FNCashActivityNeModel *model=[FNCashActivityNeModel mj_objectWithKeyValues:itemDic];
        self.headTitle.text=[NSString stringWithFormat:@"· %@ ·",model.str];//model.str;
        /*if([model.str isEqualToString:@"今日免单"]){
            self.bgImageView.backgroundColor= [UIColor whiteColor];
            self.bgImageView.image=IMAGE(@"activity_singImage");
            self.headImageView.image=IMAGE(@"day_title_nor");
            self.bgTwoImageView.image=IMAGE(@"FN_activiNotNeimage");
        }
        else if([model.str isEqualToString:@"一元秒杀"]){
            self.bgImageView.image=IMAGE(@"");
            self.bgImageView.backgroundColor= [UIColor whiteColor];
            self.headImageView.image=IMAGE(@"h5_title_nor2");
            self.bgTwoImageView.image=IMAGE(@"h5_smallbg_top");
        }
        else if([model.str isEqualToString:@"更多秒杀"]){
            self.bgImageView.image=IMAGE(@"");
            self.bgImageView.backgroundColor=FNColor(217, 106, 91);
            self.headImageView.image=IMAGE(@"h5_title_nor3");
            self.bgTwoImageView.image=IMAGE(@"h5_smallbg_top");
        }*/
    }
}
@end
