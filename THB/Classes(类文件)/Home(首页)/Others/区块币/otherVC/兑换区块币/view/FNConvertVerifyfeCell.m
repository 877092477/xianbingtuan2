//
//  FNConvertVerifyfeCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConvertVerifyfeCell.h"

@implementation FNConvertVerifyfeCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNConvertVerifyfeCellID";
    FNConvertVerifyfeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    
    self.verifyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.verifyBtn];
    
    self.verifyBtn.titleLabel.font=[UIFont systemFontOfSize:15]; 
    
    self.verifyBtn.sd_layout
    .leftSpaceToView(self, 28).centerYEqualToView(self).rightSpaceToView(self, 28).heightIs(50);
    //self.verifyBtn.backgroundColor=RGB(232, 232, 232);
    self.verifyBtn.cornerRadius=25;
}
-(void)setModel:(FNConvertfeModel *)model{
    _model=model;
    if(model){
         
    }
}
@end
