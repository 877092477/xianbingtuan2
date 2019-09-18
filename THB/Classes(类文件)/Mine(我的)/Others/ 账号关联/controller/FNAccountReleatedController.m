//
//  FNAccountReleatedController.m
//  嗨如意
//
//  Created by Jimmy on 2018/2/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNAccountReleatedController.h"
#import "FNAccountReleatedModel.h"
#import "FNImgTitleCell.h"
#import "FNAlertWithImgView.h"
//#import "BQLAuthEngine.h"
#import <AlibabaAuthSDK/ALBBSDK.h>
#import <UMSocialCore/UMSocialCore.h>
@interface FNAccountReleatedController ()<UITableViewDelegate,UITableViewDataSource>
{
//    BQLAuthEngine *_bqlAuthEngine;
}
@property (nonatomic, strong)FNAccountReleatedModel* model;
@property (nonatomic, strong)UIView* footerview;
@property (nonatomic, strong)UILabel* tiplabel;
/**
 type
 */
@property (nonatomic, copy)NSString* type;
/**
 type name
 */
@property (nonatomic, copy)NSString* typeName;
/**
 open_id
 */
@property (nonatomic, copy)NSString* open_id;

@property (nonatomic, copy)NSString* imageUrl;
@end

@implementation FNAccountReleatedController
- (UILabel *)tiplabel{
    if (_tiplabel == nil) {
        _tiplabel = [UILabel new];
        _tiplabel.font = kFONT14;
        _tiplabel.textColor = FNGlobalTextGrayColor;
        _tiplabel.numberOfLines = 0;
    }
    return _tiplabel;
}
- (UIView *)footerview{
    if (_footerview == nil) {
        _footerview = [UIView new];
        _footerview.frame = CGRectMake(0, 0, JMScreenWidth, 0);
        [_footerview addSubview:self.tiplabel];
        [self.tiplabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_jmsize_10, _jmsize_10, _jmsize_10, _jmsize_10))excludingEdge:(ALEdgeBottom)];
    }
    return _footerview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.title?:@"账号关联";
//    _bqlAuthEngine = [[BQLAuthEngine alloc] init];
    [SVProgressHUD show];
    [self requestList].CompleteBlock = ^(NSString *error) {
        if (self.model) {
            self.tiplabel.text = self.model.content;
            CGRect rect = [self.tiplabel.text boundingRectWithSize:(CGSizeMake(JMScreenWidth-_jmsize_10*2, CGFLOAT_MAX)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:kFONT15} context:nil];
            
            self.footerview.height = rect.size.height+_jmsize_10*2;
        }
        self.jm_tableview.tableFooterView = self.footerview;
        [self.jm_tableview reloadData];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)jm_setupViews{
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.emptyDataSetSource = nil;
    self.jm_tableview.emptyDataSetDelegate = nil;
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
}
#pragma mark - request
- (FNRequestTool *)requestList{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_zhgl&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNAccountReleatedModel" success:^(id respondsObject) {
        //
        [SVProgressHUD dismiss];
        self.model = respondsObject;
    } failure:^(NSString *error) {
        //
    } isHideTips:NO isCache: NO];
}
- (FNRequestTool *)requestBind{
    
    if ([NSString isEmpty:self.open_id]) {
//        [self showBindFailure];
        return nil;
    }
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"type":self.type,@"open_id":self.open_id}];
    if ([self.imageUrl kr_isNotEmpty]) {
        params[@"head_img"] = self.imageUrl;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_zhgl&ctrl=ksgl" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //
        [self requestList].CompleteBlock = ^(NSString *error) {
            [SVProgressHUD dismiss];
            NSString* title = [NSString stringWithFormat:@"%@账号关联成功",self.typeName];
            FNAlertWithImgView *alert = [FNAlertWithImgView alertWithTitle:title content:nil firstTitle:@"我知道了" andSecondTitle:nil topImg:@"relation_yes" clickBlock:nil];
            [alert.firstButton setTitleColor:FNMainGobalTextColor forState:(UIControlStateNormal)];
            [alert.secondButton setTitleColor:FNMainGobalTextColor forState:(UIControlStateNormal)];
            [alert showAlert];
            
            [self.jm_tableview reloadData];
        };
    } failure:^(NSString *error) {
        //
        [SVProgressHUD dismiss];
        [self showBindFailure];
    } isHideTips:YES];
}
- (FNRequestTool *)requestUnBind{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"type":self.type}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_zhgl&ctrl=jcgl" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //
        [self requestList].CompleteBlock = ^(NSString *error) {
            
            [SVProgressHUD dismiss];
            [self.jm_tableview reloadData];
        };
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
- (void)showBindFailure{
    NSString* title = [NSString stringWithFormat:@"%@账号关联失败",self.typeName];
    FNAlertWithImgView *alert = [FNAlertWithImgView alertWithTitle:title content:nil firstTitle:@"取消" andSecondTitle:@"重试" topImg:@"relation_warn" clickBlock:^(NSInteger index) {
        //
        if (index == 1) {
            //ready to unbind
            [self requestBind];
        }
    }];
    [alert.firstButton setTitleColor:FNMainGobalTextColor forState:(UIControlStateNormal)];
    [alert.secondButton setTitleColor:FNMainGobalTextColor forState:(UIControlStateNormal)];
    [alert showAlert];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.list.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNImgTitleCell* cell = [FNImgTitleCell cellWithTableView:tableView atIndexPath:indexPath];
    [cell setImage:self.model.list[indexPath.row].img andTitle:self.model.list[indexPath.row].name];
    cell.imgSize = CGSizeMake(25, 25);
    cell.subTitleLabel.text = self.model.list[indexPath.row].is_gl.boolValue?@"已关联":@"未关联";
    cell.subTitleLabel.textColor = self.model.list[indexPath.row].is_gl.boolValue?FNGlobalTextGrayColor:FNMainGobalControlsColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 50;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0.01;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = 0.01;
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL is_gl = self.model.list[indexPath.row].is_gl.boolValue;
    self.type = self.model.list[indexPath.row].type;
    self.typeName = self.model.list[indexPath.row].name;
    if (is_gl) {//warning
        FNAlertWithImgView *alert = [FNAlertWithImgView alertWithTitle:@"您是否要解除关联？" content:@"解除后将不同步订单/物流信息" firstTitle:@"取消" andSecondTitle:@"解除关联" topImg:@"relation_warn" clickBlock:^(NSInteger index) {
            //
            if (index == 1) {
                //ready to unbind
                [SVProgressHUD show];
                [self requestUnBind];
            }
        }];
        [alert.firstButton setTitleColor:FNMainGobalTextColor forState:(UIControlStateNormal)];
        [alert.secondButton setTitleColor:FNMainGobalTextColor forState:(UIControlStateNormal)];
        [alert showAlert];
    }else{//authorized
        if ([NSString checkIsSuccess:self.type  andElement:@"qq_au"]) {
            //
            
            [self clickToLoginWithQQMethod];
        }else if ([NSString checkIsSuccess:self.type  andElement:@"weixin_au"]) {
            //
            
            [self clickToLoginWithWeChatMethod];
        }else if ([NSString checkIsSuccess:self.type  andElement:@"taobao_au"]) {
            //
            [self showTBLogin];
        }
    }
    
}

