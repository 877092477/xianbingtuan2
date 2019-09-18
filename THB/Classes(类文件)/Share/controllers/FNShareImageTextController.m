//
//  FNShareImageTextController.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/3.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNShareImageTextController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "FNImageSelectCell.h"
#import "FNShareListView.h"
#import "FNShareMixModel.h"
#import "HXPhotoTools.h"

@interface FNShareImageTextController ()<UICollectionViewDelegate, UICollectionViewDataSource, FNShareListViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UITextView *txvContent;
@property (nonatomic, strong) UIView *vLine1;
@property (nonatomic, strong) UIView *vLine2;

@property (nonatomic, strong) UIButton *btnCopy;
@property (nonatomic, strong) UIView *vLine3;
@property (nonatomic, strong) UILabel *lblPhoto;

@property (nonatomic, strong) UICollectionView *clvPhoto;
@property (nonatomic, strong) FNShareListView *shareView;
@property (nonatomic, strong) NSMutableArray<NSString*> *checks;

@property (nonatomic, strong) FNShareMixModel *model;

@end

@implementation FNShareImageTextController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
//    [IQKeyboardManager sharedManager].enable = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _checks = [[NSMutableArray alloc] init];
    [self configUI];
}

- (void)configUI {
    
    _scrollview = [[UIScrollView alloc] init];
    _vContent = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _txvContent = [[UITextView alloc] init];
    _vLine1 = [[UIView alloc] init];
    _vLine2 = [[UIView alloc] init];
    _btnCopy = [[UIButton alloc] init];
    _vLine3 = [[UIView alloc] init];
    _lblPhoto = [[UILabel alloc] init];
    _shareView = [[FNShareListView alloc] init];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(82, 120);
    layout.minimumLineSpacing = 12;
    layout.minimumInteritemSpacing = 12;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _clvPhoto = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    [self.view addSubview:_scrollview];
    [_scrollview addSubview:_vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_txvContent];
    [_vContent addSubview:_vLine1];
    [_vContent addSubview:_vLine2];
    [_vContent addSubview:_btnCopy];
    [_vContent addSubview:_vLine3];
    [_vContent addSubview:_lblPhoto];
    [_vContent addSubview:_clvPhoto];
    [self.view addSubview: _shareView];
    
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.bottom.equalTo(self.shareView.mas_top);
        
    }];
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.width.equalTo(self.view);
//        make.height.equalTo(self.view);
    }];
    [_vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.height.mas_equalTo(1);
        make.left.right.equalTo(@0);
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.lessThanOrEqualTo(@-16);
        make.top.equalTo(@20);
    }];
    [_txvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(18);
        make.right.equalTo(@-20);
        make.height.mas_equalTo(160);
    }];
    
    [_vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txvContent.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
        make.left.right.equalTo(@0);
    }];
    [_btnCopy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.height.mas_equalTo(24);
        make.top.equalTo(self.vLine2.mas_bottom).offset(9);
    }];
    [_btnCopy.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnCopy).offset(10);
        make.right.equalTo(self.btnCopy).offset(-10);
        make.center.equalTo(self.btnCopy);
    }];
    [_vLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnCopy.mas_bottom).offset(15);
        make.height.mas_equalTo(4);
        make.left.right.equalTo(@0);
    }];
    [_lblPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.vLine3.mas_bottom).offset(10);
    }];
    [_clvPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(120);
        make.top.equalTo(self.lblPhoto.mas_bottom).offset(14);
        make.bottom.equalTo(@-20);
    }];
    [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(isIphoneX ? @-34 : @0);
        make.height.mas_equalTo(130);
    }];
    
    _scrollview.bounces = NO;
    
    _lblTitle.numberOfLines = 2;
    
    _txvContent.font = kFONT13;
    _txvContent.textColor = RGB(153, 153, 153);
    
    _vLine1.backgroundColor = RGB(240, 240, 240);
    _vLine2.backgroundColor = RGB(240, 240, 240);
    _vLine3.backgroundColor = RGB(240, 240, 240);
    
    _btnCopy.layer.cornerRadius = 12;
    _btnCopy.titleLabel.font = kFONT14;
    [_btnCopy addTarget:self action:@selector(onCopyClick) forControlEvents:UIControlEventTouchUpInside];
    
    _lblPhoto.text = @"选择照片";
    _lblPhoto.textColor = RGB(51, 51, 51);
    _lblPhoto.font = kFONT15;
    
    _clvPhoto.backgroundColor = UIColor.clearColor;
    _clvPhoto.delegate = self;
    _clvPhoto.dataSource = self;
    [_clvPhoto registerClass:[FNImageSelectCell class] forCellWithReuseIdentifier:@"FNImageSelectCell"];
    
    _shareView.delegate = self;
    
    [self apiRequestcData];
}

- (void) updateView {
    if (self.model == nil)
        return;
    
    _lblTitle.text = self.model.goods_title;
    _txvContent.text = self.model.content;
    
    [_btnCopy setTitleColor: [UIColor colorWithHexString: self.model.color_copy] forState: UIControlStateNormal];
    [_btnCopy setTitle: self.model.str_copy forState: UIControlStateNormal];
    _btnCopy.layer.backgroundColor = [UIColor colorWithHexString: self.model.bjcolor_copy].CGColor;

}

