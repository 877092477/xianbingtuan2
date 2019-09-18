//
//  FNControllerManager.m
//  新版嗨如意
//
//  Created by Weller on 2019/5/29.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNControllerManager.h"

#import "FNLoginSecondController.h"
#define MARGIN 15
#import "MyWebViewController.h"
#import "secondViewController.h"
#import "FNMineSignUpController.h"
#import "FNProductDetailController.h"
#import "ALBBCustomWebViewController.h"
#import "FNCouponTransitionView.h"
#import "FNPorDetailForShareController.h"
#import "FNBrandSaleController.h"
#import "FNJDFeaturedController.h"
#import "FNHomeSecKillViewController.h"
#import "ShopRebatesViewController.h"
#import "ShakeViewController.h"
#import "HightRebatesViewController.h"
#import "FNMCouponPurchaseController.h"
#import "FNNewProDetailController.h"
#import "FNShareController.h"
#import "FNPSecKillController.h"
#import "FNPromotionalListController.h"
#import "FNPNormalProController.h"
#import "LoginViewController.h"
#import "FNProfitStatisticsController.h"
#import "FNFansController.h"
#import "FNTeamPromoteController.h"
#import "FNMinePromoteController.h"
#import "FNMineController.h"
#import "FNVideoMarketingHomeController.h"

#import "FNShareProdcutView.h"
#import "FNShareModel.h"
#import "FNShareCodeAlert.h"
#import "JMAlertView.h"
#import "CircleOfFriendsModel.h"

#import "FNPartnerCenterController.h"
#import "FNPartnerApplyController.h"
#import "JMMIneBillController.h"
#import "MyLikeViewController.h"
#import "DisCenterViewController.h"
#import "JMInviteFriendsController.h"
#import "JMMemberUpgradeController.h"
#import "MyFootPrintViewController.h"
#import "ContactWeViewController.h"
#import "FNMCAgentController.h"
#import "FNMCAgentApplyController.h"
#import "ShakeHistoryViewController.h"
#import "FNFindOrderController.h"
#import "FNPartnerGoodsController.h"
#import "FNPosterController.h"
#import "FNWelfareController.h"
#import "FNRMAccountManagementController.h"
#import "FNMembershipUpgradeViewController.h"
#import "FNFamilyController.h"
#import "IncomeViewController.h"
#import "FXQRCodeViewController.h"
#import "FNHeroRankController.h"
#import "MyTeamViewController.h"
#import "FXOrderNavBarViewController.h"
#import "invitationPullNewController.h"
#import "COFListController.h"
#import "FNPDDCategoryController.h"
#import "FNCategoryListingsController.h"
#import "FNMineBillNController.h"
#import "FNGradeOfMembershipController.h"
#import "FNEarningsMenuNController.h"
#import "FNPopUpTool.h"

#import "FNGoodsListViewController.h"
#import "FNCashGiftSeekNeController.h"

#import "WebViewJavascriptBridge.h"
#import "D3Generator.h"
#import "RebatesViewController.h"
#import "FNCashActivityNeController.h"
#import "FNCashAcShareNeController.h"
#import "FNpacketRedNeController.h"
#import "FNOddWelfareNeController.h"
#import "FNclienteleDeController.h"
#import "OrderViewController.h"
#import "FNReckoningSetDeController.h"
#import "FNstatisticsDeController.h"
#import "FNDefiniteStoreNeController.h"
#import "FNdefineRecommendNeController.h"
#import "FNdefineRecommendNeController.h"
#import "FNdefinConvertNeController.h"
#import "FNIntegralMallDetailController.h"
#import "FNFreeProductDetailModel.h"
#import "FNConnectionsHomeController.h"
#import "FNConnectionsCreateGroupsController.h"
#import "FNArrangesingleAeController.h"
#import "FNMemberGradeDeController.h"
#import "StoreWebModel.h"
#import "FNAuthController.h"
#import "FNConnectionsMessageController.h"
#import "FNPunchCardAeController.h"
#import "lhScanQCodeViewController.h"
#import "MsgCenterViewController.h"
#import "FNAuthAlertView.h"
#import "FNAuthFailedAlertView.h"
#import "StoreWebViewController.h"
#import "FNAccountReleatedController.h"
#import "FNMakeIntegralTController.h"
#import "FNCourseTeController.h"
#import "FNNewWelfareNeController.h"
#import "JDSDK/JDKeplerSDK.h"
#import "FNVideoWebController.h"
#import "FNMyVideoCardUseController.h"


#import "FNshopTendPlazaNeController.h"

#import "FNDouQuanController.h"


#import "FNshopTendPlazaNeController.h"
#import "FNDouQuanController.h"
#import "FNLiveBroadcastController.h"
#import "FNArticleNaController.h"
#import "FNArticleNewNaController.h"
#import "FNArticleDetailsXController.h"
#import "FNWaresMultiNaController.h"

#import "FNLiveCouponeController.h"
#import "FNLiveCouponeCategoryController.h"
#import "FNDistrictCoinController.h"
#import "FNNewFreeProductDetailModel.h"
#import "FNNewFreeProductShareAlertView.h"

#import "FNCommodityFieldDeController.h"
#import "FNCommColumnItController.h"
#import "FNControllerManager.h"
#import "FNSortHomeDeController.h"
#import "FNTBWebViewController.h"
#import "FNTradeStudyController.h"


#import "FNNewConnectionHomeController.h"
#import "StoreWebViewController.h"
#import "FNMerchantCentreMeController.h"
#import "FNmerchantIndentListController.h"
#import "FNmerchentReviewSController.h"
#import "FNmerInformationsController.h"
#import "FNmerDiscountsSController.h"
#import "FNTabManager.h"
#import "FNNewProDetailWebController.h"
#import "FNCreditCardHomeController.h"
#import "FNNetCouponeExchangeController.h"
#import "FNtendOrderDaNeController.h"

#import "FNCandiesMyController.h"

#import "FNNewUpgradeGoodsNController.h"

#import "FNMerActivityToolController.h"
#import "FNStoreGoodsManagerController.h"

#import "FNCandiesConversionController.h"
#import "FNNetCouponeReceiveController.h"
#import "FNMyNetCouponeRechargeController.h"
#import "FNShareViewController.h"
#import "FNmerchantMembersController.h"
#import "FNmeMembersIndentSController.h"
#import "FNStoreLocationRedpackController.h"
#import "FNmerConsumeScanController.h"

#import "FNMarketCentreController.h"
#import "FNmerConsumeScanController.h"
#import "FNmerDiscountsCateController.h"

@implementation FNControllerManager

