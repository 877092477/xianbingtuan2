//
//  FNDistrictWealthItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNDistrictWealthItemCell.h"

@implementation FNDistrictWealthItemCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNDistrictWealthItemCellID";
    FNDistrictWealthItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews{
    //55
    self.bgImgView=[[UIImageView alloc]init];
    self.bgImgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgImgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textColor=RGB(102, 102, 102);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.fullBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.addBtn];
    [self addSubview:self.fullBtn];
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 16).topSpaceToView(self, 0).rightSpaceToView(self, 10).bottomSpaceToView(self, 0);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 40).centerYEqualToView(self).heightIs(22).widthIs(165);
    
    self.addBtn.sd_layout
    .rightSpaceToView(self, 30).centerYEqualToView(self).heightIs(29).widthIs(64);
    
    self.fullBtn.sd_layout
    .rightSpaceToView(self, 105).centerYEqualToView(self).heightIs(29).widthIs(64);
    
    [self.addBtn addTarget:self action:@selector(addBtnAction)];
    
    [self.fullBtn addTarget:self action:@selector(fullBtnAction)];
    
}

-(void)addBtnAction{
    if ([self.delegate respondsToSelector:@selector(didDistrictWealthItemAddAction:)]) {
        [self.delegate didDistrictWealthItemAddAction:self.indexS];
    }
}
-(void)fullBtnAction{
    if ([self.delegate respondsToSelector:@selector(didDistrictWealthItemFullAction:)]) {
        [self.delegate didDistrictWealthItemFullAction:self.indexS];
    }
}
-(void)setModel:(FNDistrictCoinModel *)model{
    _model=model;
    if(model){
        [self.bgImgView setNoPlaceholderUrlImg:model.qkb_jf_bg];
    }
}

-(void)setItemModel:(FNDistrictCoinWealthItemModel *)itemModel{
    _itemModel=itemModel;
    if(itemModel){
//        NSString *numStr=itemModel.counts;
//        self.titleLB.text=itemModel.tip_words;
//        if([numStr kr_isNotEmpty]){
//            [self.titleLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:18] changeText:numStr];
//            [self.titleLB  fn_changeColorWithTextColor:RGB(51, 51, 51) changeText:numStr];
//        }
        
        if([itemModel.exchange_btn kr_isNotEmpty]){ 
            [self.addBtn sd_setBackgroundImageWithURL:URL(itemModel.exchange_btn) forState:UIControlStateNormal];
            self.fullBtn.sd_layout
            .rightSpaceToView(self, 105).centerYEqualToView(self).heightIs(29).widthIs(64);
            self.addBtn.hidden=NO;
        }else{
            self.addBtn.hidden=YES;
            self.fullBtn.sd_layout
            .rightSpaceToView(self, 30).centerYEqualToView(self).heightIs(29).widthIs(64);
        }
        if([itemModel.recharge_btn kr_isNotEmpty]){  
            [self.fullBtn sd_setBackgroundImageWithURL:URL(itemModel.recharge_btn) forState:UIControlStateNormal];
            self.fullBtn.hidden=NO;
        }else{
            self.fullBtn.hidden=YES;
        }
    }
}
@end
