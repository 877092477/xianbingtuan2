//
//  FNStoreGoodsManagerAddController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/10.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsManagerAddController.h"
#import "FNCustomeNavigationBar.h"
#import "FNStoreManagerGoodsAddHeaderView.h"
#import "FNStoreManagerGoodsAddImageView.h"
#import "TZImagePickerController/TZImagePickerController.h"
#import "FNStoreManagerGoodsButtonView.h"
#import "FNStoreGoodsCateManagerController.h"
#import "FNStoreGoodsSpecManagerController.h"
#import "FNStoreManagerGoodsSpecView.h"
#import "FNStoreGoodsAttriManagerController.h"
#import "FNStoreManagerGoodsAttriView.h"
#import "FNStoreManagerGoodsAddTextView.h"
#import "FNStoreGoodsModel.h"

@interface FNStoreGoodsManagerAddController ()<FNStoreManagerGoodsAddImageViewDelegate, TZImagePickerControllerDelegate, FNStoreGoodsCateManagerControllerDelegate, FNStoreManagerGoodsButtonViewDelegate, FNStoreGoodsSpecManagerControllerDelegate, FNStoreGoodsAttriManagerControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) FNCustomeNavigationBar *navigationView;


@property (nonatomic, strong) UIScrollView *scvGoods;
@property (nonatomic, strong) UIView *vContent;

@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addName;
@property (nonatomic, strong) FNStoreManagerGoodsAddImageView *addImage;

@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addPrice;
@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addOPrice;

@property (nonatomic, strong) FNStoreManagerGoodsButtonView *selectCate;

// 规格
@property (nonatomic, strong) FNStoreManagerGoodsButtonView *selectSpec;
@property (nonatomic, strong) FNStoreManagerGoodsSpecView *viewSpec;
@property (nonatomic, strong) UILabel *lblSpec;

// 属性
@property (nonatomic, strong) FNStoreManagerGoodsButtonView *selectAttri;
@property (nonatomic, strong) FNStoreManagerGoodsAttriView *viewAttri;
@property (nonatomic, strong) UILabel *lblAttri;

// 库存
@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addStock;

// 销量
@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addSales;

// 佣金
@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addBuyCommission;
@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addShareCommission;
@property (nonatomic, strong) UILabel *lblCommission;
// 餐盒费
@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addLaunch;

@property (nonatomic, strong) FNStoreManagerGoodsAddTextView *addDesc;

// 底部按钮
@property (nonatomic, strong) UIView *vBottom;
@property (nonatomic, strong) UIButton *btnSave;
@property (nonatomic, strong) UIButton *btnSubmit;

@property (nonatomic, strong) UIImage *goodsImage;
@property (nonatomic, strong) FNStoreGoodsSpecManagerModel *spec;
@property (nonatomic, strong) NSArray<FNStoreGoodsSpecManagerModel*>* attris;

@property (nonatomic, assign) BOOL isEditing;

@property (nonatomic, strong) FNStoreManagerGoodsModel *goods;

@end

@implementation FNStoreGoodsManagerAddController

- (void)setIsEditing: (BOOL)isEditing {
    _isEditing = isEditing;
    
    if ([_goods_id kr_isNotEmpty]) {
        if (isEditing) {
            _btnSubmit.layer.borderColor = RGB(255, 102, 102).CGColor;
            [_btnSubmit setTitle: @"确认修改" forState: UIControlStateNormal];
            [_btnSubmit setTitleColor: RGB(255, 102, 102) forState: UIControlStateNormal];
        } else {
            _btnSubmit.layer.borderColor = RGB(153, 153, 153).CGColor;
            [_btnSubmit setTitle: @"删除商品" forState: UIControlStateNormal];
            [_btnSubmit setTitleColor: RGB(153, 153, 153) forState: UIControlStateNormal];
        }
        
    }
}

- (BOOL)getIsEditing {
    return _isEditing;
}

- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        _navigationView.backgroundColor = RGB(255, 102, 102);
        
        UIButton* leftView = [UIButton new];
        UIImageView *imgBack = [[UIImageView alloc] init];
        imgBack.size = CGSizeMake(9, 15);
        imgBack.image = IMAGE(@"connection_button_back");
        [leftView addSubview:imgBack];
        leftView.frame = CGRectMake(10, 0, 20, 20);
        [leftView addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        _navigationView.leftButton = leftView;
        
        self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
        self.navigationView.titleLabel.sd_layout
        .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
        [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
        _navigationView.titleLabel.text=@"添加商品";
        
        if(self.understand==YES){
            _navigationView.leftButton.hidden=YES;
        }
        
        
    }
    return _navigationView;
}

- (void)backBtnAction {
    
    if (![self getIsEditing]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"商品信息还未保存确认返回吗？"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         @strongify(self);
                                                         
                                                         [self.navigationController popViewControllerAnimated:YES];
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"继续编辑" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:self.isPop.boolValue];
    
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setIsEditing: NO];
    [self configUI];
    
    if ([_goods_id kr_isNotEmpty]) {
        [self requestGoods];
    }
}

- (void)configUI {
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    
    _vBottom = [[UIView alloc] init];
    _btnSave = [[UIButton alloc] init];
    _btnSubmit = [[UIButton alloc] init];
    
    [self.view addSubview:_vBottom];
    [_vBottom addSubview:_btnSave];
    [_vBottom addSubview:_btnSubmit];
    
    _vBottom.backgroundColor = UIColor.whiteColor;
    _btnSave.cornerRadius = 4;
    _btnSave.layer.borderColor = RGB(6, 192, 162).CGColor;
    _btnSave.layer.borderWidth = 1;
    [_btnSave setTitle: @"放入仓库" forState: UIControlStateNormal];
    [_btnSave setTitleColor: RGB(6, 192, 162) forState: UIControlStateNormal];
    [_btnSave addTarget:self action:@selector(onSaveClick) forControlEvents:UIControlEventTouchUpInside];
    
    _btnSubmit.cornerRadius = 4;
    _btnSubmit.layer.borderColor = RGB(255, 102, 102).CGColor;
    _btnSubmit.layer.borderWidth = 1;
    [_btnSubmit setTitle: @"立即上架" forState: UIControlStateNormal];
    [_btnSubmit setTitleColor: RGB(255, 102, 102) forState: UIControlStateNormal];
    [_btnSubmit addTarget:self action:@selector(onSubmitClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_vBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(isIphoneX ? 114 : 80);
    }];
    [_btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.top.equalTo(@10);
        make.right.equalTo(self.view.mas_centerX).offset(-23);
        make.height.mas_equalTo(50);
    }];
    [_btnSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-50);
        make.top.equalTo(@10);
        make.left.equalTo(self.view.mas_centerX).offset(23);
        make.height.mas_equalTo(50);
    }];
    
    _scvGoods = [[UIScrollView alloc] init];
    [self.view addSubview:_scvGoods];
    
    _scvGoods = [[UIScrollView alloc]init];
    _scvGoods.backgroundColor=RGB(248, 248, 248);
    _scvGoods.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scvGoods];
    
    _vContent = [[UIView alloc] init];
    [_scvGoods addSubview:_vContent];
    
    [_scvGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.bottom.equalTo(self.vBottom.mas_top);
        make.left.right.equalTo(@0);
    }];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.width.mas_equalTo(XYScreenWidth);
    }];
    
    _addName = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc] initWithString:@"*商品名称" attributes:@{NSFontAttributeName: kFONT14,NSForegroundColorAttributeName: RGB(255, 102, 102)}];
    [name addAttributes:@{NSForegroundColorAttributeName: RGB(24, 24, 24)} range:NSMakeRange(1, 4)];
    _addName.lblTitle.attributedText = name;
    _addName.txfTitle.placeholder = @"请输入商品名称";
    _addName.txfTitle.delegate = self;
    [_vContent addSubview:_addName];
    [_addName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addImage = [[FNStoreManagerGoodsAddImageView alloc] init];
    _addImage.delegate = self;
    _addImage.lblTitle.text = @"添加商品图片";
    [_addImage.btnImage setBackgroundImage:IMAGE(@"store_goods_button_add_image_empty") forState: UIControlStateNormal];
    [_vContent addSubview:_addImage];
    [_addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addName.mas_bottom).offset(1);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(70);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addPrice = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] initWithString:@"*现价" attributes:@{NSFontAttributeName: kFONT14,NSForegroundColorAttributeName: RGB(255, 102, 102)}];
    [price addAttributes:@{NSForegroundColorAttributeName: RGB(24, 24, 24)} range:NSMakeRange(1, 2)];
    _addPrice.lblTitle.attributedText = price;
    _addPrice.txfTitle.placeholder = @"";
    _addPrice.txfTitle.delegate = self;
    _addPrice.txfTitle.keyboardType = UIKeyboardTypeNumberPad;
    _addPrice.lblUnit.text = @"元";
    _addPrice.txfTitle.placeholder = @"0";
    [_vContent addSubview:_addPrice];
    [_addPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addImage.mas_bottom).offset(14);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addOPrice = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    _addOPrice.lblTitle.text = @"原价";
    _addOPrice.lblUnit.text = @"元";
    _addOPrice.txfTitle.delegate = self;
    _addOPrice.txfTitle.placeholder = @"0";
    _addOPrice.txfTitle.keyboardType = UIKeyboardTypeNumberPad;
    [_vContent addSubview:_addOPrice];
    [_addOPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addPrice.mas_bottom).offset(1);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _selectCate = [[FNStoreManagerGoodsButtonView alloc] init];
    _selectCate.lblTitle.text = @"选择分类";
    _selectCate.delegate = self;
    _selectCate.lblDesc.text = [_cateId kr_isNotEmpty] ? _cateName : @"待设置";
    _selectCate.lblDesc.textColor = RGB(204, 204, 204);
    [_vContent addSubview:_selectCate];
    [_selectCate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addOPrice.mas_bottom).offset(12);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _selectSpec = [[FNStoreManagerGoodsButtonView alloc] init];
    _selectSpec.lblTitle.text = @"商品规格";
    _selectSpec.delegate = self;
    _selectSpec.lblDesc.text = @"待设置";
    _selectSpec.lblDesc.textColor = RGB(204, 204, 204);
    [_vContent addSubview:_selectSpec];
    [_selectSpec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectCate.mas_bottom).offset(12);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _viewSpec = [[FNStoreManagerGoodsSpecView alloc] init];
    [_vContent addSubview:_viewSpec];
    [_viewSpec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectSpec.mas_bottom).offset(1);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _lblSpec = [[UILabel alloc] init];
    _lblSpec.text = @"指杯型、份量等，不同规格对应不同价格";
    _lblSpec.font = kFONT11;
    _lblSpec.textColor = RGB(153, 153, 153);
    [_vContent addSubview:_lblSpec];
    [_lblSpec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewSpec.mas_bottom).offset(4);
        make.left.equalTo(@33);
        make.right.lessThanOrEqualTo(@-33);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _selectAttri = [[FNStoreManagerGoodsButtonView alloc] init];
    _selectAttri.lblTitle.text = @"商品属性";
    _selectAttri.delegate = self;
    _selectAttri.lblDesc.text = @"待设置";
    _selectAttri.lblDesc.textColor = RGB(204, 204, 204);
    [_vContent addSubview:_selectAttri];
    [_selectAttri mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblSpec.mas_bottom).offset(10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _viewAttri = [[FNStoreManagerGoodsAttriView alloc] init];
    [_vContent addSubview:_viewAttri];
    [_viewAttri mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectAttri.mas_bottom).offset(1);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _lblAttri = [[UILabel alloc] init];
    _lblAttri.text = @"指辣度、温度、颜色等，不同属性不影响价格";
    _lblAttri.font = kFONT11;
    _lblAttri.textColor = RGB(153, 153, 153);
    [_vContent addSubview:_lblAttri];
    [_lblAttri mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewAttri.mas_bottom).offset(4);
        make.left.equalTo(@33);
        make.right.lessThanOrEqualTo(@-33);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addStock = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    _addStock.lblTitle.text = @"库存量(个)";
    _addStock.txfTitle.placeholder = @"0";
    _addStock.txfTitle.delegate = self;
    _addStock.txfTitle.keyboardType = UIKeyboardTypeNumberPad;
    [_vContent addSubview:_addStock];
    [_addStock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblAttri.mas_bottom).offset(8);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addSales = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    _addSales.lblTitle.text = @"销量";
    _addSales.txfTitle.placeholder = @"0";
    _addSales.txfTitle.delegate = self;
    _addSales.txfTitle.keyboardType = UIKeyboardTypeNumberPad;
    [_vContent addSubview:_addSales];
    [_addSales mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addStock.mas_bottom).offset(12);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addBuyCommission = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    _addBuyCommission.lblTitle.text = @"自购佣金比例(%)";
    _addBuyCommission.txfTitle.placeholder = @"0";
    //    _addCommission.lblUnit.text = @"元";
    _addBuyCommission.txfTitle.delegate = self;
    _addBuyCommission.txfTitle.keyboardType = UIKeyboardTypeNumberPad;
    [_vContent addSubview:_addBuyCommission];
    [_addBuyCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addSales.mas_bottom).offset(12);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addShareCommission = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    _addShareCommission.lblTitle.text = @"佣金比例(%)";
    _addShareCommission.txfTitle.placeholder = @"0";
//    _addCommission.lblUnit.text = @"元";
    _addShareCommission.txfTitle.delegate = self;
    _addShareCommission.txfTitle.keyboardType = UIKeyboardTypeNumberPad;
    [_vContent addSubview:_addShareCommission];
    [_addShareCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addBuyCommission.mas_bottom).offset(1);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _lblCommission = [[UILabel alloc] init];
    _lblCommission.text = @"* 填写后将会在您的收款扣除";
    _lblCommission.font = kFONT11;
    _lblCommission.textColor = RGB(255, 102, 0);
    [_vContent addSubview:_lblCommission];
    [_lblCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addShareCommission.mas_bottom).offset(4);
        make.left.equalTo(@33);
        make.right.lessThanOrEqualTo(@-33);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addLaunch = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    _addLaunch.lblTitle.text = @"餐盒费(单件商品)";
    _addLaunch.lblUnit.text = @"元";
    _addLaunch.txfTitle.placeholder = @"0";
    _addLaunch.txfTitle.delegate = self;
    _addLaunch.txfTitle.keyboardType = UIKeyboardTypeNumberPad;
    [_vContent addSubview:_addLaunch];
    [_addLaunch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblCommission.mas_bottom).offset(8);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addDesc = [[FNStoreManagerGoodsAddTextView alloc] init];
    _addDesc.lblTitle.text = @"商品描述";
    [_vContent addSubview:_addDesc];
    [_addDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addLaunch.mas_bottom).offset(12);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
//        make.height.mas_equalTo(127);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
}

