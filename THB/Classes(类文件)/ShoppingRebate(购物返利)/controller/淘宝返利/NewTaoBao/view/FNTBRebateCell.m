//
//  FNTBRebateCell.m
//  THB
//
//  Created by jimmy on 2017/10/31.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNTBRebateCell.h"
#import "FNTBRebateHotModel.h"
#import "FNHomeFunctionBtn.h"

#import "XYTitleModel.h"
@interface FNTBRebateCellHotElementView:UIView
@property (nonatomic, strong)UIImageView* bgimgview;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* subLabel;
@property (nonatomic, strong)UIImageView* proimgview;
@end
@implementation FNTBRebateCellHotElementView
- (UIImageView *)bgimgview{
    if (_bgimgview == nil) {
        _bgimgview = [UIImageView new];
    }
    return _bgimgview;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = kFONT15;
    }
    return _titleLabel;
}
- (UILabel *)subLabel{
    if (_subLabel == nil) {
        _subLabel = [UILabel new];
        _subLabel.font = kFONT13;
        _subLabel.textColor = FNGlobalTextGrayColor;
    }
    return _subLabel;
}
- (UIImageView *)proimgview{
    if (_proimgview == nil) {
        _proimgview = [UIImageView new];
        _proimgview.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _proimgview;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jm_setupViews];
    }
    return self;
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    //
    [self addSubview:self.bgimgview];
    [self.bgimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    [self addSubview:self.proimgview];
    [self.proimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_jm_margin10*3, 0, 0, 0)) excludingEdge:(ALEdgeLeft)];
    [self.proimgview autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self withMultiplier:0.5];
    
    UIView* view = [UIView new];
    [self addSubview:view];
    [view autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
    [view autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:self.proimgview withOffset:-5];
    [view autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [view addSubview:self.titleLabel];
    [self.titleLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    
    [view addSubview:self.subLabel];
    [self.subLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.subLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.subLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleLabel withOffset:5];
    [view autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.subLabel];
}
@end

@interface FNTBRebateCell()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray* hotviews;
@property (nonatomic, strong) NSMutableArray<FNTBRebateCellHotElementView *>* hoteleviews;
@property (nonatomic, strong) NSMutableArray* cateViews;
@property (nonatomic, strong) NSMutableArray<FNHomeFunctionBtn *>* catebtns;
@property (nonatomic, strong) UIScrollView* scrollview;
@property (nonatomic, strong) UIPageControl *pageControl;
@end
@implementation FNTBRebateCell

- (NSMutableArray *)cateViews
{
    if (_cateViews == nil) {
        _cateViews = [NSMutableArray new];
    }
    return _cateViews;
}
- (NSMutableArray<FNHomeFunctionBtn *> *)catebtns
{
    if (_catebtns == nil) {
        _catebtns = [NSMutableArray new];
    }
    return _catebtns;
}
- (NSMutableArray<FNTBRebateCellHotElementView *> *)hoteleviews{
    if (_hoteleviews == nil) {
        _hoteleviews  = [NSMutableArray new];
    }
    return _hoteleviews;
}
- (NSMutableArray *)hotviews
{
    if (_hotviews == nil) {
        _hotviews = [NSMutableArray new];
    }
    return _hotviews;
}
- (UIScrollView *)scrollview{
    if (_scrollview == nil) {
        _scrollview = [UIScrollView new];
        _scrollview.pagingEnabled = YES;
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.bounces = NO;
        _scrollview.delegate = self;
    }
    return _scrollview;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = UIColor.grayColor;
        _pageControl.currentPageIndicatorTintColor = RED;
        _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _pageControl;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self jm_setupViews];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/CGRectGetWidth(scrollView.bounds);
    self.pageControl.currentPage = page;
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    //
    [self.contentView addSubview:self.scrollview];
//    [self.scrollview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.bottom.offset(-20);
    }];
    
    [self.contentView addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(20);
    }];
}
- (void)setupHotview{
    if (self.hotviews.count>=1) {
        [self.hotviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.hotviews removeAllObjects];
        [self.hoteleviews removeAllObjects];
    }
    if (self.cateViews.count>=1) {
        [self.cateViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.cateViews removeAllObjects];
        [self.catebtns removeAllObjects];
    }
    NSInteger maxCount = 6;
    NSInteger maxColumn = 3;
    NSInteger column = ceil(self.hotsearchs.count/6.0);
    CGFloat margin = _jm_margin10;
    CGFloat width = (FNDeviceWidth-margin*(maxColumn+1))/maxColumn;
    CGFloat width1 = (FNDeviceWidth-margin*4)/3;
    CGFloat height = width1*0.7;
    
    self.pageControl.numberOfPages = (self.hotsearchs.count - 1) / maxCount + 1;
    self.pageControl.currentPage = 0;
    
    for (NSInteger i = 0; i < column; i++) {
        UIView* view = [[UIView alloc]initWithFrame:(CGRectMake(i*FNDeviceWidth, 0, FNDeviceWidth, height*2+margin*3))];
        for (NSInteger j = 0; j< maxCount; j++) {
            if (i*maxCount+j <= self.hotsearchs.count-1) {
           
                
                FNTBRebateCellHotElementView* eleview = [[FNTBRebateCellHotElementView alloc]initWithFrame:(CGRectMake((1+j% maxColumn)*margin+j%maxColumn*width, labs(j/maxColumn+1)*margin+labs(j/maxColumn)*height, width, height))];
                [eleview addJXTouchWithObject:^(FNTBRebateCellHotElementView* obj) {
                    //
                    NSInteger tag = obj.tag-100;
                    if (self.btnClicked) {
                        self.btnClicked(self.hotsearchs[tag].name,self.hotsearchs[tag].ID, NO);
                    }
                }];
                [view addSubview:eleview];
                [self.hoteleviews addObject:eleview];
            }
        }

        [self.scrollview addSubview:view];
        [self.hotviews addObject:view];
    }
    [self.hoteleviews enumerateObjectsUsingBlock:^(FNTBRebateCellHotElementView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = idx+100;
        obj.titleLabel.text = self.hotsearchs[idx].name;
        obj.subLabel.text = self.hotsearchs[idx].f_name;
        [obj.bgimgview setUrlImg:self.hotsearchs[idx].bj_img];
        [obj.proimgview setUrlImg:self.hotsearchs[idx].pic];
    }];
    
    self.scrollview.contentSize = CGSizeMake(FNDeviceWidth*column, height*2+margin*3);
}