+ (SuperViewController*) controllerWithModel: (id)model {
    
    SuperViewController* viewcontroller = nil;
    
    NSString*  keyWord = [model valueForKey:@"name"];
    NSString* view_type = [model valueForKey:@"view_type"];
    NSString* SkipUIIdentifier = [model valueForKey:@"SkipUIIdentifier"];
    NSString* url = [model valueForKey:@"url"];
    NSArray *tabAddArr=[FNTabManager shareInstance].tabs;
    NSMutableArray *barAddArr=[NSMutableArray arrayWithCapacity:0];
    
    for (FNTabModel *model in tabAddArr) {
        [barAddArr addObject:model.SkipUIIdentifier];
    }
    do {
        if (![NSString isEmpty:view_type]) {
            NSString* titleImg = [model valueForKey:@"goodslist_img"];
            NSString* title = [model valueForKey:@"goodslist_str"];
            NSString* show_name = [model valueForKey:@"show_name"];
            if ([NSString checkIsSuccess:view_type andElement:@"2"]) {
                //sec kill
                FNPSecKillController* seckill = [FNPSecKillController new];
                seckill.show_name=show_name;
                seckill.view_type = view_type;
                seckill.identifier = SkipUIIdentifier;
                seckill.title = title;
                seckill.titleImg = titleImg;
                viewcontroller = seckill;
            }else if ([NSString checkIsSuccess:view_type andElement:@"1"]){
                FNPromotionalListController* list = [FNPromotionalListController new];
                list.show_name=show_name;
                list.viewmodel.view_type = view_type;
                list.viewmodel.identifier = SkipUIIdentifier;
                list.title = title;
                list.titleImg = titleImg;
                viewcontroller = list;
            }else if ([NSString checkIsSuccess:view_type andElement:@"0"]){
                FNPNormalProController* product = [FNPNormalProController new];
                product.titleImg = titleImg;
                product.title = title;
                product.view_type = view_type;
                product.identifier = SkipUIIdentifier;
                viewcontroller = product;
            }else if ([NSString checkIsSuccess:view_type andElement:@"3"]){
                
                if ([SkipUIIdentifier isKindOfClass:[NSString class]]) {
                    NSLog(@"SkipUIIdentifier:");
                    if([SkipUIIdentifier isEqualToString:@"pub_jingdongshangpin"]){
                        FNPDDCategoryController* vc = [FNPDDCategoryController new];
                        vc.SkipUIIdentifierString = SkipUIIdentifier;
                        vc.keywordString = keyWord;
                        vc.sortType = view_type;
                        vc.itemModel = model;
                        viewcontroller = vc;
                    }else{
                        HightRebatesViewController* vc = [HightRebatesViewController new];
                        vc.SkipUIIdentifier = SkipUIIdentifier;
                        vc.title = keyWord;
                        vc.fromHome = 1;
//                        vc.hidesBottomBarWhenPushed = YES;
                        viewcontroller = vc;
                    }
                }else{
                    HightRebatesViewController* vc = [HightRebatesViewController new];
                    vc.SkipUIIdentifier = SkipUIIdentifier;
                    vc.title = keyWord;
                    vc.fromHome = 1;
//                    vc.hidesBottomBarWhenPushed = YES;
                    viewcontroller = vc;
                }
                
            }
            else if ([NSString checkIsSuccess:view_type andElement:@"5"]){
                XYLog(@"view_type:%@",view_type);
                if([SkipUIIdentifier isEqualToString:@"pub_integral_newgoods"]||[SkipUIIdentifier isEqualToString:@"pub_integral_hotgoods"]){
                    FNdefineRecommendNeController *vc=[[FNdefineRecommendNeController alloc]init];
                    vc.title=FAST_Model_NoNull(@"name", @"");
                    vc.SkipUIIdentifier=SkipUIIdentifier;
                    viewcontroller = vc;
                }
            }
            else if ([NSString checkIsSuccess:view_type andElement:@"6"]){
                if([SkipUIIdentifier isEqualToString:@"pub_integral_moneychangegoods"]||[SkipUIIdentifier isEqualToString:@"pub_integral_changegoods"]){
                    FNdefinConvertNeController *vc=[[FNdefinConvertNeController alloc]init];
                    vc.title=FAST_Model_NoNull(@"name", @"");
                    vc.SkipUIIdentifier=SkipUIIdentifier;
                    viewcontroller = vc;
                }
            }
            break;
        }
        
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_wailian"]) {
            //新人学院
            NSString*  jsonInfo = [model valueForKey:@"jsonInfo"];
            //外链
            viewcontroller = [FNControllerManager goWebDetailWithWebType:@"0" URL:url withHeaderInfo:jsonInfo];
            
        }else if([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_taobao_wailian"]) {
            //外链
            viewcontroller = [FNControllerManager goWebDetailWithWebType:@"1" URL:url];
            
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_brand"]){
            //品牌特卖
            FNBrandSaleController* brand = [FNBrandSaleController new];
            brand.toIndex = 0;
            viewcontroller = brand;
            
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_shangchengfanli"]){
            //商城返利
            if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainHRB" bundle:nil];
                HightRebatesViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SecondVC"];
                vc.type = 3;//分类名类型
                vc.title = keyWord;
                vc.fromHome = 1;
                vc.SkipUIIdentifier=SkipUIIdentifier;
//                vc.hidesBottomBarWhenPushed = YES;
                viewcontroller = vc;
            }else{
                ShopRebatesViewController*vc = [[ShopRebatesViewController alloc] initWithShopType:@"" withStr:[model valueForKey:@"show_type_str"]];
                vc.title = keyWord;
                vc.type = [NSNumber numberWithInt:1];
//                vc.hidesBottomBarWhenPushed = YES;
                viewcontroller = vc;
            }
            
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_yaoyiyao"]){
            //摇一摇
            if(![NSString isEmpty:UserAccessToken]){
                ShakeViewController *vc = [[ShakeViewController alloc]init];
                vc.title = keyWord;
//                vc.hidesBottomBarWhenPushed = YES;
                viewcontroller = vc;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_zhangdan"]){
            //账单
            if(![NSString isEmpty:UserAccessToken]){
                FNReckoningSetDeController* bill = [FNReckoningSetDeController new];
                viewcontroller = bill;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_qiandao"]){
            //签到
            if(![NSString isEmpty:UserAccessToken]){
                viewcontroller = [FNControllerManager goWebDetailWithWebType:@"0" URL: [NSString stringWithFormat:@"%@%@%@",IP,_home_api_signup,UserAccessToken]];
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_taobaogouwuche"]){
            //淘宝购物车
            if(![NSString isEmpty:UserAccessToken]){
                viewcontroller = [FNControllerManager goWebDetailWithWebType:@"0" URL:@"https://h5.m.taobao.com/mlapp/cart.html?pds=cart%23h%23taojia"];
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_jingdonggouwuche"]){
            //京东购物车
            if(![NSString isEmpty:UserAccessToken]){
                viewcontroller = [FNControllerManager goWebDetailWithWebType:@"0" URL:@"https://p.m.jd.com/cart/cart.action?sid=b1aa2372101926f7c1aeb2025d4e4387"];
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_wodeshoucang"]){
            //我的收藏
            if(![NSString isEmpty:UserAccessToken]){
                MyLikeViewController *vc =[[MyLikeViewController alloc]init];
                vc.title = keyWord;
                viewcontroller = vc;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_fenxiaozhongxin"]){
            //分销中心
            if(![NSString isEmpty:UserAccessToken]){
                DisCenterViewController* dis = [DisCenterViewController new];
                viewcontroller = dis;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_qianghongbao"]){
            //抢红包
            if(![NSString isEmpty:UserAccessToken]){
                NSString* rpurl = @"mod=wap&act=hongbao&token=";
                secondViewController *web = [secondViewController new];
                web.url = [NSString stringWithFormat:@"%@%@%@",IP,rpurl,UserAccessToken];
                web.title = keyWord;
                web.islucky = YES;
                viewcontroller = web;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_yaoqinghaoyou"]){
            //邀请好友
            if(![NSString isEmpty:UserAccessToken]){
                if ([NSString checkIsSuccess:[FNBaseSettingModel settingInstance].vip_extend_onoff andElement:@"0"]) {
                    JMInviteFriendsController* invite = [JMInviteFriendsController new];
                    invite.title = keyWord;
                    viewcontroller = invite;
                } else {
                    JMMemberUpgradeController* member= [JMMemberUpgradeController new];
                    viewcontroller = member;
                }
            }else{
                return  [FNControllerManager gologin];
            }
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"邀请注册"]){
            //邀请注册
            if(![NSString isEmpty:UserAccessToken]){
                if ([NSString checkIsSuccess:[FNBaseSettingModel settingInstance].vip_extend_onoff andElement:@"0"]) {
                    JMInviteFriendsController* invite = [JMInviteFriendsController new];
                    invite.title = keyWord;
                    viewcontroller = invite;
                } else {
                    JMMemberUpgradeController* member= [JMMemberUpgradeController new];
                    viewcontroller = member;
                }
            }else{
                return  [FNControllerManager gologin];
            }
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_wodezuji"]){
            //我的足迹
            if(![NSString isEmpty:UserAccessToken]){
                MyFootPrintViewController* footer = [MyFootPrintViewController new];
                footer.title = keyWord;
                viewcontroller = footer;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_lingquangou"]){
            //领券购

            FNMCouponPurchaseController* coupon = [FNMCouponPurchaseController new];
            coupon.type=VCTypeCoupon;
            viewcontroller = coupon;
            
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_kefuzhongxin"]){
            //客服中心
            if(![NSString isEmpty:UserAccessToken]){
                FNclienteleDeController *vc = [[FNclienteleDeController alloc]init];
                vc.title = keyWord;
//                vc.hidesBottomBarWhenPushed = YES;
                viewcontroller = vc;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_guanyuwomen"]){
            //关于我们
            viewcontroller = [FNControllerManager goWebWithUrl:Usergywm];
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_dailizhongxin"]){
            //代理中心
            if(![NSString isEmpty:UserAccessToken]){
                FNMCAgentController* member= [FNMCAgentController new];
                member.title = keyWord ;
                viewcontroller = member;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_yaojiangjilu"]){
            //摇奖记录
            if(![NSString isEmpty:UserAccessToken]){
                ShakeHistoryViewController* record = [ShakeHistoryViewController new];
                record.title = keyWord;
                viewcontroller = record;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_jifenshangcheng"]){
            //积分商城
            if(![NSString isEmpty:UserAccessToken]){
                viewcontroller = [FNControllerManager goWebDetailWithWebType:@"0" URL:[NSString stringWithFormat:@"%@%@%@",IP,_api_mine_IntegralWAP,UserAccessToken]];
            }else{
                return  [FNControllerManager gologin];
            }
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_integral_store"]){
            //积分商城
            if(![NSString isEmpty:UserAccessToken]){
                FNDefiniteStoreNeController *vc=[[FNDefiniteStoreNeController alloc]init];
                viewcontroller = vc;
            }else{
                return  [FNControllerManager gologin];
            }
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_zhaohuidingdan"]){
            //找回订单
            if(![NSString isEmpty:UserAccessToken]){
                FNFindOrderController* findorder = [FNFindOrderController new];
                findorder.title = keyWord;
                viewcontroller = findorder;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_hehuorenzhongxin"]){
            //合伙人中心
            if(![NSString isEmpty:UserAccessToken]){
//                viewcontroller = [FNControllerManager loadMembershipUpgradeViewController];
                viewcontroller = [[FNPartnerCenterController alloc] init];
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_jiazuchengyuan"]){
            //家族成员
            if(![NSString isEmpty:UserAccessToken]){
                FNFamilyController* Family = [FNFamilyController new];
                viewcontroller = Family;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_shouyibaobiao"]){
            //收益报表
            if(![NSString isEmpty:UserAccessToken]){
                FNProfitStatisticsController* profit = [FNProfitStatisticsController new];
                viewcontroller = profit;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_jianhuabaobiao"]){
            //简化报表
            if(![NSString isEmpty:UserAccessToken]){
                FNMCAgentController* member= [FNMCAgentController new];
                member.title = keyWord ;
                viewcontroller = member;
            }else{
                return  [FNControllerManager gologin];
            }
        } else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_member_upgrade"]) {
            if(![NSString isEmpty:UserAccessToken]){
                viewcontroller = [FNControllerManager loadMembershipUpgradeViewController];
            }else{
                return  [FNControllerManager gologin];
            }
        } else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_member_upgrade02"]) {
            if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
                FNPDDCategoryController* vc = [FNPDDCategoryController new];
                vc.SkipUIIdentifierString = @"pub_gettaobao";
                vc.keywordString = @"";
                vc.sortType = @"";
                return vc;
            }
            if(![NSString isEmpty:UserAccessToken]){
                viewcontroller = [FNNewUpgradeGoodsNController new];
            }else{
                return  [FNControllerManager gologin];
            }
        } else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_shouyitongji"]){
            //收益统计
            if(![NSString isEmpty:UserAccessToken]){
                //            partnerBlock(SkipUIIdentifier);
                IncomeViewController* Income = [IncomeViewController new];
                Income.No_hhr=NO;
                //            [self.navigationController pushViewController:Income animated:YES];
                viewcontroller = Income;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"fx_wodetuandui"]){
            //我的团队
            if(![NSString isEmpty:UserAccessToken]){
                //            partnerBlock(SkipUIIdentifier);
                MyTeamViewController* VC = [MyTeamViewController new];
                //            [self.navigationController pushViewController:VC animated:YES];
                viewcontroller = VC;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"fx_wodedingdan"]){
            //我的订单
            if(![NSString isEmpty:UserAccessToken]){
                //            partnerBlock(SkipUIIdentifier);
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"FXOrderStoryboard" bundle:nil];
                FXOrderNavBarViewController *vc = [sb instantiateViewControllerWithIdentifier:@"FXOrderBaseVC"];
                //            [self.navigationController pushViewController:vc animated:YES];
                viewcontroller = vc;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_yingxiongbang"]){
            //英雄榜
            if(![NSString isEmpty:UserAccessToken]){
                //            partnerBlock(SkipUIIdentifier);
                FNHeroRankController* VC = [FNHeroRankController new];
                //            [self.navigationController pushViewController:VC animated:YES];
                viewcontroller = VC;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_shengjidengji"]){
            //会员升级
            if(![NSString isEmpty:UserAccessToken]){
                //            partnerBlock(SkipUIIdentifier);
                [FNControllerManager loadMembershipUpgradeViewController];
            }else{
                return  [FNControllerManager gologin];
            }
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"会员升级"]){
            //会员升级
            if(![NSString isEmpty:UserAccessToken]){
                //            partnerBlock(SkipUIIdentifier);
                [FNControllerManager loadMembershipUpgradeViewController];
            }else{
                return  [FNControllerManager gologin];
            }
        }
        
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"提现成功"]||[NSString checkIsSuccess:SkipUIIdentifier andElement:@"提现失败"]){
            //提现成功 提现失败
            if(![NSString isEmpty:UserAccessToken]){
                NSString *urlString = [NSString stringWithFormat:@"%@%@%@",IP,_api_mine_DrawHistory,UserAccessToken];
                viewcontroller = [FNControllerManager goWebDetailWithWebType:@"0" URL:urlString];
            }else{
                return  [FNControllerManager gologin];
            }
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"自购分享新订单"]){
            //自购分享新订单
            if(![NSString isEmpty:UserAccessToken]){
                
            }else{
                return  [FNControllerManager gologin];
            }
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"团队新订单"]){
            //自购分享新订单
            if(![NSString isEmpty:UserAccessToken]){
                
            }else{
                return  [FNControllerManager gologin];
            }
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_wodeerweima"]){
            //我的二维码
            if(![NSString isEmpty:UserAccessToken]){
                //            partnerBlock(SkipUIIdentifier);
                FXQRCodeViewController* VC = [FXQRCodeViewController new];
                //            [self.navigationController pushViewController:VC animated:YES];
                viewcontroller = VC;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_wodefensi"]){
            //我的粉丝
            if(![NSString isEmpty:UserAccessToken]){
                //            partnerBlock(SkipUIIdentifier);
                FNFansController* fans = [FNFansController new];
                //            [self.navigationController pushViewController:fans animated:YES];
                viewcontroller = fans;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_jiazudingdan"]){
            //合伙人我的推广订单
            if(![NSString isEmpty:UserAccessToken]){
                //            partnerBlock(SkipUIIdentifier);
                FNTeamPromoteController* promote = [FNTeamPromoteController new];
                //            [self.navigationController pushViewController:promote animated:YES];
                viewcontroller = promote;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_fenxiangdingdan"]){
            //分享订单
            if(![NSString isEmpty:UserAccessToken]){
                //            partnerBlock(SkipUIIdentifier);
                FNMinePromoteController* promote = [FNMinePromoteController new];
                //            [self.navigationController pushViewController:promote animated:YES];
                viewcontroller = promote;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_chaogaofan"]){

            FNMCouponPurchaseController* hight = [FNMCouponPurchaseController new];
            hight.type = VCTypeHighRebate;
            viewcontroller = hight;

        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_youhuiquan"]){

                FNMCouponPurchaseController* hight = [FNMCouponPurchaseController new];
                hight.type = VCTypeCoupon;
                //            [self.navigationController pushViewController:hight animated:YES];
                viewcontroller = hight;
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_shangpinku"]){
            //合伙人商品库
            if(![NSString isEmpty:UserAccessToken]){
                NSInteger all_fx_onoff=[[FNBaseSettingModel settingInstance].all_fx_onoff integerValue];
                if(all_fx_onoff==1){
                    FNPartnerGoodsController* goods = [FNPartnerGoodsController new];
                    goods.title=keyWord;
                    //                [self.navigationController pushViewController:goods animated:YES];
                    viewcontroller = goods;
                }else{
                    viewcontroller = [FNControllerManager loadMembershipUpgradeViewController];
                }
                
            }else{
                return  [FNControllerManager gologin];
            }
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_haibao"]){
            //合伙人海报
            if(![NSString isEmpty:UserAccessToken]){
                FNPosterController* poster = [FNPosterController new];
                //            [self.navigationController pushViewController:poster animated:YES];
                viewcontroller = poster;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_fulishe"]){
            //福利社
            if(![NSString isEmpty:UserAccessToken]){
                FNWelfareController* poster = [FNWelfareController new];
                poster.title = keyWord;
                //            [self.navigationController pushViewController:poster animated:YES];
                viewcontroller = poster;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_management"]){
            //account management
            if(![NSString isEmpty:UserAccessToken]){
                FNRMAccountManagementController* account = [FNRMAccountManagementController new];
                account.title = keyWord;
                //            [self.navigationController pushViewController:account animated:YES];
                viewcontroller = account;
            }else{
                return  [FNControllerManager gologin];
            }
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_xuanzheshangpin"]){
            //选择商品显示
            //FNPorDetailForShareController* vc = [FNPorDetailForShareController new];
            //vc.url = [model valueForKey:@"fnuo_url"];
            //[self.navigationController pushViewController:vc animated:YES];
            viewcontroller = [FNControllerManager goProductVCWithModel:model];
            
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_huiyuanzhongxin"]){
            //个人中心
            FNMineController* mien = [FNMineController new];
            //        [self.navigationController pushViewController:mien animated:YES];
            viewcontroller = mien;
            
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_gouwufanli"]){
            //购物返利
            UIStoryboard *sb2 = [UIStoryboard storyboardWithName:@"ShopRebates" bundle:nil];
            UIViewController *vc = [sb2 instantiateViewControllerWithIdentifier:@"RebatesVC"];
            viewcontroller = vc;
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_pengyouquan"]){
       //爆款分享
            COFListController* vc = [COFListController new];
            viewcontroller = vc;
            
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_pddshangpin"]||[NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_gettaobao"]||[NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_jingdongshangpin"]||[NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_wph_goods"]){
            XYLog(@"点击:%@",keyWord);
            FNPDDCategoryController* vc = [FNPDDCategoryController new];
            vc.SkipUIIdentifierString = SkipUIIdentifier;
            vc.keywordString = keyWord;
            vc.sortType = view_type;
            vc.itemModel = model;
            //vc.hidesBottomBarWhenPushed = YES;
//            vc.understand=NO;
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_cateshow"]){
            //分类展示
            XYLog(@"分类展示:%@",keyWord);
            FNCategoryListingsController* CategoryVC = [FNCategoryListingsController new];
//            CategoryVC.understand=NO;
            //        [self.navigationController pushViewController:CategoryVC animated:YES];
            viewcontroller = CategoryVC;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_member_lvs"]){
            //会员等级
            XYLog(@"会员等级:%@",keyWord);
            FNGradeOfMembershipController* MembershipVC = [FNGradeOfMembershipController new];
            //        [self.navigationController pushViewController:MembershipVC animated:YES];
            viewcontroller = MembershipVC;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_agent_report"]){
            //收益报表
            XYLog(@"收益报表:%@",keyWord);
            //FNEarningsMenuNController* menuVC = [FNEarningsMenuNController new];
            //menuVC.understand=NO;
            //[self.navigationController pushViewController:menuVC animated:YES];
            FNstatisticsDeController *vc = [FNstatisticsDeController new];
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_hotsearch"]){
            //女装
            FNGoodsListViewController* GoodsList = [FNGoodsListViewController new];
            GoodsList.keyword=[model valueForKey:@"keyword"];
            viewcontroller = GoodsList;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_tljGoods"]){
            //淘礼金
            /*FNCashGiftSeekNeController* SeekVC = [FNCashGiftSeekNeController new];
             SeekVC.SkipUIIdentifierString=SkipUIIdentifier;
             SeekVC.show_type_str=[model valueForKey:@"show_type_str"];
             [self.navigationController pushViewController:SeekVC animated:YES];*/
            FNCashActivityNeController* ActivityVC = [FNCashActivityNeController new];
            ActivityVC.show_type_str=[model valueForKey:@"show_type_str"];
            //        [self.navigationController pushViewController:ActivityVC animated:YES];
            viewcontroller = ActivityVC;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_xianshiqianggou"]){
            //限时抢购
            FNHomeSecKillViewController *secKill = [FNHomeSecKillViewController new];
            
            //        [self.navigationController pushViewController:secKill animated:YES];
            viewcontroller = secKill;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_doubleMain"]||[NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_doubleGather"]||[NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_doubleTmall"]){
            //双11pub_doubleMain  pub_doubleGather pub_doubleTmall
            FNCashAcShareNeController *vc=[[FNCashAcShareNeController alloc]init];
            vc.SkipUIIdentifier=SkipUIIdentifier;
            vc.show_type_str=[model valueForKey:@"show_type_str"];
            vc.keyWord=keyWord;
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_alipay_packet"]){
            //支付宝红包页面
            FNpacketRedNeController *redVC = [FNpacketRedNeController new];
            //        [self.navigationController pushViewController:redVC animated:YES];
            viewcontroller = redVC;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_friend_list1"]){
            //人脉
            FNNewConnectionHomeController *vc = [[FNNewConnectionHomeController alloc] init];
            vc.title = keyWord;
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_friend_list"]){
            //人脉
            FNConnectionsHomeController *vc = [[FNConnectionsHomeController alloc] init];
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_message"]) {
            //人脉-消息通知
            FNConnectionsMessageController *msgVC = [FNConnectionsMessageController new];
            //        [self.navigationController pushViewController:msgVC animated:YES];
            viewcontroller = msgVC;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_miandan"]){
            //免单福利
            FNOddWelfareNeController *OddWelfare = [FNOddWelfareNeController new];
            OddWelfare.title = keyWord;
            //        [self.navigationController pushViewController:OddWelfare animated:YES];
            viewcontroller = OddWelfare;
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_bargain"]){
            //砍订单
            FNNewWelfareNeController *vc = [FNNewWelfareNeController new];
            vc.title = keyWord;
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_vip_movie"]){
            //视频营销
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            FNVideoMarketingHomeController *vc = [FNVideoMarketingHomeController new];
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        } else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_getvideo"]){
            //视频
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            FNVideoWebController *vc = [[FNVideoWebController alloc] init];
            vc.url = url;
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        } else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_exchange_code"]){
            //激活卡密
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            FNMyVideoCardUseController *vc = [[FNMyVideoCardUseController alloc] init];
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_app_qiaodao"]){
            //签到
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            FNMineSignUpController *vc = [FNMineSignUpController new];
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_live_stream"]){
            //直播
            FNLiveBroadcastController *vc = [FNLiveBroadcastController new];
            vc.title = keyWord;
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_life_coupon"]){
            //生活券
            FNLiveCouponeController *vc = [FNLiveCouponeController new];
            vc.title = keyWord;
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        } else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_life_coupon_cate"]){
            //生活券分类子页面
            
            NSString* show_type_str = [model valueForKey:@"show_type_str"];
            FNLiveCouponeCategoryController *vc = [[FNLiveCouponeCategoryController alloc] initWithType:show_type_str];
            vc.title = [model valueForKey:@"title"];
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_credit_card"]){
            //信用卡
            FNCreditCardHomeController *vc = [FNCreditCardHomeController new];
            viewcontroller = vc;
        }
        
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_index_sao"]){
            //扫一扫
            lhScanQCodeViewController *vc = [lhScanQCodeViewController new];
//            vc.delegate = self;
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_shake_coupon"]){
           //看着买
            FNDouQuanController *vc = [FNDouQuanController new];
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_index_msg"]){
            //消息中心
            if(![NSString isEmpty:UserAccessToken]){
                MsgCenterViewController *vc = [[MsgCenterViewController alloc]init];
                //            [self.navigationController pushViewController:vc animated:YES];
                viewcontroller = vc;
            }else{
                return  [FNControllerManager gologin];
            }
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_grouplist"]){
            //组建群聊
            FNConnectionsCreateGroupsController *vc = [FNConnectionsCreateGroupsController new];
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_my_order"]){
            //订单
            OrderViewController *vc = [OrderViewController new];
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_integral_onegoods"]){
            XYLog(@"积分商品详情");
            NSString *integral_idString=FAST_Model_NoNull(@"integral_id", @"");
            if([integral_idString kr_isNotEmpty]){
                FNIntegralMallDetailController *vc = [FNIntegralMallDetailController new];
                vc.goodsId =integral_idString;
                //            [self.navigationController pushViewController:vc animated:YES];
                viewcontroller = vc;
            }
            
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_ranking"]){
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            //人脉排行榜
            FNArrangesingleAeController *vc = [FNArrangesingleAeController new];
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_memberlist"]){
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            //人脉会员等级
            FNMemberGradeDeController *vc = [FNMemberGradeDeController new];
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_earlysign"]){
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            //早起打卡
            FNPunchCardAeController *vc = [[FNPunchCardAeController alloc] init];
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_zhanghaoguanlian"]){
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            //账号关联
            FNAccountReleatedController *vc = [[FNAccountReleatedController alloc] init];
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_buy_zhuanjifen"]){
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            //赚积分
            FNMakeIntegralTController *vc = [[FNMakeIntegralTController alloc] init];
//            vc.understand=NO;
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_course"]){
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            //新手教程
            FNCourseTeController *vc = [[FNCourseTeController alloc] init];
            vc.keyWord=keyWord;
//            vc.understand=NO;
            //        [self.navigationController pushViewController:vc animated:YES];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_store_goods_manage"]){
            //小店商家中心-商品管理
            FNStoreGoodsManagerController *vc = [FNStoreGoodsManagerController new];
            
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_localstore"]){
            //小店
            FNshopTendPlazaNeController *shopTend = [FNshopTendPlazaNeController new];
            shopTend.isMain=NO;
            //        [self.navigationController pushViewController:shopTend animated:YES];
            viewcontroller = shopTend;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_understore_order"]){
            //小店订单
//            FNtendOrderDaNeController *shopTend = [FNtendOrderDaNeController new];
            FNmeMembersIndentSController *shopTend = [FNmeMembersIndentSController new];
            viewcontroller = shopTend;
        } else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_coupon_exchange"]){
            //兑换优惠券
            FNNetCouponeExchangeController *VC = [[FNNetCouponeExchangeController alloc] init];
            viewcontroller = VC;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_coupon_rob"]){
            //优惠券开抢页面(兑换优惠券)
            FNNetCouponeReceiveController *VC = [[FNNetCouponeReceiveController alloc] init];
            viewcontroller = VC;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_coupon_recharge"]){
            //优惠券充值页面(兑换优惠券)
            FNMyNetCouponeRechargeController *VC = [[FNMyNetCouponeRechargeController alloc] init];
            viewcontroller = VC;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_talent_talk"]){
            //达人说
            FNArticleNewNaController *VC = [[FNArticleNewNaController alloc] init];
            VC.keyWord=keyWord;
//            VC.understand=NO;
            //        [self.navigationController pushViewController:VC animated:YES];
            viewcontroller = VC;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_tologin"]){
            viewcontroller = [FNControllerManager gologin];
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_talent_article"]){
            //达人说文章详情
            NSString * content=[model valueForKey:@"jsonInfo"];
            NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (json) {
                NSString *articleID= [json valueForKey:@"list_id"];
                FNArticleDetailsXController *VC = [[FNArticleDetailsXController alloc] init];
                VC.articleID=articleID;
//                VC.understand=NO;
                //            [self.navigationController pushViewController:VC animated:YES];
                viewcontroller = VC;
            }
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_goods_channel"]){
            // 综合活动
            FNWaresMultiNaController *VC = [[FNWaresMultiNaController alloc] init];
            VC.keyWord=keyWord;
//            VC.understand=NO;
            VC.showTypeStr=[model valueForKey:@"show_type_str"];
            //        [self.navigationController pushViewController:VC animated:YES];
            viewcontroller = VC;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_qukuaibi"]){
            // 区块币
            FNDistrictCoinController *VC = [[FNDistrictCoinController alloc] init];
            VC.keyWord=keyWord;
//            VC.understand=NO;
            VC.keyWord=keyWord;
            //        [self.navigationController pushViewController:VC animated:YES];
            viewcontroller = VC;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_goods_special_performance"]){
            //商品专场
            FNCommodityFieldDeController *VC = [[FNCommodityFieldDeController alloc] init];
            VC.keyWord=keyWord;
//            VC.understand=NO;
            VC.keyWord=keyWord;
            //        [self.navigationController pushViewController:VC animated:YES];
            viewcontroller = VC;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_goods_special_performance_detail"]){
            //商品专场详情
            FNCommColumnItController *vc=[[FNCommColumnItController alloc]init];
            vc.keyWord=keyWord;
            vc.show_type_str=[model valueForKey:@"show_type_str"];
            vc.headModel=model;
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_store_index"]){
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            //小店商家中心页面
            FNMerchantCentreMeController *vc=[[FNMerchantCentreMeController alloc]init];
            vc.keyWord=keyWord;
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_store_order"]){
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            } 
            //小店交易订单页
            FNmerchantIndentListController *vc=[[FNmerchantIndentListController alloc]init];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_store_comment"]){
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            //评论消息页
            FNmerchentReviewSController *vc=[[FNmerchentReviewSController alloc]init];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_store_msg"]){
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            //评论消息页
            FNmerInformationsController *vc=[[FNmerInformationsController alloc]init];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_red_packet_list"]){
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            FNmerDiscountsCateController *vc=[[FNmerDiscountsCateController alloc]init];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_yhq_list"]){
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            //评论消息页
            FNmerDiscountsSController *vc=[[FNmerDiscountsSController alloc]init];
            vc.typeStr=SkipUIIdentifier;
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_college"]){
            //商学院
            FNTradeStudyController *vc=[[FNTradeStudyController alloc]init];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_qukuaibi_duowei"]){
            //多维区块链
            FNCandiesMyController *vc=[[FNCandiesMyController alloc]init];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_qukuaibi_duowei_task"]){
            //任务中心
            FNCandiesConversionController *vc=[[FNCandiesConversionController alloc]init];
            viewcontroller = vc;
        } 
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_promotion_tools"]){
            //促销工具页
            FNMerActivityToolController *vc=[[FNMerActivityToolController alloc]init];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_understore_member"]) {
            //小店会员中心
            FNmerchantMembersController *vc=[[FNmerchantMembersController alloc]init];
            viewcontroller = vc;
        } else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_store_sweep_code"]) {
            //扫码核销
            viewcontroller = [[FNmerConsumeScanController alloc] init];

        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_position_redpacket"]){
            FNStoreLocationRedpackController *vc=[[FNStoreLocationRedpackController alloc]init];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_vue_sharemodel"]) {
            // vue 跳转三合一分享
            NSString*  jsonInfo = [model valueForKey:@"jsonInfo"];
            if ([jsonInfo kr_isNotEmpty]) {
                NSData *data = [jsonInfo dataUsingEncoding:NSUTF8StringEncoding];
                NSError *error = nil;
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if (error == nil && json) {
                    
                    NSString *goods_source = json[@"goods_source"];
                    NSString *gid = json[@"gid"];
                    
                    FNShareViewController *vc = [[FNShareViewController alloc] init];
                    vc.SkipUIIdentifier = goods_source;
                    vc.fnuo_id = gid;
                    viewcontroller = vc;
                }
            }
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_store_sweep_code"]){
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            //扫码确认订单页
            FNmerConsumeScanController *vc=[[FNmerConsumeScanController alloc]init];
            viewcontroller = vc;
        }
        else if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_push_hand"]){
            if ([NSString isEmpty:UserAccessToken]) {
                return  [FNControllerManager gologin];
            }
            //推手中心
            FNMarketCentreController *vc=[[FNMarketCentreController alloc]init];
            viewcontroller = vc;
        }
        
        else{
            if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_shouye"]){
                XYLog(@"dg_index_style:%@",[FNBaseSettingModel settingInstance].dg_index_style);
                if([[FNBaseSettingModel settingInstance].dg_index_style isEqualToString:@"indexstyle_01"]){
                    viewcontroller = [UIViewController getVCByClassName:nil orIdentifier:SkipUIIdentifier andParams:nil];
                }else if([[FNBaseSettingModel settingInstance].dg_index_style isEqualToString:@"indexstyle_02"]){
                    //首页
                    FNSortHomeDeController *vc = [FNSortHomeDeController new];
                    vc.type=SkipUIIdentifier;
                    viewcontroller = vc;
                }else{
                    viewcontroller = [UIViewController getVCByClassName:nil orIdentifier:SkipUIIdentifier andParams:nil];
                }
            }else{
                viewcontroller = [UIViewController getVCByClassName:nil orIdentifier:SkipUIIdentifier andParams:nil];
            }
        }
    } while (NO);
    
    id is_need_login = [model valueForKey:@"is_need_login"];
    BOOL needLogin = NO;
    if ([is_need_login isKindOfClass: [NSString class]]) {
        needLogin = [is_need_login isEqualToString: @"1"];
    } else if ([is_need_login isKindOfClass: [NSNumber class]]) {
        needLogin = [is_need_login isEqual: @(1)];
    }
    if ([viewcontroller isKindOfClass: [SuperViewController class]] && (needLogin || [viewcontroller needLogin]) && [NSString isEmpty:UserAccessToken]) {
//        ((SuperViewController*)viewcontroller).isNeedLogin = YES;
        return [FNControllerManager gologin];
    }
    
    return viewcontroller;
}


+ (SuperViewController*) gologin {
    FNLoginSecondController* vc = [FNLoginSecondController new];
    return vc;
}

+ (SuperViewController*) loadMembershipUpgradeViewController {
    if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        FNPDDCategoryController* vc = [FNPDDCategoryController new];
        vc.SkipUIIdentifierString = @"pub_gettaobao";
        vc.keywordString = @"";
        vc.sortType = @"";
        return vc;
    } else {
        [FNTipsView showTips:@"升级更高等级享受分享赚"];
        FNMembershipUpgradeViewController* VC = [FNMembershipUpgradeViewController new];
        return VC;
    }

}

