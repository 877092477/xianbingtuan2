//
//  FNStoreGoodsSpecHeaderView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsSpecHeaderView.h"

@interface FNStoreGoodsSpecHeaderView()

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIButton *btnSave;
@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UITextField *txfName;

@property (nonatomic, strong) FNStoreGoodsSpecManagerModel* model;

@end

@implementation FNStoreGoodsSpecHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self configUI];
    }
    return self;
}

-(void)configUI{
    _vContent = [[UIView alloc] init];
    _txfName = [[UITextField alloc] init];
    _btnSave = [[UIButton alloc] init];
    
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_txfName];
    [_vContent addSubview:_btnSave];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@12);
        make.right.equalTo(@-10);
        make.bottom.equalTo(@0);
    }];
    [_txfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.bottom.equalTo(@0);
        make.right.equalTo(self.btnSave.mas_left).offset(-10);
    }];
    [_btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-12);
        make.centerY.equalTo(@0);
        make.height.equalTo(self.vContent);
        make.width.mas_equalTo(100);
    }];
    
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = UIColor.clearColor;
        view;
    });
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _txfName.placeholder = @"请输入规格名称";
    _txfName.font = kFONT14;
    [_txfName addTarget:self action:@selector(didNameChanged) forControlEvents:UIControlEventEditingChanged];
    
    _btnSave.titleLabel.font = kFONT11;
    [_btnSave setTitle:@"保存为常用规格" forState: UIControlStateNormal];
    [_btnSave setTitleColor:RGB(153, 153, 153) forState: UIControlStateNormal];
    [_btnSave setImage:IMAGE(@"store_manager_spec_image_save") forState: UIControlStateNormal];
    [_btnSave layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5.0f];
    [_btnSave addTarget:self action:@selector(onSaveClick) forControlEvents:UIControlEventTouchUpInside];
    
    _vLine = [[UIView alloc] init];
    _vLine.backgroundColor = RGB(240, 240, 240);
    [_vContent addSubview: _vLine];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-14);
        make.left.equalTo(@14);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(@0);
    }];
}

- (void)onSaveClick {
    if ([_delegate respondsToSelector:@selector(didSpecHeaderClick:)]) {
        [_delegate didSpecHeaderClick:self];
    }
}

- (void)setModel: (FNStoreGoodsSpecManagerModel*)model {
    _model = model;
    _txfName.text = model.name;
}

- (void)didNameChanged {
    _model.name = _txfName.text;
}

@end
