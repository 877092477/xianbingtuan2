//
//  FNSiftViewController.m
//  THB
//
//  Created by jimmy on 2017/5/23.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNSiftViewController.h"
#import "FNSectionHeaderView.h"
#import "FNAPIHome.h"
#import "XYTitleModel.h"
#define SearchWordLength 6
#pragma mark - cell

@interface FNSiftViewCCell : UICollectionViewCell
@property (nonatomic, strong)UIButton* btn;
@property (nonatomic, strong)XYTitleModel* model;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end
@implementation FNSiftViewCCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    _btn = [UIButton buttonWithTitle:@"" titleColor:FNMainTextNormalColor font:kFONT14 target:self action:nil];
    [_btn setTitleColor:FNWhiteColor forState:UIControlStateSelected];
    _btn.userInteractionEnabled = NO;
    _btn.titleLabel.font = kFONT12;
    [_btn setBackgroundImage:IMAGE(@"newest") forState:UIControlStateNormal];
    [_btn setBackgroundImage:IMAGE(@"newest1") forState:UIControlStateSelected];
    [self.contentView addSubview:_btn];
    [_btn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];


}
- (void)setModel:(XYTitleModel *)model{
    _model = model;
    [_btn setTitle:_model.category_name forState:UIControlStateNormal];
    _btn.selected = _model.isSelected;
}
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNSiftViewCCell";
    FNSiftViewCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

@end
#pragma mark 自定义layout
@interface FNHSCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, strong) NSMutableArray *attrsArray;
@end
@implementation FNHSCollectionViewFlowLayout
//override
- (NSArray *)layoutAttributesForElementsInRect:(CGRect )rect
{
    NSArray *attributesInRect = [super layoutAttributesForElementsInRect:rect];
    
    for (NSInteger i = 0; i<attributesInRect.count; i++) {
        if (i > 0 ) {
            UICollectionViewLayoutAttributes *atts = attributesInRect[i];
            
            if ([atts.representedElementKind isEqualToString:UICollectionElementKindSectionFooter] || [atts.representedElementKind  isEqualToString:UICollectionElementKindSectionHeader]) {
                break;
            }
            if (atts.frame.origin.x != self.sectionInset.left && i+1 != attributesInRect.count) {
                [self modifiedAttributess:attributesInRect[i] andLastAtts:attributesInRect[i-1]];
            }
        }
    }
    return attributesInRect;
}
//modified attributes
- (void)modifiedAttributess:(UICollectionViewLayoutAttributes *)atts andLastAtts:(UICollectionViewLayoutAttributes *)previousLayoutAttribute;
{
    CGRect frame = atts.frame;
    frame.origin.x   = CGRectGetMaxX(previousLayoutAttribute.frame)+10;
    atts.frame = frame;
}

@end
@interface FNSiftViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UIView* headerView;
@property (nonatomic, strong) UITextField* keywordTF;
@property (nonatomic, strong) UITextField* lowPriceTF;
@property (nonatomic, strong) UITextField* highPriceTF;
@property (nonatomic, strong)UIView* footerView;

@property (nonatomic, strong)NSMutableArray<XYTitleModel *>* categories;
@property (nonatomic, strong)NSArray<XYTitleModel *>* others;

@property (nonatomic, strong)NSString* cateID;
@property (nonatomic, assign)NSInteger cateIndex;
@property (nonatomic, strong)NSString* sort;
@end

