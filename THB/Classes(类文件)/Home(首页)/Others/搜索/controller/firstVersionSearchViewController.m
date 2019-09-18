//
//  firstVersionSearchViewController.m
//  THB
//
//  Created by Fnuo-iOS on 2018/5/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "firstVersionSearchViewController.h"
#import "FNGoodsListViewController.h"
#import "FNSearchTipsAlertView.h"

@interface firstVersionSearchViewController ()<FNSearchTipsAlertViewDelegate>

@property (nonatomic, strong) FNSearchTipsAlertView *tipsAlert;

@end

@implementation firstVersionSearchViewController{
    NSMutableArray *title;
    NSInteger ColumnSelectIndex;
}

- (NSMutableArray *)hisorydataArr{
    if(_hisorydataArr==nil){
        _hisorydataArr=[NSMutableArray arrayWithContentsOfFile:HistoryPath];
        if(_hisorydataArr==nil){
            _hisorydataArr=[NSMutableArray array];
        }
        [self.jm_collectionview reloadData];
    }
    return _hisorydataArr;
}

-(UIImageView *)dibuImageView{
    if (_dibuImageView==nil) {
        _dibuImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, JMScreenWidth-20, 10)];
    }
    return _dibuImageView;
}

- (FNSectionHeaderView *)sectioHeader{
    if (_sectioHeader == nil) {
        _sectioHeader = [[FNSectionHeaderView alloc]initWithFrame:(CGRectMake(0, 1, JMScreenWidth, 44))];
        _sectioHeader.titleLabel.textColor=FNGlobalTextGrayColor;
        _sectioHeader.titleLabel.text = @" 历史搜索";
        UIImage *img1=IMAGE(@"partner_search");
        [_sectioHeader.titleLabel addAttchmentImage:img1 andBounds:CGRectMake(0, -1.5, 15*img1.size.width/img1.size.height, 15) atIndex:0];
        _sectioHeader.backgroundColor = FNWhiteColor;
        
        UIButton* deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        UIImage *img2=IMAGE(@"search_delete");
        img2=[img2 scaleFromImage:img2 toSize:CGSizeMake(img2.size.width/img2.size.height*15, 15)];
        [deleteBtn setImage:img2 forState:(UIControlStateNormal)];
        [deleteBtn sizeToFit];
        [deleteBtn addTarget:self action:@selector(removeHistories) forControlEvents:(UIControlEventTouchUpInside)];
        [_sectioHeader addSubview:deleteBtn];
        [deleteBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [deleteBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [deleteBtn autoSetDimensionsToSize:deleteBtn.size];
    }
    return _sectioHeader;
}

- (FNSearchTipsAlertView*) tipsAlert {
    if (_tipsAlert == nil) {
        _tipsAlert = [[FNSearchTipsAlertView alloc] init];
        _tipsAlert.delegate = self;
        [self.view addSubview: _tipsAlert];
        [_tipsAlert mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.SearchBar.mas_bottom);
            make.bottom.left.right.equalTo(@0);
        }];
    }
    return _tipsAlert;
}

-(UITextField *)SearchBar{
    if (_SearchBar==nil) {
        _SearchBar=[UITextField new];
        _SearchBar.returnKeyType=UIReturnKeySearch;
        _SearchBar.delegate=self;
        _SearchBar.backgroundColor=[UIColor clearColor];
        _SearchBar.font=kFONT14;
        _SearchBar.textColor=FNBlackColor;
        _SearchBar.height=40;
        [_SearchBar addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
        
        UIImage *img=IMAGE(@"search_search-1");
        img=[img scaleFromImage:img toSize:CGSizeMake(30, 30)];
        UIImageView *searchView = [[UIImageView alloc]initWithImage:img];
        searchView.frame = CGRectMake(0, 0, 30, 30);
        searchView.contentMode = UIViewContentModeCenter;
        _SearchBar.rightViewMode = UITextFieldViewModeAlways;
        _SearchBar.rightView = searchView;
        [searchView addJXTouch:^{
            [self addHistoryPath];
        }];
    }
    return _SearchBar;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self addHistoryPath];
    return YES;
}

