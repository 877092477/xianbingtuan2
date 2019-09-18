//
//  FNStoreGoodsAttriAddCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsAttriAddCell.h"

@interface FNStoreGoodsAttriAddCell()

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIView *vSpecs;
@property (nonatomic, strong) UIButton *btnCreate;

@property (nonatomic, strong) NSMutableArray<UIButton*> *buttons;

@end

@implementation FNStoreGoodsAttriAddCell

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
    _vSpecs = [[UIView alloc] init];
    _btnCreate = [[UIButton alloc] init];
    
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_vSpecs];
    [_vContent addSubview:_btnCreate];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
    [_vSpecs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
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
    
    _btnCreate.cornerRadius = 4;
    _btnCreate.layer.borderWidth = 1;
    _btnCreate.titleLabel.font = kFONT13;
    [_btnCreate layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2.0f];
    [_btnCreate setTitle: @"新建属性" forState: UIControlStateNormal];
    [_btnCreate addTarget:self action:@selector(clickCreate:) forControlEvents:UIControlEventTouchUpInside];
    
    [self clearSelected];
    
}

- (void)setTitles: (NSArray<NSString*> *) titles {
    
    for (UIView *view in _buttons) {
        [view removeFromSuperview];
    }
    [_buttons removeAllObjects];
    
    int COLUMN = 3;
    for (NSInteger index = 0; index < titles.count; index++) {
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
        [button setTitle: titles[index] forState: UIControlStateNormal];
        [button setTitleColor: RGB(153, 153, 153) forState: UIControlStateNormal];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) clickCreate: (UIButton*)sender {
    
//    [self clearSelected];
//    
//    _btnCreate.layer.borderColor = RGB(255, 102, 102).CGColor;
//    [_btnCreate setImage: IMAGE(@"store_manager_spec_image_add") forState: UIControlStateNormal];
//    [_btnCreate setTitleColor: RGB(255, 102, 102) forState: UIControlStateNormal];
    
    if ([_delegate respondsToSelector:@selector(didAddAttriClick:)]) {
        [_delegate didAddAttriClick:self];
    }
}

- (void) clickButton: (UIButton*)sender {
//    [self clearSelected];
//
//    [sender setBackgroundImage: IMAGE(@"store_manager_spec_button_selected") forState: UIControlStateNormal];
//    [sender setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    
    NSInteger index = [self.buttons indexOfObject: sender];
    if ([_delegate respondsToSelector:@selector(cell:didAttriClickAt:)]) {
        [_delegate cell: self didAttriClickAt:index];
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


- (void)setSelections: (NSArray<NSString*> *)selections {
    for (NSInteger index = 0; index < selections.count && index < _buttons.count; index++) {
        UIButton *button = _buttons[index];
        if ([selections[index] isEqualToString:@"1"]) {
            [button setBackgroundImage: IMAGE(@"store_manager_spec_button_selected") forState: UIControlStateNormal];
            [button setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
        } else {
            [button setBackgroundImage: nil forState: UIControlStateNormal];
            [button setTitleColor: RGB(153, 153, 153) forState: UIControlStateNormal];
        }
    }
}

@end
