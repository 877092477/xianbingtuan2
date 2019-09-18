//
//  invitationPullNewController.m
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/5/9.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "invitationPullNewController.h"
#import "FNAlertWithImgView.h"

@interface invitationPullNewController ()

@end

@implementation invitationPullNewController

-(FNFunctionView *)functionview{
    if (_functionview==nil) {
        CGFloat shareViewH = (JMScreenWidth-30)*0.8;
        _functionview = [[FNFunctionView alloc]initWithFrame:(CGRectMake(10, 60, JMScreenWidth-50, shareViewH-100))];
        _functionview.backgroundColor=[UIColor clearColor];
        _functionview.column = 3;
        _functionview.row = 2;
        _functionview.singleH = (shareViewH-100) / 2;
        _functionview.scrollview.pagingEnabled=YES;
        _functionview.titles = @[@"微信群",@"朋友圈",@"QQ群",@"QQ空间", @"面对面扫码", @"拉新口令"];
        _functionview.images = @[IMAGE(@"invite_wechat-1"),IMAGE(@"invite_friends"),IMAGE(@"invite_qqq"),IMAGE(@"invite_qzone"), IMAGE(@"ic_qr_code"), IMAGE(@"ic_link")];
        [_functionview setBtnviews];
        [_functionview.btns enumerateObjectsUsingBlock:^(FNHomeFunctionBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.titleLabel.textColor = FNWhiteColor;
            obj.titleLabel.font  = kFONT13;
        }];
        @weakify(self);
        _functionview.btnClickedBlock = ^(NSInteger index) {
            @strongify(self);
            if ([NSString isEmpty:UserAccessToken]) {
                [self gologin];
                return;
            }
            UMSocialPlatformType type=UMSocialPlatformType_WechatSession;
            if (index==1) {
                type=UMSocialPlatformType_WechatTimeLine;
            }else if (index==2) {
                type=UMSocialPlatformType_QQ;
            }else if (index==3) {
                type=UMSocialPlatformType_Qzone;
            } else if (index == 4) {
                [self showQRcode];
                return;
            } else if (index == 5) {
                [self showLink];
                return;
            }
            [self umengShareWithURL:self.model.invate_url image:self.model.invate_img shareTitle:self.model.invate_title andInfo:self.model.invate_content withType:type];
        };
    }
    return _functionview;
}

- (void)showQRcode {
    UIView *bg = [[UIView alloc] init];
    [self.view addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    UIImageView *imgCode = [[UIImageView alloc] init];
    [bg addSubview:imgCode];
    [imgCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.mas_equalTo(250);
    }];
    [imgCode sd_setImageWithURL:URL(self.model.qrcode_url)];
    bg.backgroundColor = RGBA(30, 30, 30, 0.5);
    
    @weakify(bg)
    [bg addJXTouch:^{
        [bg_weak_ removeFromSuperview];
    }];
}

- (void)showLink {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"拉新活动" message:self.model.share_content preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"复制" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIPasteboard generalPasteboard] setString:self.model.share_content];
        [FNTipsView showTips:@"复制成功"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollview=[UIScrollView new];
    scrollview.hidden=YES;
    scrollview.showsVerticalScrollIndicator=NO;
    scrollview.showsHorizontalScrollIndicator=NO;
    scrollview.backgroundColor=[UIColor colorWithHexString:@"ff8500"];
    [self.view addSubview:scrollview];
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        if (self.navigationController.viewControllers.count>=2) {
            make.bottom.equalTo(@0);
        }else{
            make.bottom.equalTo(@(-TABBAR_H));
        }
    }];
    self.scrollview=scrollview;
    
    [self InitializeView];
    
    [SVProgressHUD show];
    [self apiRequestPage];
}

//初始化页面
-(void)InitializeView{
    CGFloat topImageViewH = JMScreenWidth*0.85;
    CGFloat shareViewH = (JMScreenWidth-30)*0.8;
    
    UIView *BgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, 0)];
    BgView.backgroundColor=[UIColor colorWithHexString:@"ff8500"];
    [self.scrollview addSubview:BgView];
    self.BgView=BgView;
    
    UIImageView *topImageView=[UIImageView new];
    [BgView addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@(topImageViewH));
    }];
    self.topImageView=topImageView;
    BgView.height+=topImageViewH;
    
    UIView *shareView=[UIView new];
    shareView.backgroundColor=[UIColor clearColor];
    [BgView addSubview:shareView];
    [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).offset(0);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.equalTo(@(shareViewH));
    }];
    self.shareView=shareView;
    BgView.height+=shareViewH;
    