- (void)updateBottom {
    if ([_goods.is_show isEqualToString:@"1"]) {
        self.btnSave.layer.borderColor = RGB(6, 192, 162).CGColor;
        [self.btnSave setTitle: @"下架商品" forState: UIControlStateNormal];
        [self.btnSave setTitleColor: RGB(6, 192, 162) forState: UIControlStateNormal];
    } else {
        self.btnSave.layer.borderColor = RGB(255, 102, 102).CGColor;
        [self.btnSave setTitle: @"立即上架" forState: UIControlStateNormal];
        [self.btnSave setTitleColor: RGB(255, 102, 102) forState: UIControlStateNormal];
    }
    
}

#pragma FNStoreManagerGoodsAddImageViewDelegate

- (void)didAddImageClick: (FNStoreManagerGoodsAddImageView*)view {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowCrop = NO;
//    CGFloat height = XYScreenWidth * 3.0 / 4.0;
//    imagePickerVc.cropRect = CGRectMake(0, (XYScreenHeight - height) / 2, XYScreenWidth, height);
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)didCloseImageClick: (FNStoreManagerGoodsAddImageView*)view {
    _goodsImage = nil;
    _addImage.btnClose.hidden = YES;
    [_addImage.btnImage setBackgroundImage:IMAGE(@"store_goods_button_add_image_empty") forState: UIControlStateNormal];
    [self setIsEditing:YES];
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    [self setIsEditing:YES];
    _addImage.btnClose.hidden = photos.count <= 0;
    if (photos.count > 0) {
        [_addImage.btnImage setBackgroundImage:photos[0] forState: UIControlStateNormal];
        _goodsImage = photos[0];
    }
}

