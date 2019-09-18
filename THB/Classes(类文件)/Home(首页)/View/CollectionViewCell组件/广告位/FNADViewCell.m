//
//  FNADViewCell.m
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNADViewCell.h"

@implementation FNADViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.index_threemodel_01List = [NSArray new];
        [self initializedSubviews];
        
    }
    
    return self;
}

- (void)initializedSubviews
{
    _adView = [[FNAdView  alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, 300)];
    [self.contentView addSubview:_adView];
    [_adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    _adView.layer.masksToBounds = YES;
    
}

-(void)setIndex_threemodel_01List:(NSArray *)index_threemodel_01List{
    _index_threemodel_01List = index_threemodel_01List;
    @WeakObj(self);
    
//    _adView.height = 0;
    //设置广告模块数据
    if (index_threemodel_01List.count>0) {
        NSMutableArray* images = [NSMutableArray new];
        
        for (NSDictionary *dict in index_threemodel_01List) {
            Index_threemodel_01Model *threemodel=[Index_threemodel_01Model mj_objectWithKeyValues:dict];
            [images addObject:threemodel.img];
            
        } 
            //计算高度
            CGFloat padding = 0;
            
            if (images.count>1) {
                //padding = 5;
            }
        
        UIImageView*image=[[UIImageView alloc]init];
        NSLog(@"ADimages:%@",images[0]);
//        [image sd_setImageWithURL:URL(images[0]) placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//            if (image && [image isKindOfClass:[UIImage class]]) {
//                CGFloat imgW = (JMScreenWidth-(padding*images.count+padding))/images.count;
//
////                _adView.height=image.size.height/image.size.width*imgW+padding*2;
//
//
////                [self.adView layoutIfNeeded];
//
//            }
//
//        }];
        
        _adView.imgArr = images;
        _adView.adViewClicked = ^(NSInteger index) {
            if (selfWeak.QuickClickedBlock) {
                selfWeak.QuickClickedBlock(index_threemodel_01List[index]);
            }
        };

       
        
        

        
    }
    
}

@end
