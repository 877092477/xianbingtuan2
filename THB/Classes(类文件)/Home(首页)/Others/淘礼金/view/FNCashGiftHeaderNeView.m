//
//  FNCashGiftHeaderNeView.m
//  THB
//
//  Created by 李显 on 2018/10/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNCashGiftHeaderNeView.h"

@implementation FNCashGiftHeaderNeView
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    _titleView = [[JMTitleScrollView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 40)) titleArray:@[] fontSize:14 _textLength:4 andButtonSpacing:0 type:(VariableType)];
    _titleView.borderColor = FNHomeBackgroundColor;
    _titleView.borderWidth= 1.0;
    _titleView.tDelegate  =self;
    [self addSubview:_titleView];
    
    _line=[[UIView alloc]initWithFrame:CGRectMake(0, 40, FNDeviceWidth, 1)];
    _line.backgroundColor=RGB(246, 246, 246);
    [self addSubview:_line];
    
    _topSlideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 41, FNDeviceWidth-60, 40)];
    _topSlideBar.backgroundColor = FNWhiteColor;
    _topSlideBar.is_middle=NO;
    _topSlideBar.is_bubig=YES;
    [self addSubview:_topSlideBar];
    
    _Screeningline=[[UIView alloc]init];
    _Screeningline.backgroundColor=RGB(246, 246, 246);
    [self addSubview:_Screeningline];
    
    _line2=[[UIView alloc]init];
    _line2.backgroundColor=RGB(246, 246, 246);
    _line2.backgroundColor=[UIColor whiteColor];
    [self addSubview:_line2];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@5);
        make.top.equalTo(self.topSlideBar.mas_bottom).offset(0);
    }];
    
    _Screeningline.sd_layout.leftSpaceToView(_topSlideBar, 0).topEqualToView(_topSlideBar).widthIs(1).heightIs(40);
    
    _switchBtn=[[UIButton alloc]init];
    _switchBtn.selected=YES;
    [_switchBtn setImage:IMAGE(@"list_two") forState:UIControlStateNormal];
    [_switchBtn setImage:IMAGE(@"list_one") forState:UIControlStateSelected];
    _switchBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _switchBtn.imageEdgeInsets=UIEdgeInsetsMake(8, 0, 8, 0);
    [_switchBtn addTarget:self action:@selector(switchButton:) forControlEvents:UIControlEventTouchUpInside];
    _switchBtn.backgroundColor=[UIColor whiteColor];
    [self addSubview:_switchBtn];
    NSString *columnSwitch=[FNBaseSettingModel settingInstance].index_goods_columnSwitch;
    NSInteger singleInt=[columnSwitch integerValue];
    if(singleInt==0){
        _switchBtn.selected=NO;
    }else{
        _switchBtn.selected=YES;
    }
    [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(5);
        make.bottom.equalTo(_line2.mas_top).offset(0);
        make.left.equalTo(_Screeningline.mas_right).offset(0);
        make.right.equalTo(@0);
    }];
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(notice:) name:@"CashGiftSite" object:nil];
}
-(void)notice:(NSNotification *)sender{
    //NSLog(@"CashGiftSite:%@",sender.userInfo);
    NSInteger stateInt=[sender.userInfo[@"state"] integerValue];
    [_titleView setBottomViewAtIndex:stateInt];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)setClassifyArr:(NSArray *)classifyArr{
    _classifyArr=classifyArr;
    if(classifyArr.count>0){
        _titleView.titleArray=classifyArr; 
    }
}
-(void)setSortArr:(NSArray *)sortArr{
    _sortArr=sortArr;
    if(sortArr.count>0){
        NSMutableArray *name=[[NSMutableArray alloc]init];
        NSMutableArray *typeArray=[[NSMutableArray alloc]init];
        NSMutableArray *image1=[[NSMutableArray alloc]init];
        NSMutableArray *image2=[[NSMutableArray alloc]init];
        if (sortArr.count>0) {
            [sortArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [name addObject:[obj objectForKey:@"name"]];
                [typeArray addObject:[obj objectForKey:@"type"]];
                [image1 addObject:@""];
                [image2 addObject:@""];
            }];
        }
        self.topSlideBar.itemsTitle = name;
        self.topSlideBar.itemColor = FNBlackColor;
        self.topSlideBar.itemSelectedColor = FNMainGobalTextColor;
        self.topSlideBar.sliderColor = FNWhiteColor;
        self.topSlideBar.fontSize=12;
        self.topSlideBar.SelectedfontSize=12;
        @weakify(self);
        [_topSlideBar slideBarItemSelectedCallback:^(NSUInteger index) {
            NSString *type=typeArray[index];
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(CashGiftCarouselSortAction:withSite:)]) {
                [self.delegate CashGiftCarouselSortAction:type withSite:index];
            }
        }];
    }
}
- (void)clickedTitleView:(JMTitleScrollView *)titleView atIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(CashGiftCarouselClassifyAction:withIndexPath:)]) {
        [self.delegate CashGiftCarouselClassifyAction:index withIndexPath:self.indexPath];
    }
}
-(void)switchButton:(UIButton*)button{
    button.selected=!button.selected;
    NSString *columnSwitch=[FNBaseSettingModel settingInstance].index_goods_columnSwitch;
    NSInteger index=[columnSwitch integerValue];
    if (button.selected==YES) {
        index=1;
    }else{
        index=0;
    }
    if ([self.delegate respondsToSelector:@selector(CashGiftCarouselChangeAction:)]) {
        [self.delegate CashGiftCarouselChangeAction:index];
    }
}
-(void)setSeletedInt:(NSInteger)seletedInt{
    _seletedInt=seletedInt;
    if(seletedInt){
    }
}
-(void)setSortInt:(NSInteger)sortInt{
    _sortInt=sortInt;
    if(sortInt){
      [self.topSlideBar selectSlideBarItemAtIndex:sortInt];
    }
}
-(void)setSwitchInt:(NSInteger)switchInt{
    _switchInt=switchInt;
    if(switchInt==0){
        _switchBtn.selected=NO;
    }else{
        _switchBtn.selected=YES;
    }
}

@end
