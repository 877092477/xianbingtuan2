//
//  FNConvertHintfeCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConvertHintfeCell.h"

@implementation FNConvertHintfeCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNConvertHintfeCellID";
    FNConvertHintfeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(102, 102, 102);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).centerYEqualToView(self).rightSpaceToView(self, 15).heightIs(20);
    
    //self.titleLB.text=@"额外扣除￥0.10服务费（费率0.10%）";
    
    self.lineView=[UIView new];
    self.lineView.backgroundColor=RGB(240, 240, 240);
    [self addSubview:self.lineView];
    self.lineView.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(1);
}
-(void)setModel:(FNConvertfeModel *)model{
    _model=model;
    if(model){
       //self.titleLB.text=model.sxf_tips;
    }
}
@end
