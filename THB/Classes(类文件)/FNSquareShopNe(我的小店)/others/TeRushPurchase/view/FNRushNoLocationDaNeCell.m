//
//  FNRushNoLocationDaNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/11/30.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//无地址
#import "FNRushNoLocationDaNeCell.h"

@implementation FNRushNoLocationDaNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    self.contentView.backgroundColor=[UIColor whiteColor];
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:bgView];
    bgView.sd_layout
    .topEqualToView(self.contentView).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
    
    self.siteImage = [[UIImageView alloc]init];
    self.siteImage.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:self.siteImage];
    
    self.addImage = [[UIImageView alloc]init];
    self.addImage.backgroundColor=[UIColor whiteColor];
    [self.siteImage addSubview:self.addImage];
    
    self.writeLb = [[UILabel alloc]init];
    self.writeLb.font=kFONT17;
    [self.siteImage addSubview:self.writeLb];
    
    [self compositionFrame];
    
    self.siteImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *siteImagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(siteImageClick)];
    [self.siteImage addGestureRecognizer:siteImagetap];
    
}
-(void)compositionFrame{
    CGFloat space_10=10;
    CGFloat space_20=20;
    
    self.siteImage.sd_layout
    .leftSpaceToView(self.contentView, space_10).rightSpaceToView(self.contentView, space_10).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
    
    self.addImage.sd_layout
    .leftSpaceToView(self.siteImage, space_20).centerYEqualToView(self.siteImage).widthIs(25).heightIs(25);
    
    self.writeLb.sd_layout.centerYEqualToView(self.siteImage).leftSpaceToView(self.addImage, space_10).heightIs(25);
    [self.writeLb setSingleLineAutoResizeWithMaxWidth:150];  
    
    
}

-(void)siteImageClick{ 
    if ([self.delegate respondsToSelector:@selector(rushAddLoctionAction)]) {
        [self.delegate rushAddLoctionAction];
    }
}
-(void)setModel:(NSDictionary *)model{
    _model=model;
    if(model){
        FNrushBuyMsgModel *buyModel=[FNrushBuyMsgModel mj_objectWithKeyValues:model];
        
        if(![buyModel.address kr_isNotEmpty]){
            self.writeLb.text=@"填写地址";
            self.siteImage.image=IMAGE(@"pay_Address");
            self.addImage.image=IMAGE(@"pay_tab_add");
        }
        
    }
}
@end
