//
//  FNincomeNHeaderView.m
//  THB
//
//  Created by Jimmy on 2018/9/6.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//收支账单
#import "FNincomeNHeaderView.h"
#import "JMMineBillModel.h"
@implementation FNincomeNHeaderView
{
    UIButton * Selectbutton;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    self.imagebgView=[UIImageView new];
    [self.contentView addSubview:self.imagebgView];
    /** 冻结金额标题 **/
    self.frostTitle=[UILabel new];
    self.frostTitle.font=FNFontDefault(12);
    self.frostTitle.textAlignment=NSTextAlignmentCenter;
    self.frostTitle.textColor=[UIColor whiteColor];
    [self.imagebgView addSubview:self.frostTitle];
    /** 已到账金额标题 **/
    self.arriveTitle=[UILabel new];
    self.arriveTitle.font=FNFontDefault(12);
    self.arriveTitle.textAlignment=NSTextAlignmentCenter;
    self.arriveTitle.textColor=[UIColor whiteColor];
    [self.imagebgView addSubview:self.arriveTitle];
    /** 冻结金额标题 **/
    self.frostNumber=[UILabel new];
    self.frostNumber.font=FNFontDefault(12);
    self.frostNumber.textAlignment=NSTextAlignmentCenter;
    self.frostNumber.textColor=[UIColor whiteColor];
    [self.imagebgView addSubview:self.frostNumber];
    /** 冻结金额标题 **/
    self.arriveNumber=[UILabel new];
    self.arriveNumber.font=FNFontDefault(12);
    self.arriveNumber.textAlignment=NSTextAlignmentCenter;
    self.arriveNumber.textColor=[UIColor whiteColor];
    [self.imagebgView addSubview:self.arriveNumber];
    
    [self initdistribute];
    
    //图片scrollView
    _typeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 90, JMScreenWidth, 50)];
    _typeScrollView.backgroundColor=[UIColor whiteColor];
    _typeScrollView.alwaysBounceHorizontal = YES; // 水平方向弹簧效果
    _typeScrollView.alwaysBounceVertical = NO;
    _typeScrollView.directionalLockEnabled = YES;
    _typeScrollView.contentSize = CGSizeMake(JMScreenWidth, 45);
    [self.contentView addSubview:_typeScrollView];
    
    UILabel *line=[UILabel new];
    line.backgroundColor =FNColor(242,242,242);
    [self.contentView addSubview:line];
    line.sd_layout
    .bottomEqualToView(self.contentView).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(1);
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(receiveNotification:) name:@"incomeAll" object:nil];
    
}
- (void)receiveNotification:(NSNotification *)noti
{
    NSLog(@"%@ === %@ === %@", noti.object, noti.userInfo, noti.name);
    NSDictionary *dic=noti.userInfo;
    NSInteger seteted=[dic[@"selted"] integerValue];
    UIButton *button =(UIButton *)[self viewWithTag:seteted];
    [self selectClick:button];
}
-(void)initdistribute{
    UILabel *linecent=[UILabel new];
    [self.imagebgView addSubview:linecent];
    
    CGFloat space_10=10;
    
    linecent.sd_layout
    .bottomEqualToView(self.imagebgView).topSpaceToView(self.imagebgView, 0).centerXEqualToView(self.imagebgView).widthIs(1);
    
    self.imagebgView.sd_layout
    .topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
    //冻结金额标题
    self.frostTitle.sd_layout
    .topSpaceToView(self.imagebgView, space_10*2).leftSpaceToView(self.imagebgView, space_10*2).heightIs(20).rightSpaceToView(linecent,10);
    //已到账金额标题
    self.arriveTitle.sd_layout
    .topSpaceToView(self.imagebgView, space_10*2).heightIs(20).rightSpaceToView(self.imagebgView, space_10*2).leftSpaceToView(linecent, space_10);
    //冻结金额
    self.frostNumber.sd_layout
    .topSpaceToView(self.frostTitle, space_10).leftSpaceToView(self.imagebgView, space_10*2).rightSpaceToView(linecent, space_10).heightIs(20);
    //已到账金额标题
    self.arriveNumber.sd_layout
    .topSpaceToView(self.arriveTitle, space_10).leftSpaceToView(linecent, space_10).heightIs(20).rightSpaceToView(self.imagebgView, space_10*2);
}
-(void)setHeaderArr:(NSArray *)headerArr{
    
    XYLog(@"typeArr:%@",headerArr);
    _headerArr=headerArr;
    if(headerArr.count>0){
        self.imagebgView.image=IMAGE(@"bill_bjNew");
        FNheaderIncomeModel *oneModel=headerArr[0];
        FNheaderIncomeModel *TwoModel=headerArr[1];
        self.frostTitle.text=oneModel.name;
        self.arriveTitle.text=TwoModel.name;
        self.frostNumber.text=oneModel.val;
        self.arriveNumber.text=TwoModel.val;;
    }
    
}
-(void)setTypeArr:(NSArray *)typeArr{
    
    XYLog(@"typeArr:%@",typeArr);
    _typeArr=typeArr;
    
    
    CGFloat itemWidth = JMScreenWidth/5;
    _typeScrollView.contentSize = CGSizeMake(_typeArr.count*(itemWidth+10), 50);
    CGFloat itemHeight = 30;
    NSInteger loc = 0;
    CGFloat x = 0;
    CGFloat y = 10;
    for (NSInteger i = 0; i < _typeArr.count; i ++) {
        FNheaderTypeModel *model=typeArr[i];
        loc = i % _typeArr.count ;
        x = 10+(itemWidth+10) * loc ;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, itemWidth, itemHeight)];
        button.cornerRadius=5;
        button.tag =  i+100;
        if (i == 0) {
            button.selected = YES;
            Selectbutton = button;
        }
        button.titleLabel.font=FNFontDefault(12);
        [button setTitle:model.name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:FNColor(255,21,101) forState:UIControlStateSelected];
        button.backgroundColor=FNColor(242,242,242);
        [button addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.typeScrollView addSubview:button];
    }
}

//点击分类
-(void)selectClick:(UIButton*)btn{
    if (!btn.isSelected) {
        Selectbutton.selected = !Selectbutton.selected;
        btn.selected = !btn.selected;
        Selectbutton = btn;
    }
    if ([self.delegate respondsToSelector:@selector(ClickToIncomeClassify:)] ) {
        [self.delegate ClickToIncomeClassify:btn.tag];
    }
}
- (void)dealloc
{
    // 移除当前对象监听的事件
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}
@end
