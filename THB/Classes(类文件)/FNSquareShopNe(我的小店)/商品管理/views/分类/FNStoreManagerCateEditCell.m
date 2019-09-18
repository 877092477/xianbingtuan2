//
//  FNStoreManagerCateEditCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/10.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerCateEditCell.h"

@interface FNStoreManagerCateEditCell()

@property (nonatomic, strong) UIView *vEdit;
@property (nonatomic, strong) UIButton *btnEdit;
@property (nonatomic, strong) UIButton *btnDelete;

@property (nonatomic, strong) UIView *vSort;
@property (nonatomic, strong) UIButton *btnUp;
@property (nonatomic, strong) UIButton *btnDown;

@end

@implementation FNStoreManagerCateEditCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    _vEdit = [[UIView alloc] init];
    _btnEdit = [[UIButton alloc] init];
    _btnDelete = [[UIButton alloc] init];
    _vSort = [[UIView alloc] init];
    _btnUp = [[UIButton alloc] init];
    _btnDown = [[UIButton alloc] init];
    
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_vEdit];
    [_vEdit addSubview:_btnEdit];
    [_vEdit addSubview:_btnDelete];
    [self.contentView addSubview:_vSort];
    [_vSort addSubview:_btnUp];
    [_vSort addSubview:_btnDown];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(self.vEdit.mas_left).offset(-10);
    }];
    [_vEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.centerY.equalTo(@0);
    }];
    [_btnEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
    }];
    [_btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@0);
        make.left.equalTo(self.btnEdit.mas_right).offset(18);
    }];
    [_vSort mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.centerY.equalTo(@0);
    }];
    [_btnUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
    }];
    [_btnDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@0);
        make.left.equalTo(self.btnUp.mas_right).offset(18);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT14;
    
    [_btnEdit setImage:IMAGE(@"store_manager_button_edit") forState: UIControlStateNormal];
    [_btnDelete setImage:IMAGE(@"store_manager_button_delete") forState: UIControlStateNormal];
    
    [_btnUp setImage:IMAGE(@"store_manager_button_up_normal") forState: UIControlStateNormal];
    [_btnUp setImage:IMAGE(@"store_manager_button_up_disabled") forState: UIControlStateDisabled];
    [_btnDown setImage:IMAGE(@"store_manager_button_down_normal") forState: UIControlStateNormal];
    [_btnDown setImage:IMAGE(@"store_manager_button_down_disabled") forState: UIControlStateDisabled];
    
    [_btnEdit addTarget:self action:@selector(onEditClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnDelete addTarget:self action:@selector(onDeleteClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnUp addTarget:self action:@selector(onUpClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnDown addTarget:self action:@selector(onDownClick) forControlEvents:UIControlEventTouchUpInside];
    
    _vSort.hidden = YES;
}

- (void) setEditable: (BOOL)editable upable: (BOOL)upable downable: (BOOL)downable {
    _vEdit.hidden = !editable;
    _vSort.hidden = editable;
    
    _btnUp.enabled = upable;
    _btnDown.enabled = downable;
}

- (void)onDeleteClick {
    if ([_delegate respondsToSelector:@selector(cellDidDeleteClick:)]) {
        [_delegate cellDidDeleteClick:self];
    }
}

- (void)onEditClick {
    if ([_delegate respondsToSelector:@selector(cellDidEditClick:)]) {
        [_delegate cellDidEditClick:self];
    }
}

- (void)onUpClick {
    if ([_delegate respondsToSelector:@selector(cellDidUpClick:)]) {
        [_delegate cellDidUpClick:self];
    }
}

- (void)onDownClick {
    if ([_delegate respondsToSelector:@selector(cellDidDownClick:)]) {
        [_delegate cellDidDownClick:self];
    }
}

@end
