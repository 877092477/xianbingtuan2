//
//  FNMineSignUpController.m
//  THB
//
//  Created by Jimmy on 2018/1/17.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNMineSignUpController.h"

#import "FNMineSignUpShowingView.h"
#import "FNMineSignUpModel.h"
#import "FNMineSignUpCell.h"
#import "FNMineSignUpHeader.h"
#import "FNCombinedButton.h"
@interface FNMineSignUpController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)FNMineSignUpHeader* header;
@property (nonatomic, strong)FNMineSignUpModel* model;
@property (nonatomic, strong)NSMutableArray* records;
@property (nonatomic, assign)BOOL isShowMore;
@property (nonatomic, strong)UIView* footer;
@property (nonatomic, strong)FNCombinedButton* moreBtn;

@property (nonatomic, strong)UIImage* bgImage;
@property (nonatomic, strong)UIImage* iconimage;


@end

@implementation FNMineSignUpController
#pragma mark - setter && getter
- (void)setModel:(FNMineSignUpModel *)model{
    _model = model;
    self.header.model = _model;
    [[SDWebImageManager sharedManager] downloadImageWithURL:URL(self.model.qiandao_guang_img) options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (finished)
            self.bgImage = image;
    }];
    [[SDWebImageManager sharedManager] downloadImageWithURL:URL(self.model.qiandao_yuan_img) options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (finished)
            self.iconimage = image;
    }];
}

