//
//  FNUpOrderformRestsNeCell.m
//  THB
//
//  Created by 李显 on 2018/10/4.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpOrderformRestsNeCell.h"

@implementation FNUpOrderformRestsNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    // line
    self.lineLB=[UILabel new];
    self.lineLB.backgroundColor=FNColor(240, 240, 240);
    [self.contentView addSubview:self.lineLB];
    // 订单其他信息左边
    self.restsLeftLabel=[UILabel new];
    [self.restsLeftLabel sizeToFit];
    self.restsLeftLabel.textColor=FNGlobalTextGrayColor;
    self.restsLeftLabel.font=kFONT12;
    [self.contentView addSubview:self.restsLeftLabel];
    // 订单其他信息右边
    self.restsRightLabel=[UILabel new];
    [self.restsRightLabel sizeToFit];
    self.restsRightLabel.textColor=FNGlobalTextGrayColor;
    self.restsRightLabel.font=kFONT12;
    [self.contentView addSubview:self.restsRightLabel];
    [self initializedSubviews];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    CGFloat interval_10 = 10;
    // line
    self.lineLB.sd_layout
    .topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).heightIs(1).rightSpaceToView(self.contentView, 0);
    //标题
    self.restsLeftLabel.sd_layout
    .topSpaceToView(self.lineLB, 0).leftSpaceToView(self.contentView, interval_10).heightIs(39);
    [self.restsLeftLabel setSingleLineAutoResizeWithMaxWidth:100];
    // 信息
    self.restsRightLabel.sd_layout
    .topSpaceToView(self.lineLB, 0).heightIs(39).rightSpaceToView(self.contentView, interval_10);
    [self.restsRightLabel setSingleLineAutoResizeWithMaxWidth:150];
    
}

-(void)setModel:(FNUpOrderMsgNModel*)model{
    _model=model;
    if(model){
        self.restsLeftLabel.text=model.str;
        self.restsRightLabel.text=model.val;
    }
}
@end
