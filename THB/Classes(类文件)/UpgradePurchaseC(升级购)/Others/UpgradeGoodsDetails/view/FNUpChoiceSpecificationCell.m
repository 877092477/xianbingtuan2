//
//  FNUpChoiceSpecificationCell.m
//  THB
//
//  Created by Jimmy on 2018/9/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpChoiceSpecificationCell.h"
#import "FNUpDetailsNModel.h"
@implementation FNUpChoiceSpecificationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    //图片
    self.directionImage=[UIImageView new];
    self.directionImage.contentMode=UIViewContentModeScaleToFill;
    self.directionImage.image=IMAGE(@"btn_details_more_nor");
    [self.contentView addSubview:self.directionImage];
    
    //标题
    self.TitleLB=[UILabel new];
    self.TitleLB.textColor=[UIColor lightGrayColor];
    self.TitleLB.font=kFONT12;
    [self.contentView addSubview:self.TitleLB];
    
    //内容
    self.contentLabel=[UILabel new];
    self.contentLabel.numberOfLines=2;
    [self.contentLabel sizeToFit];
    self.contentLabel.textColor=FNBlackColor;
    self.contentLabel.font=kFONT14;
    [self.contentView addSubview:self.contentLabel];
    self.LineView=[UIView new];
    self.LineView.backgroundColor=FNColor(239, 239, 239);
    [self.contentView addSubview:self.LineView];
  
    [self initializedSubviews];
    
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    //CGFloat w = FNDeviceWidth/3;
    CGFloat interval_10 = 10;
    //图片
    self.directionImage.sd_layout
    .rightSpaceToView(self.contentView, interval_10).widthIs(10).heightIs(15).centerYEqualToView(self.contentView);
    
    //标题
    self.TitleLB.sd_layout
    .leftSpaceToView(self.contentView, interval_10).heightIs(20).centerYEqualToView(self.contentView);
    [self.TitleLB setSingleLineAutoResizeWithMaxWidth:70];
    //内容
    self.contentLabel.sd_layout
    .leftSpaceToView(self.TitleLB, interval_10).topSpaceToView(self.contentView, interval_10).bottomSpaceToView(self.contentView, interval_10).rightSpaceToView(self.directionImage, interval_10);
    
    self.LineView.sd_layout
    .leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(interval_10/2).bottomSpaceToView(self.contentView, 0); 
    
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
        self.TitleLB.text=@"已选";
        self.contentLabel.text=@"请选择";
        NSMutableArray *arr=[NSMutableArray array];
        for (NSInteger i = 0; i < dataArr.count; i++) {
            FNUpGoodsAttrNModel *model=dataArr[i];
            for (NSInteger j = 0; j < model.attr_val.count; j++) {
                FNUpGoodsAttrItemNModel *ExModel= model.attr_val[j];
                if (ExModel.isSelect == YES) {
                    [arr addObject:ExModel.name];
                }
            }
        }
        if(arr.count>0){
            NSString *jointString=[arr componentsJoinedByString:@"，"];
            self.contentLabel.text=[NSString stringWithFormat:@"已选%@",jointString];
        }else{
            self.contentLabel.text=@"请选择";
        }
        
    }
    
}
@end
