//
//  UIViewController+DefaultProperyMethod.m
//  THB
//
//  Created by Jimmy on 2018/1/29.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "UIViewController+DefaultProperyMethod.h"

@implementation UIViewController (DefaultProperyMethod)
#pragma mark - getter && setter
+ (NSDictionary *)vc_key_value{
    return @{@"pub_shouye":@"HomeViewController",//首页
             @"pub_xuanzheshangpin":@"FNPorDetailForShareController",//选择商品显示
             @"pub_management":@"FNRMAccountManagementController",//account management
             @"pub_huiyuanzhongxin":@"FNMineController",//我的
             @"pub_gouwufanli_taobao":@"FNTBRebateController",//购物返利淘宝
             @"pub_pinpaitemai":@"ShopRebatesViewController",//品牌特卖(改成合作商城)
             @"pub_yaoyiyao":@"ShakeViewController", //摇一摇
             @"pub_zhangdan":@"FNReckoningSetDeController",//账单
             @"pub_qiandao":@"FNMineSignUpController",//签到
             @"pub_wodeshoucang":@"MyLikeViewController",//我的收藏
             @"pub_fenxiaozhongxin":@"DisCenterViewController",//分销中心
             @"pub_wodezuji":@"MyFootPrintViewController",//我的足迹
             @"pub_kefuzhongxin":@"FNclienteleDeController",//客服中心
             @"pub_yaojiangjilu":@"ShakeHistoryViewController", //摇奖记录
             @"pub_wodefensi":@"FNFansController",//我的粉丝
             @"pub_zhaohuidingdan":@"FNFindOrderController",//找回订单
             @"pub_fenxiangdingdan":@"FNTeamPromoteController",//合伙人我的推广订单
             @"pub_shouyibaobiao":@"FNProfitStatisticsController",//收益报表
             @"pub_hehuorenzhongxin":@"FNPartnerCenterController",//合伙人中心
//             @"pub_shangpinku":@"FNPartnerGoodsController",//合伙人商品库
             @"pub_haibao":@"FNPosterController",//合伙人海报
             @"pub_fulishe":@"FNWelfareController",//福利社
             @"pub_fenxiangzhuanqian":@"JMInviteFriendsController",//分享赚钱
             @"pub_shaizhangshouyi":@"FNShowProfitController",////晒涨收益
             @"pub_yaoyiyao":@"FNWShakeRPController",//摇红包
             @"pub_wodehaoyou":@"FNMyFriendController",//我的好友
             @"pub_wodeshouyi":@"FNMyProfitController",//我的收益
             @"pub_wodezhifubao":@"FNAlipayShowController",//我的支付宝
             @"pub_yijianfankui":@"FNFeedbackController",//意见反馈
             @"pub_shangpinku":@"FNPartnerGoodsController",//商品库
             @"pub_shangchengfanli":@"ShopRebatesViewController",//商城返利
             @"pub_laxinhuodong":@"invitationPullNewController",//拉新赚钱
             @"pub_member_upgrade":@"FNMembershipUpgradeViewController",//会员升级
             @"pub_brand": @"FNBrandSaleController"//品牌馆
             };
    //@"pub_kefuzhongxin":@"ContactWeViewController",//客服中心
}
- (BOOL)isNotHome{
    id obj = objc_getAssociatedObject(self, _cmd);
    return [obj boolValue];
}
- (void)setIsNotHome:(BOOL)isNotHome{
     objc_setAssociatedObject(self, @selector(isNotHome), @(isNotHome), OBJC_ASSOCIATION_ASSIGN);
}

//对象关联
- (NSString *)isPop{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setIsPop:(NSString *)isPop{
    objc_setAssociatedObject(self, @selector(isPop), isPop, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id)sparams{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setSparams:(id)sparams{
    objc_setAssociatedObject(self, @selector(sparams), sparams, OBJC_ASSOCIATION_RETAIN);
}
+ (UIViewController *)getVCByClassName:(NSString *)name orIdentifier:(NSString*)identifier andParams:(id)params{
    
    
    if (identifier && identifier.length>=1) {
        if ([UIViewController.vc_key_value.allKeys containsObject:identifier]) {
            name = UIViewController.vc_key_value[identifier];
        }
    }
    UIViewController* vc = nil;
    if (name && name.length>=1) {
        vc = [NSClassFromString(name) new];
        vc.sparams = params;
    }
    return vc;
}
+(UIViewController *)currentViewController
{
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = [UIApplication sharedApplication].keyWindow.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        } else {
            break;
        }
    } while (Rootvc!=nil);
    
    
    return currVC;
}
@end
