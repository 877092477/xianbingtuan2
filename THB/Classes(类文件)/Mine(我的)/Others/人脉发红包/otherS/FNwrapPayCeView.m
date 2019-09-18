//
//  FNwrapPayCeView.m
//  THB
//
//  Created by Jimmy on 2019/2/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//
#define DEFAULT_MAX_HEIGHT  285
//SCREEN_WIDTH*0.8
//SCREEN_HEIGHT/3*2
/** 屏幕高度 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SELAnimationTimeInterval  0.5f
//屏幕适配
/**当前设备对应375的比例*/
#define Ratio_375 (SCREEN_WIDTH/375.0)
/**转换成当前比例的数*/
#define Ratio(x) ((int)((x) * Ratio_375))

#import "FNwrapPayCeView.h"
 
@implementation FNwrapPayCeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
+ (void)showPayCeView
{
    FNwrapPayCeView *calendarView = [[FNwrapPayCeView alloc]init];
    [[UIApplication sharedApplication].delegate.window addSubview:calendarView];
}
-(void)setUpAllView{
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3/1.0];
    
    //bgView最大高度
    CGFloat maxHeight = DEFAULT_MAX_HEIGHT-50;
    //backgroundView
    UIView *bgPayView = [[UIView alloc]init];
    bgPayView.center = self.center;
    bgPayView.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self addSubview:bgPayView];
    //白色view
    self.whiteView = [[UIView alloc]initWithFrame:CGRectMake(40, SCREEN_HEIGHT/2-maxHeight/2-55, SCREEN_WIDTH-80, maxHeight)];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    self.whiteView.layer.masksToBounds = YES;
    self.whiteView.layer.cornerRadius = 4.0f;
    [bgPayView addSubview:self.whiteView];
    
    bgPayView.userInteractionEnabled = YES;
   
    self.whiteView.userInteractionEnabled = YES;
    //UITapGestureRecognizer *whitetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewClick)];
    //[self.whiteView addGestureRecognizer:whitetap];
    
    self.titleLB=[[UILabel alloc]init];
    self.titleLB.font=kFONT15;
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    self.titleLB.text=@"请输入支付密码";
    [self.whiteView addSubview:self.titleLB];
    
    self.headImg=[[UIImageView alloc]init];
    //self.headImg.backgroundColor=[UIColor lightGrayColor];
    [self.whiteView addSubview:self.headImg];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setImage:[UIImage imageNamed:@"FJ_CA_img"]  forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteView addSubview:cancelButton];
    
    self.lineOne=[[UIView alloc]init];
    self.lineOne.backgroundColor=RGB(204, 204, 204);
    [self.whiteView addSubview:self.lineOne];
    
    self.sumLB=[[UILabel alloc]init];
    self.sumLB.font=[UIFont systemFontOfSize:20];
    self.sumLB.textAlignment=NSTextAlignmentCenter;
    [self.whiteView addSubview:self.sumLB];
    
    self.lineTwo=[[UIView alloc]init];
    self.lineTwo.backgroundColor=RGB(204, 204, 204);
    [self.whiteView addSubview:self.lineTwo];
    
    self.titleLB.sd_layout
    .topSpaceToView(self.whiteView, 10).centerXEqualToView(self.whiteView).widthIs(7*15+5).heightIs(45);
    
    self.headImg.sd_layout
    .rightSpaceToView(self.titleLB, 15).centerYEqualToView(self.titleLB).widthIs(20).heightIs(20);
    
    cancelButton.sd_layout
    .rightSpaceToView(self.headImg, 15).centerYEqualToView(self.titleLB).widthIs(20).heightIs(20);
    
    self.lineOne.sd_layout
    .leftSpaceToView(self.whiteView, 25).rightSpaceToView(self.whiteView, 25).topSpaceToView(self.titleLB, 0).heightIs(1);
    
    self.sumLB.sd_layout
    .leftSpaceToView(self.whiteView, 25).rightSpaceToView(self.whiteView, 25).topSpaceToView(self.lineOne, 0).heightIs(50);
    
    self.lineTwo.sd_layout
    .leftSpaceToView(self.whiteView, 25).rightSpaceToView(self.whiteView, 25).topSpaceToView(self.sumLB, 0).heightIs(1);
    
    
    [self payModelView];
    
    [self importView];
    
    //显示
    [self showWithAlert:bgPayView];
    
}
#pragma mark - // 取消按钮点击事件
- (void)cancelAction
{
    [self dismissAlert];
}
#pragma mark - //添加Alert入场动画
- (void)showWithAlert:(UIView*)alert{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = SELAnimationTimeInterval;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [alert.layer addAnimation:animation forKey:nil];
}
#pragma mark - // 添加Alert出场动画
- (void)dismissAlert{
    [UIView animateWithDuration:SELAnimationTimeInterval animations:^{
        self.transform = (CGAffineTransformMakeScale(1.5, 1.5));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ]; 
}
#pragma mark - 支付方式
-(void)payModelView{
    CGFloat tableHeight=150;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.pay_collectionview= [[UICollectionView alloc]initWithFrame:CGRectMake(25, 100, SCREEN_WIDTH-80-50, tableHeight) collectionViewLayout:flowlayout];
    self.pay_collectionview.backgroundColor=[UIColor whiteColor];
    self.pay_collectionview.dataSource = self;
    self.pay_collectionview.delegate = self;
    self.pay_collectionview.showsVerticalScrollIndicator=NO;
    self.pay_collectionview.showsHorizontalScrollIndicator=NO;
    [self.pay_collectionview registerClass:[FNwrapPayItemAeCell class] forCellWithReuseIdentifier:@"FNpayModelCellID"];
    [self.whiteView addSubview:self.pay_collectionview];
    self.pay_collectionview.userInteractionEnabled = YES;
    self.pay_collectionview.sd_layout
    .leftSpaceToView(self.whiteView, 25).rightSpaceToView(self.whiteView, 25).topSpaceToView(self.lineTwo, 10).heightIs(150);
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNwrapPayItemAeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNpayModelCellID" forIndexPath:indexPath];
    cell.backgroundColor =[UIColor whiteColor];
    cell.model=self.dataArr[indexPath.row];
    return cell;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=SCREEN_WIDTH-80-50;
    CGFloat height=50;
    CGSize size = CGSizeMake(with, height);
    return size;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNpackagePayNaModel *model=self.dataArr[indexPath.row];
    self.payType=model.payType;
    for (FNpackagePayNaModel *itemModel in self.dataArr) {
        if(model.payId==itemModel.payId){
            if(itemModel.state==0){
                itemModel.state=1;
            }else{
                itemModel.state=0;
            }
        }else{
            itemModel.state=0;
        }
    }
    if([model.payType isEqualToString:@"money"]){
        if(model.state ==1){
        self.payPasswordView.hidden=NO;
        [self upwardVoidAction];
        [self.payPasswordView.textField becomeFirstResponder];
        }else{
                self.payPasswordView.hidden=YES;
                [self backAction];
                [self.payPasswordView.textField resignFirstResponder];
        }
        
    }else{
        if ([self.delegate respondsToSelector:@selector(inBackPasswordString:payModel:)]){
            [self.delegate inBackPasswordString:@"" payModel:self.payType];
        }
        [self dismissAlert];
    }
    [self.pay_collectionview reloadData];
}
-(void)importView{
    
    self.payPasswordView=[[FNPayPasswordCeView alloc]init];
    self.payPasswordView.frame=CGRectMake(0, 161, SCREEN_WIDTH-80, 100);
    self.payPasswordView.backgroundColor=[UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    [self.payPasswordView addJXTouch:^{
      __strong typeof(weakSelf) self = weakSelf;
      [self upwardVoidAction];
      [self.payPasswordView.textField becomeFirstResponder];
    }];
    self.payPasswordView.hidden=YES;
    
    self.payPasswordView.completionBlock = ^(NSString *password) {
        ///XYLog(@"password=:%@",password);
        [weakSelf bgViewClick];
        
        if ([weakSelf.delegate respondsToSelector:@selector(inBackPasswordString:payModel:)])
        {
            [weakSelf.delegate inBackPasswordString:password payModel:weakSelf.payType];
            //[weakSelf dismissAlert];
        }
    };
    [self.whiteView addSubview:self.payPasswordView];
    UIView *lineView=[[UIView alloc]init];
    lineView.backgroundColor=RGB(204, 204, 204);
    [self.payPasswordView addSubview:lineView];
    self.payPasswordView.sd_layout
    .leftSpaceToView(self.whiteView, 0).rightSpaceToView(self.whiteView, 0).topSpaceToView(self.lineTwo, 61).heightIs(100);
    
    lineView.sd_layout
    .leftSpaceToView(self.payPasswordView, 25).rightSpaceToView(self.payPasswordView, 25).topSpaceToView(self.payPasswordView, 15).heightIs(1);
}

-(void)upwardVoidAction{
    [UIView animateWithDuration:0.25 animations:^{
        self.whiteView.frame = CGRectMake(40, SCREEN_HEIGHT/2-DEFAULT_MAX_HEIGHT/2-100, SCREEN_WIDTH-80, DEFAULT_MAX_HEIGHT);
    } completion:^(BOOL finished) {
        
    }];
}
-(void)backAction{
    [UIView animateWithDuration:0.25 animations:^{
        self.whiteView.frame = CGRectMake(40, SCREEN_HEIGHT/2-DEFAULT_MAX_HEIGHT/2-55, SCREEN_WIDTH-80, DEFAULT_MAX_HEIGHT);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)bgViewClick{
    [self backAction];
    [self.payPasswordView.textField resignFirstResponder];
    
    //[self.payPasswordView didInputPasswordError];
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr.count>0){
      [self.pay_collectionview reloadData];
    }
}
@end
