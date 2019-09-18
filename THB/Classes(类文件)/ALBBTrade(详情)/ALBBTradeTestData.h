//
//  ALBBTradeTestData.h
//  TaeSDKSample
//
//  Created by 千醒 on 15/6/23.
//  Copyright (c) 2015年 com.taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALBBTradeTestData : NSObject

@property (nonatomic, strong) NSString *pageUrl;
@property (nonatomic, strong) NSString *itemType;
@property (nonatomic, strong) NSString *realItemId;
@property (nonatomic, strong) NSString *openItemId1;
@property (nonatomic, strong) NSString *skuId1;
@property (nonatomic, strong) NSString *openItemId2;
@property (nonatomic, strong) NSString *skuId2;

@property (nonatomic, strong) NSString *taoKePid;
@property (nonatomic, strong) NSString *taoKeUnionId;

@property (nonatomic, strong) NSString *promotionparam;
@property (nonatomic, strong) NSString *promotiontype;
@property (nonatomic, strong) NSString *eticketorderid;


/*!
 @brief ItemType可选值:淘宝宝贝、天猫宝贝
 !*/
typedef NS_ENUM(NSInteger, OneSDKItemType)
{
    OneSDKItemType_TAOBAO1      = 0,
    OneSDKItemType_TAOBAO2      = 1,
    OneSDKItemType_TMALL1       = 2,
    OneSDKItemType_TMALL2       = 3,
};


/*!
 @brief PromoType可选值:shop、auction
 !*/
typedef NS_ENUM(NSInteger, OneSDKPromoType)
{
    OneSDKPromoType_SNSHOP      = 0,
    OneSDKPromoType_IDAUCTION   = 1
};


@end





#pragma mark - 日常宝贝
//==============daily taobao item===============//
#define DAILYURL_TB1            @"http://h5.waptest.taobao.com/cm/snap/index.html?id=2100520226791"
#define DAILYITEMID_TB1         @"AAEUb-fzAAgOrLtFIjZQjzV7"
#define DAILYREALITEMID_TB1     @"2100520226791"
#define DAILYITEMTYPE_TB1       @"1"
#define DAILYSKUID_TB1          @"31057098224"
#define SANDBOXURL_TB1          @"http://h5.waptest.tbsandbox.com/cm/snap/index.html?id=2100520226791"

//淘宝宝贝二
#define DAILYURL_TB2            @"http://h5.waptest.taobao.com/cm/snap/index.html?id=1500001830461"
#define DAILYITEMID_TB2         @"AAGMb-fzAAgOrLtFIoJ_X7yh"
#define DAILYREALITEMID_TB2     @"1500001830461"
#define DAILYITEMTYPE_TB2       @"1"
#define DAILYSKUID_TB2          nil
#define SANDBOXURL_TB2          @"http://h5.waptest.tbsandbox.com/cm/snap/index.html?id=1500001830461"



//===============================================//


//==============daily tmall item===============//

//天猫宝贝一
#define DAILYURL_TM1            @"http:detail.waptest.tmall.com/item.htm?id=2100502166202"
#define DAILYITEMID_TM1         @"AAEdb-fzAAgOrLtFIjZP40Am"
#define DAILYREALITEMID_TM1     @"2100502166202"
#define DAILYITEMTYPE_TM1       @"2"
#define DAILYSKUID_TM1          nil
#define SANDBOXURL_TM1          @"http:detail.tmall.waptest.tbsandbox.com/item.htm?id=2100502166202"

#define DAILYURL_TM2            @"http://detail.waptest.tmall.com/item.htm?id=2100502146518"
#define DAILYITEMID_TM2         @"AAEYb-fzAAgOrLtFIjZP4xdK"
#define DAILYREALITEMID_TM2     @"2100502146518"
#define DAILYITEMTYPE_TM2       @"2"
#define DAILYSKUID_TM2          @"31050689961"
#define SANDBOXURL_TM2          @"http://detail.tmall.waptest.tbsandbox.com/item.htm?id=2100502146518"
//===============================================//


//==============daily Taoke===============//
#define DAILYTAOKEPID           @"mm_2000059001_20312021_20406001"
#define DAILYTAOKEUNIONID       nil
//========================================//

//===========daily 优惠券,电子凭证===========//
#define DAILYSELLNICK           @"shenlingseller"
#define DAILYITID               @"AAG-b-fzAAgOrLtFIg7r63OY"
#define DAILYORDERID            @"192535700917185"
//========================================//




