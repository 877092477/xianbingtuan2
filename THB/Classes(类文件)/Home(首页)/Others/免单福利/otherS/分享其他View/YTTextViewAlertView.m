//
//  YTTextViewAlertView.m
//  YTTextViewAlertView
//
//  Created by TonyAng on 2018/4/23.
//  Copyright © 2018年 TonyAng. All rights reserved.
//

/** 手机屏 比例 */
#define kIphone6Width 375.0
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define kFit(x) (Screen_Width*((x)/kIphone6Width))
#define UIColorFromR_G_B(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//分割线颜色
#define main_line_color             UIColorFromR_G_B(243, 243, 243, 1)

//主题色
#define main_color                  UIColorFromR_G_B(254, 152, 8, 1)

//浅色字体主题色
#define main_font_light_color       UIColorFromR_G_B(153, 153, 153, 1)

//深色字体主题色
#define main_font_deep_color        UIColorFromR_G_B(51, 51, 51, 1)

#import "YTTextViewAlertView.h"
#import "Masonry.h"
@interface YTTextViewAlertView()<UITextFieldDelegate>
//<UITextViewDelegate>
@property (nonatomic,strong) UIView *alertview;

@property (nonatomic,strong) UILabel *repulse_label;//打回

@property (nonatomic,strong) UITextView *repulse_content_textView;//输入评价内容
@property (nonatomic, copy) NSString *repulse_content_str;//输入评价内容

@property (nonatomic,strong) UILabel *describeLabel;//描述
@property (nonatomic,strong) UITextField *tfField;//输入评价内容

@property (nonatomic,strong) UILabel *max_textCont_label;//500字内
@property (nonatomic,strong) UIButton *repulse_cancel_button;//取消
@property (nonatomic,strong) UIButton *repulse_makeSure_button;//打回

@end

@implementation YTTextViewAlertView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.alertview.frame = CGRectMake(Screen_Width/2 - kFit(200)/2, kFit(180) + ([NSStringFromCGSize([UIScreen mainScreen].bounds.size) isEqualToString:@"{375, 812}"] ? 88.0 : 64.0), kFit(200), kFit(180));
        //        self.alertview.center = self.center;
        self.alertview.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.alertview];
        [self createYTStsrAlertView];
    }
    return self;
}

-(void)createYTStsrAlertView{
    //打回
    self.repulse_label = [UILabel new];
    [self.alertview addSubview:self.repulse_label];
    [self.repulse_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kFit(20));
        make.centerX.equalTo(self.mas_centerX);
    }];
    self.repulse_label.text = @"请输入单号";
    self.repulse_label.textColor =  RGB(129, 128, 129);
    self.repulse_label.font = [UIFont systemFontOfSize:kFit(12)];
    
    //输入评价内容
//    self.repulse_content_textView = [UITextView new];
//    [self.alertview addSubview:self.repulse_content_textView];
//    [self.repulse_content_textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.repulse_label.mas_bottom).offset(kFit(20));
//        make.left.offset(kFit(20));
//        make.right.offset(-kFit(20));
//        make.height.offset(kFit(75));
//    }];
//    self.repulse_content_textView.delegate = self;
//    self.repulse_content_textView.text = @"请描述您遇到的问题，以便我们更好的了解您的需求做出改进～";
//    self.repulse_content_textView.textColor = UIColorFromR_G_B(204, 204, 204, 1);
//    self.repulse_content_textView.font = [UIFont systemFontOfSize:kFit(10)];
    
    self.describeLabel= [UILabel new];
    self.describeLabel.numberOfLines=2;
    self.describeLabel.textColor = RGB(129, 128, 129);
    //self.describeLabel.text=@"亲，订单号补充后不可修改,补充错误将无法获得补贴，请谨慎提填写";
    self.describeLabel.textAlignment=NSTextAlignmentCenter;
    self.describeLabel.font = [UIFont systemFontOfSize:kFit(12)];
    [self.alertview addSubview:self.describeLabel];
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.repulse_label.mas_bottom).offset(kFit(10));
        make.left.offset(kFit(10));
        make.right.offset(-kFit(10));
        make.height.offset(kFit(35));
    }];
    
    
    self.tfField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, 200)];
    self.tfField.delegate=self;
    self.tfField.font =[UIFont systemFontOfSize:kFit(12)];// kFONT12;
    self.tfField.placeholder = @"单号:";
    self.tfField.borderStyle = UITextBorderStyleRoundedRect;
        self.tfField.backgroundColor = [UIColor redColor];
    [self.tfField setBackground:IMAGE(@"")];
    [self.alertview addSubview:self.tfField];
    [self.tfField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.describeLabel.mas_bottom).offset(kFit(10));
        make.left.offset(kFit(20));
        make.right.offset(-kFit(20));
        make.height.offset(kFit(25));
    }];
    self.tfField.backgroundColor=[UIColor whiteColor];
    self.tfField.borderWidth=0.5;
    self.tfField.borderColor = FNGlobalTextGrayColor;
    self.tfField.cornerRadius=kFit(25/2);
    self.tfField.clipsToBounds = YES;
    //500字内
