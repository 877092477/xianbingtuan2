//
//  FNshopTendStoreRowNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/11/22.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNshopTendStoreRowNeCell.h"

@implementation FNshopTendStoreRowNeCell


-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    
    self.backgroundColor = UIColor.whiteColor;
    
    //店铺
    self.storeImage=[UIImageView new];
    [self.contentView addSubview:self.storeImage];
    
    //店铺
    self.storeName=[UILabel new];
    [self.storeName sizeToFit];
    self.storeName.textColor=[UIColor blackColor];
    self.storeName.font=kFONT14;
    [self.contentView addSubview:self.storeName];
    
    //店铺距离
    self.distanceLB=[UILabel new];
    [self.distanceLB sizeToFit];
    self.distanceLB.textColor=[UIColor blackColor];
    self.distanceLB.font=kFONT12;
    [self.contentView addSubview:self.distanceLB];
    
    //店铺位置
    self.locationLB=[UILabel new];
    [self.locationLB sizeToFit];
    self.locationLB.textColor=[UIColor grayColor];
    self.locationLB.font=kFONT12;
    [self.contentView addSubview:self.locationLB];
    
    //赏
    self.rewardLB=[UILabel new];
    [self.rewardLB sizeToFit];
    self.rewardLB.textColor=FNColor(255, 17, 29);
    self.rewardLB.font=kFONT13;
    [self.contentView addSubview:self.rewardLB];
    
    self.lineLB=[UILabel new];
    self.lineLB.backgroundColor=FNColor(244, 244, 244);
    [self.contentView addSubview:self.lineLB];
    
    [self initPlaceSubviews];
    
    self.tagsView =[[LXTagsView alloc]init];
    //self.tagsView.layer.borderWidth = 1;
    //self.tagsView.layer.borderColor = [UIColor redColor].CGColor;
    [self.contentView addSubview:self.tagsView];
    
    self.tagsView.sd_layout
    .heightIs(25).leftSpaceToView(self.storeImage, 0).rightSpaceToView(self.contentView, 10).topSpaceToView(self.storeName, 5);
    
//    [self.tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(self.contentView);
//    }];
    //self.tagsView.frame=CGRectMake(10, 10, 120, 50);
    self.tagsView.tagClick = ^(NSString *tagTitle) {
        NSLog(@"cell打印---%@",tagTitle);
    };
}
#pragma mark - initPlaceSubviews
- (void)initPlaceSubviews {
    CGFloat space_10=10;
    CGFloat space_7=7;
   
    self.storeImage.sd_layout
    .centerYEqualToView(self.contentView).leftSpaceToView(self.contentView, space_10).widthIs(90).heightIs(90);
    
//    self.storeName.sd_layout.topEqualToView(self.storeImage).heightIs(20).leftSpaceToView(self.storeImage, space_10);
//    [self.storeName setSingleLineAutoResizeWithMaxWidth:100];
    [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.storeImage);
        make.height.mas_equalTo(20);
        make.left.equalTo(self.storeImage.mas_right).offset(10);
        make.right.lessThanOrEqualTo(self.distanceLB.mas_left).offset(-20);
    }];
    
    self.distanceLB.sd_layout.topEqualToView(self.storeImage).heightIs(20).rightSpaceToView(self.contentView, space_10);
    [self.distanceLB setSingleLineAutoResizeWithMaxWidth:80];
    
    self.rewardLB.sd_layout.heightIs(15).leftSpaceToView(self.storeImage, space_10).bottomEqualToView(self.storeImage).rightSpaceToView(self.contentView, space_10);
    
    
    self.locationLB.sd_layout.heightIs(15).leftSpaceToView(self.storeImage, space_10).bottomSpaceToView(self.rewardLB, space_7).rightSpaceToView(self.contentView, space_10);
     
    self.lineLB.sd_layout.heightIs(1).leftSpaceToView(self.contentView, space_10).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, space_10);
    
}
-(void)setDicModel:(NSDictionary *)dicModel{
    _dicModel=dicModel;
    if(dicModel){
        FNStoreThendNeModel *model=[FNStoreThendNeModel mj_objectWithKeyValues:dicModel];
        [self.storeImage setUrlImg:model.img];
        self.storeName.text=model.name;//@"中国国际影城";  
        if(![model.distance isEqualToString:@"0"]){
            self.distanceLB.text=model.distance;//@"12.9km";
        }
        self.locationLB.text=model.address;//@"广东省广州市天河区体育西路天河又一城7楼";
        if (![FNCurrentVersion isEqualToString:Setting_checkVersion]) {
            self.rewardLB.text=model.str;//@"赏3.2%";
        }
        self.tagsView.dataA =model.label;//     @[@"电影",@"娱乐"];//
        //NSString* price = [NSString stringWithFormat:@"%.2lf",[model.goods_price floatValue]];
        //self.qhPriceLabel.text = [NSString stringWithFormat:@"券后¥%@",price];
        //[self.rewardLB addSingleAttributed:@{NSFontAttributeName:kFONT16} ofRange:[self.rewardLB.text rangeOfString:price]];
    }
      [self.contentView layoutIfNeeded];
}
//- (void)addSingleAttributed:(NSDictionary *)att ofRange:(NSRange)range{
//    if (self.text == nil || self.text.length <=0) {
//        return;
//    }
//    NSMutableAttributedString* matt = [[NSMutableAttributedString alloc]initWithString:self.text];
//    [matt addAttributes:att range:range];
//    self.attributedText = matt;
//}
@end
