//
//  FNCashActivityFooterNeView.m
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNCashActivityFooterNeView.h"

@implementation FNCashActivityFooterNeView

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
    [self.contentView addSubview:self.bgImageView];
    [self initdistribute];
}
-(void)initdistribute{
    self.bgImageView.sd_layout
    .leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 10).heightIs(35);
   
    //self.bgImageView.image=IMAGE(@"h5_smallbg_bottom");
}
-(void)setItemDic:(NSDictionary *)itemDic{
    _itemDic=itemDic;
    if(itemDic){
        FNCashActivityNeModel *model=[FNCashActivityNeModel mj_objectWithKeyValues:itemDic];
//        if([model.str isEqualToString:@"今日免单"]){
//            self.contentView.backgroundColor= [UIColor whiteColor];
//        }
//        else if([model.str isEqualToString:@"一元秒杀"]){
//            self.contentView.backgroundColor= FNColor(217, 106, 91);
//        }
//        else if([model.str isEqualToString:@"更多秒杀"]){
//            self.contentView.backgroundColor=FNColor(217, 106, 91); 
//        }
    }
}
@end