//    self.max_textCont_label = [UILabel new];
//    [self.alertview addSubview:self.max_textCont_label];
//    [self.max_textCont_label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(-kFit(15));
//        make.bottom.offset(-kFit(43));
//    }];
//    self.max_textCont_label.text = @"500字内";
//    self.max_textCont_label.textColor = main_font_light_color;
//    self.max_textCont_label.font = [UIFont systemFontOfSize:kFit(10)];
    
    //取消
    self.repulse_cancel_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.alertview addSubview:self.repulse_cancel_button];
    [self.repulse_cancel_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kFit(20));
        make.top.equalTo(self.tfField.mas_bottom).offset(kFit(18));
        make.height.offset(kFit(20));
        make.width.offset(kFit(60));
    }];
    self.repulse_cancel_button.backgroundColor = RGB(244, 62, 121);
    [self.repulse_cancel_button setTitle:@"确定" forState:UIControlStateNormal];
    [self.repulse_cancel_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.repulse_cancel_button.titleLabel.font = [UIFont systemFontOfSize:kFit(12)];
    [self.repulse_cancel_button addTarget:self action:@selector(evaluate_makeSure_buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.repulse_cancel_button.cornerRadius=kFit(20/2);
    
    
    //确定
    self.repulse_makeSure_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.alertview addSubview:self.repulse_makeSure_button];
    [self.repulse_makeSure_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfField.mas_bottom).offset(kFit(18));
        make.right.offset(-kFit(20));
        make.height.offset(kFit(20));
        make.width.offset(kFit(60));
    }];
    self.repulse_makeSure_button.backgroundColor = [UIColor whiteColor];
    [self.repulse_makeSure_button setTitle:@"取消" forState:UIControlStateNormal];
    [self.repulse_makeSure_button setTitleColor:RGB(244, 62, 121) forState:UIControlStateNormal];
    self.repulse_makeSure_button.titleLabel.font = [UIFont systemFontOfSize:kFit(12)];
    [self.repulse_makeSure_button addTarget:self action:@selector(evaluate_cancel_buttonAction) forControlEvents:UIControlEventTouchUpInside];
    self.repulse_makeSure_button.borderWidth=0.5;
    self.repulse_makeSure_button.borderColor = RGB(244, 62, 121);
    self.repulse_makeSure_button.cornerRadius=kFit(20/2);
    self.repulse_makeSure_button.clipsToBounds = YES;
}

#pragma mark -
#pragma mark -------->取消Action
-(void)evaluate_cancel_buttonAction{
    NSLog(@"取消了----view");
    if (self.ytAlertViewCloseBlock) {
        self.ytAlertViewCloseBlock();
        [self dismissAlertView];
    }
}

#pragma mark -
#pragma mark -------->确定Action
-(void)evaluate_makeSure_buttonAction{
    NSLog(@"输入-----view");
    
    if(![UserAccessToken kr_isNotEmpty]){
        [FNTipsView showTips: @"请先登录"];
        return;
    }
    else if(![self.tfField.text kr_isNotEmpty]){
        [FNTipsView showTips: @"请输入单号"];
        return;
    }else{
        if (self.ytAlertViewMakeSureBlock) {
            self.ytAlertViewMakeSureBlock(self.tfField.text);
            [self dismissAlertView];
        }
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self upwardmovementView];
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self backtrackView];
}
//向上
-(void)upwardmovementView{
    [UIView animateWithDuration:0.3 // 动画时长
                          delay:0.0 // 动画延迟
                        options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
                     animations:^{
                         self.alertview.frame = CGRectMake(Screen_Width/2 - kFit(200)/2, ([NSStringFromCGSize([UIScreen mainScreen].bounds.size) isEqualToString:@"{375, 812}"] ? 88.0 : 64.0), kFit(200), kFit(180));
                     }
                     completion:^(BOOL finished) {
                         // 动画完成后执行
                     }];
    
}
//返回原来的位置
-(void)backtrackView{
    [UIView animateWithDuration:0.3 // 动画时长
                          delay:0.0 // 动画延迟
                        options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
                     animations:^{
                         self.alertview.frame = CGRectMake(Screen_Width/2 - kFit(200)/2, kFit(130) + ([NSStringFromCGSize([UIScreen mainScreen].bounds.size) isEqualToString:@"{375, 812}"] ? 88.0 : 64.0), kFit(200), kFit(180));
                     }
                     completion:^(BOOL finished) {
                         // 动画完成后执行
                     }];
}