@implementation FNSiftViewController
- (NSMutableArray<XYTitleModel *> *)categories
{
    if (_categories == nil) {
        _categories = [NSMutableArray new];
    }
    return _categories;
}
- (NSArray <XYTitleModel *>*)others
{
    if (_others == nil) {
        XYTitleModel* model = [XYTitleModel new];
        model.category_name = @"最新";
        
        XYTitleModel* model2 = [XYTitleModel new];
        model2.category_name = @"最热";
        _others = @[model,model2];
    }
    return _others;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"筛选宝贝";
    [self setUpHeaderView];
    [self setUpFooterView];
    [self initializedSubviews];
    [self apiRequestCate];
    NSLog(@"_others:%@",_others);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - api reqeust
- (void)apiRequestCate{
    [SVProgressHUD show];
    NSString* type = @"cgf";
    if([self.Sifttype kr_isNotEmpty]){
        type=self.Sifttype;
    }
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":type,@"SkipUIIdentifier":@""}];
    //[NSMutableDictionary dictionaryWithDictionary:@{@"type":@3}]
    /*[FNAPIHome apiHomeForNewNavCategoriesWithParams:params success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        [self.categories removeAllObjects];
        [self.categories addObjectsFromArray:respondsObject];
        if (self.categories.count> 0) {
            self.categories[0].isSelected = YES;
            self.cateID = self.categories[0].id;
            self.cateIndex = 0;
        }
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHidden:NO];*/
    
    [FNRequestTool requestWithParams:params api:@"act=api&ctrl=getCates" respondType:(ResponseTypeArray) modelType:@"XYTitleModel" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        [self.categories removeAllObjects];
        [self.categories addObjectsFromArray:respondsObject];
        if (self.categories.count> 0) {
            self.categories[0].isSelected = YES;
            self.cateID = self.categories[0].id;
            self.cateIndex = 0;
        }
        [self.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    //layout
    FNHSCollectionViewFlowLayout *flowLayout = [FNHSCollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.headerReferenceSize = CGSizeMake(FNDeviceWidth, 40);
    flowLayout.footerReferenceSize = CGSizeMake(FNDeviceWidth, 40);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-60-64) collectionViewLayout:flowLayout];
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.backgroundColor = FNWhiteColor;
    [self.jm_collectionview registerClass:[FNSiftViewCCell class] forCellWithReuseIdentifier:@"FNSiftViewCCell"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter"];
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.jm_collectionview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.footerView];
    
}
- (void)setUpHeaderView{
    _headerView = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
    CGFloat imgH = 40;
    CGFloat TFY = 5;
    //第一个Lable
    UILabel *topLable = [[UILabel alloc]initWithFrame:CGRectMake(LeftSpace, LeftSpace, 150, 30)];
    topLable.text = @"关键词";
    topLable.font = kFONT14;
    [topLable sizeToFit];
    topLable.textColor = [UIColor blackColor];
    [_headerView addSubview:topLable];
    
    

    //输入框
    _keywordTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(topLable.frame)+5, FNDeviceWidth-2*_jm_leftMargin, imgH)];
    _keywordTF.placeholder = @"输入关键字";
    _keywordTF.font = kFONT15;
    _keywordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_headerView addSubview:_keywordTF];
    
    UIView* line1 = [[UIView alloc]initWithFrame:CGRectMake(_keywordTF.x, CGRectGetMaxY(_keywordTF.frame), _keywordTF.width, 1.0)];
    line1.backgroundColor = FNHomeBackgroundColor;
    [self.headerView addSubview:line1];
    
    
    //第二个Lable
    UILabel *midLable = [[UILabel alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(line1.frame)+_jm_leftMargin, 70, 30)];
    midLable.text = @"到手价";
    midLable.font = kFONT14;
    [midLable sizeToFit];
    midLable.textColor = [UIColor blackColor];
    [self.headerView addSubview:midLable];
    
    
    //    CGFloat TFW = XYScreenWidth/4+10;
    //最低价格输入框
    _lowPriceTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(midLable.frame)+TFY, 120, imgH)];
    _lowPriceTF.keyboardType = UIKeyboardTypeDecimalPad;
    _lowPriceTF.placeholder = @"最低价格";
    _lowPriceTF.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:_lowPriceTF];
    UIView* line2 = [[UIView alloc]initWithFrame:CGRectMake(_lowPriceTF.x, CGRectGetMaxY(_lowPriceTF.frame), _lowPriceTF.width, 1.0)];
    line2.backgroundColor = FNHomeBackgroundColor;
    [self.headerView addSubview:line2];
    
    //箭头Lable
    UILabel *toLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_lowPriceTF.frame)+2,CGRectGetMaxY(midLable.frame) , 14, imgH)];
    toLable.textAlignment = NSTextAlignmentCenter;
    toLable.adjustsFontSizeToFitWidth = YES;
    toLable.text = @"——";
    toLable.font = kFONT16;
    [self.headerView addSubview:toLable];
    
    //最高价格输入框
    _highPriceTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(toLable.frame)+2, CGRectGetMinY(_lowPriceTF.frame), CGRectGetWidth(_lowPriceTF.frame), imgH)];
    _highPriceTF.placeholder = @"最高价格";
    _highPriceTF.keyboardType = UIKeyboardTypeDecimalPad;
    _highPriceTF.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:_highPriceTF];
    UIView* line3 = [[UIView alloc]initWithFrame:CGRectMake(_highPriceTF.x, CGRectGetMaxY(_highPriceTF.frame), _highPriceTF.width, 1.0)];
    line3.backgroundColor = FNHomeBackgroundColor;
    [self.headerView addSubview:line3];
    
    
    
    UILabel* titleLabel = [[ UILabel alloc]initWithFrame:(CGRectMake(line1.x, CGRectGetMaxY(line3.frame) +12.5, 0, 0))];
    titleLabel.font = kFONT14;
    titleLabel.text  =@"一级分类";
    [titleLabel sizeToFit];
    [self.headerView addSubview:titleLabel];
    
    self.headerView.height = CGRectGetMaxY(titleLabel.frame) +12.5;
    
}
- (void)setUpFooterView{
    
    _footerView = [[UIView alloc]initWithFrame:(CGRectMake(0, FNDeviceHeight-60 -XYNavBarHeigth, FNDeviceWidth, 60))];
    UIButton* siftbtn = [UIButton buttonWithTitle:@"筛选完成" titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(siftingAction)];
    siftbtn.backgroundColor = FNMainGobalControlsColor;
    siftbtn.cornerRadius = 20;
    siftbtn.frame = CGRectMake(_jm_leftMargin, _jm_margin10, FNDeviceWidth-_jm_leftMargin*2, 40);
    [_footerView addSubview:siftbtn];
    [self.view addSubview:_footerView];
    [self.view bringSubviewToFront:_footerView];
    [_footerView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 0, XYNavBarHeigth, 0)) excludingEdge:(ALEdgeTop)];
    [_footerView autoSetDimension:(ALDimensionHeight) toSize:60];
}
- (void)siftingAction{
    if (self.lowPriceTF.text == nil) {
        self.lowPriceTF.text = @"";
    }
    if (self.highPriceTF.text == nil) {
        self.highPriceTF.text = @"";
    }
    if (self.keywordTF.text == nil) {
        self.keywordTF.text = @"";
    }
    if (self.others[0].isSelected) {
        self.sort = @"4";
    }
    if (self.others[1].isSelected) {
        self.sort = @"5";
    }
    if (self.sort == nil) {
        self.sort = @"";
    }
    //创建通知
    NSDictionary *dataDict = [NSDictionary dictionaryWithObjectsAndKeys:self.keywordTF.text,@"keyword", self.lowPriceTF.text,@"minPrice",self.highPriceTF.text,@"maxPrice",self.cateID,@"cid",self.sort,@"sort",@(self.cateIndex),@"index",nil];
    NSNotification *notification =[NSNotification notificationWithName:@"SiftNoti" object:nil userInfo:dataDict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    if (self.completeSiftBlock) {
        self.completeSiftBlock(dataDict);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.categories.count;
            break;
        case 1:
            return self.others.count;
            break;
            
        default:
            return 0;
            break;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FNSiftViewCCell* cell = [FNSiftViewCCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.model = self.categories[indexPath.item];
    }else{
        cell.model = self.others[indexPath.item];
    }
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    @WeakObj(self);
    UICollectionReusableView *reusableView = [UICollectionReusableView new];
    if (indexPath.section == 0 ) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader] ) {
            
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
            
            if (reusableView.subviews.count == 0) {
                
                [reusableView addSubview:_headerView];
            }else {
                _headerView = (FNSectionHeaderView *)[reusableView.subviews firstObject];
            }
            
            
        }else{
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"sectionFooter" forIndexPath:indexPath];
            [reusableView.subviews makeObjectsPerformSelector:@selector( removeFromSuperview)];
            FNSectionHeaderView* footer = [[FNSectionHeaderView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 40))];
            footer.backgroundColor = FNWhiteColor;
            footer.titleLabel.text = @"排序";
            [reusableView addSubview:footer];

        }
    }
    
    return reusableView;
}

