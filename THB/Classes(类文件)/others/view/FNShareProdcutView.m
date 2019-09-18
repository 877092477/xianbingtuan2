//
//  FNShareProdcutView.m
//  SuperMode
//
//  Created by jimmy on 2017/7/26.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNShareProdcutView.h"
#import "FNFunctionBtnView.h"
@interface FNShareProdcutView ()

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* desLabel;
@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) NSLayoutConstraint* textViewConsH;
@property (nonatomic, strong) UIView* buttonView;
@property (nonatomic, strong) UIButton* cancelBtn;
@property (nonatomic, weak) UIButton* cBtn;
@property (nonatomic, strong) CAShapeLayer* shapeLayer;
@property (nonatomic, strong)UIView* mainview;
@property (nonatomic, strong)UIScrollView* scrollview;
@end
@implementation FNShareProdcutView
- (UIView *)mainview{
    if (_mainview == nil) {
        _mainview = [UIView new];
        
        self.backgroundColor  = FNWhiteColor;
        
        CGFloat margin_horizontal = 10;
        
        _titleLabel  =[UILabel new];
        _titleLabel.font = kFONT15;
        _titleLabel.text = @"分享赚";
        _titleLabel.textColor = FNMainGobalControlsColor;
        _titleLabel.textAlignment= NSTextAlignmentCenter;
        [_mainview addSubview:_titleLabel];
        [_titleLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(margin_horizontal*2, margin_horizontal, 0, margin_horizontal)) excludingEdge:(ALEdgeBottom)];
        
        _desLabel  =[UILabel new];
        _desLabel.font = kFONT12;
        _desLabel.textColor = FNMainGobalControlsColor;
        _desLabel.numberOfLines = 0;
        _desLabel.textAlignment= NSTextAlignmentLeft;
        [_mainview addSubview:_desLabel];
        [_desLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_titleLabel withOffset:margin_horizontal*2];
        [_desLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:margin_horizontal];
        [_desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin_horizontal];
        
        UIView *line = [UIView new];
        line.backgroundColor = FNHomeBackgroundColor;
        [_mainview addSubview:line];
        [line autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [line autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [line autoSetDimension:(ALDimensionHeight) toSize:1.0];
        [line autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_desLabel withOffset:margin_horizontal];
        
        
        
        _textView = [[UITextView alloc]init];
        _textView.cornerRadius = 5;
        _textView.editable = NO;
        _textView.scrollEnabled = NO;
        _textView.textColor = FNGlobalTextGrayColor;
        _textView.backgroundColor  =FNHomeBackgroundColor;
        [_mainview addSubview:_textView];
        [_textView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin_horizontal];
        [_textView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:margin_horizontal];
        [_textView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:line withOffset:margin_horizontal*2];
        self.textViewConsH = [_textView autoSetDimension:(ALDimensionHeight) toSize:100];
        
        
        CGFloat btnH = 60;
        _buttonView = [UIView  new];
        [_mainview addSubview:_buttonView];
        [_buttonView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_textView withOffset:margin_horizontal*2];
        [_buttonView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin_horizontal];
        [_buttonView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:margin_horizontal];
        [_buttonView autoSetDimension:(ALDimensionHeight) toSize:btnH];
        
        NSArray* images = @[@"invite_wechat",@"invite_circle",@"invite_qq",@"invite_copy"];
        NSArray* titles = @[@"微信",@"朋友圈",@"QQ",@"复制文案"];
        CGFloat width = (FNDeviceWidth-_jmsize_10*2)/images.count;
        
        [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNFunctionBtnView * btn = [[FNFunctionBtnView alloc]initWithFrame:(CGRectMake(width*idx, 0, width, btnH)) btnImage:IMAGE(images[idx]) andTitle:titles[idx]];
            btn.tag = idx+100;
            @weakify(self);
            [btn addJXTouchWithObject:^(id obj) {
                @strongify(self);
                UIView* view = obj;
                NSInteger tag = view.tag - 100;
                if (tag<3) {
                    if (self.shareBtnBlock) {
                        self.shareBtnBlock(tag);
                    }
                }else{
                    [FNTipsView showTips:@"已复制"];
                    [[UIPasteboard generalPasteboard] setString:self.textView.text];
                }
            }];
            [_buttonView addSubview:btn];
        }];
        UIButton* cancelBtn = [UIButton buttonWithTitle:@"取消" titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(cancelBtnAction)];
        cancelBtn.backgroundColor = RGB(190, 190, 190);
        cancelBtn.cornerRadius = 5;
        [_mainview addSubview:cancelBtn];
        [cancelBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin_horizontal];
        [cancelBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:margin_horizontal];
        [cancelBtn autoSetDimension:(ALDimensionHeight) toSize:40];
        [cancelBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_buttonView withOffset:margin_horizontal*2];
        _cancelBtn = cancelBtn;
    }
    return _mainview;
}
- (UIScrollView *)scrollview{
    if (_scrollview == nil) {
        _scrollview = [UIScrollView new];
        
        [_scrollview addSubview:self.mainview];
        [self.mainview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [self.mainview autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        [self.mainview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.cancelBtn withOffset:_jmsize_10];
        [self.mainview autoSetDimension:(ALDimensionWidth) toSize:JMScreenWidth];
    }
    return _scrollview;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollview];
        [self.scrollview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
        CGFloat mainviewHeight=220;
        if (mainviewHeight <FNDeviceHeight-64) {
            self.height = mainviewHeight;
        }else{
            self.height = FNDeviceHeight-64;
            self.scrollview.contentSize  =CGSizeMake(JMScreenWidth, mainviewHeight);
        }
        
        self.y = FNDeviceHeight-self.height;
    }
    return self;
}
- (void)cancelBtnAction{
    if (self.cancelBtnBlock) {
        self.cancelBtnBlock();
    }
}
- (void)copyAction{
    [FNTipsView showTips:@"已复制"];
    [[UIPasteboard generalPasteboard] setString:self.textView.text];
}
- (void)setModel:(id)model{
    _model = model;
    if (_model) {
        CGFloat mainviewHeight=220;
        CGFloat margin_horizontal = 10;
        self.desLabel.text = [_model valueForKey:@"str1"];
        CGRect rect = [self.desLabel.text boundingRectWithSize:(CGSizeMake(FNDeviceWidth-margin_horizontal*2, CGFLOAT_MAX)) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:kFONT12} context:nil];
        mainviewHeight += rect.size.height + 20;
        
        self.textView.text = [_model valueForKey:@"str2"];
        CGRect rect1 = [self.textView.text boundingRectWithSize:(CGSizeMake(FNDeviceWidth-margin_horizontal*2, CGFLOAT_MAX)) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:kFONT12} context:nil];
        self.textViewConsH.constant=rect1.size.height + 20;
        mainviewHeight += self.textViewConsH.constant;
        
        if (mainviewHeight <FNDeviceHeight-64) {
            self.height = mainviewHeight;
        }else{
            self.height = FNDeviceHeight-64;
            self.scrollview.contentSize  =CGSizeMake(JMScreenWidth, mainviewHeight);
        }
        
        self.y = FNDeviceHeight-self.height;
        NSLog(@"%@",NSStringFromCGRect(self.frame));
        
        if (_shapeLayer) {
            [_shapeLayer removeFromSuperlayer];
            _shapeLayer = nil;
        }
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.frame = self.bounds;
        _shapeLayer.path = maskPath.CGPath;
        self.layer.mask = _shapeLayer;
        
        if (self.shareHeightBlock) {
            self.shareHeightBlock();
        }
    }
}
@end
