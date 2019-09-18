//
//  FeedBackViewController.m
//  THB
//
//  Created by zhongxueyu on 16/3/31.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "FeedBackViewController.h"
#import "FNCustomeTextView.h"
#define MARGIN 25
@interface FeedBackViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong)UIScrollView* mainview;
@property (nonatomic, strong)FNCustomeTextView* textview;
@property (nonatomic, strong)UITextField* typeTF;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, strong)UITextField* contactTF;

@property (nonatomic,strong) UITextView *feedbackTV;
@property (nonatomic,strong) UIButton *confirmBtn;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,assign) BOOL isConfirm;

@end

@implementation FeedBackViewController
@synthesize feedbackTV,textView;
- (UITextField *)typeTF{
    if (_typeTF == nil) {
        _typeTF = [UITextField new];
        _typeTF.text = @"请选择";
        _typeTF.font = kFONT14;
        _typeTF.enabled = NO;
        _typeTF.borderStyle = UITextBorderStyleRoundedRect;
    

        UIImageView* rightimgview = [[UIImageView alloc]initWithImage:IMAGE(@"view_off")];
        rightimgview.size = CGSizeMake(44, 44);
        rightimgview.contentMode = UIViewContentModeCenter;
        _typeTF.rightView = rightimgview;
        _typeTF.rightViewMode = UITextFieldViewModeAlways;
    }
    return _typeTF;
}
- (UITextField *)contactTF{
    if (_contactTF == nil) {
        _contactTF = [UITextField new];
        _contactTF.font = kFONT14;
        _contactTF.placeholder = @"请输入联系方式";
        _contactTF.keyboardType = UIKeyboardTypePhonePad;
        _contactTF.borderStyle = UITextBorderStyleRoundedRect;
        _contactTF.delegate = self;
    }
    return _contactTF;
}
- (UIButton *)confirmBtn{
    if (_confirmBtn == nil) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_confirmBtn.layer setMasksToBounds:YES];
        [_confirmBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = kFONT15;
        _confirmBtn.titleLabel.textColor = [UIColor whiteColor];
        _confirmBtn.backgroundColor = RED;
        [_confirmBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
- (FNCustomeTextView *)textview{
    if (_textview == nil) {
        _textview = [[FNCustomeTextView alloc]initWithFrame:(CGRectMake(MARGIN, MARGIN, XYScreenWidth-MARGIN*2, XYScreenHeight/3))];
        _textview.placeholderColor = FNGlobalTextGrayColor;
        _textview.placeholder = @"请输入要反馈的内容";
        _textview.placeHolderLabel.font = kFONT14;
        _textview.borderColor = FNHomeBackgroundColor;
        _textview.borderWidth = 1;
        _textview.cornerRadius = 5;
    }
    return _textview;
}
- (UIScrollView *)mainview{
    if (_mainview == nil) {
        _mainview = [UIScrollView new];
        _mainview.showsVerticalScrollIndicator = NO;
        
        [_mainview addSubview:self.textview];
        [self.textview autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:MARGIN];
        [self.textview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:MARGIN];
        [self.textview autoSetDimension:(ALDimensionHeight) toSize:self.textview.height];
        [self.textview autoSetDimension:(ALDimensionWidth) toSize:self.textview.width];
        
        UILabel* typeLabel = [UILabel new];
        typeLabel.text = @"*反馈类型";
        typeLabel.font = kFONT14;
        [_mainview addSubview:typeLabel];
        [typeLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.textview withOffset:MARGIN];
        [typeLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.textview];
        [typeLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.textview];
        
        [_mainview addSubview:self.typeTF];
        [self.typeTF autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:typeLabel withOffset:5];
        [self.typeTF autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.textview];
        [self.typeTF autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.textview];
        [self.typeTF autoSetDimension:(ALDimensionHeight) toSize:44];
        
        UIView* typeview = [UIView new];
        @weakify(self);
        [typeview addJXTouch:^{
            @strongify(self);
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请选择类型" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
            NSArray* titles = @[@"功能出错",@"信息错误",@"出现闪退",@"页面错乱",@"出现乱码",@"取消"];
            [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [alert addAction:[UIAlertAction actionWithTitle:obj style:(idx==titles.count-1?UIAlertActionStyleCancel:UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    //
                    if (action.style != UIAlertActionStyleCancel) {
                        self.typeTF.text = action.title;
                        self.type = self.typeTF.text;
                    }
                }]];
            }];
            [self presentViewController:alert animated:YES completion:nil];
        }];
        [_mainview addSubview:typeview];
        [typeview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:typeLabel withOffset:5];
        [typeview autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.textview];
        [typeview autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.textview];
        [typeview autoSetDimension:(ALDimensionHeight) toSize:44];
        
        UILabel* contactLabel = [UILabel new];
        contactLabel.text = @"*联系方式";
        contactLabel.font = kFONT14;
        [_mainview addSubview:contactLabel];
        [contactLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.typeTF withOffset:MARGIN];
        [contactLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.textview];
        [contactLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.textview];
        
        [_mainview addSubview:self.contactTF];
        [self.contactTF autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:contactLabel                                            withOffset:5];
        [self.contactTF autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.textview];
        [self.contactTF autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.textview];
        [self.contactTF autoSetDimension:(ALDimensionHeight) toSize:44];
     
        [_mainview addSubview:self.confirmBtn];
        [self.confirmBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.contactTF                                            withOffset:MARGIN*2];
        [self.confirmBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.textview];
        [self.confirmBtn autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.textview];
        [self.confirmBtn autoSetDimension:(ALDimensionHeight) toSize:44];
    }
    return _mainview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"意见反馈";
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self initViewMethod];
    [self.view addSubview:self.mainview];
    [self.mainview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    [self.view layoutIfNeeded];
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGFloat conY = CGRectGetMaxY(self.confirmBtn.frame)+MARGIN*2;
    if (conY>=JMScreenHeight) {
        self.mainview.contentSize = CGSizeMake(JMScreenWidth, conY);
    }
}
-(void)initViewMethod
{
    textView = [[UITextView alloc]initWithFrame:CGRectMake(MARGIN, MARGIN, XYScreenWidth-MARGIN*2, XYScreenHeight/3)];
    
    textView.font = kFONT15;
    textView.delegate = self;
    feedbackTV = textView;
    feedbackTV.layer.borderColor = [UIColor grayColor].CGColor;
    feedbackTV.layer.borderWidth =1.0;
    feedbackTV.layer.cornerRadius =8.0;
    [self.view addSubview:feedbackTV];
    
    _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(MARGIN, CGRectGetMaxY(feedbackTV.frame)+15, CGRectGetWidth(feedbackTV.frame), 40)];
    [_confirmBtn.layer setMasksToBounds:YES];
    [_confirmBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = kFONT15;
    _confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    _confirmBtn.backgroundColor = RED;
    [_confirmBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    _confirmBtn.tag = 4;
    [self.view addSubview:_confirmBtn];
    
}

-(void)textViewDidChange:(UITextView *)textView
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)FeedBackMethod
{
    
    if (![_textview.textView.text kr_isNotEmpty]){
        [Tools showMessage:@"请留下您对本产品的宝贵意见"];
    }else if ([NSString isEmpty:self.type]){
        [Tools showMessage:@"请选择反馈类型，以便更方便快捷地解决问题"];
    }else if ([NSString isEmpty:self.contactTF.text]){
        [Tools showMessage:@"请留下您的联系方式，以便更方便快捷地解决问题"];
    }
    
    else{
        

        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"content":_textview.textView.text,
                                       @"time":[NSString GetNowTimes],
                                                                                    @"token":UserAccessToken,@"contact":self.contactTF.text,@"type":self.type}];
        params[SignKey] = [NSString getSignStringWithDictionary:params];
        [SVProgressHUD show];
        [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_mine_setideasBox successBlock:^(id responseBody) {
            NSDictionary *dict = responseBody;
            XYLog(@"responseBody2 is %@",responseBody);
            if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
                
//                [SVProgressHUD dismiss];
                
                _isConfirm = YES;
                [self.navigationController popViewControllerAnimated:YES];
                [FNTipsView showTips:@"谢谢您对产品的建议，我们会及时改进"];
                
            }else
            {
                _isConfirm = NO;
                
                [XYNetworkAPI queryFinishTip:dict];
                [XYNetworkAPI cancelAllRequest];
            }
            
            
        } failureBlock:^(NSString *error) {
            [SVProgressHUD dismiss];
            [XYNetworkAPI cancelAllRequest];
        }];
        
        
        
    }
    return _isConfirm;
}
-(void)clickBtnMethod:(UIButton *)sender
{
    if([self FeedBackMethod]){
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark - Text field delegate


@end
