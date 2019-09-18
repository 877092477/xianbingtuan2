//
//  FNTallyPhotoTailView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNTallyPhotoTailView.h"
static const CGFloat kPhotoViewMargin = 12.0;
@implementation FNTallyPhotoTailView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.hintLb=[[UILabel alloc]init];
    [self addSubview:self.hintLb];
    
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.bgView.cornerRadius=3;
    
    self.hintLb.font=[UIFont systemFontOfSize:10];
    self.hintLb.textColor=RGB(153, 153, 153);
    self.hintLb.textAlignment=NSTextAlignmentLeft;
    
    self.hintLb.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 9).rightSpaceToView(self, 10).heightIs(16);
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self.hintLb, 3).heightIs(383);
    
    self.hintLb.text=@"注：一次性最多上传9张";
    
    
    self.manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
    self.manager.openCamera = NO;
    self.manager.cacheAlbum = YES;
    self.manager.lookLivePhoto = YES;
    self.manager.outerCamera = NO;
    self.manager.cameraType = HXPhotoManagerCameraTypeFullScreen;
    //_manager.photoMaxNum = 3;
    self.manager.videoMaxNum = 0;
    self.manager.maxNum = 3;
    self.manager.videoMaxDuration = 120.f;
    self.manager.saveSystemAblum = NO;
    self.manager.style = HXPhotoAlbumStylesSystem;
    //        _manager.reverseDate = YES;
    self.manager.showDateHeaderSection = NO;
    self.manager.selectTogether = NO;
    self.manager.rowCount = 4;
    //self.manager.UIManager.photoViewAddImageName=@"FN_TallyPhotoimg";
    self.manager.photoMaxNum=9;
    self.manager.UIManager.navBar = ^(UINavigationBar *navBar) {
       
    };
    
    CGFloat width = FNDeviceWidth-24;
    self.photoView = [HXPhotoView photoManager:self.manager];
    self.photoView.frame = CGRectMake(10, 0, width - 10 * 2, 0);
    self.photoView.delegate = self;
    self.photoView.lineCount = 3;
    self.photoView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:self.photoView];
    self.photoView.sd_layout
    .leftSpaceToView(self.bgView, 10).topSpaceToView(self.bgView, 5).rightSpaceToView(self.bgView, 10).bottomSpaceToView(self.bgView, 5);
}

#pragma mark - 图片代理方法
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    
    [HXPhotoTools getImageForSelectedPhoto:photos type:HXPhotoToolsFetchOriginalImageTpe completion:^(NSArray<UIImage *> *images) {
        XYLog(@"images:%@",images);
        if ([self.delegate respondsToSelector:@selector(didMerTallyPhotoImages:)]) {
            [self.delegate didMerTallyPhotoImages:images];
        } 
    }];
}
- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"networkPhotoUrl:%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    
    CGFloat imgsHeight=frame.size.height;
    if(imgsHeight>350){
       self.bgView.sd_layout
       .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self.hintLb, 3).heightIs(imgsHeight+50);
       self.photoView.sd_layout
       .leftSpaceToView(self.bgView, 10).topSpaceToView(self.bgView, 5).rightSpaceToView(self.bgView, 10).bottomSpaceToView(self.bgView, 5);
    }
   
    //NSSLog(@"高=%@",NSStringFromCGRect(frame));
 
    
}
@end
