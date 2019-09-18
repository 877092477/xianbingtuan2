//
//  FNFamilyView.m
//  SuperMode
//
//  Created by jimmy on 2017/11/4.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNFamilyView.h"
#import "FNFamilyViewModel.h"
#import "FNPromotionalTeamCell.h"
#import "JMTitleScrollView.h"
@interface FNFamilyView()<JMTitleScrollViewDelegate>
{
    NSInteger cateState;
}
@property (nonatomic, strong)FNFamilyViewModel* viewmodel;
@property (nonatomic, strong)UIView* header;
@property (nonatomic, strong)JMTitleScrollView* cateview;
@property (nonatomic, strong)JMTitleScrollView* twoCateView;


@end
@implementation FNFamilyView
- (UIView *)header{
    if (_header == nil) {
        _header = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 50+50+44))];
        
        [_header addSubview:self.cateview];
        [_header addSubview:self.twoCateView];
        [self.cateview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
        [self.cateview autoSetDimension:(ALDimensionHeight) toSize:self.cateview.height];
        
        //[self.twoCateView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
        //[self.twoCateView autoSetDimension:(ALDimensionHeight) toSize:self.twoCateView.height];
        self.twoCateView.frame=CGRectMake(0, 50, JMScreenWidth, 50);
        UIView* tmpview = [UIView new];
        tmpview.backgroundColor = FNMainGobalControlsColor;
        [_header addSubview:tmpview];
        [tmpview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
        [tmpview autoSetDimension:(ALDimensionHeight) toSize:44];
        
        UILabel* titleLabel =[UILabel new];
        titleLabel.font = kFONT14;
        titleLabel.text = @"点亮星星的成员，代表已经成为联盟合伙人";
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.textColor = FNWhiteColor;
        [tmpview addSubview:titleLabel];
        [titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [titleLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        
        UIImage* img = IMAGE(@"family_star");
        [titleLabel addAttchmentImage:img andBounds:(CGRectMake(0, -3, img.size.width/img.size.height*20, 20)) atIndex:4];
        
    }
    return _header;
}
- (JMTitleScrollView *)cateview{
    if (_cateview == nil) {

        _cateview = [[JMTitleScrollView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 50)) titleArray:@[] fontSize:14 _textLength:10 andButtonSpacing:5 type:VariableType];

        _cateview.backgroundColor = FNWhiteColor;
        _cateview.tDelegate = self;
        _cateview.isShowIndicator = NO;
    }
    return _cateview;
}
- (JMTitleScrollView *)twoCateView{
    if (_twoCateView == nil) {

        _twoCateView = [[JMTitleScrollView alloc]initWithFrame:(CGRectMake(0, 50, JMScreenWidth, 50)) titleArray:@[] fontSize:14 _textLength:10 andButtonSpacing:0 type:VariableType];

        _twoCateView.backgroundColor = FNWhiteColor;
        _twoCateView.tDelegate = self;
        _twoCateView.isShowIndicator = NO;
    }
    return _twoCateView;
}

- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self.viewmodel =(FNFamilyViewModel*) viewModel;
    return  [super initWithViewModel:viewModel];
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    cateState=0;
    [self addSubview:self.header];
    [self.header autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.header autoSetDimension:(ALDimensionHeight) toSize:self.header.height];
    
    self.jm_tableview.alpha = 0;
    [self addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.jm_tableview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.header];
    
    @weakify(self);
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.viewmodel.jm_page = 1;
        [self.viewmodel.refreshDataCommand execute:nil];
    }];
}
- (void)jm_bindViewModel{
    @weakify(self);
    [[self.viewmodel.refreshHeader takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        NSMutableArray *titles=[[NSMutableArray alloc]init];
        NSMutableArray *twoTitles=[[NSMutableArray alloc]init];
        [self.viewmodel.Header enumerateObjectsUsingBlock:^(FNFamilyHeaderModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [titles addObject:obj.str];
        }];
        if(cateState==0){
          self.cateview.titleArray=titles;
        }
        
        //[self.cateview setBottomViewAtIndex:0];
        [self.viewmodel.twoHeader enumerateObjectsUsingBlock:^(FNFamilyHeaderModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [twoTitles addObject:obj.str];
        }];
        self.twoCateView.titleArray=twoTitles;
        [self.twoCateView setBottomViewAtIndex:0];
    }];
    
    [[self.viewmodel.refreshUI takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.jm_tableview reloadData];
        [UIView animateWithDuration:1.0 animations:^{
            self.jm_tableview.alpha = 1;
        }];
    }];
    
    [[self.viewmodel.refreshEndSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        JMRefreshDataStatus statu = [x integerValue];
        switch (statu) {
            case JMRefreshHeader_HasMoreData:
            {
                self.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.viewmodel.jm_page ++;
                    [self.viewmodel.refreshDataCommand execute:nil];
                }];
                [self.jm_tableview.mj_header endRefreshing];
                break;
            }
            case JMRefreshHeader_HasNoMoreData:{
                self.jm_tableview.mj_footer = nil;
                [self.jm_tableview.mj_header endRefreshing];
                break;
            }
            case JMRefreshFooter_HasMoreData:
            {
                [self.jm_tableview.mj_footer endRefreshing];
                break;
            }
            case JMRefreshFooter_HasNoMoreData:
            {
                [self.jm_tableview.mj_footer endRefreshingWithNoMoreData];
                break;
            }
            case JMRefreshError:{
                [self.jm_tableview.mj_header endRefreshing];
                [self.jm_tableview.mj_footer endRefreshing];
                break;
            }
                
            default:
                break;
        }
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewmodel.members.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNPromotionalTeamCell* cell = [FNPromotionalTeamCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.model = self.viewmodel.members[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = _ptc_cell_height;
    return height;
}

#pragma mark  -JMTitleScrollViewDelegate
- (void)clickedTitleView:(JMTitleScrollView *)titleView atIndex:(NSInteger)index{
    if(titleView==_cateview){
        cateState+=1;
        self.viewmodel.index = self.viewmodel.Header[index].lv;
        self.viewmodel.jm_page = 1;
        [SVProgressHUD show];
        //self.viewmodel.twoIndex= self.viewmodel.twoHeader[0].lv;
        //[self.twoCateView setBottomViewAtIndex:0];
        self.viewmodel.seletedState=1;
        [self.viewmodel.refreshDataCommand execute:nil];
    }else if(titleView==_twoCateView){
        XYLog(@"二级");
        self.viewmodel.twoIndex= self.viewmodel.twoHeader[index].lv;
        self.viewmodel.seletedState=2;
        [self.viewmodel.refreshDataCommand execute:nil];
        
    }
    
}
@end
