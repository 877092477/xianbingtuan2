//
//  FNStoreGoodsSpecHeaderCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsSpecHeaderCell.h"

@interface FNStoreGoodsSpecHeaderCell()

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIView *vSpecs;
@property (nonatomic, strong) UIButton *btnCreate;

@property (nonatomic, strong) NSMutableArray<UIButton*> *buttons;

@end

@implementation FNStoreGoodsSpecHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _buttons = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _vContent = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _vSpecs = [[UIView alloc] init];
    _btnCreate = [[UIButton alloc] init];
    
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_lblDesc];
    [_vContent addSubview:_vSpecs];
    [_vContent addSubview:_btnCreate];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(@16);
        make.right.lessThanOrEqualTo(@-14);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(6);
        make.right.lessThanOrEqualTo(@-14);
    }];
    [_vSpecs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@50);
        make.left.equalTo(@14);
        make.right.equalTo(@0);
    }];
    
    [_btnCreate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(self.vSpecs.mas_bottom).offset(10);
        make.height.mas_equalTo(36);
        make.width.equalTo(self.vSpecs).dividedBy(3).offset(-14);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColor.clearColor;
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"选择推荐的商品规格(单选)" attributes:@{NSFontAttributeName: kFONT14,NSForegroundColorAttributeName: RGB(51, 51, 51)}];
    [string addAttributes:@{NSFontAttributeName: kFONT11, NSForegroundColorAttributeName: RGB(153, 153, 153)} range:NSMakeRange(9, 4)];
    _lblTitle.attributedText = string;
    
    _lblDesc.textColor = RGB(153, 153, 153);
    _lblDesc.font = kFONT11;
    _lblDesc.text = @"如份量、尺寸等，可为对应规格设置价格、库存";
    
    _btnCreate.cornerRadius = 4;
    _btnCreate.layer.borderWidth = 1;
    _btnCreate.titleLabel.font = kFONT13;
    [_btnCreate layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2.0f];
    [_btnCreate setTitle: @"新建规格" forState: UIControlStateNormal];
    [_btnCreate addTarget:self action:@selector(clickCreate:) forControlEvents:UIControlEventTouchUpInside];
    
    [self clearSelected];
    
}

- (void)setSpecs: (NSArray<FNStoreGoodsSpecManagerModel*> *) specs {
    
    for (UIView *view in _buttons) {
        [view removeFromSuperview];
    }
    [_buttons removeAllObjects];

    int COLUMN = 3;
    for (NSInteger index = 0; index < specs.count; index++) {
        UIButton *button = [[UIButton alloc] init];
        [self.vSpecs addSubview: button];
        [self.buttons addObject:button];

        NSInteger row = index / COLUMN;
        NSInteger column = index % COLUMN;

        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (row == 0)
                make.top.equalTo(@10);
            else
                make.top.equalTo(self.buttons[index - COLUMN].mas_bottom).offset(10);
            if (column == 0)
                make.left.equalTo(@0);
            else
                make.left.equalTo(self.buttons[index - 1].mas_right).offset(14);
            make.width.height.equalTo(self.btnCreate);

            make.bottom.lessThanOrEqualTo(@0);
        }];

        button.cornerRadius = 4;
        button.backgroundColor = RGB(250, 250, 250);
        button.titleLabel.font = kFONT13;
        [button setTitle: specs[index].name forState: UIControlStateNormal];
        [button setTitleColor: RGB(153, 153, 153) forState: UIControlStateNormal];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) clickCreate: (UIButton*)sender {
    
    [self clearSelected];
    
    _btnCreate.layer.borderColor = RGB(255, 102, 102).CGColor;
    [_btnCreate setImage: IMAGE(@"store_manager_spec_image_add") forState: UIControlStateNormal];
    [_btnCreate setTitleColor: RGB(255, 102, 102) forState: UIControlStateNormal];
    
    if ([_delegate respondsToSelector:@selector(didAddClick:)]) {
        [_delegate didAddClick:self];
    }
}

- (void) clickButton: (UIButton*)sender {
    [self clearSelected];
    
    [sender setBackgroundImage: IMAGE(@"store_manager_spec_button_selected") forState: UIControlStateNormal];
    [sender setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    
    NSInteger index = [self.buttons indexOfObject: sender];
    if ([_delegate respondsToSelector:@selector(cell:didSpecClickAt:)]) {
        [_delegate cell: self didSpecClickAt:index];
    }
}

- (void) clearSelected {
    for (UIButton *button in _buttons) {
        [button setBackgroundImage: nil forState: UIControlStateNormal];
        [button setTitleColor: RGB(153, 153, 153) forState: UIControlStateNormal];
    }
    
    _btnCreate.layer.borderColor = RGB(153, 153, 153).CGColor;
    [_btnCreate setImage: IMAGE(@"store_manager_spec_image_add_enabled") forState: UIControlStateNormal];
    [_btnCreate setTitleColor: RGB(153, 153, 153) forState: UIControlStateNormal];
}

- (void)setSelectAt: (NSInteger)index {
    [self clearSelected];
    if (index < _buttons.count) {
        
        [_buttons[index] setBackgroundImage: IMAGE(@"store_manager_spec_button_selected") forState: UIControlStateNormal];
        [_buttons[index] setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    }
}

@end