#pragma  mark - UICollectionViewDelegateFlowLayout
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //
        if (self.categories.count > 0) {
            [self.categories enumerateObjectsUsingBlock:^(XYTitleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.isSelected = idx == indexPath.item;
                if (obj.isSelected) {
                    self.cateID = obj.id;
                    self.cateIndex =idx;
                }
            }];
        }
    } else {
        //
        if (self.others.count > 0) {
            [self.others enumerateObjectsUsingBlock:^(XYTitleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.isSelected = idx == indexPath.item;
            }];
        }
    }
    [self.jm_collectionview reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *dataStr = nil;
    CGSize size = CGSizeZero;
    switch (indexPath.section) {
        case 0:
        {
            if (self.categories.count > 0) {
                dataStr = self.categories[indexPath.item].category_name;
                NSInteger strLength = dataStr.length > SearchWordLength ? SearchWordLength:dataStr.length;
                size = CGSizeMake(15*strLength+20, 35);
            }
            break;
        }
        case 1:
        {
                if (self.others.count > 0) {
                    dataStr = self.others[indexPath.item].category_name;
                    NSInteger strLength = dataStr.length > SearchWordLength ? SearchWordLength:dataStr.length;
                    size = CGSizeMake(14*strLength+20, 35);
                }
            break;
        }
        case 2:
        {
            break;
        }
        default:
            break;
    }
    return size;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return CGSizeMake(FNDeviceWidth, _headerView.height);
            break;
        }
        case 1:
        {
            return CGSizeZero;
            break;
        }
        default:
            return CGSizeZero;
            break;
    }
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    CGFloat height = 40;
    return section == 0? CGSizeMake(FNDeviceWidth, height):CGSizeZero;
}


@end
