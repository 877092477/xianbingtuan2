//
//  FNMyVideoCardBuyController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMyVideoCardBuyController.h"
#import "FNMyVideoCardBuyModel.h"
#import "FNVideoCardBuyHeader.h"
#import "FNVideoCardBuyCell.h"
#import "FNVideoCardBuyDescCell.h"
#import "FNMyVideoCardPayController.h"

@interface FNMyVideoCardBuyController ()<UITableViewDelegate, UITableViewDataSource, FNVideoCardBuyHeaderDelegate, FNVideoCardBuyCellDelegate, FNMyVideoCardPayControllerDelegate>

@property (nonatomic, strong) FNVideoCardBuyHeader *header;
@property (nonatomic, strong) FNMyVideoCardBuyModel* model;
@property (nonatomic, strong) FNMyVideoCardBuyTypeModel* currentType;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) UIButton *btnBuy;

@property (nonatomic, strong) NSMutableArray *payArr;
    
@end

@implementation FNMyVideoCardBuyController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];
    [self configHeader];
    [self requestMain];
    
}

- (void)configUI {
    self.view.backgroundColor = UIColor.whiteColor;
    
    _btnBuy = [[UIButton alloc] init];
    [self.view addSubview:_btnBuy];
    [_btnBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0).offset(isIphoneX ? -34 : 0);
        make.height.mas_equalTo(53);
    }];
    [_btnBuy addTarget:self action:@selector(onBuyClick)];
    
    self.jm_tableview = [[UITableView alloc] init];
    [self.view addSubview:self.jm_tableview];
    self.jm_tableview.backgroundColor = FNHomeBackgroundColor;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.delegate = self;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.estimatedSectionFooterHeight = 0;
    self.jm_tableview.estimatedSectionHeaderHeight = 0;
    [self.jm_tableview registerClass:[FNVideoCardBuyCell class] forCellReuseIdentifier:@"FNVideoCardBuyCell"];
    [self.jm_tableview registerClass:[FNVideoCardBuyDescCell class] forCellReuseIdentifier:@"FNVideoCardBuyDescCell"];
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.bottom.equalTo(self.btnBuy.mas_top);
    }];
}

-(void) configHeader {
    _header = [[FNVideoCardBuyHeader alloc] init];
    _header.delegate = self;
    self.jm_tableview.tableHeaderView = _header;
    [_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.width.mas_equalTo(XYScreenWidth);
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        FNVideoCardBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNVideoCardBuyCell"];
        [cell setTitle:@"数量" count:_count withMaxCount:999];
        cell.delegate = self;
        return cell;
    } else if (indexPath.row == 1) {
        FNVideoCardBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNVideoCardBuyCell"];
        if (_currentType) {
            NSAttributedString *str = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.lf", _currentType.price.doubleValue * _count] attributes:@{NSForegroundColorAttributeName: RGB(252, 156, 9)}];
            [cell setTitle:@"小计" withAttributeDesc: str];
        }
        else {
            [cell setTitle:@"小计" withAttributeDesc: [[NSAttributedString alloc] init]];
        }
        
        return cell;
    } else if (indexPath.row == 2) {
        FNVideoCardBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNVideoCardBuyCell"];
        if (_currentType) {
            NSAttributedString *str = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", _currentType.end_time]];
            [cell setTitle:self.model.valid_str withAttributeDesc: str];
        } else {
            NSAttributedString *str = [[NSAttributedString alloc] initWithString:@""];
            [cell setTitle:self.model.valid_str withAttributeDesc: str];
        }
        return cell;
    } else {
        FNVideoCardBuyDescCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNVideoCardBuyDescCell"];
        [cell setDesc:_model.info];
        return cell;
    }
    
}

- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath cellContentViewWidth:(CGFloat)width tableView:(UITableView *)tableView {
    return 60;
}



#pragma mark - Networking
    
