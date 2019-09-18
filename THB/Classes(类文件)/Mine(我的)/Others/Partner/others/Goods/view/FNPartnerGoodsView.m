//
//  FNPartnerGoodsView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerGoodsView.h"
#import "FNPartnerGoodsViewModel.h"
#import "FNPartnerGoodsCell.h"
#import "FNPartnerGoodsNewCell.h"
#import "FNPartnerGoodsFilter.h"
#import "FNFGFilterElementView.h"
#import "FNPartnerGoodsCateListView.h"
#import "FNPopUpTool.h"
@interface FNPartnerGoodsView()<UISearchBarDelegate>
@property (nonatomic, strong)FNPartnerGoodsViewModel* viewmodel;
@property (nonatomic, strong)FNPartnerGoodsFilter*  filter;
@property (nonatomic, strong)FNFGFilterElementView* elementview;
@property (nonatomic, strong)FNPartnerGoodsCateListView* categoryview;
@property (nonatomic, strong)FNPartnerGoodsCateListView* recommendview;
@property (nonatomic, strong) UIView *shareView;
@end
@implementation FNPartnerGoodsView{
    NSInteger chooseNum;
}

- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self.viewmodel =(FNPartnerGoodsViewModel *) viewModel;
    return  [super initWithViewModel:viewModel];
}

- (UIView *)shareView{
    if (_shareView==nil) {
        _shareView=[[UIView alloc]initWithFrame:CGRectMake(0, self.height, JMScreenWidth, 100)];
        _shareView.backgroundColor=FNWhiteColor;
        
        NSArray *titleArr=@[@"朋友圈",@"微信好友",@"微博",@"QQ"];
        NSArray *ImageArr=@[IMAGE(@"invite_circle"),IMAGE(@"invite_wechat"),IMAGE(@"weibo"),IMAGE(@"invite_qq")];
        CGFloat BtnW=JMScreenWidth/titleArr.count;
        [titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *Btn=[[UIButton alloc]initWithFrame:CGRectMake(idx*BtnW, 0, BtnW, 100)];
            Btn.tag=idx;
            [Btn setTitleColor:FNMainTextNormalColor forState:UIControlStateNormal];
            [Btn setTitle:obj forState:UIControlStateNormal];
            [Btn setImage:ImageArr[idx] forState:UIControlStateNormal];
            [Btn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_shareView addSubview:Btn];
            [Btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5.0];
        }];
    }
    return _shareView;
}

