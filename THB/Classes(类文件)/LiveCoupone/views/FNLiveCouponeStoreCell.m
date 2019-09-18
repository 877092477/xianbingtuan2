//
//  FNLiveCouponeStoreCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveCouponeStoreCell.h"

#define _quick_menuH  147
#define _quick_pageH   20

@interface FNLiveCouponeStoreCell()<UIScrollViewDelegate>

//快速入口数据数组（index_kuaisurukou_01）
@property (nonatomic, strong)NSArray *index_store_01List;

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray<UIImageView*> *images;

@property(nonatomic,strong)UIPageControl *pageControl;

@end

@implementation FNLiveCouponeStoreCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews
{
    _images = [[NSMutableArray alloc] init];
    
    self.functionbgimgview = [UIImageView new];
    self.functionbgimgview.clipsToBounds = YES;
//    [self.functionbgimgview setUrlImg:[FNBaseSettingModel settingInstance].ksrk];
    [self.contentView addSubview:self.functionbgimgview];
    
    
    _lblTitle = [[UILabel alloc] init];
    [self.contentView addSubview:_lblTitle];
    
    _scrollView = [[UIScrollView alloc] init];
    [self.contentView addSubview:_scrollView];
    
//    [self.functionbgimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    [self.functionbgimgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.bottom.equalTo(self.scrollView);
    }];
    
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.right.lessThanOrEqualTo(@-10);
        make.height.mas_equalTo(18);
    }];
    
    
    _lblTitle.text = @"商家推荐";
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = [UIFont systemFontOfSize:17];
    
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(8);
        make.height.mas_equalTo(108);
    }];
    
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(FNDeviceWidth/2,144,0,20)];
    _pageControl.currentPage=0;
    
    [_pageControl setCurrentPageIndicatorTintColor:FNMainGobalTextColor];
    [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    
    [self.contentView addSubview:_pageControl];
    self.backgroundColor = FNWhiteColor;
}

-(void)setIndex_store_01List:(NSArray *)index_store_01List withColumn: (int)column{
    
    _index_store_01List = index_store_01List;
    
    for (UIImageView *v in self.images) {
        [v removeFromSuperview];
    }
    [self.images removeAllObjects];
    
    if (index_store_01List.count <= 0)
        return;
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (index_store_01List.count <= column) {
            make.height.mas_equalTo(54);
        } else {
            make.height.mas_equalTo(108);
        }
    }];
    
    [self.functionbgimgview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        if (index_store_01List.count <= column * 2) {
            
            make.bottom.equalTo(self.scrollView);
        } else {
            
            make.bottom.equalTo(self.scrollView).offset(20);
        }
    }];
    
    CGFloat padding = 12;
//    CGFloat width = XYScreenWidth / 4 - padding * 2;
    CGFloat width = 70;
    CGFloat height = width / 70 * 30;
    
    NSInteger max_page = (index_store_01List.count - 1) / (column * 2) + 1;
    
    _pageControl.numberOfPages=max_page;
    _pageControl.hidden = max_page <= 1;
    
    for (NSInteger index = 0; index < max_page * column * 2; index++) {
        
        NSInteger page = index / (column * 2);
        NSInteger row = (index / 4) % 2;
        
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.scrollView addSubview:imgView];
        [self.images addObject:imgView];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(padding + (index % column) * (width + 2 * padding) + page * XYScreenWidth));
            make.top.equalTo(@(padding + row * (height + 2 * padding)));
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
            make.right.lessThanOrEqualTo(@(-padding));
        }];
        
        if (index < index_store_01List.count) {
            NSDictionary *dict = index_store_01List[index];
            Index_kuaisurukou_01Model *kuaisurukou=[Index_kuaisurukou_01Model mj_objectWithKeyValues:dict];
            [imgView sd_setImageWithURL:URL(kuaisurukou.img)];
        }
        
        NSInteger i = index;
        @weakify(self)
        [imgView addJXTouch:^{
            @strongify(self)
            if (self.QuickClickedBlock) {
                self.QuickClickedBlock(self.index_store_01List[i]);
            }
        }];
        
    }
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    _pageControl.currentPage = page;
    _pageControl.currentPage=page;
    
}

@end