-(void)textField1TextChange:(UITextField *)textField{
    NSString *str = textField.text;
    if ([str kr_isNotEmpty] && [str UTF8String] != NULL ) {
        [self.tipsAlert showTips: str SkipUIIdentifier: self.SkipUIIdentifier];
    } else {
        [self.tipsAlert dismiss];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}
- ( BOOL )textFieldShouldEndEditing:( UITextField*)textField {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.SearchBar];
    [self.SearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(@0);
        make.height.equalTo(@(self.SearchBar.height));
    }];
    
    UIView *line=[UIView new];
    line.backgroundColor=RGB(246, 246, 246);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(self.SearchBar.mas_bottom).offset(0);
    }];
    
    FNMaximumSpacingFlowLayout* flowlayout = [FNMaximumSpacingFlowLayout new];
    flowlayout.headerReferenceSize = self.sectioHeader.size;
    flowlayout.footerReferenceSize = self.dibuImageView.size;
    flowlayout.sectionInset = UIEdgeInsetsMake(_jmsize_10, _jmsize_10, _jmsize_10, _jmsize_10);
    flowlayout.minimumInteritemSpacing  = 5;
    flowlayout.minimumLineSpacing  = 5;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=FNWhiteColor;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(@0);
        make.top.equalTo(line.mas_bottom).offset(0);
    }];
    
    [FNAPIHome startWithRequests:@[[self apiRequestHotSearchHeadColumn]] withFinishedBlock:^(NSArray *erros) {
        _slideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(40, 0, FNDeviceWidth-80, 40)];
        _slideBar.backgroundColor = FNWhiteColor;
        _slideBar.is_middle=YES;
        _slideBar.itemsTitle = title;
        _slideBar.itemColor = FNGlobalTextGrayColor;
        _slideBar.itemSelectedColor = FNMainGobalTextColor;
        _slideBar.sliderColor = FNMainGobalTextColor;
        _slideBar.fontSize=13;
        _slideBar.SelectedfontSize=14;
        [_slideBar selectSlideBarItemAtIndex:ColumnSelectIndex];
        [self slideBarItemSelected];
        self.navigationItem.titleView = _slideBar;
        [self requestMain];
    }];
}

-(void)slideBarItemSelected{
    [_slideBar slideBarItemSelectedCallback:^(NSUInteger index) {
        self.SkipUIIdentifier=self.ColumnArray[index].SkipUIIdentifier;
        [self requestMain];
    }];
}

//获取商品栏目（淘宝，京东，拼多多那几个大栏目）
- (FNAPIHome *)apiRequestHotSearchHeadColumn{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@"3"}];
    return [FNAPIHome apiHomeForHotSearchHeadColumnWithParams:params success:^(id respondsObject) {
        self.ColumnArray=respondsObject;
        title=[[NSMutableArray alloc]init];
        [respondsObject enumerateObjectsUsingBlock:^(HotSearchHeadColumnModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [title addObject:obj.name];
            if (self.SkipUIIdentifier==nil) {
                if ([obj.is_check integerValue]==1) {
                    self.SkipUIIdentifier=obj.SkipUIIdentifier;
                    ColumnSelectIndex=idx;
                }
            }else{
                if ([obj.SkipUIIdentifier isEqualToString:self.SkipUIIdentifier]) {
                    self.SkipUIIdentifier=obj.SkipUIIdentifier;
                    ColumnSelectIndex=idx;
                }
            }
        }];
        
        if (self.SkipUIIdentifier==nil) {
            self.SkipUIIdentifier=self.ColumnArray[0].SkipUIIdentifier;
            ColumnSelectIndex=0;
        }
        
    } failure:^(NSString *error) {
        
    } isHidden:YES];
}

