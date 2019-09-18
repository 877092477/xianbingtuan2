//
//  FNDetailBottomView.m
//  THB
//
//  Created by Jimmy on 2017/12/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNDetailBottomView.h"
#import "FNFunctionBtnView.h"
#import "FNCmbDoubleTextButton.h"
#import "FNNewProductDetailModel.h"
@interface FNDetailBottomView()
@property (nonatomic, strong)UIButton *btnCollection;
@property (nonatomic, strong)UIButton *btnShare;
@property (nonatomic, strong)UIButton *btnBuy;
@end
@implementation FNDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _btnCollection = [[UIButton alloc] init];
        [_btnCollection setTitle:@"收藏" forState:UIControlStateNormal];
        _btnCollection.titleLabel.font = kFONT14;
        [_btnCollection setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];
        [_btnCollection setImage:IMAGE(@"new_product_detail_collection_normal") forState:UIControlStateNormal];
        [_btnCollection setImage:IMAGE(@"new_product_detail_collection_selected") forState:UIControlStateSelected];
        [_btnCollection layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [_btnCollection addTarget:self action:@selector(onCollectionClick:)];
        [self addSubview:_btnCollection];
        [_btnCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(@0);
            make.width.mas_equalTo(98);
        }];
        
        _btnShare = [[UIButton alloc] init];
        [_btnShare setTitle:@"分享" forState:UIControlStateNormal];
        _btnShare.titleLabel.font = kFONT14;
        [_btnShare setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];
        [_btnShare layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [_btnShare addTarget:self action:@selector(shareBtnAction)];
        [self addSubview:_btnShare];
        
        
        _btnBuy = [[UIButton alloc] init];
        [_btnBuy setTitle:@"立即购买" forState:UIControlStateNormal];
        _btnBuy.titleLabel.font = kFONT14;
        [_btnBuy setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];
        [_btnBuy layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [_btnBuy addTarget:self action:@selector(purchaseBtnAction)];
        [self addSubview:_btnBuy];
        
        [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btnCollection.mas_right);
            make.top.equalTo(@5);
            make.bottom.equalTo(@-5);
        }];
        
        [_btnBuy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btnShare.mas_right);
            make.top.equalTo(@5);
            make.bottom.equalTo(@-5);
            make.right.equalTo(@-10);
            make.width.equalTo(self.btnShare);
        }];
    }
    return self;
}

- (void)onCollectionClick: (id)sender {
    NSString *token = UserAccessToken;
    if (self.btnClicked) {
        self.btnClicked(0);
    }
    if (token == nil  || token.length == 0) {
        //warn user to login
        [FNTipsView showTips:@"登录之后才可以收藏商品"];
    }else{
        if (self.model.is_collect.boolValue) {
            [self deleteMyLikeMethod:self.model.ID];
        }else{
            [self addMyLikeMethod:self.model.ID];
        }
    }
}

