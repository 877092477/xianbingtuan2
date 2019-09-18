//
//  FNPDDCategorySectionHeader.m
//  THB
//
//  Created by Weller Zhao on 2019/3/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNPDDCategorySectionHeader.h"
#import "OnlyView.h"
#import "ScreeningView.h"

@interface FNPDDCategorySectionHeader()

//@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) OnlyView *Onlyview;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) QJSlideButtonView *slideView;

@end

@implementation FNPDDCategorySectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = UIColor.whiteColor;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    _titleView = [[UIView alloc] init];
    [self addSubview:_titleView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.mas_equalTo(39);
        make.width.mas_equalTo(XYScreenWidth);
    }];
    
    UIView *line1=[[UIView alloc]init];
    line1.backgroundColor=RGB(246, 246, 246);
    [_titleView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.bottom.equalTo(@1);
    }];
    
    
    _screeningView = [[ScreeningView alloc]initWithFrame:(CGRectMake(0, 40, FNDeviceWidth-60, 40))];
    _screeningView.backgroundColor  =FNWhiteColor;

    [self addSubview:_screeningView];
    
    UIView *line2=[[UIView alloc]init];
    line2.backgroundColor=RGB(246, 246, 246);
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(self.screeningView.mas_bottom).offset(0);
    }];
    
    UIView *Screeningline=[[UIView alloc]init];
    Screeningline.backgroundColor=RGB(246, 246, 246);
    [self addSubview:Screeningline];
    [Screeningline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.left.equalTo(self.screeningView.mas_right).offset(0);
//        make.top.equalTo(line.mas_bottom).offset(5);
        make.top.equalTo(self.screeningView);
        make.bottom.equalTo(line2.mas_top).offset(-5);
    }];
    
    UIButton *switchBtn=[[UIButton alloc]init];
    switchBtn.selected=YES;
    [switchBtn setImage:IMAGE(@"list_two") forState:UIControlStateNormal];
    [switchBtn setImage:IMAGE(@"list_one") forState:UIControlStateSelected];
    switchBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    switchBtn.imageEdgeInsets=UIEdgeInsetsMake(8, 0, 8, 0);
    [switchBtn addTarget:self action:@selector(switchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:switchBtn];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@45);
        make.bottom.equalTo(line2.mas_top).offset(-5);
        make.left.equalTo(Screeningline.mas_right).offset(0);
        make.right.equalTo(@0);
    }];
    
    OnlyView* Onlyview=[[OnlyView alloc]init];
    Onlyview.backgroundColor=FNWhiteColor;
    Onlyview.leftImage.image=IMAGE(@"list_quan");
    Onlyview.titleLabel.text=@"仅显示优惠券商品";
    [Onlyview.Switch addTarget:self action:@selector(SwitchClickOn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:Onlyview];
    [Onlyview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.right.equalTo(@0);
        make.top.equalTo(line2.mas_bottom).offset(0);
    }];
    self.Onlyview=Onlyview;
    
    UIView *line3=[[UIView alloc]init];
    line3.backgroundColor=RGB(246, 246, 246);
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(Onlyview.mas_bottom).offset(0);
    }];
    
}

- (void)switchButton: (UIButton*)sender {
    sender.selected = !sender.selected;
    if ([_delegate respondsToSelector:@selector(didRowStyleClick:)]) {
        [_delegate didRowStyleClick:!sender.selected];
    }
}
-(void)SwitchClickOn:(UISwitch *)sender{
    if ([_delegate respondsToSelector:@selector(didCuponClick:)]) {
        [_delegate didCuponClick:sender.on];
    }
}

-(void) setTitles: (NSMutableArray<NSString*>*)titles withBlock: (SBViewBlock)block{
    if (titles == nil || titles.count <= 0)
        return;
    if (_slideView) {
        [_slideView removeFromSuperview];
    }
    _slideView = [[QJSlideButtonView alloc] initWithTitleArr:titles withRoll:0 withTextColor:RED];
    [_titleView addSubview:_slideView];
    [_slideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    _slideView.sbBlock = block;
}

- (void)setCategoryAt: (NSInteger)index {
    
    [_slideView seScrollViewPitchOn:index isAnimate: NO];
    [_slideView setSBScrollViewContentOffset: index isAnimate:NO];
}

-(void)showFilter {
    UIView *filter = [[UIView alloc] init];
    filter.backgroundColor = UIColor.redColor;
    [self addSubview:filter];
    [filter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(200);
    }];
}

@end
