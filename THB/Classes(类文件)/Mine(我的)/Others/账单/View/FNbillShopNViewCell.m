//
//  FNbillShopNViewCell.m
//  THB
//
//  Created by Jimmy on 2018/9/6.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//购物账单cell
#import "FNbillShopNViewCell.h"
#import "JMMineBillModel.h"
@implementation FNbillShopNViewCell
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
    /** 订单编号 **/
    self.orderTitle=[UILabel new];
    self.orderTitle.font=FNFontDefault(12);
    self.orderTitle.textColor=FNColor(132,132,132);
    [self.contentView addSubview:self.orderTitle];
    /** 复制 **/
    self.selectBtn=[UIButton new];
    self.selectBtn.titleLabel.font=FNFontDefault(10);
    self.selectBtn.borderWidth=0.5;
    self.selectBtn.borderColor = FNGlobalTextGrayColor;
    self.selectBtn.cornerRadius=5;
    self.selectBtn.clipsToBounds = YES;
    [self.selectBtn setTitleColor:FNColor(132,132,132) forState:0];
    [self.selectBtn setTitle:@"复制" forState:0];
    [self.selectBtn addTarget:self action:@selector(duplication)];
    [self.contentView addSubview:self.selectBtn];
    /** 商品类型 例:拼多多 **/
    self.typeTitle=[UILabel new];
    self.typeTitle.font=FNFontDefault(12);
    self.typeTitle.textColor=FNColor(132,132,132);
    [self.contentView addSubview:self.typeTitle];
    
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
    
    self.typeTitle.sd_layout
    .rightSpaceToView(self.contentView, 10).topSpaceToView(self.timeTitle, space_10).heightIs(20);
    [self.typeTitle setSingleLineAutoResizeWithMaxWidth:60];
    
    self.selectBtn.sd_layout
    .centerYEqualToView(self.typeTitle).rightSpaceToView(self.typeTitle, 15).heightIs(20).widthIs(50);
    
    self.orderTitle.sd_layout
    .leftEqualToView(self.purchaseTitle).topSpaceToView(self.timeTitle, space_10).heightIs(20) .rightSpaceToView(self.selectBtn, 15);
    
}
#pragma mark - setter && getter
- (void)setModel:(FNBillDetailsModel *)model{
    _model = model;
    if (model) {
        self.purchaseTitle.text=model.detail;
        self.acquireTitle.text=_model.interal;
        self.timeTitle.text=_model.dzstr;
        self.orderTitle.text=_model.oid;
        self.typeTitle.text=_model.orderType;
    }
    [self.contentView setNeedsLayout];
}
-(void)duplication{
    if ([self.delegate respondsToSelector:@selector(ClickTocopy:)] ) {
        [self.delegate ClickTocopy:self.IndexPath];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)dealloc
{
    // 移除当前对象监听的事件
    [[NSNotificationCenter defaultCenter] removeObserver:self];
   
    
}
@end
