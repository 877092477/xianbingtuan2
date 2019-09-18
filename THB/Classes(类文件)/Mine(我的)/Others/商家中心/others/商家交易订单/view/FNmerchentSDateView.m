//
//  FNmerchentSDateView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerchentSDateView.h"

@interface FNmerchentSDateView()

@property (nonatomic, strong) UILabel *lblOrder;
@property (nonatomic, strong) UIView *vOrders;

@property (nonatomic, strong) NSMutableArray<UIButton*> *buttons;
@property (nonatomic, strong) NSMutableArray *isSelecteds;

@end

@implementation FNmerchentSDateView

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor]; 
        [self initializedSubviews];
    } return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initializedSubviews];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}
- (void)initializedSubviews{
    _buttons = [[NSMutableArray alloc] init];
    _isSelecteds = [[NSMutableArray alloc] init];
    self.bgview=[[UIView alloc]init];
    [self addSubview:self.bgview];
    
    self.titleLB=[[UILabel alloc]init];
    [self.bgview addSubview:self.titleLB];
    
    self.zhiLB=[[UILabel alloc]init];
    [self.bgview addSubview:self.zhiLB];
    
    self.startBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgview addSubview:self.startBtn];
    
    self.endBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgview addSubview:self.endBtn];
    
    self.cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgview addSubview:self.cancelBtn];
    
    self.confirmBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgview addSubview:self.confirmBtn];
    
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textColor=RGB(24, 24, 24);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.zhiLB.font=[UIFont systemFontOfSize:12];
    self.zhiLB.textColor=RGB(24, 24, 24);
    self.zhiLB.textAlignment=NSTextAlignmentCenter;
    
    self.startBtn.titleLabel.font=kFONT12;
    self.startBtn.backgroundColor=[UIColor whiteColor]; 
    [self.startBtn setTitleColor:RGB(60, 60, 60) forState:UIControlStateNormal];
    self.startBtn.borderWidth=0.5;
    self.startBtn.borderColor = RGB(200, 200, 200);
    self.startBtn.cornerRadius=2;
    self.startBtn.clipsToBounds = YES;
    
    self.endBtn.titleLabel.font=kFONT11;
    self.endBtn.backgroundColor=[UIColor whiteColor];
    self.endBtn.cornerRadius=2;
    [self.endBtn setTitleColor:RGB(60, 60, 60) forState:UIControlStateNormal];
    self.endBtn.borderWidth=0.5;
    self.endBtn.borderColor = RGB(200, 200, 200);
    self.endBtn.cornerRadius=2;
    self.endBtn.clipsToBounds = YES;
    
    self.cancelBtn.titleLabel.font=kFONT16;
    self.cancelBtn.backgroundColor=[UIColor whiteColor];
    [self.cancelBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    
    self.confirmBtn.titleLabel.font=kFONT16;
    self.confirmBtn.backgroundColor=RGB(235, 90, 0);
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.bgview.backgroundColor=RGB(246, 245, 245);
    CGFloat bottomWitd=FNDeviceWidth/2;
    self.bgview.frame = CGRectMake(0, 0, FNDeviceWidth, 0);
//    self.bgview.sd_layout
//    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(137);
    
    _lblOrder = [[UILabel alloc] init];;
    _vOrders = [[UIView alloc] init];;
    [self.bgview addSubview:_lblOrder];
    [self.bgview addSubview:_vOrders];
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.bgview, 15).heightIs(50).rightSpaceToView(self.bgview, 15).topSpaceToView(self.bgview, 0);
    
    self.startBtn.sd_layout
    .leftSpaceToView(self.bgview, 15).topSpaceToView(self.titleLB, 0).widthIs(135).heightIs(28);
    
    self.startBtn.imageView.sd_layout
    .centerYEqualToView(self.startBtn).leftSpaceToView(self.startBtn, 10).widthIs(13).heightIs(13);
    
    self.startBtn.titleLabel.sd_layout
    .centerYEqualToView(self.startBtn).leftSpaceToView(self.startBtn, 33).rightSpaceToView(self.startBtn, 5);
    
    self.zhiLB.sd_layout
    .leftSpaceToView(self.startBtn, 0).heightIs(28).topSpaceToView(self.titleLB, 0).widthIs(30);
    
    self.endBtn.sd_layout
    .leftSpaceToView(self.zhiLB, 0).topSpaceToView(self.titleLB, 0).widthIs(135).heightIs(28);
    
    self.endBtn.imageView.sd_layout
    .centerYEqualToView(self.endBtn).leftSpaceToView(self.endBtn, 10).widthIs(13).heightIs(13);
    
    self.endBtn.titleLabel.sd_layout
    .centerYEqualToView(self.endBtn).leftSpaceToView(self.endBtn, 33).rightSpaceToView(self.endBtn, 5);
    
//    self.cancelBtn.sd_layout
//    .leftSpaceToView(self.bgview, 0).bottomSpaceToView(self.bgview, 0).widthIs(bottomWitd).heightIs(44);
//
//    self.confirmBtn.sd_layout
//    .leftSpaceToView(self.cancelBtn, 0).bottomSpaceToView(self.bgview, 0).widthIs(bottomWitd).heightIs(44);
    [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
//        make.height.mas_equalTo(200);
        
    }];
    [_lblOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@100);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_vOrders mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-20);
        make.top.equalTo(self.lblOrder.mas_bottom).offset(12);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(self.bgview.mas_centerX);
        make.height.mas_equalTo(44);
        make.top.equalTo(self.vOrders.mas_bottom).offset(10);
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(self.bgview.mas_centerX);
        make.height.mas_equalTo(44);