//    UIImageView *shareBGImageView=[[UIImageView alloc]initWithImage:IMAGE(@"invite_share")];
//    [shareView addSubview:shareBGImageView];
//    [shareBGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.left.right.equalTo(@0);
//    }];
//    self.shareBGImageView=shareBGImageView;
    UIImageView *shareBg1 = [[UIImageView alloc] initWithImage:IMAGE(@"invite_share1")];
    [shareView addSubview:shareBg1];
    UIImageView *shareBg2 = [[UIImageView alloc] initWithImage:IMAGE(@"invite_share2")];
    [shareView addSubview:shareBg2];
    UIImageView *shareBg3 = [[UIImageView alloc] initWithImage:IMAGE(@"invite_share3")];
    [shareView addSubview:shareBg3];
    
    [shareBg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.mas_equalTo(shareBg1.mas_width).multipliedBy(93.0 / 670.0);
    }];
   
    [shareBg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(shareBg1.mas_bottom);
        make.bottom.equalTo(shareBg3.mas_top);
    }];
    
    [shareBg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(shareBg3.mas_width).multipliedBy(69.0 / 670.0);
    }];
    
    
    
    [shareView addSubview:self.functionview];
    
    UILabel *OneLabel=[UILabel new];
    OneLabel.numberOfLines=2;
    OneLabel.font=kFONT13;
    OneLabel.textAlignment=NSTextAlignmentCenter;
    OneLabel.textColor=FNWhiteColor;
    [BgView addSubview:OneLabel];
    [OneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareView.mas_bottom).offset(0);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.equalTo(@40);
    }];
    self.OneLabel=OneLabel;
    BgView.height+=40;
    
    UIButton *leftBtn=[UIButton new];
    leftBtn.backgroundColor=RGB(249, 233, 44);
    leftBtn.cornerRadius=8;
    leftBtn.titleLabel.font=kFONT14;
    [leftBtn setTitleColor:[UIColor colorWithHexString:@"ff8500"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"邀请明细" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [BgView addSubview:leftBtn];
    
    UIButton *rightBtn=[UIButton new];
    rightBtn.backgroundColor=RGB(249, 233, 44);
    rightBtn.cornerRadius=8;
    rightBtn.titleLabel.font=kFONT14;
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"ff8500"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"我的团队" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [BgView addSubview:rightBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(OneLabel.mas_bottom).offset(0);
        make.height.equalTo(@40);
        make.width.equalTo(rightBtn.mas_width);
        make.left.equalTo(@35);
        make.right.equalTo(rightBtn.mas_left).offset(-20);
    }];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(OneLabel.mas_bottom).offset(0);
        make.height.equalTo(@40);
        make.width.equalTo(leftBtn.mas_width);
        make.right.equalTo(@-35);
        make.left.equalTo(leftBtn.mas_right).offset(20);
    }];
    BgView.height+=60;
    
    UIView *requirementsView=[UIView new];
    requirementsView.backgroundColor=FNWhiteColor;
    requirementsView.borderWidth=6;
    requirementsView.borderColor=RGB(253, 249, 159);
    requirementsView.cornerRadius=20;
    [BgView addSubview:requirementsView];
    [requirementsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftBtn.mas_bottom).offset(45);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.bottom.equalTo(@-40);
    }];
    self.requirementsView=requirementsView;
    
    
    CGFloat logoImageW=(JMScreenWidth-30)/2.5;
    UIImageView *logoImage=[[UIImageView alloc]initWithImage:IMAGE(@"invite_rt")];
    logoImage.contentMode=UIViewContentModeScaleAspectFit;
    [BgView addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(requirementsView.mas_top).offset(logoImageW*0.32/1.5);
        make.height.equalTo(@(logoImageW*0.32));
        make.width.equalTo(@(logoImageW));
        make.centerX.equalTo(requirementsView.mas_centerX);
    }];
    
    UILabel *requirementsLabel=[UILabel new];
    requirementsLabel.numberOfLines=0;
    requirementsLabel.textColor=FNGlobalTextGrayColor;
    requirementsLabel.font=kFONT12;
    [requirementsView addSubview:requirementsLabel];
    [requirementsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImage.mas_bottom).offset(10);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
    }];
    self.requirementsLabel=requirementsLabel;
}

#pragma mark - Action
-(void)leftBtnAction{
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    FNPullNewDetailController *VC=[FNPullNewDetailController new];
    VC.title=self.model.yq_top_title;
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)rightBtnAction{
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    FNteamPullNewController *VC=[FNteamPullNewController new];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 网络请求
//获取页面数据
- (FNRequestTool *)apiRequestPage{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=tbkNewApi&ctrl=getInviteData" respondType:(ResponseTypeModel) modelType:@"FNinvitationPullNewModel" success:^(id respondsObject) {
        //
        [SVProgressHUD dismiss];
        self.model=respondsObject;
        
        self.scrollview.hidden=NO;
        self.navigationItem.title=self.model.top_title;
        [self.topImageView setUrlImg:self.model.head_img];
//        [self.shareBGImageView setUrlImg:self.model.top_img];
        self.OneLabel.text=self.model.str2;
        [self setLabelSpace:self.requirementsLabel withValue:self.model.activity_content withFont:kFONT12];
        CGFloat requirementsViewH=[self getSpaceLabelHeight:self.model.activity_content withFont:kFONT12 withWidth:JMScreenWidth-66];
        self.BgView.height+=requirementsViewH+60;
        self.scrollview.contentSize=CGSizeMake(JMScreenWidth, self.BgView.height);
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 5; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 5;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, JMScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height+70;
}

@end
