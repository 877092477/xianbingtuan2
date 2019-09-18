//
//  FNStoreGoodsSpecAddCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsSpecAddCell.h"

@interface FNStoreGoodsSpecAddCell()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblStock;

@property (nonatomic, strong) UITextField *txfName;
@property (nonatomic, strong) UITextField *txfPrice;
@property (nonatomic, strong) UITextField *txfStock;

@property (nonatomic, strong) FNStoreGoodsSpecDataModel *model;


@end

@implementation FNStoreGoodsSpecAddCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _vContent = [[UIView alloc] init];
    _lblName = [[UILabel alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _lblStock = [[UILabel alloc] init];
    _txfName = [[UITextField alloc] init];
    _txfPrice = [[UITextField alloc] init];
    _txfStock = [[UITextField alloc] init];
    _btnDelete = [[UIButton alloc] init];
    
    [self.contentView addSubview:_vContent];
    [self.vContent addSubview:_lblName];
    [self.vContent addSubview:_lblPrice];
    [self.vContent addSubview:_lblStock];
    [self.vContent addSubview:_txfName];
    [self.vContent addSubview:_txfPrice];
    [self.vContent addSubview:_txfStock];
    [self.vContent addSubview:_btnDelete];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@0);
        make.right.equalTo(@-10);
        make.bottom.equalTo(@0);
    }];
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.width.mas_equalTo(@70);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblName.mas_right).offset(10);
        make.top.equalTo(@10);
        make.width.mas_equalTo(@70);
    }];
    [_lblStock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblPrice.mas_right).offset(10);
        make.top.equalTo(@10);
        make.right.equalTo(self.btnDelete.mas_left).offset(-10);
    }];
    [_txfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblName.mas_bottom).offset(4);
        make.height.mas_equalTo(@26);
        make.width.mas_equalTo(60);
        make.centerX.equalTo(self.lblName);
    }];
    [_txfPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblPrice.mas_bottom).offset(4);
        make.height.mas_equalTo(@26);
        make.width.mas_equalTo(60);
        make.centerX.equalTo(self.lblPrice);
    }];
    [_txfStock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblStock.mas_bottom).offset(4);
        make.height.mas_equalTo(@26);
        make.width.mas_equalTo(60);
        make.centerX.equalTo(self.lblStock);
    }];
    [_btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.centerY.equalTo(@0);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColor.clearColor;
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _lblName.textColor = RGB(153, 153, 153);
    _lblName.font = kFONT12;
    _lblName.text = @"规格选项";
    _lblName.textAlignment = NSTextAlignmentCenter;
    
    _lblPrice.textColor = RGB(153, 153, 153);
    _lblPrice.font = kFONT12;
    _lblPrice.text = @"价格(元)";
    _lblPrice.textAlignment = NSTextAlignmentCenter;
    
    _lblStock.textColor = RGB(153, 153, 153);
    _lblStock.font = kFONT12;
    _lblStock.text = @"库存(不限库存可不填)";
    _lblStock.textAlignment = NSTextAlignmentCenter;
    
    _txfName.placeholder = @"请输入";
    _txfName.font = kFONT13;
    _txfName.textAlignment = NSTextAlignmentCenter;
    _txfPrice.placeholder = @"必填";
    _txfPrice.font = kFONT13;
    _txfPrice.textAlignment = NSTextAlignmentCenter;
    _txfStock.placeholder = @"选填";
    _txfStock.font = kFONT13;
    _txfStock.textAlignment = NSTextAlignmentCenter;
    
    [_btnDelete setImage: IMAGE(@"store_manager_spec_image_delete") forState: UIControlStateNormal];
    [_btnDelete addTarget:self action:@selector(onDeleteClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *vLine1 = [[UIView alloc] init];
    UIView *vLine2 = [[UIView alloc] init];
    UIView *vLine3 = [[UIView alloc] init];
    UIView *vLine4 = [[UIView alloc] init];
    [_vContent addSubview: vLine1];
    [_vContent addSubview: vLine2];
    [_vContent addSubview: vLine3];
    [_vContent addSubview: vLine4];
    
    [vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.txfName);
        make.height.mas_equalTo(1);
    }];
    [vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.txfPrice);
        make.height.mas_equalTo(1);
    }];
    [vLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.txfStock);
        make.height.mas_equalTo(1);
    }];
    [vLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
    vLine1.backgroundColor = RGB(250, 250, 250);
    vLine2.backgroundColor = RGB(250, 250, 250);
    vLine3.backgroundColor = RGB(250, 250, 250);
    vLine4.backgroundColor = RGB(250, 250, 250);
    
    [self.txfName addTarget:self action:@selector(didNameChanged) forControlEvents:UIControlEventEditingChanged];
    [self.txfPrice addTarget:self action:@selector(didPriceChanged) forControlEvents:UIControlEventEditingChanged];
    [self.txfStock addTarget:self action:@selector(didStockChanged) forControlEvents:UIControlEventEditingChanged];
    self.txfPrice.delegate = self;
    self.txfPrice.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)setModel: (FNStoreGoodsSpecDataModel*)model {
    _model = model;
    _txfName.text = model.name;
    _txfPrice.text = model.price;
    _txfStock.text = model.stock;
}

- (void)onDeleteClick {
    if ([_delegate respondsToSelector:@selector(cellDidDeleteClick:)]) {
        [_delegate cellDidDeleteClick:self];
    }
}

- (void)didNameChanged {
    _model.name = self.txfName.text;
}

- (void)didPriceChanged {
    _model.price = self.txfPrice.text;
}

- (void)didStockChanged {
    _model.stock = self.txfStock.text;
}

#pragma mark - UITextFieldDelegate

//参数一：range，要被替换的字符串的range，如果是新输入的，就没有字符串被替换，range.length = 0
//参数二：替换的字符串，即键盘即将输入或者即将粘贴到textField的string
//返回值为BOOL类型，YES表示允许替换，NO表示不允许
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    //新输入的
    if (string.length == 0) {
        return YES;
    }
    
    //第一个参数，被替换字符串的range
    //第二个参数，即将键入或者粘贴的string
    //返回的是改变过后的新str，即textfield的新的文本内容
    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    //正则表达式（只支持两位小数）
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    //判断新的文本内容是否符合要求
    return [self isValid:checkStr withRegex:regex];
    
}

//检测改变过的文本是否匹配正则表达式，如果匹配表示可以键入，否则不能键入
- (BOOL) isValid:(NSString*)checkStr withRegex:(NSString*)regex
{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:checkStr];
}


@end
