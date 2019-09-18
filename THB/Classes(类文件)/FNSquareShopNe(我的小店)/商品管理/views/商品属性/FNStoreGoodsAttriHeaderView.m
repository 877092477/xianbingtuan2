//
//  FNStoreGoodsAttriHeaderView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsAttriHeaderView.h"

@interface FNStoreGoodsAttriHeaderView()

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;

@end

@implementation FNStoreGoodsAttriHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self configUI];
    }
    return self;
}

-(void)configUI{
    _vContent = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_lblDesc];
    
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
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"选择推荐的商品属性(多选)" attributes:@{NSFontAttributeName: kFONT14,NSForegroundColorAttributeName: RGB(51, 51, 51)}];
    [string addAttributes:@{NSFontAttributeName: kFONT11, NSForegroundColorAttributeName: RGB(153, 153, 153)} range:NSMakeRange(9, 4)];
    _lblTitle.attributedText = string;
    
    _lblDesc.textColor = RGB(153, 153, 153);
    _lblDesc.font = kFONT11;
    _lblDesc.text = @"如辣度、甜度，属性与价格、库存无关";
}

@end