#pragma mark - 第三方登录方法
-(void)showTBLogin{
    
    
    
    [[ALBBSDK sharedInstance]auth:self successCallback:^(ALBBSession *session) {
        XYLog(@"topAccessToken is %@",[session getUser].topAccessToken);
        XYLog(@"topAuthCode is %@",[session getUser].topAuthCode);
        XYLog(@"openId is %@",[session getUser].openId);

        self.open_id =[session getUser].openId;
        self.imageUrl = [session getUser].avatarUrl;
        
        
        [self requestBind];
    } failureCallback:^(ALBBSession *session, NSError *error) {
        [self showBindFailure];
    }];

}

-(void)clickToLoginWithQQMethod{
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
//
//        NSLog(@"install--");
//        [_bqlAuthEngine authLoginQQWithSuccess:^(id response) {
//
//            self.open_id = UserQQOpenID;
//            [self requestBind];
//        } Failure:^(NSError *error) {
//
//            [FNTipsView showTips:[NSString stringWithFormat:@"%@",error]];
//        }];
//
//
//    }else{
    
        NSLog(@"no---");
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                
            } else {
                UMSocialUserInfoResponse *resp = result;
                NSLog(@"QQ originalResponse: %@", resp.originalResponse);
                NSDictionary *param =  resp.originalResponse;
                // 第三方平台SDK源数据
                self.open_id = resp.openid;
                self.imageUrl = [param valueForKey:@"figureurl_qq_2"];
                [self requestBind];
            }
        }];
        
        
//    }
    
    
    
}
-(void)clickToLoginWithWeChatMethod{
//    if ([WXApi isWXAppInstalled]) {
//        //判断是否有微信
//        [_bqlAuthEngine authLoginWeChatWithSuccess:^(id response) {
//
//            NSDictionary *param = response;
//
//            self.open_id = [param valueForKey:@"openid"];
//            [self requestBind];
//        } Failure:^(NSError *error) {
//
//            [FNTipsView showTips:[NSString stringWithFormat:@"%@",error]];
//        }];
//    }else{
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                
            } else {
                
                if (error) {
                    
                } else {
                    UMSocialUserInfoResponse *resp = result;
                    XYLog(@"wxresp.openid is %@",resp);
                    
                    NSDictionary *param = resp.originalResponse;
                    NSString *unionId = [param valueForKey:@"unionid"];
                    
                    self.open_id = unionId;
                    self.imageUrl = [param valueForKey:@"headimgurl"];
                    
                    XYLog(@"unionId is %@",unionId);
                    XYLog(@"openid is %@",resp.openid);
                    [self requestBind];
                }

                
            }
        }];
//    }
    
}

@end