- (void)setupCateview{
    if (self.hotviews.count>=1) {
        [self.hotviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.hotviews removeAllObjects];
        [self.hoteleviews removeAllObjects];
    }
    if (self.cateViews.count>=1) {
        [self.cateViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.cateViews removeAllObjects];
        [self.catebtns removeAllObjects];
    }
    NSInteger maxCount = 8;
    NSInteger maxColumn = 4;
    NSInteger column = ceil(self.categories.count/8.0);
    CGFloat margin = _jm_margin10;
    CGFloat width = (FNDeviceWidth-margin*(maxColumn+1))/maxColumn;
    CGFloat width1 = (FNDeviceWidth-margin*4)/3;
    CGFloat height = width1*0.7;
    
    self.pageControl.numberOfPages = (self.categories.count - 1) / maxCount + 1;
    self.pageControl.currentPage = 0;
    
    for (NSInteger i = 0; i < column; i++) {
        UIView* view = [[UIView alloc]initWithFrame:(CGRectMake(i*FNDeviceWidth, 0, FNDeviceWidth, height*2+margin*3))];
        for (NSInteger j = 0; j< maxCount; j++) {
            if (i*maxCount+j <= self.categories.count-1) {
                FNHomeFunctionBtn* btn = [[FNHomeFunctionBtn alloc]
                                          initWithFrame:(CGRectMake(
                                                                    (1+j% maxColumn)*margin+j%maxColumn*width,
                                                                    labs(j/maxColumn+1)*margin+labs(j/maxColumn)*height,
                                                                    width,
                                                                    height))
                                          title:@"" andImageURL:nil];
                [btn addJXTouchWithObject:^(FNHomeFunctionBtn* obj) {
                    NSInteger tag = obj.tag-1000;
                    if (self.btnClicked) {
                        self.btnClicked(self.categories[tag].keyword,self.categories[tag].id, NO);
                    }
                }];
                [view addSubview:btn];
                [self.catebtns addObject:btn];
            }
        }
        [self.scrollview addSubview:view];
        [self.cateViews addObject:view];
    }
    [self.catebtns enumerateObjectsUsingBlock:^(FNHomeFunctionBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = idx+1000;
        obj.titleLabel.text = self.categories[idx].category_name;
        if (self.categories[idx].category_name.length==0) {
            obj.titleLabel.text = self.categories[idx].name;
        }
        [obj.imgView setUrlImg:self.categories[idx].img];
    }];
    
    self.scrollview.contentSize = CGSizeMake(FNDeviceWidth*column, height*2+margin*3);
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNTBRebateCell";
    FNTBRebateCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNTBRebateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setCategories:(NSArray<XYTitleModel *> *)categories{
    _categories = categories;
    if (_categories.count>=1) {
        [self setupCateview];
    }
    
}
- (void)setHotsearchs:(NSArray<FNTBRebateHotModel *> *)hotsearchs{
    _hotsearchs = hotsearchs;
    if (_hotsearchs.count>=1) {
        [self setupHotview];
    }
}
@end