#pragma mark - 线上宝贝
//==============release taobao item===============//
#define RELEASEURL_TB1          @"http://h5.m.taobao.com/cm/snap/index.html?id=42966483399"
#define RELEASEITEMID_TB1       @"AAG1t-dcABxGVVui-VfjmwWi"        //23082328
//#define RELEASEITEMID_TB1       @"AAGcIOpwABpJi95ZrWi_VOWw"       //23015524
#define RELEASEREALITEMID_TB1   @"42966483399"
#define RELEASEITEMTYPE_TB1     @"1"
#define RELEASESKUID_TB1        @"74133269398"
#define PRERELEASEURL_TB1       @"http://h5.wapa.taobao.com/cm/snap/index.html?id=42966483399"


//专享价宝贝

#define RELEASEURL_TB2          @"https://item.taobao.com/item.htm?spm=a1z10.3-c.w4002-11208743438.74.JJkYox&id=520776050719"

#define RELEASEITEMID_TB2       @"AAEVt-dcABxGVVui-SSiMGx6"         //23082328
//#define RELEASEITEMID_TB2       @"AAEcIOpwABpJi95ZrWsQcHG0"       //23015524
#define RELEASEREALITEMID_TB2   @"520776050719"
#define RELEASEITEMTYPE_TB2     @"1"
#define RELEASESKUID_TB2        nil
//#define PRERELEASEURL_TB2       @"http://h5.wapa.taobao.com/cm/snap/index.html?id=41576306115"
#define PRERELEASEURL_TB2       @"http://h5.wapa.taobao.com/item.htm?spm=a1z10.3-c.w4002-11208743438.74.JJkYox&id=520776050719"


/*原始淘宝宝贝二
#define RELEASEURL_TB2          @"http://h5.m.taobao.com/awp/core/detail.htm?id=45802953688"
#define RELEASEITEMID_TB2       @"AAG-t-dcABxGVVui-VdIih-9"         //23082328
//#define RELEASEITEMID_TB2       @"AAH7IOpwABpJi95ZrWgURf-v"         //23015524
#define RELEASEREALITEMID_TB2   @"45802953688"
#define RELEASEITEMTYPE_TB2     @"1"
#define RELEASESKUID_TB2        nil
#define PRERELEASEURL_TB2       @"http://h5.wapa.taobao.com/cm/snap/index.html?id=45802953688"
 */
//===============================================//




//==============release tmall item===============//
//原始天猫宝贝一
/*
#define RELEASEURL_TM1          @"http://detail.m.tmall.com/item.htm?id=39273264628"
#define RELEASEITEMID_TM1       @"AAGat-dcABxGVVui-VTGRfGR"        //23082328
//#define RELEASEITEMID_TM1       @"AAGvIOpwABpJi95ZrWuaihGD"       //23015524
#define RELEASEREALITEMID_TM1   @"39273264628"
#define RELEASEITEMTYPE_TM1     @"2"
#define RELEASESKUID_TM1        nil
#define PRERELEASEURL_TM1       @"http://detail.wapa.tmall.com/item.htm?id=39273264628"
*/


//商超宝贝 线上环境修改预发环境
#define RELEASEURL_TM1          @"https://chaoshi.detail.m.tmall.com/item.htm?spm=0.0.0.0.SEsTTK&userBucket=17&id=13921456618"
#define RELEASEITEMID_TM1       @"AAHtt-dcABxGVVui-V7fUxWP"         //23082328
//#define RELEASEITEMID_TM1       @"AAGvIOpwABpJi95ZrWuaihGD"       //23015524
#define RELEASEREALITEMID_TM1   @"13921456618"
#define RELEASEITEMTYPE_TM1     @"2"
#define RELEASESKUID_TM1        nil
#define PRERELEASEURL_TM1       @"https://chaoshi.detail.wapa.tmall.com/item.htm?spm=0.0.0.0.SEsTTK&userBucket=17&id=13921456618"



#define RELEASEURL_TM2          @"http://detail.m.tmall.com/item.htm?id=22429824161"
#define RELEASEITEMID_TM2       @"AAEPt-dcABxGVVui-VjacHDE"        //23082328
//#define RELEASEITEMID_TM2       @"AAGeIOpwABpJi95ZrWeGv5DW"       //23015524
#define RELEASEREALITEMID_TM2   @"22429824161"
#define RELEASEITEMTYPE_TM2     @"2"
#define RELEASESKUID_TM2        nil
#define PRERELEASEURL_TM2       @"http://detail.wapa.tmall.com/item.htm?id=22429824161"
//===============================================//


//==============release Taoke===============//
#define RELEASETAOKEPID         @"mm_97100348_7476080_24834937"
#define RELEASETAOKEUNIONID     nil
//==========================================//


//===========release 优惠券,电子凭证===========//
#define RELEASESELLNICK         @"c测试账号0515"
#define RELEASEITID             @"AAHiIOpwABpJi95ZrWtQ9RKU"
#define RELEASEORDERID          @"931159680463903"
//==========================================//