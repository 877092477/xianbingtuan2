//
//  JMAPIURL.m
//  THB
//
//  Created by jimmy on 2017/5/4.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMAPIURL.h"

/*
 首页
 */
NSString* const _api_home = @"mod=appapi&act=appDiyIndex&ctrl=getIndex";
NSString* const _api_home_marqueeApi = @"mod=appapi&act=appDiyIndex&ctrl=super_msg";

NSString* const _api_home_rebatebanner = @"mod=default&act=api&ctrl=getSlides";
NSString* const _api_home_getSlides   =     @"act=api&ctrl=getSlides";
NSString* const _api_home_getIcon      =     @"act=api&ctrl=getIcon";
NSString* const _api_home_proGoods  =     @"act=api&ctrl=getkuang";
NSString* const _api_home_gettuwen   =     @"act=api&ctrl=gettuwen";
NSString* const _api_home_getpic        =     @"act=api&ctrl=getpic";
NSString* const _api_home_getCates   =     @"act=api&ctrl=getCates";
NSString* const _api_home_getGoods  =     @"act=api&ctrl=getgoods";
NSString* const _api_home_productdetailtool = @"mod=mlt&act=xrfl&ctrl=tburl";
NSString* const _home_api_invitedText = @"mod=mlt&act=xrfl&ctrl=yqdt";
NSString* const _home_api_invitefriend = @"mod=mlt&act=xrfl&ctrl=yqFriend";
NSString* const _api_home_getProvince = @"act=api&ctrl=getProvince";
NSString* const _api_home_getCity = @"act=api&ctrl=getCity";
NSString* const _api_home_getDistrict = @"act=api&ctrl=getDistrict";
NSString* const _api_home_getCatesChild = @"act=api&ctrl=getCatesChild";
NSString* const _api_home_deletemylike = @"act=api&ctrl=deletemylike";
NSString* const _api_home_addmylike = @"act=api&ctrl=addmylike";
NSString* const _api_home_getkeyword = @"act=api&ctrl=getkeyword";
NSString* const _api_home_getType        =     @"mod=appapi&act=appJdPdd&ctrl=getType";
NSString* const _api_Newhome_getCates   =     @"mod=appapi&act=appGoodsCate02&ctrl=getCate";
NSString* const _api_Newhome_getGoods  =     @"mod=appapi&act=appGoods02&ctrl=getgoods";

NSString* const _api_home_shake = @"act=api&ctrl=shake";
NSString* const _api_home_shakerecord = @"act=api&ctrl=shakerecord";
NSString* const _api_home_shakemessage = @"act=api&ctrl=shakemessage";
NSString* const _api_home_seckillhome = @"mod=appapi&act=dgmiaosha&ctrl=index";
NSString* const _api_home_seckilpro = @"mod=appapi&act=dgmiaosha&ctrl=getgoods";

NSString* const _api_home_recommendproduct = @"mod=appapi&act=tj_goods";
/*
 店铺（品牌特卖）
 */
NSString* const _api_brand_getDp       = @"act=api&ctrl=getDp";
NSString* const _api_brand_getShopCates = @"mod=&act=api&ctrl=getShopCates";

/*
 购物返利
 */
NSString* const _api_shoprebate_getmallalliance = @"act=api&ctrl=getmallalliance";
NSString* const _api_shoprebate_getmallalliancecates = @"act=api&ctrl=getmallalliancecates";
NSString* const _api_shoprebate_gettaobaoUrl = @"act=api&ctrl=gettaobaoUrl";
/*
 优惠券
 */
NSString* const _api_coupon_yhq_goodslist =  @"mod=appapi&act=yhq_goods&ctrl=yhq_goodslist";
/*
 我的
 */
NSString* const _api_mine_getcode               = @"act=api&ctrl=getcode";
NSString* const  _api_mine_checkcode          = @"act=api&ctrl=checkcode";
NSString* const _api_mine_bill = @"mod=gh&act=ghdy&ctrl=szDetail";
NSString* const _api_mine_aboutus = @"mod=wap&act=shouTu&name=关于我们";
NSString* const _api_mine_updateUser = @"act=api&ctrl=updateUser";
NSString* const _api_mine_updatePwd = @"act=api&ctrl=updatePwd";
NSString* const _api_mine_forgetPwd = @"act=api&ctrl=forgetPwd";
 NSString* const _api_mine_getUserInfo = @"act=api&ctrl=getUserInfo";