+ (SuperViewController*)goProductVCWithModel:(id)model {
    return [FNControllerManager goProductVCWithModel:model withData:nil];
}
+ (SuperViewController*)goProductVCWithModel:(id)model withData: (nullable NSDictionary*)data{
    return [FNControllerManager goProductVCWithModel:model withData:data isLive:NO];
}
+ (SuperViewController*)goProductVCWithModel:(id)model withData: (nullable NSDictionary*)data isLive: (BOOL)isLive{
    //    if ([NSString isEmpty:UserAccessToken]&&[FNBaseSettingModel settingInstance].is_need_login.boolValue) {
    //        [self warnToLogin];
    //        return;
    //    }
    
    
    NSObject *item=model;
    NSDictionary *dictry=item.keyValues;
    FNBaseProductModel *modelL=[FNBaseProductModel mj_objectWithKeyValues:dictry];
    //XYLog(@"dictry=:%@",dictry);
    //XYLog(@"goods_title=:%@",dictry[@"goods_title"]);
    //商品详细
    FNNewProDetailController* detail = [FNNewProDetailController new];
    if (data) {
        detail.data = data;
    } else {
        // ！！！！ 兼容旧版本data，旧版本多次类型转换会导致data数据不全，若因data不全导致奇怪bug，使用显式传递data：
        // - (void)goProductVCWithModel:(id)model withData: (nullable NSDictionary*)data
        detail.data = dictry;
    }
    detail.fnuo_id = modelL.fnuo_id;// [model valueForKey:@"fnuo_id"];
    detail.isLive = isLive;
    if ([modelL.getGoodsType kr_isNotEmpty]){
        detail.getGoodsType = modelL.getGoodsType;//[model valueForKey:@"getGoodsType"];
    }
    if (modelL.goods_title!=nil) {
        detail.goods_title = modelL.goods_title;//[model valueForKey:@"goods_title"];
    }
    else if(modelL.goodsInfo!=nil){
        detail.goods_title = modelL.goodsInfo;//[model valueForKey:@"goodsInfo"];
    }
    else{
        detail.goods_title = @"";
    }
    detail.SkipUIIdentifier = modelL.shop_type;// [model valueForKey:@"shop_type"];
    if ([modelL.pdd integerValue]==1) {
        detail.SkipUIIdentifier = @"buy_pinduoduo";
    }
    if ([modelL.jd integerValue]==1) {
        detail.SkipUIIdentifier = @"buy_jingdong";
        detail.yhqUrl=modelL.yhq_url;//[model valueForKey:@"yhq_url"];
    }
    if ([modelL.wph integerValue]==1) {
        detail.SkipUIIdentifier = @"pub_wph_goods";
    }
    if ([model isKindOfClass:[FNBaseProductModel class]]) {
        FNBaseProductModel* pro = model;
        detail.isSearch = pro.ID == nil;
    }
    
    //    detail.dataDict = model;
    
//    [self.navigationController pushViewController:detail animated:YES];
    return detail;
    
}

