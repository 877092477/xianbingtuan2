//
//  ShakeViewController.m
//  THB
//
//  Created by zhongxueyu on 16/5/4.
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

#import "ShakeViewController.h"
#import "ShakeModel.h"
#import "UIView+KRKit.h"
#import "SecondShakeView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ShakeHistoryViewController.h"


static SystemSoundID shake_sound_male_id = 0;
@interface ShakeViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>
{
    SystemSoundID                 soundID;
}


/** 列表数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btmCons;

/** 消息 */
@property (nonatomic, strong) NSString *shakeMsg;

@end

@implementation ShakeViewController

- (BOOL)isFullScreenShow {
    return YES;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.uniqueIdentifier = @"pub_yaoyiyao";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"摇一摇";
    [[UIApplication sharedApplication]setApplicationSupportsShakeToEdit:YES];
    [self setupNav];
    [self becomeFirstResponder];
    [self getProductMethod:1];
    [self getShareInfoMethod];
    if (!self.isNotHome) {
        self.btmCons.constant = 40+XYTabBarHeight;
    }else{
        self.btmCons.constant = 40;
    }
    [self.view layoutIfNeeded];
    
    

    
    
}

-(void)setupNav{
    
    
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(50, 0, 80, 40)];
    [rightbutton setTitle:@"免责声明" forState:UIControlStateNormal];
    rightbutton.titleLabel.font = kFONT15;
    [rightbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(RightBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];

    
}




-(void)getShareInfoMethod{
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:[NSString GetParamDic] url:_api_mine_getShareInfo successBlock:^(id responseBody) {
        
        NSDictionary *dict = responseBody;
        [SVProgressHUD dismiss];
        XYLog(@"getShareInforesponseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            NSArray *tempArray = [dict objectForKey:XYData];
            NSString *word;
            if ([[tempArray valueForKey:@"word"]kr_isNotEmpty]) {
                word = [tempArray valueForKey:@"word"];
            }else{
                word = @" ";
            }
            
            NSString *img;
            if ([[tempArray valueForKey:@"img"]kr_isNotEmpty]) {
                img = [tempArray valueForKey:@"img"];
            }else{
                img = @" ";
            }
            
            
            [[NSUserDefaults standardUserDefaults] setValue:img forKey:XYShareImg];
            [[NSUserDefaults standardUserDefaults] setValue:word forKey:XYShareWord];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
    } failureBlock:^(NSString *error) {
        [XYNetworkAPI cancelAllRequest];
    }];
    
}

-(void)RightBtnMethod:(UIButton *)sender
{
    secondViewController *vc = [[secondViewController alloc]init];
    vc.url = [NSString stringWithFormat:@"%@%@",IP,_api_others_statement];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)postFootPrintMethpd:(NSString *)goodsId{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{ @"time":[NSString GetNowTimes],
                                                                                  @"goodsid":goodsId,
                                                                                  @"token":UserAccessToken}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_addfootmark successBlock:^(id responseBody) {
        
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取商品
-(void)getProductMethod:(NSInteger)type{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{ @"time":[NSString GetNowTimes],
                                                                                  @"token":UserAccessToken}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    
    if (type == 1) {
        [SVProgressHUD show];
    }
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_home_shake successBlock:^(id responseBody) {
        XYLog(@"responseBody is%@",responseBody);
        NSDictionary *dict = responseBody;
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            [self.dataArray removeAllObjects];
            
            ShakeModel *model = [ShakeModel mj_objectWithKeyValues:[dict objectForKey:XYData]];
            [self.dataArray addObject:model];
            if (type == 1) {
                [self initViewMethod];
            }else{
                [self getShakeInfoMethod];
            }
            
            [SVProgressHUD dismiss];
            
            
        }
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self getProductMethod:0];
//}
-(void)getShakeInfoMethod{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{ @"time":[NSString GetNowTimes],
                                                                                  @"token":UserAccessToken}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_home_shakemessage successBlock:^(id responseBody) {
        XYLog(@"responseBody is%@",responseBody);
        NSDictionary *dict = responseBody;
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            _shakeMsg = [[dict objectForKey:XYData]valueForKey:@"r_message"];
            [self AftershakeMethod];
        }
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
}


-(void)initViewMethod{
    
    self.productImg.alpha = 0.f;
    
    // 执行动画
    [UIView animateWithDuration:IMGDuration animations:^{
        self.productImg.alpha = 1.f;
    }];
    ShakeModel *model = self.dataArray[0];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapView:)];
    self.productImg.userInteractionEnabled = YES;
    [self.productImg addGestureRecognizer:tap];
    self.productImg.contentMode=UIViewContentModeScaleAspectFill;
    self.productImg.clipsToBounds = YES;
    //    self.productImg.tag = [model.fnuo_id intValue];
    [self.productImg sd_setImageWithURL:URL(model.goods_img_max) placeholderImage:IMAGE(@"shake_pic")];
    self.productTitle.text = model.goods_title;
    self.productTitle.textColor = [UIColor whiteColor];

    self.price.text = [NSString stringWithFormat:@"价格:￥%@",model.goods_price];
    self.price.textColor = [UIColor whiteColor];
    self.rebates.text = [NSString stringWithFormat:@"返%@%@",model.returnfb,[FNBaseSettingModel settingInstance].CustomUnit];
    self.rebates.textColor = [UIColor whiteColor];

    self.rebates.adjustsFontSizeToFitWidth = YES;
    self.price.adjustsFontSizeToFitWidth = YES;
    [self.shakeImg kr_shake];
    
    
}

