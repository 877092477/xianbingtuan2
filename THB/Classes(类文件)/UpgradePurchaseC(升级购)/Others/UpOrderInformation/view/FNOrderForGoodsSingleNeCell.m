//
//  FNOrderForGoodsSingleNeCell.m
//  THB
//
//  Created by 李显 on 2018/10/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNOrderForGoodsSingleNeCell.h"

@implementation FNOrderForGoodsSingleNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=FNWhiteColor;
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    /** line **/
    self.lineLB=[UILabel new];
    self.lineLB.backgroundColor=FNColor(240, 240, 240);
    [self.contentView addSubview:self.lineLB];
    //其他left
    self.restsleftLabel=[UILabel new];
    [self.restsleftLabel sizeToFit];
    self.restsleftLabel.textColor=FNGlobalTextGrayColor;
    self.restsleftLabel.font=kFONT12;
    self.restsleftLabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.restsleftLabel];
    //其他right
    self.restsrightLabel=[UILabel new];
    [self.restsrightLabel sizeToFit];
    self.restsrightLabel.textColor=FNGlobalTextGrayColor;
    self.restsrightLabel.font=kFONT12;
    self.restsrightLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.restsrightLabel]; 
    [self initializedSubviews];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    CGFloat interval_10 = 10;
    self.lineLB.sd_layout
    .topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).heightIs(1).rightSpaceToView(self.contentView, 0);
    
    self.restsleftLabel.sd_layout
    .leftSpaceToView(self.contentView, interval_10).heightIs(25).centerYEqualToView(self.contentView);
    [self.restsleftLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.restsrightLabel.sd_layout
    .rightSpaceToView(self.contentView, interval_10).heightIs(25).centerYEqualToView(self.contentView);
    [self.restsrightLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    
}
-(void)setModel:(FNUpOrderMsgNModel *)model{
    _model=model;
    if(model){
        self.restsleftLabel.text=model.str;
        self.restsrightLabel.text=model.val;
    }
}
@end
