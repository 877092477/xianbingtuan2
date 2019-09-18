//
//  FNmakeHeadItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmakeHeadItemCell.h"

@implementation FNmakeHeadItemCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNmakeHeadItemCellID";
    FNmakeHeadItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    self.numberLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    [self addSubview:self.numberLB];
    self.titleLB.font=kFONT14;
    self.titleLB.textColor=[UIColor whiteColor];
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    self.numberLB.textColor=[UIColor whiteColor];
    self.numberLB.textAlignment=NSTextAlignmentCenter;
    self.numberLB.font=kFONT17;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 5).rightSpaceToView(self, 5).topSpaceToView(self, 0).heightIs(20);
    
    self.numberLB.sd_layout
    .leftSpaceToView(self, 5).rightSpaceToView(self, 5).bottomSpaceToView(self, 5).heightIs(20);
    
}
-(void)setModel:(FNMakeJFTmodel *)model{
    _model=model;
    if (model) {
        
        self.numberLB.text=model.number;
        self.titleLB.text=model.detail;
        //self.numberLB.text=model.jf; 
        
    }
}
@end
