//
//  FNStoreJoinContriller.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreJoinContriller.h"
#import "FNStoreJoinModel.h"
#import "FNStoreJoinCell.h"
#import "FNStoreJoinFormController.h"
#import "FNStoreJoinAuthController.h"

@interface FNStoreJoinContriller()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FNStoreJoinModel *model;
@property (nonatomic, strong) UIButton *btnJoin;
@property (nonatomic, strong) UIImage *headerImage;

@end

@implementation FNStoreJoinContriller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self requestMain];
}

- (void)configUI {
    self.view.backgroundColor = RGB(238, 238, 238);
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor=RGB(238, 238, 238);
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.jm_tableview registerClass:[FNStoreJoinCell class] forCellReuseIdentifier:@"FNStoreJoinCell"];
    [self.view addSubview:self.jm_tableview];
    
    self.btnJoin = [[UIButton alloc] init];
    [self.view addSubview:self.btnJoin];
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.btnJoin.mas_top).offset(-20);
        make.left.right.top.equalTo(@0);
    }];
    
    [self.btnJoin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.bottom.equalTo(isIphoneX ? @-54 : @-20);
        make.height.mas_equalTo(50);
    }];
    
    _btnJoin.cornerRadius = 5;
    _btnJoin.titleLabel.font = kFONT16;
    [_btnJoin addTarget:self action:@selector(onJoinClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Networking

- (void)requestMain{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=apply_index" respondType:(ResponseTypeModel) modelType:@"FNStoreJoinModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.model = respondsObject;
        
        self.title = self.model.title;
        [self.btnJoin setTitle: self.model.btn_font forState: UIControlStateNormal];
        [self.btnJoin setTitleColor: [UIColor colorWithHexString:self.model.btn_color] forState: UIControlStateNormal];
        self.btnJoin.backgroundColor = [UIColor colorWithHexString:self.model.btn_bj];
        self.headerImage = nil;
        [SDWebImageManager.sharedManager downloadImageWithURL:self.model.top_img options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (finished && image) {
                self.headerImage = image;
                [self.jm_tableview reloadData];
            }
        }];
        
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.introducts.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNStoreJoinCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNStoreJoinCell"];

    [cell setModel: self.model.introducts[indexPath.row] withIndex: [NSString stringWithFormat: @"%ld", indexPath.row + 1]];
    
    return cell;
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 128;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_headerImage) {
        return XYScreenWidth * _headerImage.size.height / _headerImage.size.width;
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = _headerImage;
    return imageView;
}

#pragma mark - Action
- (void)onJoinClick {
    FNStoreJoinFormController *vc = [[FNStoreJoinFormController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
//    FNStoreJoinAuthController *vc = [[FNStoreJoinAuthController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
