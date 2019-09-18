//
//  FNincomeNViewCell.m
//  THB
//
//  Created by Jimmy on 2018/9/6.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//收支cell
#import "FNincomeNViewCell.h"
#import "JMMineBillModel.h"
@implementation FNincomeNViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    /** 自购获得 **/
    self.purchaseTitle=[UILabel new];
    self.purchaseTitle.font=FNFontDefault(12);
    self.purchaseTitle.textColor=FNColor(255,21,101);
    [self.contentView addSubview:self.purchaseTitle];
    /** 获得金额 **/
    self.acquireTitle=[UILabel new];
    self.acquireTitle.font=FNFontDefault(12);
    self.acquireTitle.textColor=FNColor(255,21,101);
    [self.contentView addSubview:self.acquireTitle];
    /** 预计到账时间 **/
    self.timeTitle=[UILabel new];
    self.timeTitle.font=FNFontDefault(12);
    self.timeTitle.textColor=FNColor(132,132,132);
    [self.contentView addSubview:self.timeTitle];
    
    [self setCompositionView];
    
    
    
    UILabel *line=[UILabel new];
    line.backgroundColor =FNColor(242,242,242);
    [self.contentView addSubview:line];
    line.sd_layout
    .bottomEqualToView(self.contentView).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(1);
    
    
}
-(void)setCompositionView{
    CGFloat space_10=10;
    
    self.acquireTitle.sd_layout
    .topSpaceToView(self.contentView, space_10).rightSpaceToView(self.contentView, space_10).heightIs(20);
    [self.acquireTitle setSingleLineAutoResizeWithMaxWidth:80];
    
    self.purchaseTitle.sd_layout
    .leftSpaceToView(self.contentView, space_10).topSpaceToView(self.contentView, space_10).heightIs(20).rightSpaceToView(self.acquireTitle, 10);
    
    self.timeTitle.sd_layout
    .topSpaceToView(self.purchaseTitle, space_10).leftEqualToView(self.purchaseTitle).heightIs(20).rightSpaceToView(self.contentView, space_10);
    
   
    
}
#pragma mark - setter && getter
- (void)setModel:(FNBillDetailsModel *)model{
    _model = model;
    if (_model) {
        self.purchaseTitle.text=_model.detail;
        self.acquireTitle.text=_model.interal;
        self.timeTitle.text=  [NSString  getTimeStr:_model.time withFormat:@"yyyy-MM-dd HH:mm"];
    }
    [self.contentView setNeedsLayout];
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
