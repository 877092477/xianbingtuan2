//
//  FNConvertheaderFeCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConvertheaderFeCell.h"

@implementation FNConvertheaderFeCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNConvertheaderFeCellID";
    FNConvertheaderFeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    self.priceLB=[[UILabel alloc]init];
    [self addSubview:self.priceLB];
   
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(102, 102, 102);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    
    self.priceLB.font=[UIFont systemFontOfSize:24];
    self.priceLB.textColor=RGB(51, 51, 51);
    self.priceLB.textAlignment=NSTextAlignmentCenter;
    
    self.hintLB.font=[UIFont systemFontOfSize:12];
    self.hintLB.textColor=RGB(102, 102, 102);
    self.hintLB.textAlignment=NSTextAlignmentCenter;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self, 19).rightSpaceToView(self, 15).heightIs(20);
    
    self.priceLB.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self.titleLB, 18).rightSpaceToView(self, 15).heightIs(30);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self.priceLB, 9).rightSpaceToView(self, 15).heightIs(16);
    
    UIView *line=[UIView new];
    line.backgroundColor=RGB(240, 240, 240);
    [self addSubview:line]; 
    line.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(1);
    
}

-(void)setModel:(FNConvertfeModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.top_title;
        self.priceLB.text=model.top_qkb_count;
        self.hintLB.text=model.top_tips;
    }
}
@end