- (FNCombinedButton *)moreBtn{
    if (_moreBtn == nil) {
        _moreBtn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"sign_down") selectedImage:IMAGE(@"sign_down") title:@"查看更多" font:kFONT14 titleColor:FNGlobalTextGrayColor selectedTitleColor:FNGlobalTextGrayColor target:self action:nil];
        _moreBtn.size = CGSizeMake(14*5+20, 30);
        _moreBtn.userInteractionEnabled = NO;
    }
    return _moreBtn;
}
- (UIView *)footer{
    if (_footer == nil) {
        _footer = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 50))];
        [_footer addLineOnDirection:(LineDirectionTop) withLineSzie:(CGSizeMake(JMScreenWidth, 1))];
        _footer.backgroundColor = FNWhiteColor;
        [_footer addSubview:self.moreBtn];
        [self.moreBtn autoSetDimensionsToSize:self.moreBtn.size];
        [self.moreBtn autoCenterInSuperview];
        @weakify(self);
        [_footer addJXTouch:^{
            @strongify(self);
            self.jm_tableview.tableFooterView = nil;
            self.isShowMore = YES;
            
            if (self.records.count>=_jm_pageszie) {
                self.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    [self requestRecrodWithCache:NO];
                }];
            }else{
                self.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    [self requestRecrodWithCache:NO];
                }];
                [self.jm_tableview.mj_footer endRefreshingWithNoMoreData];
            }
            [self.jm_tableview reloadData];
        }];
    }
    return _footer;
}
- (FNMineSignUpHeader *)header{
    if (_header ==nil) {
        _header = [[FNMineSignUpHeader alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 0))];
        @weakify(self);
        _header.signUpClicked = ^{
            @strongify(self);
            [self requestSigning];
        };
    }
    return _header;
}
- (NSMutableArray *)records{
    if (_records == nil) {
        _records = [NSMutableArray new];
    }
    return _records;
}
#pragma mark - system
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.title?:@"今日签到";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)jm_setupViews{
    self.jm_page = 1;
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    self.jm_tableview.delegate = self;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.tableHeaderView = self.header;
//    self.jm_tableview.alpha = 0;
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
//    [SVProgressHUD show];
    [self requestMainWithCache:YES];
}
#pragma mark - request
- (void)requestMainWithCache: (BOOL)isCache{
    [FNRequestTool startWithRequests:@[[self requestSignUpWithCache:isCache],[self requestRecrodWithCache: isCache]] withFinishedBlock:^(NSArray *erros) {
        //
//        [SVProgressHUD dismiss];
        [self.jm_tableview reloadData];
    }];
}
- (FNRequestTool *)requestSignUpWithCache: (BOOL)isCache{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_fls&ctrl=qiandao" respondType:(ResponseTypeModel) modelType:@"FNMineSignUpModel" success:^(id respondsObject) {
        //
        self.model = respondsObject;
    } failure:^(NSString *error) {
        //
    } isHideTips:NO isCache:isCache];
}
- (FNRequestTool *)requestRecrodWithCache: (BOOL)isCache{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,PageNumber:@(self.jm_page)}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_fls&ctrl=qd_jl" respondType:(ResponseTypeArray) modelType:@"FNMineSignUpRecordModel" success:^(NSArray* respondsObject) {
        //
        if (self.jm_page == 1) {
            [self.records removeAllObjects];
            [self.records addObjectsFromArray:respondsObject];
            if (respondsObject.count>=_jm_pageszie ) {
                self.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestRecrodWithCache: isCache];
                }] ;
            }else{

                if (self.records.count == 0) {
                    self.jm_tableview.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
                        self.jm_page ++;
                        [self requestRecrodWithCache: isCache];
                    }];
                    [self.jm_tableview.mj_footer endRefreshingWithNoMoreData];
                }else{
                    self.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                        self.jm_page ++;
                        [self requestRecrodWithCache: isCache];
                    }] ;
                    
                    [self.jm_tableview.mj_footer endRefreshingWithNoMoreData];
                }
                
            }
        }else{
            [self.records addObjectsFromArray:respondsObject];
            if (respondsObject.count>=_jm_pageszie) {
                [self.jm_tableview.mj_footer endRefreshing];
            }else{
                [self.jm_tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }
    } failure:^(NSString *error) {
        //
        [self.jm_tableview.mj_footer endRefreshing];
    } isHideTips:NO isCache:isCache];
}
- (FNRequestTool *)requestSigning{
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_fls&ctrl=qd_doing" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        [self requestMainWithCache:NO];
        NSString *content = respondsObject[@"str"]?:@"";
        NSString* moeny = respondsObject[@"money"]?:@"";
        if (self.bgImage == nil)
            self.bgImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL(self.model.qiandao_guang_img)]];
        if (self.iconimage == nil)
            self.iconimage = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL(self.model.qiandao_yuan_img)]];
        [SVProgressHUD dismiss];
        [FNMineSignUpShowingView showSignUpViewWithBgImage:self.bgImage content:[NSString stringWithFormat:@"恭喜你!\n%@",content] iconImage:self.iconimage hightLightedValue:moeny block:^(id sender) {
            //
        }];
    } failure:^(NSString *error) {
        //
        
    } isHideTips:NO isCache:NO];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{

        return self.records.count;
        
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString* reusedID = @"cell";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reusedID];
            cell.textLabel.font = kFONT14;
        }
        if (self.model) {
            NSString* string = self.model.str1?:@"";
            NSString* money = self.model.money?:@"";
            cell.textLabel.text = [NSString stringWithFormat:@"  %@%@",string,money] ;
            
            NSMutableAttributedString* matt = [[NSMutableAttributedString alloc]initWithString:cell.textLabel.text];
            if (![NSString isEmpty:cell.textLabel.text] &&[cell.textLabel.text containsString:money]) {
                [matt addAttribute:NSForegroundColorAttributeName value:FNMainGobalControlsColor range:[cell.textLabel.text rangeOfString:money]];
            }
            if (self.model.img) {
                UIImage* image = IMAGE(@"sign_coin");
                UIImage* urlImgae = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL(self.model.img)]];
                NSTextAttachment* attchment = [NSTextAttachment new];
                attchment.image =urlImgae?:image ;
                attchment.bounds = CGRectMake(0, -3, image.size.width, image.size.height);
                NSAttributedString *att = [NSAttributedString attributedStringWithAttachment:attchment];
                [matt insertAttributedString:att atIndex:0];
                
            }
            cell.textLabel.attributedText = matt;
        }
        return cell;
    }else{
        FNMineSignUpCell* cell = [FNMineSignUpCell cellWithTableView:tableView atIndexPath:indexPath];
        cell.model = self.records[indexPath.row];
        return cell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 50))];
    view.backgroundColor  = FNWhiteColor;
    [view addLineOnDirection:(LineDirectionBottom) withLineSzie:(CGSizeMake(JMScreenWidth, 1))];
    UILabel* textLabel = [UILabel new];
    textLabel.text = self.model.mx_title?:@"明细";
    [view addSubview:textLabel];
    [textLabel autoCenterInSuperview];
    
    UIView* leftLine = [UIView new];
    leftLine.backgroundColor = FNBlackColor;
    [view addSubview:leftLine];
    [leftLine autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:textLabel withOffset:-_jmsize_10*2];
    [leftLine autoSetDimension:(ALDimensionHeight) toSize:1];
    [leftLine autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:view withMultiplier:0.2];
    [leftLine autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    UIView* rightLine = [UIView new];
    rightLine.backgroundColor = FNBlackColor;
    [view addSubview:rightLine];
    [rightLine autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:textLabel withOffset:_jmsize_10*2];
    [rightLine autoSetDimension:(ALDimensionHeight) toSize:1];
    [rightLine autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:view withMultiplier:0.2];
    [rightLine autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    return section == 1? view:nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 50;
    if (indexPath.section== 1) {
        height = 64;
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = section == 1? 50:5;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = section == 0 ? 5:0.01;
    return height;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return self.header.height;
}
@end