#pragma mark - //根据类型跳转网页，webType:0.普通网页；1.淘宝站内网页;2.京东站内网页
+(SuperViewController*)goWebDetailWithWebType:(NSString *)webType URL:(NSString *)url{
    return [FNControllerManager goWebDetailWithWebType:webType URL:url withHeaderInfo:nil];
}
+(SuperViewController*)goWebDetailWithWebType:(NSString *)webType URL:(NSString *)url withHeaderInfo: (NSString*)jsonInfo{
    if (webType == nil || [webType isEqualToString:@"0"]) {
        return [FNControllerManager goWebWithUrl:url withHeader:jsonInfo];
    }else if ([webType isEqualToString:@"1"]) {
        return [FNControllerManager goTBDetailWithUrl:url];
    }else if ([webType isEqualToString:@"2"]) {
        return [FNControllerManager goJDWebWithUrl:url];
    }
    return nil;
}


/** 跳转普通网页 **/
+ (SuperViewController*)goWebWithUrl:(NSString *)url{
    return [FNControllerManager goWebDetailWithWebType:@"0" URL:url withHeaderInfo:nil];
}

+ (SuperViewController*)goWebWithUrl: (NSString*)url withHeader: (NSString*)header {
//- (void)goWebWithUrl:(NSString *)url withHeader: (nullable NSString*)header{
    if ((![NSString isEmpty:url]) && [url containsString:@"uin="] && [url containsString:@"&site"] && [url containsString:@"http://wpa.qq.com"]) {
        NSRange rang1 = [[FNBaseSettingModel settingInstance].ContactUs rangeOfString:@"uin="];
        NSRange rang2 = [[FNBaseSettingModel settingInstance].ContactUs rangeOfString:@"&site"];
        NSString* strin = [[FNBaseSettingModel settingInstance].ContactUs substringWithRange:NSMakeRange(rang1.location+rang1.length, rang2.location-(rang1.location+rang1.length))];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",strin]];
        [[UIApplication sharedApplication] openURL:url];
        if (![QQApiInterface isQQInstalled]) {
            
            NSLog(@"没安装qq或qq空间");
            [FNTipsView showTips:@"没安装qq或qq空间"];
            
        }
        return nil;
        
    }
    if ([url kr_isNotEmpty]) {
        StoreWebViewController *web = [StoreWebViewController new];
        web.url = url;
        web.jsonInfo = header;
        return web;
//        [self.navigationController pushViewController:web animated:YES];
    }
    return nil;
}

