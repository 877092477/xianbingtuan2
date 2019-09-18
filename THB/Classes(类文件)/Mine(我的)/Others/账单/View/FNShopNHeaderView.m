//
//  FNShopNHeaderView.m
//  THB
//
//  Created by Jimmy on 2018/9/6.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//购物section
#import "FNShopNHeaderView.h"
#import "JMMineBillModel.h"
@implementation FNShopNHeaderView
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
    //图片scrollView
    _typeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, JMScreenWidth, 50)];
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
    // 注册一个监听事件。第三个参数的事件名， 系统用这个参数来区别不同事件。
    [notiCenter addObserver:self selector:@selector(receiveNotification:) name:@"biliAll" object:nil];
    
}
- (void)receiveNotification:(NSNotification *)noti
{
    
    // NSNotification 有三个属性，name, object, userInfo，其中最关键的object就是从第三个界面传来的数据。name就是通知事件的名字， userInfo一般是事件的信息。
    NSLog(@"%@ === %@ === %@", noti.object, noti.userInfo, noti.name);
    NSDictionary *dic=noti.userInfo;
    NSInteger seteted=[dic[@"selted"] integerValue];
    
    UIButton *button =(UIButton *)[self viewWithTag:seteted];
    [self selectClick:button];
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
        loc = i % typeArr.count ;
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
    
    if ([self.delegate respondsToSelector:@selector(ClickToClassify:)] ) {
        [self.delegate ClickToClassify:btn.tag];
    }
}

- (void)dealloc
{
    // 移除当前对象监听的事件
    [[NSNotificationCenter defaultCenter] removeObserver:self]; 
    
}
@end
