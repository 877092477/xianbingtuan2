//
//  FNArtcleHeadCView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArtcleHeadCView.h"

@implementation FNArtcleHeadCView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //[self initializedSubviews];
    }
    return self;
}

//- (void)initializedSubviews{
//    //分类view
//    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 45)];
//    self.categoryView.delegate = self;
//    self.categoryView.titleColorGradientEnabled = YES;
//    //lineView
//    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
//    self.lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
//    //文字体大小颜色
//    self.categoryView.titleFont=kFONT15;
//    self.categoryView.titleSelectedFont=kFONT17;
//    self.categoryView.titleColor=RGB(34, 34, 34);
//    self.categoryView.titleSelectedColor=RGB(251, 155, 31);
//    //line颜色
//    self.lineView.indicatorColor=RGB(251, 155, 31);
//    self.lineView.indicatorHeight=4;
//    self.categoryView.indicators = @[self.lineView];
//    [self addSubview:self.categoryView];
//
//
//
//}
//- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
//    //XYLog(@"选择%ld",(long)index);
//    if ([self.delegate respondsToSelector:@selector(didArtcleHeadCViewItemAction:)]) {
//        [self.delegate didArtcleHeadCViewItemAction:index];
//    }
//}
//-(void)setTitleArr:(NSArray *)titleArr{
//    _titleArr=titleArr;
//    if(titleArr){
//        //文字体大小颜色
//        NSArray *cateArr=titleArr;
//
//        FNExpertSortNaNodel *itemModel=[FNExpertSortNaNodel mj_objectWithKeyValues:cateArr[0]];
//        NSMutableArray *dataArray=[NSMutableArray arrayWithCapacity:0];
////        [cateArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////            FNExpertSortNaNodel *model=[FNExpertSortNaNodel mj_objectWithKeyValues:obj];
////            [dataArray addObject:model.name];
////        }];
//        for (NSDictionary *dic in titleArr) {
//            FNExpertSortNaNodel *model=[FNExpertSortNaNodel mj_objectWithKeyValues:dic];
//            [dataArray addObject:model.name];
//        }
//        self.categoryView.titleFont=kFONT15;
//        self.categoryView.titleSelectedFont=kFONT17;
//        self.categoryView.titleColor=[UIColor colorWithHexString:itemModel.color];//RGB(34, 34, 34);
//        self.categoryView.titleSelectedColor=[UIColor colorWithHexString:itemModel.check_color];//RGB(251, 155, 31);
//        //line颜色
//        self.lineView.indicatorColor=[UIColor colorWithHexString:itemModel.check_color];//RGB(251, 155, 31);
//        self.lineView.indicatorHeight=4;
//        self.categoryView.titles =dataArray;
//
//        
//    }
//}
//

@end