- (FNRequestTool*) requestMain {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_movie_card&ctrl=buy" respondType:(ResponseTypeModel) modelType:@"FNMyVideoCardBuyModel" success:^(id respondsObject) {
        @strongify(self);
        self.model = respondsObject;
        
        self.title = self.model.top_title;
        [self.header.imgHeader sd_setImageWithURL:URL(self.model.logo)];
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        NSMutableArray *prices = [[NSMutableArray alloc] init];
        NSMutableArray *oPrices = [[NSMutableArray alloc] init];
        
        for (FNMyVideoCardBuyTypeModel *type in self.model.card_type) {
            [titles addObject:type.info];
            [prices addObject:[NSString stringWithFormat:@"￥%@", type.price]];
            [oPrices addObject:[NSString stringWithFormat:@"￥%@", type.cost_price]];
        }
        [self.header setHeaders:titles withPrices:prices andOPrices:oPrices];
        
        CGFloat height = [self.header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;

        //update the header's frame and set it again
        CGRect headerFrame = self.header.frame;
        headerFrame.size.height = height;
        self.header.frame = headerFrame;
        self.jm_tableview.tableHeaderView = self.header;
        
        _currentType = self.model.card_type[0];
        _count = 1;
        [self.jm_tableview reloadData];
        
        [self.btnBuy setTitle:self.model.btn_str forState:UIControlStateNormal];
        [self.btnBuy setTitleColor:[UIColor colorWithHexString:self.model.btn_color] forState:UIControlStateNormal];
        [self.btnBuy sd_setBackgroundImageWithURL:URL(self.model.btn_img) forState:UIControlStateNormal];
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:NO];
}

//- (FNRequestTool*) requestPayType {
//    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
//    @weakify(self);
//    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_movie_card&ctrl=zf_type" respondType:(ResponseTypeModel) modelType:@"" success:^(id respondsObject) {
//        @strongify(self);
//
//        [self.payArr removeAllObjects];
//        NSArray<FNRedPackagePayModel*> *payment = respondsObject;
//        int index = 1;
//        for (FNRedPackagePayModel* pay in payment) {
//            FNpackagePayNaModel *model = [[FNpackagePayNaModel alloc] init];
//            model.title = pay.str;
//            model.img = pay.img;
//            model.sum = pay.str2;
//            model.payType = pay.pay_type;
//            model.payId = index++;
//            [self.payArr addObject:model];
//        }
//
//        self.payView = [[FNwrapPayCeView alloc]init];
//        self.payView.delegate=self;
////        self.payView.sumLB.text=[NSString stringWithFormat:@"¥ %.2f",sumFloat];//@"¥ 28.00元";
//        self.payView.headImg.image=IMAGE(Userhead_img);
//        self.payView.dataArr=self.payArr;
//        [[UIApplication sharedApplication].delegate.window addSubview:self.payView];
//        [self.view endEditing:YES];
//
//    } failure:^(NSString *error) {
//        @strongify(self);
//        if (![error isEqualToString:@"请求过于频繁"]) {
//            [self requestPayType];
//        }
//        else{
//            [XYNetworkAPI cancelAllRequest];
//        }
//    } isHideTips:YES isCache:NO];
//}


#pragma mark - FNVideoCardBuyHeaderDelegate
- (void)header:(FNVideoCardBuyHeader *)header didItemSelectedAt:(NSInteger)index {
    _currentType = self.model.card_type[index];
    [self.jm_tableview reloadData];
}

#pragma mark - FNVideoCardBuyCellDelegate
- (void)cell:(FNVideoCardBuyCell *)cell didCountChange:(NSInteger)count {
    _count = count;
    [self.jm_tableview reloadData];
}

#pragma mark - Action
- (void)onBuyClick {
    if (self.model == nil || self.currentType == nil)
        return;
//    [self requestPayType];
    FNMyVideoCardPayController *vc = [[FNMyVideoCardPayController alloc] init];
    vc.cardId = _currentType.ID;
    vc.count = _count;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - FNMyVideoCardPayControllerDelegate
- (void)didCardPay {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
