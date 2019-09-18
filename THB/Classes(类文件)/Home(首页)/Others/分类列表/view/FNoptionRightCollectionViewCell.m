//
//  FNoptionRightCollectionViewCell.m
//  THB
//
//  Created by Jimmy on 2018/9/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNoptionRightCollectionViewCell.h"
#import "FNLeftclassifyModel.h"
@implementation FNoptionRightCollectionViewCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"rightClassifycellId";
    FNoptionRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}


-(void)initUI{
    //商品图片
    self.classifyImage=[UIImageView new];
    self.classifyImage.contentMode=UIViewContentModeScaleToFill;
    self.classifyImage.userInteractionEnabled = YES;
    [self.contentView addSubview:self.classifyImage];
    
    //商品标题
    self.nameLB=[UILabel new];
    self.nameLB.textColor=FNBlackColor;
    self.nameLB.font=kFONT12;
    self.nameLB.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLB];
    
    self.classifyImage.sd_layout
    .centerXEqualToView(self.contentView).topSpaceToView(self.contentView, 5).widthIs(60).heightIs(60);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).topSpaceToView(self.classifyImage, 5).heightIs(15);
    
}
-(void)setModel:(FNRightclassifyModel *)model{
    _model = model; 
    if (model) {
        NSLog(@"category_name:%@",model.category_name);
        [self.classifyImage setUrlImg:model.img];
        self.nameLB.text=model.catename;
    }
}
@end
