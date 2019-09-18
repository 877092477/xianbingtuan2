//
//  FNDistrictTextItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNDistrictTextItemCell.h"

@interface FNDistrictTextItemCell()

@property (nonatomic, strong) UIImageView *imgRight;

@end

@implementation FNDistrictTextItemCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNDistrictTextItemCellID";
    FNDistrictTextItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    //54
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    self.lineView.backgroundColor=RGB(250, 250, 250);
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 19).centerYEqualToView(self).heightIs(19).widthIs(200);
    self.lineView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomEqualToView(self).heightIs(1);
    
    _imgRight = [[UIImageView alloc] init];
    _imgRight.image = IMAGE(@"FN_dk_rightimg");
    [self.contentView addSubview:_imgRight];
    [_imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.centerY.equalTo(@0);
    }];
    
}
-(void)setModel:(FNDistrictCoinModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.qkb_jymx;
    } 
}
@end
