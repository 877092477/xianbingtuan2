//
//  FNUpAddressItemNeCell.m
//  THB
//
//  Created by Jimmy on 2018/9/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpAddressItemNeCell.h"

@implementation FNUpAddressItemNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    /** 姓 **/
    self.lastnameLB=[UILabel new];
    self.lastnameLB.backgroundColor=FNColor(200,200,200);
    self.lastnameLB.textColor=FNWhiteColor;
    self.lastnameLB.font=kFONT16;
    [self.contentView addSubview:self.lastnameLB];
    self.lastnameLB.textAlignment=NSTextAlignmentCenter;
    self.lastnameLB.cornerRadius=25;
    
    /** 名字 **/
    self.nameLabel=[UILabel new];
    self.nameLabel.textColor=FNBlackColor;
    self.nameLabel.font=kFONT14;
    [self.contentView addSubview:self.nameLabel];
    
    /** 编辑 **/
    self.compileButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.compileButton.titleLabel.font=kFONT12;
    [self.compileButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.compileButton setTitleColor:[UIColor grayColor] forState:0];
    [self.compileButton addTarget:self action:@selector(compileAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.compileButton];
    
    /** rightLine **/
    self.rightLine=[UILabel new];
    self.rightLine.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.rightLine];
    
    /** 电话 **/
    self.numberLabel=[UILabel new];
    self.numberLabel.textColor=FNBlackColor;
    self.numberLabel.font=kFONT12;
    self.numberLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.numberLabel];
    
    /** 地址 **/
    self.siteLabel=[UILabel new];
    self.siteLabel.numberOfLines=2;
    self.siteLabel.textColor=FNBlackColor;
    self.siteLabel.font=kFONT12;
    [self.contentView addSubview:self.siteLabel];
    
    
    /** 默认地址 **/
    self.defaultLB=[UILabel new];
    self.defaultLB.textColor=FNWhiteColor;
    self.defaultLB.backgroundColor=FNColor(255,57,61);
    self.defaultLB.font=kFONT12;
    self.defaultLB.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.defaultLB];
    self.defaultLB.cornerRadius=5;
    
    /** Line **/
    self.LineLB=[UILabel new];
    self.LineLB.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.LineLB];
    [self initializedSubviews];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    CGFloat interval_10 = 10;
    //商品BGView
    self.lastnameLB.sd_layout
    .leftSpaceToView(self.contentView, interval_10).heightIs(50).centerYEqualToView(self.contentView).widthIs(50);
    self.nameLabel.sd_layout
    .topSpaceToView(self.contentView, interval_10).leftSpaceToView(self.lastnameLB, interval_10).heightIs(25);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.compileButton.sd_layout
    .rightSpaceToView(self.contentView, interval_10).heightIs(25).centerYEqualToView(self.contentView).widthIs(50);
    
    self.rightLine.sd_layout
    .rightSpaceToView(self.compileButton, interval_10).heightIs(40).centerYEqualToView(self.contentView).widthIs(1);
    
    self.numberLabel.sd_layout
    .rightSpaceToView(self.rightLine, interval_10).heightIs(20).bottomEqualToView(self.nameLabel);
    [self.numberLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.siteLabel.sd_layout
    .leftSpaceToView(self.lastnameLB, interval_10).rightSpaceToView(self.rightLine, interval_10).heightIs(35).topSpaceToView(self.nameLabel, interval_10/2);
    
    self.defaultLB.sd_layout
    .leftSpaceToView(self.lastnameLB, interval_10).heightIs(20).topSpaceToView(self.siteLabel, interval_10/2).widthIs(60);
    
    self.LineLB.sd_layout
    .leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(1).bottomSpaceToView(self.contentView, 0);
   
    
}
-(void)setModel:(FNUpAddressNeModel*)model{
    _model=model;
    if(model){
        self.lastnameLB.text=model.surname;//@"王";
        self.nameLabel.text=model.name;//@"王小明";
        self.numberLabel.text=model.phone;//@"13177754536";
        self.siteLabel.text=model.detail_address;//@"广东省珠海市香洲区南屏镇南屏科技广场永和花园一栋六单元1421";
        NSInteger is_acquiesce=[model.is_acquiesce integerValue];
        if(is_acquiesce==1){
          self.defaultLB.text=@"默认地址";
          self.defaultLB.hidden=NO;
        }else{
          self.defaultLB.hidden=YES;
        }
        NSLog(@"is_acquiesce:%ld",(long)is_acquiesce);
        
    }
    [self.contentView setNeedsLayout];
}
-(void)compileAction{
    if ([self.delegate respondsToSelector:@selector(InAddressItemCopyreaderAction:)]) {
        [self.delegate InAddressItemCopyreaderAction:self.indexPath];
    } 
}
@end
