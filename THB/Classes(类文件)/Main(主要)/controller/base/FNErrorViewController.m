//
//  FNErrorViewController.m
//
//
//  Created by Fnuo-iOS on 2018/6/14.
//

#import "FNErrorViewController.h"

@interface FNErrorViewController ()

@end

@implementation FNErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *IconImage=[[UIImageView alloc]initWithImage:IMAGE(@"pcresults_empty")];
    [self.view addSubview:IconImage];
    [IconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-100);
    }];
    
    UILabel *promptLabel=[UILabel new];
    promptLabel.textColor=FNGlobalTextGrayColor;
    promptLabel.font=kFONT15;
    promptLabel.text=@"请检查网络连接或重启应用！";
    [self.view addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(IconImage.mas_bottom).offset(20);
    }];
    
    UIButton *Btn=[UIButton buttonWithTitle:@"重 试" titleColor:FNWhiteColor font:kFONT16 target:self action:@selector(reconnect)];
    Btn.backgroundColor=FNMainGobalControlsColor;
    Btn.cornerRadius=5;
    [Btn sizeToFit];
    [self.view addSubview:Btn];
    [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promptLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@100);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden=YES;
}

-(void)reconnect{
    [SVProgressHUD show];
    AppDelegate *app=[AppDelegate new];
    [FNRequestTool startWithRequests:@[[app reqeustBaseSetting],[app requestTab]] withFinishedBlock:^(NSArray *erros) {
        [SVProgressHUD dismiss];
        BOOL __block flag = NO;
        NSString*__block err = @"";
        if (erros.count>=1) {
            [erros enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.length>=1) {
                    flag = YES;
                    err = obj;
                }
            }];
        }
        if (flag) {
            [FNTipsView showTips:err];
            return;
        }
        [UIApplication sharedApplication].keyWindow.rootViewController = [XYTabBarViewController new];
        [self.view removeFromSuperview];
    }];
}

@end