- (void) updateShare {
    if (self.model == nil)
        return;
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (FNShareMixButtonModel *mix in self.model.share_list) {
        [titles addObject: mix.title];
        [images addObject: mix.img];
    }
    [_shareView setImages:images withTitles:titles];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.img_list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //FNCollectionViewCellIdentifier *FunctionComponent=self.tableSections[section];
    FNImageSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNImageSelectCell" forIndexPath:indexPath];
    [SDWebImageManager.sharedManager downloadImageWithURL:URL(self.model.img_list[indexPath.row]) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.imageView.image = image;
    }];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.layer.masksToBounds = YES;
    [cell setCheck: [self.checks[indexPath.row] isEqualToString: @"1"]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    FNImageSelectCell *cell = (FNImageSelectCell *)[collectionView cellForItemAtIndexPath:indexPath];
    BOOL status = [self.checks[indexPath.row] isEqualToString: @"1"];
//    [cell setCheck: !status];
    
    self.checks[indexPath.row] = status ? @"0" : @"1";
    [collectionView reloadData];
}

#pragma mark - Networking

- (FNRequestTool *)apiRequestcData{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token": UserAccessToken}];
    if(self.SkipUIIdentifier){
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    }
    if(self.fnuo_id){
        params[@"gid"]=self.fnuo_id;
    }
    if(self.type){
        params[@"type"]=self.type;
    }
    NSLog(@"searSkipUIIdentifier:%@",self.SkipUIIdentifier);
    @weakify(self)
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=share_model&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNShareMixModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.model = respondsObject;
        
        [self updateShare];
        [self updateView];
        
        [self.checks removeAllObjects];
        for (NSInteger index = 0; index < self.model.img_list.count; index++) {
            [self.checks addObject: @"0"];
        }
        [self.clvPhoto reloadData];
        
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}


#pragma mark - Action

- (void)onCopyClick {
    if (![_txvContent.text kr_isNotEmpty])
        return;
    
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    [pab setString:_txvContent.text];
    if (pab == nil) {
        [FNTipsView showTips:@"复制失败"];
    }else{
        [FNTipsView showTips:@"复制成功"];
    }
}

#pragma mark - FNShareListViewDelegate
- (void)shareListView: (FNShareListView*)view didClickAt: (NSInteger) index {
    FNShareMixButtonModel *model = self.model.share_list[index];
    
    NSMutableArray<NSString*> *selectImages = [[NSMutableArray alloc] init];
    for (NSInteger j = 0; j < self.model.img_list.count; j++) {
        if ([self.checks[j] isEqualToString:@"1"]) {
            [selectImages addObject: self.model.img_list[j]];
        }
    }
    
    if (selectImages.count == 0 && self.model.img_list.count > 0) {
        [FNTipsView showTips:@"请选择要分享的图片"];
        return;
    }
    @weakify(self)
    [XYNetworkAPI downloadImages:selectImages withFinishedBlock:^(NSArray<UIImage *> *images) {
        @strongify(self)
        
        if ([model.type isEqualToString:@"share_img"]) {
            
            
            if ([_txvContent.text kr_isNotEmpty]){
                
                UIPasteboard *pab = [UIPasteboard generalPasteboard];
                [pab setString:_txvContent.text];
                [FNTipsView showTips:@"文案复制成功"];
            }
            
            if (images.count <= 1) {
                
                UMSocialPlatformType type = 0;
                
                if ([model.share_platform isEqualToString:@"wechat"]) {
                    type = UMSocialPlatformType_WechatSession;
                } else if ([model.share_platform isEqualToString:@"wechat_circle"]) {
                    type = UMSocialPlatformType_WechatTimeLine;
                } else if ([model.share_platform isEqualToString:@"qq"]) {
                    type = UMSocialPlatformType_QQ;
                } else if ([model.share_platform isEqualToString:@"sina"]) {
                    type = UMSocialPlatformType_Sina;
                }
                if (images.count == 1) {
                    [self umengShareWithURL:nil image:images[0] shareTitle:nil andInfo:nil withType: type];
                }
            } else {
                UIActivityViewController* vc = [[UIActivityViewController alloc]initWithActivityItems:images applicationActivities:nil];
                [self presentViewController:vc animated:YES completion:nil];
            }
            
            
            
        } else if ([model.type isEqualToString:@"save_img"]) {
            int i = 0;
            for (UIImage *image in images) {
                NSString *name = [NSString stringWithFormat:@"%lf%d", [NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970, i];
                [HXPhotoTools savePhotoToCustomAlbumWithName:name photo: image];
                i++;
            }
            
            if ([_txvContent.text kr_isNotEmpty]){
                
                UIPasteboard *pab = [UIPasteboard generalPasteboard];
                [pab setString:_txvContent.text];
            }
            [FNTipsView showTips:@"保存成功"];
        }
        
        
    }];
    
    
}

@end