#pragma mark -
#pragma mark -------->textViewDidBeginEditing
- (void)textViewDidBeginEditing:(UITextView *)textView {
    [UIView animateWithDuration:0.3 // 动画时长
                          delay:0.0 // 动画延迟
                        options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
                     animations:^{
                         self.alertview.frame = CGRectMake(Screen_Width/2 - kFit(290)/2, ([NSStringFromCGSize([UIScreen mainScreen].bounds.size) isEqualToString:@"{375, 812}"] ? 88.0 : 64.0), kFit(290), kFit(189));
                     }
                     completion:^(BOOL finished) {
                         // 动画完成后执行
                     }];
    if([textView.text isEqualToString:@"请描述您遇到的问题，以便我们更好的了解您的需求做出改进～"]){
        textView.text=@"";
        textView.textColor = main_font_deep_color;
        
    }
}

#pragma mark - textViewDidEndEditing
- (void)textViewDidEndEditing:(UITextView *)textView {
    [UIView animateWithDuration:0.3 // 动画时长
                          delay:0.0 // 动画延迟
                        options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
                     animations:^{
                         self.alertview.frame = CGRectMake(Screen_Width/2 - kFit(290)/2, kFit(130) + ([NSStringFromCGSize([UIScreen mainScreen].bounds.size) isEqualToString:@"{375, 812}"] ? 88.0 : 64.0), kFit(290), kFit(189));
                     }
                     completion:^(BOOL finished) {
                         // 动画完成后执行
                     }];
    
    if(textView.text.length < 1){
        textView.text = @"请描述您遇到的问题，以便我们更好的了解您的需求做出改进～";
        textView.textColor = UIColorFromR_G_B(204, 204, 204, 1);
    }else{
        textView.textColor = [UIColor blackColor];
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    
    NSString *lang = textView.textInputMode.primaryLanguage;//键盘输入模式
    static NSInteger length = 0;
    if ([lang isEqualToString:@"zh-Hans"]){
        UITextRange *selectedRange = [textView markedTextRange];
        if (!selectedRange) {//没有有高亮
            length = textView.text.length;
        }else{
            
        }
    }else{
        length = textView.text.length;
    }
    
    NSLog(@"length------->%ld",(long)length);
    
    if (length > 500 ) {
        //        self.iWantPraiseViewTextView.text =  [self.iWantPraiseViewTextView.text substringToIndex:200];
    }
}

#pragma mark -
#pragma mark -------->打回set方法
-(void)setYtAlertViewMakeSureBlock:(void (^)(NSString *))ytAlertViewMakeSureBlock{
    _ytAlertViewMakeSureBlock = ytAlertViewMakeSureBlock;
}

#pragma mark -
#pragma mark -------->取消set方法
-(void)setYtAlertViewCloseBlock:(void (^)(void))ytAlertViewCloseBlock{
    _ytAlertViewCloseBlock = ytAlertViewCloseBlock;
}

-(UIView *)alertview
{
    if (_alertview == nil) {
        _alertview = [[UIView alloc] init];
        _alertview.backgroundColor = [UIColor whiteColor];
        _alertview.layer.cornerRadius = 5.0;
        _alertview.layer.masksToBounds = YES;
        _alertview.userInteractionEnabled = YES;
    }
    return _alertview;
}

-(void)show
{
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    
    self.alertview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertview.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = UIColorFromR_G_B(1, 1, 1, 0.3f);
        self.alertview.transform = transform;
        self.alertview.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismissAlertView{
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}
-(void)setContentString:(NSString *)contentString{
    
    _contentString=contentString;
    if(contentString){
        XYLog(@"contentString=:%@",contentString);
        self.describeLabel.text=contentString;//@"亲，订单号补充后不可修改,补充错误将无法获得补贴，请谨慎提填写";
        if([contentString kr_isNotEmpty]){
            NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.describeLabel.text];
            NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:5];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.describeLabel.text length])];
            [self.describeLabel setAttributedText:attributedString];
        }
        
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