NSString* const _api_mine_addfootmark = @"act=api&ctrl=addfootmark";
NSString* const _api_mine_getfootmark = @"act=api&ctrl=getfootmark";
NSString* const _api_mine_getmylike = @"act=api&ctrl=getmylike";
NSString* const _api_mine_getIntegral = @"act=api&ctrl=getIntegral";
 NSString* const _api_mine_getExchangeres = @"act=api&ctrl=getExchangeres";
 NSString* const _api_mine_getMsg = @"act=api&ctrl=getMsg";
 NSString* const _api_mine_getMsgDetail = @"act=api&ctrl=getMsgDetail";
 NSString* const _api_mine_checkVersion = @"act=api&ctrl=checkVersion";
 NSString* const _api_mine_setideasBox = @"act=api&ctrl=setideasBox";
NSString* const _api_mine_incentiverules = @"mod=wap&act=other&ctrl=incentiverules";
NSString* const _api_mine_commproblem = @"mod=wap&act=help&ctrl=usehelp";
NSString* const _api_mine_usehelp = @"mod=wap&act=help&ctrl=commproblem";
NSString* const _api_mine_AboutUs = @"mod=wap&act=shouTu&ctrl=about_us";
NSString* const _api_mine_ServiceProxy = @"mod=wap&act=shouTu&name=%E7%94%A8%E6%88%B7%E6%B3%A8%E5%86%8C%E5%8D%8F%E8%AE%AE";
NSString* const _api_mine_tbrecord = @"mod=appapi&act=tborder&ctrl=record";
NSString* const _api_mine_getOrder = @"act=api&ctrl=getOrder";
NSString* const _api_mine_gethelper = @"act=api&ctrl=gethelper";
NSString* const _api_mine_getpic = @"act=api&ctrl=getpic";
NSString* const _api_mine_reorder = @"act=api&ctrl=reorder";
NSString* const _api_mine_getExtendtopthree = @"act=api&ctrl=getExtendtopthree";
NSString* const _api_mine_getShopOrder = @"mod=&act=duomai&ctrl=get&t=1";
NSString* const _api_mine_flushOrder = @"http://www.chaojh.com/?mod=base&act=ordermessage&ctrl=getOrderMsg";
NSString* const _api_mine_getExtend = @"act=api&ctrl=getExtend";
NSString* const _api_mine_getmyself = @"act=api&ctrl=getmyself";
NSString* const _api_mine_helper = @"mod=wap&act=help&ctrl=helper";
NSString* const _api_mine_Level =@"mod=wap&act=memgrade&ctrl=grade&token=" ;
NSString* const _api_mine_IntegralWAP = @"mod=wap&act=paybalance&ctrl=integral&token=" ;
NSString* const _api_mine_followOrder =@"act=api&ctrl=followOrder";
NSString* const _api_mine_course =@"mod=wap&act=help&ctrl=course";
NSString* const _api_mine_Draw = @"mod=wap&act=drawals&ctrl=withdrawal&token=";
NSString* const _api_mine_DrawHistory = @"mod=wap&act=drawals&ctrl=record&token=";
NSString* const _api_mine_describe = @"mod=wap&act=business&ctrl=describe";
NSString* const _api_mine_invfriends1 = @"mod=wap&act=other&ctrl=invfriends1&name=&tid=";
NSString* const _api_mine_getShareInfo = @"act=api&ctrl=getShareInfo";
NSString* const _api_mine_functions = @"mod=appapi&act=dg_userico";
NSString* const _api_mine_agentcenter = @"mod=wap&act=agent&ctrl=agent&token=";
/*
 注册 , 登录
 */

NSString* const _api_register_register = @"act=api&ctrl=register";
NSString* const _api_login_login = @"act=api&ctrl=login";
NSString* const _api_login_threelogin = @"act=api&ctrl=threelogin";
/*
 晒单部分
 */