#pragma mark - FNStoreManagerGoodsButtonViewDelegate

- (void)onButtonViewTitleClick: (FNStoreManagerGoodsButtonView*)view {
    if ([view isEqual:_selectCate]) {
        FNStoreGoodsCateManagerController *vc = [[FNStoreGoodsCateManagerController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([view isEqual:_selectSpec]) {
        FNStoreGoodsSpecManagerController *vc = [[FNStoreGoodsSpecManagerController alloc] init];
        
        FNStoreGoodsSpecManagerModel *model = [[FNStoreGoodsSpecManagerModel alloc] init];
        model.name = self.goods.specs.name;
        model.list = [[NSArray alloc] initWithArray:self.goods.specs.data];
        
        vc.baseSpec = model;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([view isEqual:_selectAttri]) {
        FNStoreGoodsAttriManagerController *vc = [[FNStoreGoodsAttriManagerController alloc] init];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (FNStoreManagerGoodsAttriModel *attri in self.goods.attribute) {
            FNStoreGoodsSpecManagerModel *model = [[FNStoreGoodsSpecManagerModel alloc] init];
            model.name = attri.name;
            NSMutableArray *list = [[NSMutableArray alloc] init];
            for (NSString *name in attri.data) {
                FNStoreGoodsSpecDataModel *spec = [[FNStoreGoodsSpecDataModel alloc] init];
                spec.name = name;
                spec.isSelected = YES;
                [list addObject: spec];
            }
            model.list = list;
            [array addObject:model];
        }
        vc.baseSpecs = array;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -  FNStoreGoodsCateManagerControllerDelegate

- (void)goodsCate: (FNStoreGoodsCateManagerController*)vc didSelected: (NSDictionary*) cate {
    [self setIsEditing:YES];
    _cateId = cate[@"id"];
    _selectCate.lblDesc.text = cate[@"name"];
    _selectCate.lblDesc.textColor = RGB(51, 51, 51);
    [self.navigationController popViewControllerAnimated: YES];
}

#pragma mark - FNStoreGoodsSpecManagerControllerDelegate
- (void)goodsSpec: (FNStoreGoodsSpecManagerController*)vc didSelected: (FNStoreGoodsSpecManagerModel*) spec {
    [self setIsEditing:YES];
    _spec = spec;
    if (spec) {
        
        _selectSpec.lblDesc.text = @"修改";
        _selectSpec.lblDesc.textColor = RGB(255, 102, 102);
        
        float price = spec.list[0].price.floatValue;
        NSString *p = spec.list[0].price;
        for (FNStoreGoodsSpecDataModel *model in spec.list) {
            if (price > model.price.floatValue) {
                price = model.price.floatValue;
                p = model.price;
            }
        }
        
        _addPrice.txfTitle.text = p;
        _addPrice.lblUnit.text = @"元起";
        _addPrice.txfTitle.enabled = NO;
        _addStock.txfTitle.text = @"已根据商品规格设置";
        _addStock.txfTitle.textColor = RGB(153, 153, 153);
        _addStock.txfTitle.enabled = NO;
        
        _viewSpec.lblTitle.text = spec.name;
        [_viewSpec setSpec: spec];
    } else {
        
        _selectSpec.lblDesc.text = @"待设置";
        _selectSpec.lblDesc.textColor = RGB(204, 204, 204);
        
        _addPrice.txfTitle.text = @"";
        _addPrice.lblUnit.text = @"元";
        _addPrice.txfTitle.enabled = YES;
        _addStock.txfTitle.text = @"";
        _addStock.txfTitle.textColor = RGB(51, 51, 51);
        _addStock.txfTitle.enabled = YES;
        
        _viewSpec.lblTitle.text = @"";
        [_viewSpec setSpec: nil];
    }
    
    [self.navigationController popViewControllerAnimated: YES];
}

#pragma mark - FNStoreGoodsAttriManagerControllerDelegate

- (void)goodsAttri: (FNStoreGoodsAttriManagerController*)vc didSelected: (NSArray<FNStoreGoodsSpecManagerModel*>*) specs {
    [self setIsEditing:YES];
    _attris = specs;
    if (specs && specs.count > 0) {
    
        _selectAttri.lblDesc.text = @"修改";
        _selectAttri.lblDesc.textColor = RGB(255, 102, 102);
        
        [_viewAttri setAttris: specs];
    } else {
        _selectAttri.lblDesc.text = @"待设置";
        _selectAttri.lblDesc.textColor = RGB(204, 204, 204);
        
        [_viewAttri setAttris: @[]];
    }
    
    [self.navigationController popViewControllerAnimated: YES];
}

#pragma mark - Action

- (void)onSaveClick {
    
    if ([_goods_id kr_isNotEmpty]) {
        if (_goods) {
            // 若当前已上架，则保存为下架商品，若当前未上架，保存为上架状态
//            [self requestAddGoods:[_goods.is_show isEqualToString:@"1"] ? NO : YES];
            [self requestChangeGoodsStatus];
        }
    } else {
        // 添加商品为未上架
        [self requestAddGoods:NO];
    }
    
}

- (void)onSubmitClick {
    
    if ([_goods_id kr_isNotEmpty]) {
        if ([self getIsEditing]) {
            // 保存修改
            [self requestAddGoods:YES];
        } else {
            // 删除商品
            [self requestDeleteGoods];
        }
        
    } else {
        // 添加商品
        [self requestAddGoods:YES];
    }
}

#pragma mark - UITextFieldDelegate

//参数一：range，要被替换的字符串的range，如果是新输入的，就没有字符串被替换，range.length = 0
//参数二：替换的字符串，即键盘即将输入或者即将粘贴到textField的string
//返回值为BOOL类型，YES表示允许替换，NO表示不允许
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    
    [self setIsEditing:YES];
    
    if ([textField isEqual:_addName.txfTitle]) {
        return YES;
    }
    
    //新输入的
    if (string.length == 0) {
        return YES;
    }

    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    //正则表达式（只支持两位小数）
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    
    if ([textField isEqual:_addStock.txfTitle]) {
        regex = @"^[1-9]\\d*$";
    }
    
    //判断新的文本内容是否符合要求
    return [self isValid:checkStr withRegex:regex];
    
}

//检测改变过的文本是否匹配正则表达式，如果匹配表示可以键入，否则不能键入
- (BOOL) isValid:(NSString*)checkStr withRegex:(NSString*)regex
{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:checkStr];
}

#pragma mark - Networking

- (void)requestGoods{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{}];
    if ([_goods_id kr_isNotEmpty]) {
        params[@"id"] = _goods_id;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_admin&ctrl=goods_detail" respondType:(ResponseTypeModel) modelType:@"FNStoreManagerGoodsModel" success:^(id respondsObject) {
        @strongify(self)
        
        FNStoreManagerGoodsModel *goods = respondsObject;
        self.goods = respondsObject;
        
        self.addName.txfTitle.text = goods.goods_title;
        [self.addImage.btnImage sd_setBackgroundImageWithURL:URL(goods.goods_img) forState: UIControlStateNormal];
        
        @weakify(self)
        [self.addImage.btnImage sd_setBackgroundImageWithURL:URL(goods.goods_img) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            @strongify(self)
            if (image) {
                self.goodsImage = image;
            }
        }];
        
        
        self.addOPrice.txfTitle.text = goods.goods_cost_price;
        
        FNStoreGoodsSpecModel *spec = goods.specs;
        if (spec) {
            
            _selectSpec.lblDesc.text = @"修改";
            _selectSpec.lblDesc.textColor = RGB(255, 102, 102);
            
            float price = spec.data[0].price.floatValue;
            NSString *p = spec.data[0].price;
            for (FNStoreGoodsSpecDataModel *model in spec.data) {
                if (price > model.price.floatValue) {
                    price = model.price.floatValue;
                    p = model.price;
                }
            }
            
            _addPrice.txfTitle.text = p;
            _addPrice.lblUnit.text = @"元起";
            _addPrice.txfTitle.enabled = NO;
            _addStock.txfTitle.text = @"已根据商品规格设置";
            _addStock.txfTitle.textColor = RGB(153, 153, 153);
            _addStock.txfTitle.enabled = NO;
            
            _viewSpec.lblTitle.text = spec.name;
            FNStoreGoodsSpecManagerModel *specManager = [[FNStoreGoodsSpecManagerModel alloc] init];
            specManager.name = spec.name;
            specManager.list = spec.data;
            [_viewSpec setSpec: specManager];
        } else {
            
            _selectSpec.lblDesc.text = @"待设置";
            _selectSpec.lblDesc.textColor = RGB(204, 204, 204);
            
            self.addPrice.txfTitle.text = goods.goods_price;
            _addPrice.lblUnit.text = @"元";
            _addPrice.txfTitle.enabled = YES;
            _addStock.txfTitle.text = @"";
            _addStock.txfTitle.textColor = RGB(51, 51, 51);
            _addStock.txfTitle.enabled = YES;
            _addStock.txfTitle.text = goods.stock;
            
            _viewSpec.lblTitle.text = @"";
            [_viewSpec setSpec: nil];
        }
        
        
        if (goods.attribute && goods.attribute.count > 0) {
            
            _selectAttri.lblDesc.text = @"修改";
            _selectAttri.lblDesc.textColor = RGB(255, 102, 102);
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (FNStoreManagerGoodsAttriModel *att in goods.attribute) {
                FNStoreGoodsSpecManagerModel *attri = [[FNStoreGoodsSpecManagerModel alloc] init];
                attri.name = att.name;
                NSMutableArray *list = [[NSMutableArray alloc] init];
                for (NSString *str in att.data) {
                    FNStoreGoodsSpecDataModel *sd = [[FNStoreGoodsSpecDataModel alloc] init];
                    sd.name = str;
                    [list addObject: sd];
                }
                attri.list = list;
                [array addObject:attri];
            }
            
            [_viewAttri setAttris: array];
        } else {
            _selectAttri.lblDesc.text = @"待设置";
            _selectAttri.lblDesc.textColor = RGB(204, 204, 204);
            
            [_viewAttri setAttris: @[]];
        }
        
        
        self.addBuyCommission.txfTitle.text = goods.commission;
        self.addShareCommission.txfTitle.text = goods.share_bili;
        self.addSales.txfTitle.text = goods.goods_sales;

        self.addLaunch.txfTitle.text = goods.mealbox_money;
        
        self.addDesc.txvDesc.text = goods.describe;
        self.addDesc.lblPlaceholder.hidden = [goods.describe kr_isNotEmpty];
        
        [self updateBottom];
        [self setIsEditing: [self getIsEditing]];
        
//        _btnSubmit.layer.borderColor = RGB(153, 153, 153).CGColor;
//        [_btnSubmit setTitle: @"删除商品" forState: UIControlStateNormal];
//        [_btnSubmit setTitleColor: RGB(153, 153, 153) forState: UIControlStateNormal];
        
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestAddGoods: (BOOL)isShow{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{@"is_show": isShow ? @"1" : @"0"}];
    
    if ([_goods_id kr_isNotEmpty]) {
        params[@"id"] = _goods_id;
    }
    
    if ([_addName.txfTitle.text kr_isNotEmpty]) {
        params[@"goods_title"] = _addName.txfTitle.text;
    } else {
        [FNTipsView showTips:@"请输入商品名称"];
        return;
    }
    
    if (_goodsImage == nil) {
        [FNTipsView showTips:@"请添加商品图片"];
        return;
    }
    
    if (_cateId) {
        params[@"cate_id"] = _cateId;
    }
    
    if (_spec && _spec.list.count > 0) {
        
        NSMutableDictionary *sss = [[NSMutableDictionary alloc] init];
        sss[@"name"] = _spec.name;
        
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (FNStoreGoodsSpecDataModel *model in _spec.list) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            dict[@"name"] = model.name;
            dict[@"price"] = model.price;
            dict[@"stock"] = [model.stock kr_isNotEmpty] ? model.stock : @"";
            [array addObject: dict];
        }
        
        sss[@"data"] = array;
        
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sss options:kNilOptions error:&error];
        NSString *jsonSpec = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        params[@"specs"] = jsonSpec;
        params[@"goods_price"] = _addPrice.txfTitle.text;
    } else {
        //现价
        if ([_addPrice.txfTitle.text kr_isNotEmpty]) {
            params[@"goods_price"] = _addPrice.txfTitle.text;
        } else {
            [FNTipsView showTips:@"请输入商品价格或选择商品规格"];
            return;
        }
        
        //库存
        params[@"stock"] = [_addStock.txfTitle.text kr_isNotEmpty] ? _addStock.txfTitle.text : @"";
        
    }
    
    if ([_addOPrice.txfTitle.text kr_isNotEmpty]) {
        params[@"goods_cost_price"] = _addOPrice.txfTitle.text;
    } else {
        [FNTipsView showTips:@"请输入商品原价"];
        return;
    }
    
    if ([_addBuyCommission.txfTitle.text kr_isNotEmpty]) {
        params[@"commission"] = _addBuyCommission.txfTitle.text;
    } else {
        [FNTipsView showTips:@"请输入商品自购佣金比例"];
        return;
    }
    
    if ([_addShareCommission.txfTitle.text kr_isNotEmpty]) {
        params[@"commission"] = _addShareCommission.txfTitle.text;
    } else {
        [FNTipsView showTips:@"请输入商品自购佣金比例"];
        return;
    }
    
    if ([_addLaunch.txfTitle.text kr_isNotEmpty]) {
        params[@"mealbox_money"] = _addLaunch.txfTitle.text;
    } else {
        [FNTipsView showTips:@"请输入餐盒费"];
        return;
    }
    
    if ([_addSales.txfTitle.text kr_isNotEmpty]) {
        params[@"goods_sales"] = _addSales.txfTitle.text;
    }
    
    if ([_addDesc.txvDesc.text kr_isNotEmpty]) {
        params[@"describe"] = _addDesc.txvDesc.text;
    } else {
        [FNTipsView showTips:@"请输入商品描述"];
        return;
    }
    
    if (_attris && _attris.count > 0) {
        // 属性
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (FNStoreGoodsSpecManagerModel *attri in _attris) {
//            [array addObject: model.keyValues];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            dict[@"name"] = attri.name;
            NSMutableArray *datas = [[NSMutableArray alloc] init];
            for (FNStoreGoodsSpecDataModel *model in attri.list) {
                [datas addObject: model.name];
            }
            dict[@"data"] = datas;
            [array addObject: dict];
        }
        
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:&error];
        NSString *jsonSpec = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        params[@"attribute"] = jsonSpec;
    }
    
    [SVProgressHUD show];
//    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    NSData *data= [UIImage scaleData:_goodsImage toKb:MAX_IMAGE_SIZE];
    NSString * fileName = [NSString stringWithFormat:@"%@_image.jpg",[NSString GetNowMillisecond]];
    [FNRequestTool uploadDataWithParams:params api:@"mod=appapi&act=rebate_goods_admin&ctrl=add_goods" data:data withKey:@"goods_img" fileName:fileName success:^(id respondsObject) {
        
        [SVProgressHUD dismiss];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSString *error) {
        
        [SVProgressHUD dismiss];
        
    }];
    
}

- (void)requestChangeGoodsStatus{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{}];
    if ([_goods_id kr_isNotEmpty]) {
        params[@"id"] = _goods_id;
    }
    [SVProgressHUD show];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_admin&ctrl=change_status" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        [SVProgressHUD dismiss];
        self.goods.is_show = [self.goods.is_show isEqualToString:@"1"] ? @"0" : @"1";
        
        [FNTipsView showTips:@"修改成功"];
        
        [self updateBottom];
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
        
    } isHideTips:NO isCache: NO];
}

- (void)requestDeleteGoods{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{}];
    if ([_goods_id kr_isNotEmpty]) {
        params[@"id"] = _goods_id;
    }
    [SVProgressHUD show];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_admin&ctrl=del" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        [SVProgressHUD dismiss];
        [FNTipsView showTips:@"删除成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
        
    } isHideTips:NO isCache: NO];
}


@end
