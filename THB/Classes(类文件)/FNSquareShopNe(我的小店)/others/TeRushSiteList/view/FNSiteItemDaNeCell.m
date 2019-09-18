//
//  FNSiteItemDaNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/11/30.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//小店收货地址
#import "FNSiteItemDaNeCell.h"

@implementation FNSiteItemDaNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    
    //名字
    self.nameLabel=[UILabel new];
    self.nameLabel.textColor=FNBlackColor;
    self.nameLabel.font=kFONT16;
    [self.contentView addSubview:self.nameLabel];
    
    // 编辑
    self.compileButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.compileButton.titleLabel.font=kFONT12;
    [self.compileButton addTarget:self action:@selector(compileAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.compileButton]; 
    
    // 地址
    self.siteLabel=[UILabel new];
    //self.siteLabel.numberOfLines=2;
    self.siteLabel.textColor=FNBlackColor;
    self.siteLabel.font=kFONT14;
    [self.contentView addSubview:self.siteLabel];
    
    // 电话名字
    self.phoneNameLB=[UILabel new];
    self.phoneNameLB.font=kFONT13;
    [self.contentView addSubview:self.phoneNameLB];
    
    // Line
    self.LineLB=[UILabel new];
    self.LineLB.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.LineLB];
    [self initializedSubviews];
    
    
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    CGFloat interval_20 = 20;
    CGFloat interval_10 = 10;
    CGFloat interval_5 = 5;
    CGFloat interval_2 = 2.5;
    self.compileButton.sd_layout
    .rightSpaceToView(self.contentView, interval_20).heightIs(25).centerYEqualToView(self.contentView).widthIs(25);
    
    self.siteLabel.sd_layout
    .leftSpaceToView(self.contentView, interval_20).rightSpaceToView(self.compileButton, interval_10).heightIs(20).centerYEqualToView(self.contentView);
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.contentView, interval_20).heightIs(20).bottomSpaceToView(self.siteLabel, interval_2).rightSpaceToView(self.compileButton, interval_10);
    
    self.phoneNameLB.sd_layout
    .leftSpaceToView(self.contentView, interval_20).heightIs(20).topSpaceToView(self.siteLabel, interval_2).rightSpaceToView(self.compileButton, interval_10);
    
    self.LineLB.sd_layout
    .leftSpaceToView(self.contentView, interval_10).rightSpaceToView(self.contentView, interval_10).heightIs(1).bottomSpaceToView(self.contentView, 0);
    
    
}
-(void)setModel:(NSDictionary*)model{
    _model=model;
    if(model){
        NSArray *sexArr=@[@"男",@"女"];
        FNrushSiteDaNeModel *dataModel=[FNrushSiteDaNeModel mj_objectWithKeyValues:model];
        self.nameLabel.text=dataModel.long_address;//@"南屏科技广场";
        self.siteLabel.text=dataModel.address;//@"香洲区 南屏镇十二村永和花园一栋 1421栋";
        NSString *sexString=sexArr[dataModel.sex];
        self.phoneNameLB.text=[NSString stringWithFormat:@"%@(%@)  %@",dataModel.name,sexString,dataModel.phone];//@"王小明(先生)   13177754536";
        [self.compileButton setBackgroundImage:IMAGE(@"pay_icon_amend") forState:UIControlStateNormal];
        
//        self.lastnameLB.text=model.surname;//@"王";
//        self.nameLabel.text=model.name;//@"王小明";
//        self.numberLabel.text=model.phone;//@"13177754536";
//        self.siteLabel.text=model.detail_address;//@"广东省珠海市香洲区南屏镇南屏科技广场永和花园一栋六单元1421";
//        NSInteger is_acquiesce=[model.is_acquiesce integerValue];
//        if(is_acquiesce==1){
//            self.defaultLB.text=@"默认地址";
//            self.defaultLB.hidden=NO;
//        }else{
//            self.defaultLB.hidden=YES;
//        }
//        NSLog(@"is_acquiesce:%ld",(long)is_acquiesce);
        
    }
    [self.contentView setNeedsLayout];
}
-(void)compileAction{
    if ([self.delegate respondsToSelector:@selector(SiteItemCopyreaderAction:)]) {
        [self.delegate SiteItemCopyreaderAction:self.indexPath];
    }
}

@end