NSString* const _api_showorder_addsorder = @"act=sapi&ctrl=addsorder";
NSString* const _api_showorder_getorderlike = @"act=sapi&ctrl=getorderlike";
NSString* const _api_showorder_addorderlike = @"act=sapi&ctrl=addorderlike";
NSString* const _api_showorder_deleteorderlike = @"act=sapi&ctrl=deleteorderlike";
NSString* const _api_showorder_addfollow = @"act=sapi&ctrl=addfollow";
NSString* const _api_showorder_deletefollow = @"act=sapi&ctrl=deletefollow";
NSString* const _api_showorder_getfollow = @"act=sapi&ctrl=getfollow";
NSString* const _api_showorder_addflower = @"act=sapi&ctrl=addflower";
NSString* const _api_showorder_getsorder = @"act=sapi&ctrl=getsorder";
NSString* const _api_showorder_gettop = @"act=sapi&ctrl=gettop";
NSString* const _api_showorder_getflower=@"act=sapi&ctrl=getflower" ;
NSString* const _api_showorder_getusersorder = @"act=sapi&ctrl=getusersorder";
NSString* const _api_showorder_getSlide = @"act=sapi&ctrl=getSlide";
NSString* const _api_showorder_getotheruser = @"act=sapi&ctrl=getotheruser";
NSString* const _api_showorder_addcomment = @"act=sapi&ctrl=addcomment";
NSString* const _api_showorder_getcomment = @"act=sapi&ctrl=getcomment";
NSString* const _api_showorder_getdetails = @"act=sapi&ctrl=getdetails";
NSString* const _api_showorder_seach = @"act=sapi&ctrl=search";
NSString* const _api_showorder_deletesorder = @"act=sapi&ctrl=deletesorder";
NSString* const _api_showorder_GETATBProductInfo = @"act=atbapi&ctrl=getgoods";
NSString* const _api_showorder_getFirendOrder = @"act=api&ctrl=getFirendOrder";
NSString* const _api_showorder_WirteCache = @"act=api&ctrl=is_app&token=";

/**
 *  三级分销中心模块接口
 */
NSString* const _api_threesale_fxzx = @"act=fxapi&ctrl=fxzx";
NSString* const _api_threesale_fxico = @"mod=appapi&act=dg_fxico";
NSString* const _api_threesale_wdyj = @"act=fxapi&ctrl=wdyj";
NSString* const _api_threesale_sytj = @"act=fxapi&ctrl=sytj";
NSString* const _api_threesale_fxqrcode = @"act=fxapi&ctrl=qrcode";
NSString* const _api_threesale_qdcy = @"act=fxapi&ctrl=qdcy";
NSString* const _api_threesale_yjly = @"act=fxapi&ctrl=yjly";
NSString* const _api_threesale_fxorder = @"act=fxapi&ctrl=order";
NSString* const _api_threesale_FXURL = @"mod=wap&act=help&ctrl=fenxiao";
/*
 others
 */
NSString* const _api_others_getstartpic = @"act=api&ctrl=getstartpic";
//接口描述：用于获取app的一些基本设置
NSString* const _api_others_getset = @"mod=appapi&act=appset&ctrl=getset";
NSString* const _api_others_statement = @"mod=wap&act=statement";
NSString* const _api_others_yiyuanindex = @"mod=wap&act=yiyuanindex&ctrl=home";
NSString* const _api_others_htmlFllowOrder = @"mod=appapi&act=jsorder&ctrl=html";

NSString* const _api_others_JShtmlFllowOrder = @"act=te&ctrl=d3";

/** 15.1超高返&&超级券图文位 **/
NSString* const _api_others_rebatetuwen = @"mod=appapi&act=dg_new_jk&ctrl=tuwen";
/** 15.2购物返利栏目商品分类 **/
NSString* const _api_others_rebatecate = @"mod=appapi&act=dg_new_jk&ctrl=cate";
/** 15.3超高返&&优惠券广告文 **/
NSString* const _api_others_rebateggw = @"mod=appapi&act=dg_new_jk&ctrl=ggw";
/** 15.4超级券&&超高返二级分类 **/
NSString* const _api_others_rebatesubcate = @"mod=appapi&act=dg_new_jk&ctrl=two_cate";
/** 15.5热搜关键词 **/
NSString* const _api_others_getkeyword = @"act=api&ctrl=getkeyword";

NSString* const _home_api_signup = @"mod=wap&act=sign&ctrl=index&token=";