-(void)OnTapView:(UITapGestureRecognizer *)sender{
    
    if(self.dataArray.count>0){
        ShakeModel *model = self.dataArray[0];
        if([model.id kr_isNotEmpty]){
            if ([model.shop_id isEqualToString:@"3"]) {
                secondViewController *vc = [[secondViewController alloc]init];
                vc.url = model.jd_url;
                vc.hidesBottomBarWhenPushed = YES;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NoLoginMsgTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    if (![UserAccessToken kr_isNotEmpty]) {
                        [FNTipsView showTips:XYNoLoginMsg];
                    }
                });
                //添加浏览足迹
                [self postFootPrintMethpd:model.id];
                
                [self.navigationController pushViewController:vc animated:YES];
                
                
            }else{
                if([model.yhq_price isEqualToString:@"0.00"] || ![model.yhq_price kr_isNotEmpty]){
                    ALBBDetailsViewController *vc = [[ALBBDetailsViewController alloc]init];
                    vc.highcommission_url = model.highcommission_wap_url;
                    vc.goodsId = model.id;
                    vc.fnuoId  = model.fnuo_id;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:NO];
                }else{
                    [self goToProductDetailsWithId:model.id couponDes:@"" andCouponUrl:@""];
                    
                }
                
            }
            
            
        }else{
            [FNTipsView showTips:@"您访问的商品不存在~"];
        }
    }
    
}


-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"开始摇动");
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shake" ofType:@"mp3"];
    if (path) {
        //注册声音到系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id);
        AudioServicesPlaySystemSound(shake_sound_male_id);
        //        AudioServicesPlaySystemSound(shake_sound_male_id);//如果无法再下面播放，可以尝试在此播放
    }
    
    AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
    
    
    
}

-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent*)event

{
    
    //摇动取消
    
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent*)event
{
    
    //摇动结束
    
    if(event.subtype
       == UIEventSubtypeMotionShake) {
        
        //somethinghappens
        XYLog(@"摇动结束");
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:1.5 animations:^{
                
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                
                
                [self getProductMethod:0];
            } completion:^(BOOL finished) {
               
                NSString *path = [[NSBundle mainBundle] pathForResource:@"shake2" ofType:@"wav"];
                if (path) {
                    //注册声音到系统
                    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id);
                    AudioServicesPlaySystemSound(shake_sound_male_id);
                    //        AudioServicesPlaySystemSound(shake_sound_male_id);//如果无法再下面播放，可以尝试在此播放
                }
                
                AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
                
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动

                
            }];
            
        });
        
        
    }
    
}

-(void)AftershakeMethod{
    if (self.dataArray.count>0) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SecondShakeView" owner:self options:nil];
        //得到第一个UIView
        SecondShakeView *view = [nib objectAtIndex:0];
        [view setFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight)];
        view.productImg.alpha = 0.f;
        UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareMethod:)];
        [view.shareBtnView addGestureRecognizer:tap1];

        // 执行动画
        [UIView animateWithDuration:IMGDuration animations:^{
            view.productImg.alpha = 1.f;
        }];
        ShakeModel *model = self.dataArray[0];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapView:)];
        view.shakeBg.userInteractionEnabled = YES;
        [view.shakeBg addGestureRecognizer:tap];
        view.productImg.contentMode=UIViewContentModeScaleAspectFill;
        view.productImg.clipsToBounds = YES;
        [view.productImg sd_setImageWithURL:URL(model.goods_img_max) placeholderImage:IMAGE(@"shake_pic")];
        view.productTitle.text = model.goods_title;
        view.price.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
        view.rebates.text = [NSString stringWithFormat:@"返%@%@",model.returnfb,[FNBaseSettingModel settingInstance].CustomUnit];
                //view.costPrice.text = [NSString stringWithFormat:@"￥%@",model.goods_cost_price];
        view.shakeInfo.text = _shakeMsg;
        view.rebates.adjustsFontSizeToFitWidth = YES;
        view.price.adjustsFontSizeToFitWidth = YES;
        view.price.textColor=RED;
        view.rebates.textColor=RED;
        [self.view addSubview:view];
        [view kr_showSubView];
    }
}

- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString *outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                       NULL, /* allocator */
                                                                                       (__bridge CFStringRef)input,
                                                                                       NULL, /* charactersToLeaveUnescaped */
                                                                                       (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    return
    outputStr;
}
-(void)shareMethod:(UIGestureRecognizer *)sender{
    NSString *shareText = UserShareWord;             //分享内嵌文字
    NSString *shareUrl = [NSString encodeToPercentEscapeString:ShareUrl];
    

    [self umengShareWithURL:shareUrl image:UserShareImg shareTitle:shareText andInfo:shareText];
    
}



#pragma mark -Getter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
