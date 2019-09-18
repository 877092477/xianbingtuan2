//
//  FNNewStoreCommendQuestionController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/6.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreCommendQuestionController.h"
#import "FNNewStoreCommentQuestionCell.h"

@interface FNNewStoreCommendQuestionController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *btnBg;
@property (nonatomic, strong) UIView *vAlert;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnClose;

@property (nonatomic, strong) UITableView *tbvQuestion;
@property (nonatomic, strong) UITextView *txvDesc;
@property (nonatomic, strong) UILabel *lblPlaceholder;
@property (nonatomic, strong) UIButton *btnSubmit;

@property (nonatomic, strong) NSArray<NSDictionary*> *questions;
@property (nonatomic, copy) NSString *type;

@end

@implementation FNNewStoreCommendQuestionController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _btnBg.backgroundColor = RGBA(0, 0, 0, 0.2);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.clearColor;
    [self configUI];
    [self requestComment];
}

- (void)configUI {
    _btnBg = [[UIButton alloc] init];
    _vAlert = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _btnClose = [[UIButton alloc] init];
    _tbvQuestion = [[UITableView alloc] init];
    _txvDesc = [[UITextView alloc] init];
    _lblPlaceholder = [[UILabel alloc] init];
    _btnSubmit = [[UIButton alloc] init];
    
    [self.view addSubview:_btnBg];
    [self.view addSubview:_vAlert];
    [_vAlert addSubview:_lblTitle];
    [_vAlert addSubview:_btnClose];
    [_vAlert addSubview:_tbvQuestion];
    [_vAlert addSubview:_txvDesc];
    [_vAlert addSubview:_lblPlaceholder];
    [_vAlert addSubview:_btnSubmit];
    
    [_btnBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(470);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@15);
        make.height.mas_equalTo(18);
    }];
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblTitle.mas_centerY);
        make.right.equalTo(@-15);
    }];
    [_tbvQuestion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(15);
    }];
    [_txvDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tbvQuestion.mas_bottom).offset(0);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.mas_equalTo(65);
    }];
    [_lblPlaceholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txvDesc).offset(8);
        make.left.equalTo(self.txvDesc).offset(8);
        make.right.lessThanOrEqualTo(self.txvDesc).offset(-8);
        
    }];
    [_btnSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(isIphoneX ? @-34 : @0);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.txvDesc.mas_bottom).offset(10);
    }];
    
//    _btnBg.backgroundColor = RGBA(0, 0, 0, 0.2);
    _vAlert.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.font = kFONT16;
    
    [_btnClose setImage:IMAGE(@"store_coupone_close_button") forState: UIControlStateNormal];
    
    _tbvQuestion.delegate = self;
    _tbvQuestion.dataSource = self;
    [_tbvQuestion registerClass:[FNNewStoreCommentQuestionCell class] forCellReuseIdentifier:@"FNNewStoreCommentQuestionCell"];
//    FNNewStoreCommentQuestionCell
    
    _txvDesc.backgroundColor = RGB(239, 239, 244);
    _txvDesc.font = kFONT10;
    _txvDesc.delegate = self;
    
    _lblPlaceholder.textColor = RGB(153, 153, 153);
    _lblPlaceholder.font = kFONT10;
    
    _btnSubmit.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_btnSubmit setTitle: @"提交" forState: UIControlStateNormal];
    [_btnSubmit setTitleColor: UIColor.blackColor forState: UIControlStateNormal];
    
    [_btnSubmit addTarget:self action:@selector(onSubmitClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnBg addTarget:self action:@selector(onCloseClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnClose addTarget:self action:@selector(onCloseClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Action
- (void)onSubmitClick {
    if ([_type kr_isNotEmpty]) {
        [self requestAddDoubt];
    } else {
        [FNTipsView showTips:@"请先选择类型~"];
    }
}

- (void)onCloseClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 监听输入框
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length <= 0) {
        self.lblPlaceholder.alpha = 1;
    }else{
        self.lblPlaceholder.alpha = 0;
    }
}

#pragma mark - Networking
- (void)requestComment{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];

    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=doubt_page" respondType:(ResponseTypeDataKey) modelType:@"FNStoreCarModel" success:^(id respondsObject) {
        @strongify(self)
        
        NSString *title = respondsObject[@"title"];
        NSString *content_tips = respondsObject[@"content_tips"];
        NSString *btn = respondsObject[@"btn"];
        self.lblTitle.text = title;
        self.lblPlaceholder.text = content_tips;
//        self.txvDesc.zw_placeHolder = content_tips;
        [self.btnSubmit setTitle: btn forState: UIControlStateNormal];
        
        self.questions = respondsObject[@"type"];
        
        [self.tbvQuestion reloadData];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestAddDoubt{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"id": _commentId}];
    
    if ([_type kr_isNotEmpty]) {
        params[@"type"] = _type;
    }
    if ([self.txvDesc.text kr_isNotEmpty]) {
        params[@"content"] = self.txvDesc.text;
    }
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=add_doubt" respondType:(ResponseTypeDataKey) modelType:@"FNStoreCarModel" success:^(id respondsObject) {
        @strongify(self)
        
        [FNTipsView showTips:@"提交成功~"];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.questions.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNNewStoreCommentQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewStoreCommentQuestionCell"];
    NSDictionary *question = self.questions[indexPath.row];
    cell.lblTitle.text = question[@"str"];
    
    return cell;
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *question = self.questions[indexPath.row];
    _type = question[@"type"];
}

@end
