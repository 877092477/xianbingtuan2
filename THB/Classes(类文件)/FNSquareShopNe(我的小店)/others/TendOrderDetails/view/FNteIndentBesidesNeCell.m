//
//  FNteIndentBesidesNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//订单详情 其他信息:订单号 之类
#import "FNteIndentBesidesNeCell.h"

@implementation FNteIndentBesidesNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=FNWhiteColor;
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    self.contentView.backgroundColor=FNColor(240,240,240);
    self.bgView=[[UIView alloc]init];
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    //文本
    self.corrupLB=[UILabel new];
    self.corrupLB.font=kFONT12;
    self.corrupLB.textColor=RGB(200, 200, 200);
    self.corrupLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.corrupLB];
    [self placeViewFrame];
    
}
-(void)placeViewFrame{
    CGFloat space_20=20;
    CGFloat space_10=10;
    self.bgView.sd_layout
    .topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, space_10).rightSpaceToView(self.contentView, space_10).bottomSpaceToView(self.contentView, 0);
    self.corrupLB.sd_layout
    .topSpaceToView(self.bgView, 0).leftSpaceToView(self.bgView, space_20).bottomSpaceToView(self.bgView, 0).rightSpaceToView(self.bgView, space_20);
    
}
-(void)setModel:(FNtendDetailsOrderMsgModel *)model{
    _model=model;
    if(model){
        if ([model.str kr_isNotEmpty] && [model.val kr_isNotEmpty]) {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",model.str,model.val] attributes:@{NSFontAttributeName: kFONT12,NSForegroundColorAttributeName: RGB(200, 200, 200)}];
            
            [string addAttributes:@{NSForegroundColorAttributeName: RGB(51, 51, 51)} range:NSMakeRange(model.str.length, model.val.length)];
            
            self.corrupLB.attributedText = string;
        } else {
            self.corrupLB.text=[NSString stringWithFormat:@"%@%@",model.str,model.val];//@"订单号:4503180279";
        }
    }
    
}
@end
