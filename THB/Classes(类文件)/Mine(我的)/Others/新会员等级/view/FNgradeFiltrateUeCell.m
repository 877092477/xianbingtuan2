//
//  FNgradeFiltrateUeCell.m
//  THB
//
//  Created by 李显 on 2019/1/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNgradeFiltrateUeCell.h"

@implementation FNgradeFiltrateUeCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"gradeFiltrateUeCellID";
    FNgradeFiltrateUeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.btns = [NSMutableArray new];
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{  
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate=self;
    self.searchBar.backgroundImage = [UIImage createImageWithColor:FNWhiteColor];
    self.searchBar.placeholder=@"搜索手机号码查询";
    self.searchBar.cornerRadius=27/2;
    self.searchBar.borderWidth=0.5;
    self.searchBar.borderColor = RGB(165,165,165);
    self.searchBar.clipsToBounds = YES;
    [self.searchBar setBackgroundColor:FNWhiteColor];
    self.searchBar.backgroundImage = [UIImage createImageWithColor:FNWhiteColor];
    [self addSubview:self.searchBar];
    [self.searchBar setImage:IMAGE(@"FJ_slices_img") forSearchBarIcon:UISearchBarIconSearch  state:UIControlStateNormal];
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    if (searchField) {
        searchField.width=100;
        if ([self.searchBar.placeholder kr_isNotEmpty]) {
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.searchBar.placeholder attributes:
                                              @{NSForegroundColorAttributeName:RGB(165,165,165),
                                                NSFontAttributeName:[UIFont systemFontOfSize:12]}];
            searchField.attributedPlaceholder = attrString;
        }
    }
    
    self.dateLB=[UILabel new];
    self.dateLB.textColor=RGB(153,153,153);
    self.dateLB.font=kFONT12;
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.dateLB];
    
    self.screenView = [[UIView alloc]initWithFrame:(CGRectMake(20, 44, FNDeviceWidth-40, 26))];
    self.screenView.cornerRadius=26/2;
    [self addSubview:self.screenView];
    
    self.bgImageView=[UIImageView new];
    self.bgImageView.cornerRadius=26/2;
    self.bgImageView.backgroundColor =  RGB(165,165,165);
    [self.screenView addSubview:self.bgImageView];
    
    self.searchBar.sd_layout
    .topSpaceToView(self, 8).rightSpaceToView(self, 23).heightIs(27).widthIs(180);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self, 30).rightSpaceToView(self.searchBar, 5).centerYEqualToView(self.searchBar).heightIs(15);
    
    self.screenView.sd_layout
    .leftSpaceToView(self, 20).rightSpaceToView(self, 20).bottomSpaceToView(self, 10).heightIs(26);
    
    self.bgImageView.sd_layout
    .leftSpaceToView(self.screenView, 0).rightSpaceToView(self.screenView, 0).bottomSpaceToView(self.screenView, 0).topSpaceToView(self.screenView, 0);
    
    
}