//- (void)setupbtns{
//
//    if ([FNBaseSettingModel settingInstance].goods_detail_yhq_onoff.boolValue) {
//        UIButton* purchaseBtn  =[ UIButton buttonWithTitle:@"立即购买" titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(purchaseBtnAction)];
//        purchaseBtn.tag = 3 + 1000;
//        purchaseBtn.backgroundColor = FNMainGobalControlsColor;
//        purchaseBtn.frame = CGRectMake(left_width*titles.count, 0, JMScreenWidth-left_width*titles.count, self.height);
//        [self addSubview:purchaseBtn];
//
//    }else{
//        NSLog(@"FNCurrentVersion:%@",FNCurrentVersion);
//        NSLog(@"Setting_checkVersion:%@",Setting_checkVersion);
//
//        if(![FNCurrentVersion isEqualToString:Setting_checkVersion]){
//            for (NSInteger i= 0; i<2; i++) {
//                FNCmbDoubleTextButton* textBtn = [[FNCmbDoubleTextButton alloc]initWithFrame:(CGRectMake(left_width*titles.count+i*right_width, 0, right_width, self.height))];
////                textBtn.bottomLabel.titleLabel.text = @"0.00";
//                textBtn.isHiidenTop = YES;
//                textBtn.normalColor = FNWhiteColor;
//                textBtn.tag = i+3 + 1000;
//                [textBtn addJXTouchWithObject:^(FNCmbDoubleTextButton* obj) {
//                    //
//                    NSInteger tag = obj.tag-1000;
//                    if (self.btnClicked) {
//                        self.btnClicked(tag);
//                    }
//                }];
//                UIImageView* bgimgview = [UIImageView new];
////                if (i == 0) {
//                    //bgimgview.image = IMAGE(@"detail_btn1_bj");
//                    bgimgview.image = IMAGE(@"");
//                    [textBtn setBackgroundColor:[UIColor blackColor]];
////                }else{
////                    bgimgview.image = IMAGE(@"detail_btn2_bj");
////                }
//                [textBtn insertSubview:bgimgview atIndex:0];
//                [bgimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
//                [self addSubview:textBtn];
//                [self.rightbtns addObject:textBtn];
//            }
//        }else{
//            NSLog(@"版本号:%@",FNCurrentVersion);
//            FNCmbDoubleTextButton* textBtn = [[FNCmbDoubleTextButton alloc]initWithFrame:(CGRectMake(left_width*titles.count, 0, JMScreenWidth-left_width*titles.count, self.height))];
//            textBtn.isHiidenTop = YES;
//            textBtn.normalColor = FNWhiteColor;
//            textBtn.tag = 4 + 1000;
//            [textBtn addJXTouchWithObject:^(FNCmbDoubleTextButton* obj) {
//                //
//                NSInteger tag = obj.tag-1000;
//                if (self.btnClicked) {
//                    self.btnClicked(tag);
//                }
//            }];
//            UIImageView* bgimgview = [UIImageView new];
//            bgimgview.image = IMAGE(@"detail_btn2_bj");
//            [textBtn insertSubview:bgimgview atIndex:0];
//            [bgimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
//            [self addSubview:textBtn];
//            [self.rightbtns addObject:textBtn];
//        }
//
//    }
//
//}
- (void)setModel:(FNNewProductDetailModel *)model{
    _model = model;
    if (_model) {
        self.btnCollection.selected =  self.model.is_collect.boolValue;
        if(![FNCurrentVersion isEqualToString:Setting_checkVersion]){

            NSDictionary *fxzdictry=model.btn_fxz;
            NSString *fxzString=[NSString stringWithFormat:@"%@%.2f",fxzdictry[@"str"],((NSString*)fxzdictry[@"bili"]).floatValue];
            CGFloat zhiOne=((NSString*)fxzdictry[@"bili"]).floatValue;
            if(zhiOne==0){
               fxzString=fxzdictry[@"str"];
            }
            [self.btnShare setTitle:[NSString stringWithFormat:@"%@",fxzString] forState:(UIControlStateNormal)];
            NSString *fxzbjcolor=fxzdictry[@"bjcolor"];
            NSString *fxzfontcolor=fxzdictry[@"fontcolor"];
            NSString *fxzImage = fxzdictry[@"img"];
            if ([fxzImage kr_isNotEmpty]) {
                [self.btnShare sd_setBackgroundImageWithURL:URL(fxzImage) forState:UIControlStateNormal];
                self.btnShare.backgroundColor = UIColor.clearColor;
            } else if([fxzbjcolor kr_isNotEmpty]){
                self.btnShare.backgroundColor=[UIColor colorWithHexString:fxzbjcolor];
            }
            if([fxzfontcolor kr_isNotEmpty]){
                [self.btnShare setTitleColor:[UIColor colorWithHexString:fxzfontcolor] forState:UIControlStateNormal];
            }

            NSDictionary *dictry=model.btn_zgz;
            NSString *jointString=[NSString stringWithFormat:@"%@%.2f",dictry[@"str"],((NSString*)dictry[@"bili"]).floatValue];
            CGFloat zhiTwo=((NSString*)dictry[@"bili"]).floatValue;
            if(zhiTwo==0){
                jointString=dictry[@"str"];
            }
            [self.btnBuy setTitle:jointString forState:(UIControlStateNormal)];
            NSString *rightbjcolor=dictry[@"bjcolor"];
            NSString *rightfontcolor=dictry[@"fontcolor"];
            NSString *rightImage = dictry[@"img"];
            if ([rightImage kr_isNotEmpty]) {
                [self.btnBuy sd_setBackgroundImageWithURL:URL(rightImage) forState:UIControlStateNormal];
                self.btnBuy.backgroundColor=[UIColor clearColor];
            }
            else if([rightbjcolor kr_isNotEmpty]){
                self.btnBuy.backgroundColor=[UIColor colorWithHexString:rightbjcolor];
            }
            if([rightfontcolor kr_isNotEmpty]){
                [self.btnBuy setTitleColor:[UIColor colorWithHexString:rightfontcolor] forState:UIControlStateNormal];
            }
        }else{
            self.btnShare.hidden = YES;
            self.btnBuy.backgroundColor = RED;
        }
        
    }
}


#pragma mark - request
-(void)deleteMyLikeMethod:(NSString *)goodsId{
    @WeakObj(self);

    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{                                                                                  @"time":[NSString GetNowTimes],
                                                                                                                                                                    @"goodsid":goodsId,
                                                                                                                                                                    @"token":UserAccessToken}];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_home_deletemylike successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            selfWeak.model.is_collect = @"0";
            selfWeak.btnCollection.selected =selfWeak.model.is_collect.boolValue;
            [FNTipsView showTips:XYDeleteLikeMsg];
        }else {
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        [SVProgressHUD dismiss];
    } failureBlock:^(NSString *error) {
        [XYNetworkAPI cancelAllRequest];
        [SVProgressHUD dismiss];
    }];
    
}
-(void)addMyLikeMethod:(NSString *)goodsId{
    @WeakObj(self);
  
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{                                                                                  @"time":[NSString GetNowTimes],
                                                                                                                                                                    @"goodsid":goodsId,
                                                                                                                                                                    @"token":UserAccessToken}];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_home_addmylike successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            selfWeak.model.is_collect = @"1";
//            selfWeak.leftbtns[self.collectioIndex].button.selected =selfWeak.model.is_collect.boolValue;
            selfWeak.btnCollection.selected =selfWeak.model.is_collect.boolValue;
            [FNTipsView showTips:XYAddLikeMsg];
        }else {
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        [SVProgressHUD dismiss];
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
        [XYNetworkAPI cancelAllRequest];
    }];
    
}

- (void)shareBtnAction{
    
    
    if (self.btnClicked) {
        self.btnClicked(3);
    }
}

- (void)purchaseBtnAction{
    
        
    if (self.btnClicked) {
        self.btnClicked(4);
    }
}
@end
