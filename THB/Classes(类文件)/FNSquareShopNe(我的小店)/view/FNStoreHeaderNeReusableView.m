//
//  FNStoreHeaderNeReusableView.m
//  69橙子
//
//  Created by Jimmy on 2018/11/22.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNStoreHeaderNeReusableView.h"

@interface FNStoreHeaderNeReusableView()

@property (nonatomic, strong)UIView* vLine;
@property (nonatomic, strong) UIButton *btnLayout;

@end

@implementation FNStoreHeaderNeReusableView
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    self.backgroundColor = UIColor.whiteColor;
    
    _vLine = [[UIView alloc] init];
    [self addSubview: _vLine];
    _vLine.backgroundColor = RGB(255, 68, 68);
    
    _btnLayout = [[UIButton alloc] init];
    [self addSubview: _btnLayout];
    [_btnLayout setImage:IMAGE(@"xiaodian_button_layout_selected") forState:UIControlStateSelected];
    [_btnLayout setImage:IMAGE(@"xiaodian_button_layout_normal") forState:UIControlStateNormal];
    [_btnLayout addTarget:self action:@selector(onLayoutClick) forControlEvents:UIControlEventTouchUpInside];
    _btnLayout.hidden = YES;
    
    //名字
    self.TypeLB=[UILabel new];
    self.TypeLB.font=kFONT14;
    self.TypeLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.TypeLB];
    
//    self.leftLB=[UILabel new];
//    self.leftLB.backgroundColor=FNColor(244, 244, 244);
//    [self addSubview:self.leftLB];
//
//    self.rightLB=[UILabel new];
//    self.rightLB.backgroundColor=FNColor(244, 244, 244);
//    [self addSubview:self.rightLB];
    
    self.topLineLB=[UILabel new];
    self.topLineLB.backgroundColor=FNColor(244, 244, 244);
    [self addSubview:self.topLineLB];
    
    self.baseLineLB=[UILabel new];
    self.baseLineLB.backgroundColor=FNColor(244, 244, 244);
    [self addSubview:self.baseLineLB];
   
    CGFloat space_10=10;
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(2);
        make.centerY.equalTo(@5);
    }];
    
    [self.btnLayout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.centerY.equalTo(self.vLine);
        make.width.height.mas_equalTo(20);
    }];
    
    self.topLineLB.sd_layout
    .leftSpaceToView(self, 0).heightIs(space_10).rightSpaceToView(self, 0).topSpaceToView(self, 0);
    
    self.baseLineLB.sd_layout
    .leftSpaceToView(self, 0).heightIs(1).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
//    self.TypeLB.sd_layout
//    .topSpaceToView(self.topLineLB, 0).bottomSpaceToView(self.baseLineLB, 0).centerXEqualToView(self).widthIs(60);
    [_TypeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vLine.mas_right).offset(10);
        make.centerY.equalTo(self.vLine);
        make.right.lessThanOrEqualTo(self.btnLayout.mas_left).offset(-10);
    }];
    
//    self.leftLB.sd_layout
//    .rightSpaceToView(self.TypeLB, space_10).heightIs(1).centerYEqualToView(self.TypeLB).widthIs(15);
//
//    self.rightLB.sd_layout
//    .leftSpaceToView(self.TypeLB, space_10).heightIs(1).centerYEqualToView(self.TypeLB).widthIs(15);
    
}

- (void) onLayoutClick {
    _btnLayout.selected = !_btnLayout.isSelected;
    
    if ([self.delegate respondsToSelector:@selector(view:didLayoutSelected:)]) {
        [self.delegate view: self didLayoutSelected:_btnLayout.isSelected];
    }
}
 
@end