-(void)setModel:(FNgradeHeadModel *)model{
    _model=model;
    if(model){
        self.dateLB.text=model.update_time;//@"更新时间：2018-12-21";
        self.searchBar.placeholder=model.search_str;//@"搜索手机号码查询";
        [self.bgImageView setNoPlaceholderUrlImg:model.bg_img];
        NSMutableArray *name=[[NSMutableArray alloc]init];
        NSString *strColor=@"FFFFFF";
        if (model.list.count>0) {
            FNgradeSortItemModel *onemodel=[FNgradeSortItemModel mj_objectWithKeyValues:model.list[0]];
            strColor=onemodel.str_color;
            [model.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNgradeSortItemModel *model=[FNgradeSortItemModel mj_objectWithKeyValues:obj];
                
                [name addObject:model.str];
            }];
        }
        if (self.btns.count>=1) {
            [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self.btns removeAllObjects];
        }
        CGFloat width = (FNDeviceWidth-40)*0.25;
        [name enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNgradeSortItemModel *onemodel=[FNgradeSortItemModel mj_objectWithKeyValues:model.list[idx]];
            NSInteger is_up=[onemodel.is_up integerValue];
            FNCombinedButton* tmpview = nil;
            tmpview.userInteractionEnabled=YES;
            //if (idx<2) {
            if (is_up==0) {
                FNCombinedButton* btn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"") selectedImage:IMAGE(@"") title:obj font:kFONT13 titleColor:[UIColor colorWithHexString:strColor] selectedTitleColor:[UIColor colorWithHexString:strColor] target:self action:nil];
                [self.screenView addSubview:btn];
                tmpview  = btn;
            }else{
                FNCombinedButton* btn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"FN_SX_sortImg") selectedImage:IMAGE(@"FJ_orSH_SJ") title:obj font:kFONT12 titleColor:[UIColor colorWithHexString:strColor] selectedTitleColor:[UIColor colorWithHexString:strColor] target:self action:nil];
                [btn.titleLabel sd_setImageWithURL:[NSURL URLWithString:model.sort_img] forState:UIControlStateNormal];
                [btn.titleLabel sd_setImageWithURL:[NSURL URLWithString:model.sort_ascimg] forState:UIControlStateSelected];
                
                btn.tag = idx+100;
                [self.screenView addSubview:btn];
                tmpview  = btn;
            }
            [tmpview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, width*idx, 0, 0)) excludingEdge:(ALEdgeRight)];
            [tmpview autoSetDimension:(ALDimensionWidth) toSize:width];
            tmpview.tag = idx+100;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [tmpview addGestureRecognizer:tap];
            [self.btns addObject:tmpview];
        }];
        
    }
}
#pragma mark - action
-(void)tapClick:(id)sender{
    UITapGestureRecognizer * singleTap = (UITapGestureRecognizer *)sender;
    
    UIView *tmp =nil;
    
    UIView *view = (UIView *)singleTap.view;
    
    NSInteger index = view.tag;
    
    NSInteger tag = index-100;
    NSString *strColor=@"FFFFFF";
    if (self.model.list.count>0) {
        FNgradeSortItemModel *onemodel=[FNgradeSortItemModel mj_objectWithKeyValues:self.model.list[0]];
        strColor=onemodel.str_color;
    }
    FNgradeSortItemModel *seletedmodel=[FNgradeSortItemModel mj_objectWithKeyValues:self.model.list[tag]];
    NSInteger is_up=[seletedmodel.is_up integerValue];
    //if (tag==0||tag==1) {
    if (is_up==0) {
        FNCombinedButton* btn = self.btns[tag];
        tmp= btn;
        if ([self.delegate respondsToSelector:@selector(filtrateIntegralClickWithPlace:WithState:)]) {
            [self.delegate filtrateIntegralClickWithPlace:tag WithState:1];
        }
    }else{
        FNCombinedButton* btn = self.btns[tag];
        btn.titleLabel.selected=!btn.titleLabel.selected;
        //[btn.titleLabel setImage:IMAGE(@"FJ_orX_SJ") forState:UIControlStateNormal];
        //[btn.titleLabel setImage:IMAGE(@"FJ_orSH_SJ") forState:UIControlStateSelected];
        [btn.titleLabel sd_setImageWithURL:[NSURL URLWithString:self.model.sort_descimg] forState:UIControlStateNormal];
        [btn.titleLabel sd_setImageWithURL:[NSURL URLWithString:self.model.sort_ascimg] forState:UIControlStateSelected];
        
        [btn.titleLabel setTitleColor:[UIColor colorWithHexString:strColor] forState:UIControlStateNormal];
        [btn.titleLabel setTitleColor:[UIColor colorWithHexString:strColor] forState:UIControlStateSelected];
        tmp = btn;
        NSInteger state=0;
        if( btn.titleLabel.selected==YES){
            state=1;
        }else{
            state=0;
        }
        if ([self.delegate respondsToSelector:@selector(filtrateIntegralClickWithPlace:WithState:)]) {
            [self.delegate filtrateIntegralClickWithPlace:tag WithState:state];
        }
    }
    [self.btns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNgradeSortItemModel *enmodel=[FNgradeSortItemModel mj_objectWithKeyValues:self.model.list[idx]];
        NSInteger enis_up=[enmodel.is_up integerValue];
        //if (idx<2) {
        if (enis_up==0) {
            FNCombinedButton* btn = obj;
            btn.selected = btn==tmp;
        }else{
            if(idx!=tag){
                FNCombinedButton* btn = obj;
                btn.titleLabel.selected=NO;
                //[btn.titleLabel setImage:IMAGE(@"FJ_gray_sj") forState:UIControlStateNormal];
                [btn.titleLabel sd_setImageWithURL:[NSURL URLWithString:self.model.sort_img] forState:UIControlStateNormal];
                
                [btn.titleLabel setTitleColor:[UIColor colorWithHexString:strColor] forState:UIControlStateNormal];
                btn.selected = btn==tmp;
            }
        }
    }];
}
-(void)setSortPalce:(NSInteger)sortPalce{
    _sortPalce=sortPalce;
    if(self.btns.count>0){
       // [self sortPitchon:sortPalce];
        NSString *strColor=@"FFFFFF";
        if (self.model.list.count>0) {
            FNgradeSortItemModel *onemodel=[FNgradeSortItemModel mj_objectWithKeyValues:self.model.list[0]];
            strColor=onemodel.str_color;
        }
        UIView *tmp =nil;
        FNCombinedButton* btn = self.btns[sortPalce];
        tmp= btn;
        [self.btns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNgradeSortItemModel *enmodel=[FNgradeSortItemModel mj_objectWithKeyValues:self.model.list[idx]];
            NSInteger enis_up=[enmodel.is_up integerValue];
            //if (idx<2) {
            if (enis_up==0) {
                FNCombinedButton* btn = obj;
                btn.selected = btn==tmp;
            }else{
                if(idx!=sortPalce){
                    FNCombinedButton* btn = obj;
                    btn.titleLabel.selected=NO;
                    //[btn.titleLabel setImage:IMAGE(@"FJ_gray_sj") forState:UIControlStateNormal];
                    [btn.titleLabel sd_setImageWithURL:[NSURL URLWithString:self.model.sort_img] forState:UIControlStateNormal];

                    [btn.titleLabel setTitleColor:[UIColor colorWithHexString:strColor] forState:UIControlStateNormal];
                    btn.selected = btn==tmp;
                }
            }
        }];
    }
}
-(void)sortPitchon:(NSInteger)send{
    UIView *view =[self viewWithTag:send + 100];
    view.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [view addGestureRecognizer:tap];
    [self tapClick:tap];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([self.delegate respondsToSelector:@selector(filtrateIntegralPhone:)]) { 
        [self.delegate filtrateIntegralPhone:searchBar.text];
         [self.searchBar resignFirstResponder];
    }
}
@end
