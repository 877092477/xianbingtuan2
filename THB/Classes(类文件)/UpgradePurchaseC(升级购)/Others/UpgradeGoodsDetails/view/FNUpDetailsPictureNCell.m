//
//  FNUpDetailsPictureNCell.m
//  THB
//
//  Created by Jimmy on 2018/9/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpDetailsPictureNCell.h"

@implementation FNUpDetailsPictureNCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
        
    }
    return self;
}
-(void)setCompositionView{
    self.imgBgview=[UIView new];
    [self.contentView addSubview:self.imgBgview];
    [self.imgBgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    self.imgview = [UIImageView new];
    [self.imgBgview addSubview:self.imgview];
    //[self.imgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    self.imgview.sd_layout.leftSpaceToView(self.imgBgview, 10).rightSpaceToView(self.imgBgview, 10).bottomSpaceToView(self.imgBgview, 0).topSpaceToView(self.imgBgview, 0);
}
- (void)setImage:(NSString *)image{
    _image = image;
    if (_image) {
        [self.imgview sd_setImageWithURL:[NSURL URLWithString:_image] placeholderImage:IMAGE(@"APP底图") completed:^(UIImage *ima, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (ima) {
                self.imgconh.constant = ima.size.height/ ima.size.width*JMScreenWidth;
            }
        }];
    }
}
@end