/** 跳转到京东网页 **/
+ (SuperViewController*)goJDWebWithUrl:(NSString *)url{
    if ((![NSString isEmpty:url]) && [url containsString:@"uin="] && [url containsString:@"&site"] && [url containsString:@"http://wpa.qq.com"]) {
        NSRange rang1 = [[FNBaseSettingModel settingInstance].ContactUs rangeOfString:@"uin="];
        NSRange rang2 = [[FNBaseSettingModel settingInstance].ContactUs rangeOfString:@"&site"];
        NSString* strin = [[FNBaseSettingModel settingInstance].ContactUs substringWithRange:NSMakeRange(rang1.location+rang1.length, rang2.location-(rang1.location+rang1.length))];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",strin]];
        [[UIApplication sharedApplication] openURL:url];
        if (![QQApiInterface isQQInstalled]) {
            
            NSLog(@"没安装qq或qq空间");
            [FNTipsView showTips:@"没安装qq或qq空间"];
            
        }
        return nil;
        
    }
    if ([url kr_isNotEmpty]) {
        StoreWebViewController *web = [StoreWebViewController new];
        web.url = url;
//        [self.navigationController pushViewController:web animated:YES];
        return web;
    }
    return nil;
}

//打开淘宝网页
+ (SuperViewController*)goTBDetailWithUrl:(NSString *)url{
    FNTBWebViewController *controller = [[FNTBWebViewController alloc] init];
    controller.url = url;
    return controller;
}