#pragma mark - request
- (FNRequestTool *)requestMain{
    @weakify(self);
    NSMutableDictionary *Params=[NSMutableDictionary dictionaryWithDictionary:@{}];
    if([self.SkipUIIdentifier kr_isNotEmpty]){
        Params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    }
    return [FNRequestTool requestWithParams:Params api:@"mod=appapi&act=appJdPdd&ctrl=course" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //
        NSDictionary* dict = respondsObject[DataKey];
        self.SearchBar.placeholder=[dict objectForKey:@"str"];
        [self.dibuImageView setUrlImg:[dict objectForKey:@"img"]];
        [self.dibuImageView addJXTouch:^{
            NSLog(@"点击教程");
            @strongify(self);
            [self loadOtherVCWithModel:dict andInfo:nil outBlock:nil]; 
        }];
        NSString *imageUrl=dict[@"img"];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            if ([imageUrl kr_isNotEmpty]) {
                UIImage* img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
                CGFloat imgwidth=JMScreenWidth-20;
                CGFloat height = img?imgwidth*(img.size.height/img.size.width):0;
                self.dibuImageView.height=height;
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.jm_collectionview reloadData];
                });
            }
        });
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        //
        [self requestMain];
    } isHideTips:YES];
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.hisorydataArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 5;
    cell.layer.borderColor = FNHomeBackgroundColor.CGColor;
    cell.layer.borderWidth = 1.0;
    if (cell.contentView.subviews.count>0) {
        return cell;
    }else {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.font = kFONT14;
        label.textColor = FNGlobalTextGrayColor;
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        [label autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView* reusableview=nil;
    if (kind==UICollectionElementKindSectionHeader) {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        [reusableview addSubview:self.sectioHeader];
    }else{
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        [reusableview addSubview:self.dibuImageView];
        [self.dibuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.bottom.equalTo(@-20);
        }];
    }
    return reusableview;
}
#pragma mark - Collection view delegate && flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString* string = self.hisorydataArr[indexPath.item];
    CGRect rect =  [string boundingRectWithSize:(CGSizeMake(JMScreenWidth-30, 30)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:kFONT15} context:nil];
    CGFloat width = rect.size.width+20;
    if (width>=(JMScreenWidth-_jmsize_15*2)) {
        width = (JMScreenWidth-_jmsize_15*2);
    }
    CGSize size = CGSizeMake(floor(width), 30);
    return size;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(JMScreenWidth, 44);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    //return CGSizeMake(JMScreenWidth, self.dibuImageView.image.size.width/self.dibuImageView.image.size.height*(JMScreenWidth-20)+20);
    return CGSizeMake(JMScreenWidth, self.dibuImageView.height);
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell.contentView.subviews.count == 0) {
        return;
    }
    for (UILabel*label in cell.contentView.subviews) {
        label.text = self.hisorydataArr[indexPath.item];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNGoodsListViewController *VC=[FNGoodsListViewController new];
    VC.SkipUIIdentifier=self.SkipUIIdentifier;
    VC.keyword=self.hisorydataArr[indexPath.item];
    [self.navigationController pushViewController:VC animated:YES];
    [self removeVC];
}

#pragma mark - action
- (void)removeHistories{
    JMAlertView * alert = [JMAlertView alertWithTitle:@"提示" content:@"是否清空历史数据？" firstTitle:@"取消" andSecondTitle:@"是的" alertType:(AlertTypeAlert) clickBlock:^(NSInteger index) {
        if (index == 1) {
            NSFileManager *fileMagr=[NSFileManager defaultManager];
            NSError *error;
            [fileMagr removeItemAtPath:HistoryPath error:&error];
            [self.hisorydataArr removeAllObjects];
            [self.jm_collectionview reloadData];
        }
    }];
    [alert showAlert];
}

-(void)addHistoryPath{
    
    [self.tipsAlert dismiss];
    
    if(self.SearchBar.text.length>0){
        [self.hisorydataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj isEqualToString:self.SearchBar.text]){
                *stop=YES;
                if(*stop==YES){
                    [self.hisorydataArr removeObject:self.SearchBar.text];
                }
            }
        }];
        [self.hisorydataArr insertObject:self.SearchBar.text atIndex:0];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.hisorydataArr writeToFile:HistoryPath atomically:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.jm_collectionview reloadData];
                FNGoodsListViewController *VC=[FNGoodsListViewController new];
                VC.SkipUIIdentifier=self.SkipUIIdentifier;
                VC.keyword=self.SearchBar.text;
                [self.navigationController pushViewController:VC animated:YES];
                [self removeVC];
            });
        });
    }
}

//删除navigationController栈中VC
-(void)removeVC{
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in marr) {
        if ([vc isKindOfClass:[firstVersionSearchViewController class]]) {
            [marr removeObject:vc];
            break;
        }
    }
    self.navigationController.viewControllers = marr;
}

#pragma mark - FNSearchTipsAlertViewDelegate
- (void)didTipsSelect: (NSString*)tip {
    self.SearchBar.text = tip;
    [self addHistoryPath];
}

@end
