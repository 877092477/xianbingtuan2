//
//  FNShareController.m
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNShareController.h"
#import "FNShareMutiplyView.h"
#import "FNShareMutiplyViewModel.h"
#import "HXPhotoTools.h"

@interface FNShareController ()<FNShareMutiplyViewDelegate>
@property (nonatomic, strong)FNShareMutiplyViewModel* viewmodel;
@property (nonatomic, strong)FNShareMutiplyView* shareview;
@end

@implementation FNShareController
- (FNShareMutiplyView *)shareview{
    if (_shareview == nil) {
        _shareview = [[FNShareMutiplyView alloc]initWithViewModel:self.viewmodel];
        _shareview.delegate = self;
    }
    return _shareview;
}
- (FNShareMutiplyViewModel *)viewmodel{
    if (_viewmodel == nil) {
        _viewmodel = [FNShareMutiplyViewModel new];
        _viewmodel.fnuo_id = self.fnuo_id;
        _viewmodel.getGoodsType=self.getGoodsType;
        if ([self.SkipUIIdentifier isEqualToString:@"buy_jingdong"]){
            _viewmodel.yhq_url=self.yhq_url;
        }
        _viewmodel.SkipUIIdentifier=self.SkipUIIdentifier;
    }
    return _viewmodel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"创建分享";
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"存至相册" style:UIBarButtonItemStyleDone target:self action:@selector(savePhotos)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)savePhotos {
//    if (_viewmodel == nil)
//        return;
//    FNShareMutiplyModel *model = _viewmodel.model;
//
//    [FNTipsView showTips:@"文案复制成功"];
//    [[UIPasteboard generalPasteboard] setString:model.goods_title];
//    [SVProgressHUD show];
//
//    [XYNetworkAPI downloadImages:model.goods_img withIndexBlock:^(UIImage *image, NSInteger index) {
//        NSString *name = [NSString stringWithFormat:@"%lf", [NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970];
//        [HXPhotoTools savePhotoToCustomAlbumWithName:name photo: image];
//        if (index == model.goods_img.count - 1) {
//
//            [SVProgressHUD dismiss];
//            [FNTipsView showTips:@"保存成功～"];
//        }
//    } failureBlock:^(NSError *error) {
//
//    }];
//
//}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self.view addSubview:self.shareview];
    [self.shareview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
}
- (void)jm_bindViewModel{
    [[self.viewmodel.shareSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        //
        UIActivityViewController* vc = [[UIActivityViewController alloc]initWithActivityItems:x applicationActivities:nil];
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

#pragma mark - FNShareMutiplyViewDelegate
- (void)didImageShare: (FNShareMutiplyView*)view withImages: (NSArray<NSString*>*) images atType: (UMSocialPlatformType) type {
    if (images.count == 0) {
        [FNTipsView showTips:@"请选择分享图片"];
        return;
    }
    
    if (type == -1) {//保存相册
        FNShareMutiplyModel *model = _viewmodel.model;
        [FNTipsView showTips:@"文案复制成功"];
        [[UIPasteboard generalPasteboard] setString:model.goods_title];
        [SVProgressHUD show];
        
        [XYNetworkAPI downloadImages:images withIndexBlock:^(UIImage *image, NSInteger index) {
            NSString *name = [NSString stringWithFormat:@"%lf", [NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970];
            [HXPhotoTools savePhotoToCustomAlbumWithName:name photo: image];
            if (index == images.count - 1) {
                
                [SVProgressHUD dismiss];
                [FNTipsView showTips:@"保存成功～"];
            }
        } failureBlock:^(NSError *error) {
            
        }];
        return;
    }
    
    @weakify(self);
    [XYNetworkAPI downloadImages:images withFinishedBlock:^(NSArray<UIImage *> *imgs) {
        @strongify(self);
        if (imgs.count == 1) {
            [self umengShareWithURL:nil image:imgs[0] shareTitle:nil andInfo:nil withType: type];
        } else if (imgs.count>1) {
            [self.viewmodel.shareSubject sendNext:imgs];
        }
    }];
    
    
}

@end