#pragma mark - Bai Chuan
+(void)initBaiChuanSDKMethod:(BOOL)setIsForceH5{
    NSString* pid= nil;
    //    if ([ProfileModel profileInstance].is_sqdl.boolValue) {
    //        pid = [ProfileModel profileInstance].tg_pid;
    //    }else{
    pid = [FNBaseSettingModel settingInstance].TaoKePid;
    //    }
    // 外部使用只能用Release环境
    [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentRelease];
    
    // 百川平台基础SDK初始化，加载并初始化各个业务能力插件
    //    NSString *appKey = @"23082328";
    
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        
    } failure:^(NSError *error) {
        
    }];
#warning 测试跟单
    // 开发阶段打开日志开关，方便排查错误信息
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:NO];
    
    // 配置全局的淘客参数
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.pid = [FNBaseSettingModel settingInstance].TaoKePid;
    taokeParams.adzoneId =  [FNBaseSettingModel settingInstance].APP_adzoneId;
    taokeParams.extParams = @{@"taokeAppkey": [FNBaseSettingModel settingInstance].APP_alliance_appkey?:@""};
    taokeParams.subPid = nil;
    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
    
    // 设置全局配置，是否强制使用h5
    [[AlibcTradeSDK sharedInstance] setIsForceH5:setIsForceH5];
    
    
    
}

//去除括号和空格获取订单号
//+(NSString *)getOrderNumMethod:(NSString *)orderNum{
//    NSString* str=orderNum;
//    //1. 去掉首尾空格和换行符
//    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    //2. 去掉所有空格和换行符
//    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    return str;
//}

+ (void)apiRequesteDetail: (NSString*)url block: (ControllerBlock) block {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"url": url}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_rebate_store&ctrl=check_tb_goods" respondType:ResponseTypeDataKey modelType:@"" success:^(id respondsObject) {
        StoreWebModel *store = [StoreWebModel mj_objectWithKeyValues: respondsObject];
        UIViewController *vc;
        if (store.is_jump_detail.integerValue == 1 && store.goods_msg.count > 0) {
            vc = [FNControllerManager goProductVCWithModel: store.goods_msg[0]];

        } else {
        
            FNNewProDetailWebController *storeVC = [[FNNewProDetailWebController alloc] init];
            storeVC.url = url;
            storeVC.model = store;
            vc = storeVC;
        }
        
        block(vc);
        
    } failure:^(NSString *error) {
        
    } isHideTips:NO isCache:NO];
}

@end
