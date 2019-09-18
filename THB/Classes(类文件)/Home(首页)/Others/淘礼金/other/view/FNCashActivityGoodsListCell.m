//
//  FNCashActivityGoodsListCell.m
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNCashActivityGoodsListCell.h"

@implementation FNCashActivityGoodsListCell

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
    //self.bgImageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.bgImageView];
    //self.bgTwoImageView=[UIImageView new];
    //[self.bgImageView addSubview:self.bgTwoImageView];
    self.bgTwoImageView=[UIImageView new];
    self.bgTwoImageView.userInteractionEnabled=YES;
    //[self.contentView addSubview:self.bgTwoImageView];
    //[self.contentView bringSubviewToFront:self.bgTwoImageView];
    [self.bgImageView addSubview:self.bgTwoImageView];
    self.listNeView=[[FNCashActivityListNeView alloc]initWithFrame:CGRectMake(10+2.5, 10, FNDeviceWidth-25, self.frame.size.height)];
    self.listNeView.backgroundColor=[UIColor whiteColor];
    self.listNeView.ActivityCollectionview.scrollEnabled = NO;
    [self.bgTwoImageView addSubview:self.listNeView];
    [self initdistribute];
}
-(void)initdistribute{
    CGFloat interval_5=5;
    CGFloat interval_10=10;
    
    self.bgImageView.sd_layout
    .leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0);
     
    self.bgTwoImageView.sd_layout
    .leftSpaceToView(self.bgImageView, interval_10).topSpaceToView(self.bgImageView, 0).bottomSpaceToView(self.bgImageView, 0).rightSpaceToView(self.bgImageView, interval_10);
    self.listNeView.sd_layout
    .leftSpaceToView(self.bgTwoImageView, interval_10+2.5).topSpaceToView(self.bgTwoImageView, 0).bottomSpaceToView(self.bgTwoImageView, 0).rightSpaceToView(self.bgTwoImageView, interval_10+2.5);
    
    //self.bgImageView.image=IMAGE(@"h5_bigbg_top");
    //self.bgTwoImageView.image=IMAGE(@"h5_smallbg_middle");
    
}
-(void)setHeight:(CGFloat *)height{
    _height=height;
    
}
-(void)setModelArray:(NSArray *)modelArray{
    _modelArray=modelArray;
    if (modelArray.count>0) {
        self.listNeView.dataArr=modelArray;
        //[self.listNeView.ActivityCollectionview reloadData];
    } 
}
-(void)setModictry:(NSDictionary *)modictry{
    _modictry=modictry;
    if(modictry){
        FNCashActivityNeModel *model=[FNCashActivityNeModel mj_objectWithKeyValues:modictry];
        //self.bgTwoImageView.image=IMAGE(@"h5_smallbg_middle");
        /*if([model.str isEqualToString:@"今日免单"]){
            //self.bgImageView.image=IMAGE(@"h5_bigbg_top");
            self.bgImageView.backgroundColor=[UIColor whiteColor];
        }
        else if([model.str isEqualToString:@"一元秒杀"]){
            self.bgImageView.image=IMAGE(@"");
            self.bgImageView.backgroundColor=FNColor(217, 106, 91); 
        }
        else if([model.str isEqualToString:@"更多秒杀"]){
            //self.bgImageView.contentMode=UIViewContentModeBottom;
            self.bgImageView.image=IMAGE(@"");
            self.bgImageView.backgroundColor=FNColor(217, 106, 91);
        }*/
    }
}
@end
