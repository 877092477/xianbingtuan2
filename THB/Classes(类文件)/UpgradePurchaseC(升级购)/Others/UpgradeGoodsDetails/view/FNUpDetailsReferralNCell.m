//
//  FNUpDetailsReferralNCell.m
//  THB
//
//  Created by Jimmy on 2018/9/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpDetailsReferralNCell.h"

@implementation FNUpDetailsReferralNCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    NSArray *titles=@[@"商品介绍",@"参数规格"];
    self.ReferralBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 40)];
    self.ReferralBar.backgroundColor = FNWhiteColor;
    self.ReferralBar.is_middle=YES; 
    self.ReferralBar.itemsTitle = titles;
    self.ReferralBar.itemColor = FNBlackColor;
    self.ReferralBar.itemSelectedColor = FNMainGobalTextColor;
    self.ReferralBar.sliderColor = FNMainGobalTextColor;
    self.ReferralBar.fontSize=13;
    self.ReferralBar.SelectedfontSize=14;
    
    [self.ReferralBar slideBarItemSelectedCallback:^(NSUInteger index) {
        
        if ([self.delegate respondsToSelector:@selector(likeBtnClickAction:)]) {
            [self.delegate likeBtnClickAction:index];
        }
    }];
    //[self.contentView addSubview:self.ReferralBar];
    
    //商品介绍
    self.referralBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.referralBtn.titleLabel.font=kFONT13;
    self.referralBtn.selected=YES;
    self.referralBtn.frame=CGRectMake(0, 0, FNDeviceWidth/2, 40);
    [self.referralBtn setTitle:@"商品介绍" forState:UIControlStateNormal];
    [self.referralBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.referralBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.referralBtn addTarget:self action:@selector(referralBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:self.referralBtn];
    
    //规格参数
    self.parameterBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.parameterBtn.titleLabel.font=kFONT13;
    self.parameterBtn.frame=CGRectMake(FNDeviceWidth/2, 0, FNDeviceWidth/2, 40);
    [self.parameterBtn setTitle:@"规格参数" forState:UIControlStateNormal];
    [self.parameterBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.parameterBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.parameterBtn addTarget:self action:@selector(parameterBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:self.parameterBtn];
}
-(void)setPrintInt:(NSInteger)printInt{
    _printInt=printInt;
    if(printInt){
        
        //[self.ReferralBar selectSlideBarItemAtIndex:printInt];
        if(printInt==0){
            self.referralBtn.selected=YES;
            self.parameterBtn.selected=NO;
        }else{
            self.referralBtn.selected=NO;
            self.parameterBtn.selected=YES;
        }
    }
}
//商品介绍
-(void)referralBtnClick{
    self.referralBtn.selected=YES;
    self.parameterBtn.selected=NO;
    if ([self.delegate respondsToSelector:@selector(likeBtnClickAction:)]) {
        [self.delegate likeBtnClickAction:0];
    }
}
//规格参数
-(void)parameterBtnClick{
    self.referralBtn.selected=NO;
    self.parameterBtn.selected=YES;
    if ([self.delegate respondsToSelector:@selector(likeBtnClickAction:)]) {
        [self.delegate likeBtnClickAction:1];
    }
    
}
@end
