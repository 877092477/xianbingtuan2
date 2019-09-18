//
//  FNCashAcShareNeController.m
//  THB
//
//  Created by Jimmy on 2018/10/24.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNCashAcShareNeController.h"
#import "FNAssemblyNeModel.h"
@interface FNCashAcShareNeController ()
/** bg **/
@property (nonatomic, strong)UIImageView *bgImageView;
/** 分享 **/
@property (nonatomic, strong)UIButton *shareTopBtn;
/** 复制 **/
@property (nonatomic, strong)UIButton *duplBtn;
/** 分享二维码 **/
@property (nonatomic, strong)UIButton *codeShareBtn;
/** 领取 **/
@property (nonatomic, strong)UIButton *fetchBtn;
/** model **/
@property (nonatomic, strong)FNAssemblyNeModel *dataModel;
@end

@implementation FNCashAcShareNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self apiRequestAssembly];
    self.title=@"分享";
    if ([self.keyWord kr_isNotEmpty]) {
        self.title=self.keyWord;
    }
    self.bgImageView=[UIImageView new];
    self.bgImageView.userInteractionEnabled=YES;
    //self.bgImageView.image=IMAGE(@"FN_CashAcBGimage");
    [self.view addSubview:self.bgImageView];
    
    self.shareTopBtn=[[UIButton alloc]init];
    //[self.shareTopBtn setImage:IMAGE(@"FN_CashAcShareimage") forState:UIControlStateNormal];
    [self.shareTopBtn addTarget:self action:@selector(shareTopClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:self.shareTopBtn];
    
    UIView *centView=[[UIView alloc]init];
    [self.bgImageView addSubview:centView];
    
    self.duplBtn=[[UIButton alloc]init];
    //[self.duplBtn setImage:IMAGE(@"FN_CashAcCopyimage") forState:UIControlStateNormal];
    [self.duplBtn addTarget:self action:@selector(duplBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:self.duplBtn];
    
    self.codeShareBtn=[[UIButton alloc]init];
    //[self.codeShareBtn setImage:IMAGE(@"FN_CashAcCSimage") forState:UIControlStateNormal];
    [self.codeShareBtn addTarget:self action:@selector(codeShareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:self.codeShareBtn];
    
    self.fetchBtn=[[UIButton alloc]init];
    //[self.fetchBtn setImage:IMAGE(@"FN_CashAcLQimage") forState:UIControlStateNormal];
    [self.fetchBtn addTarget:self action:@selector(fetchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:self.fetchBtn];
    
    self.bgImageView.sd_layout
    .leftSpaceToView(self.view, 0).topSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).rightSpaceToView(self.view, 0);
    
    self.shareTopBtn.sd_layout
    .topSpaceToView(self.bgImageView, 10).rightSpaceToView(self.bgImageView, 10).heightIs(35).widthIs(35);
    
    centView.sd_layout
    .bottomSpaceToView(self.bgImageView, 35).widthIs(1).heightIs(45).centerXEqualToView(self.bgImageView);
    
    self.duplBtn.sd_layout
    .bottomSpaceToView(self.bgImageView, 35).heightIs(45).widthIs(150).rightSpaceToView(centView, 10);
    
    self.codeShareBtn.sd_layout
    .bottomSpaceToView(self.bgImageView, 30).heightIs(45).widthIs(150).leftSpaceToView(centView, 10);
    
    self.fetchBtn.sd_layout
    .bottomSpaceToView(self.duplBtn, 10).heightIs(60).widthIs(220).centerXEqualToView(self.bgImageView);
}
//分享
- (void)shareTopClick{
//    NSString *url=self.dataModel.url;
//    [self goWebWithUrl:url];
    
    NSString *tkl_content=self.dataModel.tkl_content;
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    [pab setString:tkl_content];
//    NSString *act_share_qrcode_imgStr=self.dataModel.act_share_qrcode_img;
    //NSString *act_share_title=self.dataModel.act_share_title;
    //NSString *act_share_url=self.dataModel.act_share_url;
    [self umengShareWithURL:self.dataModel.act_share_url image:self.dataModel.act_share_img shareTitle:self.dataModel.act_share_title andInfo:self.dataModel.act_share_content];
    
}
//复制淘口令
- (void)duplBtnClick{
    NSString *tkl_content=self.dataModel.tkl_content;
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    [pab setString:tkl_content];
    if (pab == nil) {
      [FNTipsView showTips:@"复制失败"];
    }else{
      [FNTipsView showTips:@"复制成功"];
    }
}
//分享二维码
- (void)codeShareBtnClick{
    NSString *tkl_content=self.dataModel.tkl_content;
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    [pab setString:tkl_content];
    NSString *act_share_qrcode_imgStr=self.dataModel.act_share_qrcode_img;
    //NSString *act_share_title=self.dataModel.act_share_title;
    //NSString *act_share_url=self.dataModel.act_share_url;
    [self umengShareWithURL:nil image:act_share_qrcode_imgStr shareTitle:nil andInfo:nil];
}
//领取
- (void)fetchBtnClick{
    NSString *url=self.dataModel.url;
    [self goWebDetailWithWebType:@"1" URL:url];
}

#pragma mark - //双11会场接口
- (FNRequestTool *)apiRequestAssembly{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.SkipUIIdentifier kr_isNotEmpty]){
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    }
    if([self.show_type_str kr_isNotEmpty]){
        params[@"show_type_str"]=self.show_type_str;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=tb_activity&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNAssemblyNeModel" success:^(id respondsObject) {
        selfWeak.dataModel=respondsObject;
        [self.bgImageView setUrlImg:selfWeak.dataModel.act_bj_img];
        [self.fetchBtn sd_setImageWithURL:URL(selfWeak.dataModel.act_receive_img) forState:UIControlStateNormal];
        [self.codeShareBtn sd_setImageWithURL:URL(selfWeak.dataModel.act_share_btn_img) forState:UIControlStateNormal];
        [self.duplBtn sd_setImageWithURL:URL(selfWeak.dataModel.act_copy_btn_img) forState:UIControlStateNormal];
        [self.shareTopBtn setImage:IMAGE(@"FN_CashAcShareimage") forState:UIControlStateNormal];
        //[self.shareTopBtn sd_setImageWithURL:URL(selfWeak.dataModel.act_copy_btn_img) forState:UIControlStateNormal];
        
    } failure:^(NSString *error) {
    } isHideTips:YES];
}
@end