- (FNPartnerGoodsCateListView *)categoryview{
    if (_categoryview == nil) {
        _categoryview = [[FNPartnerGoodsCateListView alloc]initWithFrame:(CGRectMake(0, self.filter.height+JMNavBarHeigth, JMScreenWidth, 0))];
        _categoryview.selectedIndex = -1;
        @weakify(self);
        
        _categoryview.selectedBlock = ^(NSInteger index, NSString *string) {
            [FNPopUpTool hiddenAnimated:YES];
            @strongify(self);
            [self.filter.btns[0].titleLabel setTitle:string forState:(UIControlStateNormal)];
            self.filter.btns[0].selected = NO;
            self.viewmodel.cid  = self.viewmodel.categories[index].ID;
            self.viewmodel.jm_page = 1;
            [SVProgressHUD show];
            [self.viewmodel.refreshDataCommand execute:nil];
        };
    }
    return _categoryview;
}
- (FNPartnerGoodsCateListView *)recommendview{
    if (_recommendview == nil) {
        _recommendview = [[FNPartnerGoodsCateListView alloc]initWithFrame:(CGRectMake(0, self.filter.height+JMNavBarHeigth, JMScreenWidth, 0))];
        _recommendview.selectedIndex = 0;
        @weakify(self);
        _recommendview.selectedBlock = ^(NSInteger index, NSString *string) {
            [FNPopUpTool hiddenAnimated:YES];
            @strongify(self);
            [self.filter.btns[1].titleLabel setTitle:string forState:(UIControlStateNormal)];
            self.filter.btns[1].selected = NO;
            self.viewmodel.sort  = @(index+1);
            self.viewmodel.jm_page = 1;
            [SVProgressHUD show];
            [self.viewmodel.refreshDataCommand execute:nil];
        };
    }
    return _recommendview;
}
- (FNFGFilterElementView *)elementview{
    if (_elementview == nil) {
        @weakify(self);
        _elementview = [[FNFGFilterElementView alloc]initWithFrame:(CGRectMake(0, self.filter.height+JMNavBarHeigth, JMScreenWidth, 0))];
        _elementview.types = @[];
        _elementview.btnClickedAction = ^{
            @strongify(self);
            [FNPopUpTool hiddenAnimated:YES];
            if (self.elementview.selectedIndex>0) {
                self.viewmodel.source = @(self.elementview.selectedIndex+1);
            }
            self.viewmodel.start_price=self.elementview.lowprice;
            self.viewmodel.end_price=self.elementview.highprice;
            self.viewmodel.jm_page = 1;
            [SVProgressHUD show];
            [self.viewmodel.refreshDataCommand execute:nil];
        };
    }
    return _elementview;
}
- (FNPartnerGoodsFilter *)filter{
    if (_filter == nil) {
        _filter = [[FNPartnerGoodsFilter alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 0))];
        _filter.titles = @[@"商品分类",@"每日必推",@"筛选"];
        @weakify(self);
        _filter.searchbar.delegate = self;
        _filter.filterClicked = ^(PGFFilterType type,FNCombinedButton* btn) {
            @strongify(self);
            switch (type) {
                case PGFFilterTypeCategory:
                {
                    if (self.viewmodel.categories.count>=1) {
                        self.categoryview.list = self.viewmodel.cateNames;
                        [FNPopUpTool showViewWithContentView:self.categoryview withDirection:(FMPopupAnimationDirectionNone) finished:^{
                            btn.selected = NO;
                        }];
                    }else{
                        [SVProgressHUD show];
                        [self.viewmodel.categorycommand execute:nil];
                    }
                    break;
                    
                }
                case PGFFilterTypeRecommend:
                {
                    self.recommendview.list = @[@"每日必推",@"价格低到高",@"最新",@"销量"];
                    [FNPopUpTool showViewWithContentView:self.recommendview withDirection:(FMPopupAnimationDirectionNone) finished:^{
                        btn.selected = NO;
                    }];
                    break;
                    
                }
                case PGFFilterTypeFilter:
                {
                    [FNPopUpTool showViewWithContentView:self.elementview withDirection:(FMPopupAnimationDirectionNone) finished:^{
                        //
                        btn.selected = NO;
                    }];
                    break;
                    
                }
                    
                default:
                    break;
            }
        };
    }
    return _filter;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self addSubview:self.filter];
    [self.filter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@(self.filter.height));
    }];
    
    [self addSubview:self.shareView];
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@(self.shareView.height));
        make.height.equalTo(@(self.shareView.height));
    }];
    
    self.jm_tableview.alpha = 0;
    [self addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.filter.mas_bottom).offset(0);
        make.bottom.equalTo(self.shareView.mas_top).offset(0);
        make.left.right.equalTo(@0);
    }];
    
    @weakify(self);
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.viewmodel.jm_page = 1;
        [self.viewmodel.refreshDataCommand execute:nil];
    }];
}
- (void)jm_bindViewModel{
    
    [SVProgressHUD show];
    @weakify(self);
    [self.viewmodel.refreshDataCommand execute:nil];
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
    
    
    [self.viewmodel.categorycommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.categoryview.list = self.viewmodel.cateNames;
        [FNPopUpTool showViewWithContentView:self.categoryview withDirection:(FMPopupAnimationDirectionNone) finished:nil];
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewmodel.products.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    FNPartnerGoodsCell* cell = [FNPartnerGoodsCell cellWithTableView:tableView atIndexPath:indexPath];
//    cell.OnlyChangeStyle=self.isPL;
//    cell.model = self.viewmodel.products[indexPath.row];
//    cell.sharerightNow = ^(FNBaseProductModel *model) {
//        [self.viewmodel.cellClickSubject sendNext:model];
//    };
//    return cell;
    FNPartnerGoodsNewCell* cell = [FNPartnerGoodsNewCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.OnlyChangeStyle=self.isPL;
    cell.model = self.viewmodel.products[indexPath.row];
    cell.sharerightNow = ^(FNBaseProductModel *model) {
            [self.viewmodel.cellClickSubject sendNext:model];
    };
    return cell; 
    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = _pgc_cell_height;
    if (isIphone5) {
        height -= 20;
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.isPL==YES){
        if (chooseNum<9) {
            self.viewmodel.products[indexPath.row].isChoose=!self.viewmodel.products[indexPath.row].isChoose;
            FNPartnerGoodsNewCell* cell = (FNPartnerGoodsNewCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.chooseBtn.selected=self.viewmodel.products[indexPath.row].isChoose;
            if (self.viewmodel.products[indexPath.row].isChoose==YES) {
                chooseNum++;
            }else{
                chooseNum--;
            }
        }else{
            [FNTipsView showTips:@"亲，一次最多只能分享9个商品哦~~"];
        }
    }else{
        FNBaseProductModel *model=self.viewmodel.products[indexPath.row];
        self.selectCommodityType(model);
    }
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    self.viewmodel.keyword = searchBar.text;
    [SVProgressHUD show];
    self.viewmodel.jm_page = 1;
    [self.viewmodel.refreshDataCommand execute:nil];
}

#pragma mark - Action
- (void)BtnAction:(UIButton *)sender{
    __block NSString *ShareFnuo_id=@"";
    [self.viewmodel.products enumerateObjectsUsingBlock:^(FNPartnerGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isChoose==YES) {
            if (ShareFnuo_id.length==0) {
                ShareFnuo_id=obj.fnuo_id;
            }else{
                ShareFnuo_id=[NSString stringWithFormat:@"%@,%@",ShareFnuo_id,obj.fnuo_id];
            }
        }
    }];
    if (ShareFnuo_id.length==0) {
        [FNTipsView showTips:@"请选择分享商品"];
        return;
    }
    if (self.PlShareType) {
        self.PlShareType(sender.tag, ShareFnuo_id);
    }
}

-(void)setIsPL:(BOOL)isPL{
    _isPL=isPL;
    chooseNum=0;
    if (_isPL==YES) {
        [self.shareView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
        }];
    }else{
        [self.shareView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(self.shareView.height));
        }];
    }
    [self.viewmodel.products enumerateObjectsUsingBlock:^(FNPartnerGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isChoose=NO;
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:idx inSection:0];
        FNPartnerGoodsNewCell* cell = (FNPartnerGoodsNewCell *)[self.jm_tableview cellForRowAtIndexPath:indexPath];
        cell.OnlyChangeStyle=isPL;
    }];
}

@end