//        make.top.equalTo(self.vOrders.mas_bottom).offset(10);
    }];
    
    self.titleLB.text=@"精确时间筛选";
    self.zhiLB.text=@"至";
    [self.startBtn setImage:IMAGE(@"FN_menRiliimg") forState:UIControlStateNormal];
    [self.startBtn setTitle:@"选择开始时间" forState:UIControlStateNormal];
    [self.endBtn setImage:IMAGE(@"FN_menRiliimg") forState:UIControlStateNormal];
    [self.endBtn setTitle:@"选择结束时间" forState:UIControlStateNormal];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal]; 
//    self.bgview.hidden=YES;
//    self.titleLB.hidden=YES;
//    self.zhiLB.hidden=YES;
//    self.startBtn.hidden=YES;
//    self.endBtn.hidden=YES;
//    self.cancelBtn.hidden=YES;
//    self.confirmBtn.hidden=YES;
    
    self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    _lblOrder.textColor = RGB(24, 24, 24);
    _lblOrder.font = kFONT14;
    
}
-(void)startBtnClick{
    
}
#pragma mark - 显示
- (void)showView: (NSArray<NSString*>*)types {
    self.hidden = NO;
    _lblOrder.text = types.count > 0 ? @"订单类型" : @"";
    
    int ROW = 3;
    CGFloat width = (XYScreenWidth - 36) / 3 - 18;
    
    for (UIButton *button in self.buttons) {
        [button removeFromSuperview];
    }
    [self.buttons removeAllObjects];
    [self.isSelecteds removeAllObjects];
    
    for (NSInteger index = 0; index < types.count; index++) {
        [self.isSelecteds addObject:@(0)];
        UIButton *button = [[UIButton alloc] init];
        
        [self.buttons addObject: button];
        [self.vOrders addSubview: button];
        
        NSInteger column = index % ROW;
        NSInteger row = index / ROW;
        
        [_vOrders addSubview: button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (column == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(self.buttons[index - 1].mas_right).offset(18);
            }

            if (row == 0) {
                make.top.equalTo(@0);
            } else {
                make.top.equalTo(self.buttons[index - ROW].mas_bottom).offset(10);
            }
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(28);
            make.bottom.lessThanOrEqualTo(@0);
        }];
        
        [button setTitleColor: RGB(102, 102, 102) forState: UIControlStateNormal];
        [button setTitle:types[index] forState:UIControlStateNormal];
        button.backgroundColor = UIColor.whiteColor;
        [button addTarget:self action:@selector(typeAction:) forControlEvents:UIControlEventTouchUpInside];
        button.cornerRadius = 2.5;
        button.titleLabel.font = kFONT12;
        
    }
}

- (void)typeAction: (UIButton*)sender {
    
    NSInteger index = [_buttons indexOfObject: sender];
    UIButton *button = _buttons[index];
    if ([_isSelecteds[index] isEqual:@(0)]) {
        _isSelecteds[index] = @(1);
        
        [button setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
        button.backgroundColor = RGB(255, 71, 97);
    } else {
        _isSelecteds[index] = @(0);
        
        [button setTitleColor: RGB(102, 102, 102) forState: UIControlStateNormal];
        button.backgroundColor = UIColor.whiteColor;
    }
    
}

- (NSArray*) getSelecteds {
    return _isSelecteds;
}

//-(void)showView{
//    [UIView animateWithDuration:0.25 animations:^{
//        self.bgview.frame = CGRectMake(0, 0, FNDeviceWidth, 137);
//        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.3];
//        // [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.3];
//        self.bgview.hidden=NO;
////        self.titleLB.hidden=NO;
////        self.zhiLB.hidden=NO;
////        self.startBtn.hidden=NO;
////        self.endBtn.hidden=NO;
//    } completion:^(BOOL finished) {
//        self.cancelBtn.hidden=NO;
//        self.confirmBtn.hidden=NO;
//        self.titleLB.hidden=NO;
//        self.zhiLB.hidden=NO;
//        self.startBtn.hidden=NO;
//        self.endBtn.hidden=NO;
//    }];
//}
#pragma mark - 隐藏
-(void)hideViewAction{
    self.hidden = YES;
//    self.bgview.frame = CGRectMake(0, 0, FNDeviceWidth, 137);
//    self.cancelBtn.hidden=YES;
//    self.confirmBtn.hidden=YES;
//    //self.backgroundColor = [UIColor clearColor];
//    [UIView animateWithDuration:0.25 animations:^{
//        self.bgview.frame = CGRectMake(0, 0, FNDeviceWidth, 0);
//        self.bgview.hidden=YES;
//        self.titleLB.hidden=YES;
//        self.zhiLB.hidden=YES;
//        self.startBtn.hidden=YES;
//        self.endBtn.hidden=YES;
//        self.hidden = YES;
//    } completion:^(BOOL finished) {
//        self.hidden = YES;
//        [self removeFromSuperview];
//    }];
}
@end
