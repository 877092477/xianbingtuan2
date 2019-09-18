//
//  FNcateSortDeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/17.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNcateSortDeCell.h"

@implementation FNcateSortDeCell
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        //self.index_goods_01List = [NSArray new];
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews
{
    
    //商品分栏模块
    self.slideBarView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 40)];
    self.slideBarView.backgroundColor=FNWhiteColor;
    [self addSubview:self.slideBarView];
    
    UIImageView* img = [[UIImageView alloc]initWithImage:IMAGE(@"home_highRebate")];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.clipsToBounds = YES;
    [_slideBarView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(self.slideBarView.mas_centerX);
        make.height.equalTo(@40);
        //make.width.equalTo(@(img.size.width));
    }];
    [img setUrlImg:[FNBaseSettingModel settingInstance].index_cgfjx_ico];
    
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 40, FNDeviceWidth, 1)];
    line.backgroundColor=RGB(246, 246, 246);
    [self addSubview:line];
    
    self.screeningView = [[ScreeningView alloc]initWithFrame:(CGRectMake(0, 41, FNDeviceWidth-60, 40))];
    self.screeningView.genreString=@"record";
    self.screeningView.backgroundColor  =FNWhiteColor;
    [self addSubview:self.screeningView];
    @weakify(self);
    self.screeningView.clickedWithType = ^(NSString *type) {
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(cateGoodsSortAction:)]) {
            [self.delegate cateGoodsSortAction:type];
        }
    };
    
    UIView *Screeningline=[[UIView alloc]init];
    Screeningline.backgroundColor=RGB(246, 246, 246);
    [self addSubview:Screeningline];
    
    UIView *line2=[[UIView alloc]init];
    line2.backgroundColor=RGB(246, 246, 246);
    [self addSubview:line2];
    
    UIButton *switchBtn=[[UIButton alloc]init];
    switchBtn.selected=YES;
    [switchBtn setImage:IMAGE(@"list_two") forState:UIControlStateNormal];
    [switchBtn setImage:IMAGE(@"list_one") forState:UIControlStateSelected];
    switchBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    switchBtn.imageEdgeInsets=UIEdgeInsetsMake(8, 0, 8, 0);
    [switchBtn addTarget:self action:@selector(switchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:switchBtn];
    
    self.screeningView.sd_layout
    .bottomSpaceToView(self, 0).leftSpaceToView(self, 0).widthIs(FNDeviceWidth-60).heightIs(40);
    line.sd_layout
    .bottomSpaceToView(_screeningView, 0).widthIs(FNDeviceWidth).heightIs(1);
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(self.screeningView.mas_bottom).offset(0);
    }];
    Screeningline.sd_layout
    .leftSpaceToView(self.screeningView, 0).topEqualToView(self.screeningView).widthIs(1).heightIs(40);
    
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(5);
        make.bottom.equalTo(line2.mas_top).offset(-5);
        make.left.equalTo(Screeningline.mas_right).offset(0);
        make.right.equalTo(@0);
    }];
    
    self.line=line;
    self.line2=line2;
    self.Screeningline=Screeningline;
    self.switchBtn=switchBtn;
    
}
-(void)switchButton:(UIButton *)btn{
    btn.selected=!btn.selected;
    NSInteger state=0;
    if (btn.selected==YES) {
        state=1;
    }else{
        state=0;
    }
    if ([self.delegate respondsToSelector:@selector(cateGoodsComposingAction:)]) {
        [self.delegate cateGoodsComposingAction:state];
    }
}
-(void)setSortArr:(NSArray *)sortArr{
    _sortArr=sortArr;
    if(sortArr){
        NSMutableArray *name=[[NSMutableArray alloc]init];
        NSMutableArray *type=[[NSMutableArray alloc]init];
        NSMutableArray *image1=[[NSMutableArray alloc]init];
        NSMutableArray *image2=[[NSMutableArray alloc]init];
        
        if (sortArr.count>0) {
            [sortArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [name addObject:[obj objectForKey:@"name"]];
                [type addObject:[obj objectForKey:@"type"]];
                [image1 addObject:@""];
                [image2 addObject:@""];
            }];
        }
        //NSLog(@"type:%@",type);
        [self.screeningView setTitles:name images:image1 selectedImage:image2 types:type];
    }
}
-(void)setCategoryId:(NSString *)categoryId{
    _categoryId=categoryId;
    if([categoryId isEqualToString:@"0"]){
        _screeningView.hidden=YES;
        //[_screeningView removeFromSuperview];
        self.line.hidden=YES;
        self.line2.hidden=YES;
        self.Screeningline.hidden=YES;
        self.switchBtn.hidden=YES;
    }
}
-(void)setSingleType:(BOOL)singleType{
    _singleType=singleType;
    if (singleType) {
        self.switchBtn.selected=!singleType;
    }
}
@end
