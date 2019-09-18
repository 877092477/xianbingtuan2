//
//  FNProductVideoHeader.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/25.
//  Copyright © 2019 方诺科技. All rights reserved.
// 图片放大视频播放

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNProductVideoHeader : UIView <UIScrollViewDelegate>
@property (nonatomic, strong) void (^PlayVideoOptBlock)(BOOL isOK);
@property (nonatomic, strong) void (^scrollOptBlock)(NSInteger index);
@property (nonatomic, strong, setter=setDownloadBlock:) void (^DownloadBlock)(void);
@property (nonatomic, strong) void (^ClickBlock)(NSInteger index);
@property (nonatomic,strong) UIScrollView * scrolV;
@property (nonatomic,strong) UIImageView *  videoCoverImgV;//视频封面
@property (nonatomic,strong) UILabel *  indexLab;//当前播放页数
@property (nonatomic,strong) UIButton *  playBtn;//播放按钮
@property (nonatomic,strong) UIButton *  ToVideoBtn;//切换到视频
@property (nonatomic,strong) UIButton *  ToPictureBtn;//切换到图片
@property (nonatomic,copy) NSArray * productDetailsArr;//包含图片或视频URL的数组
- (void)updateUIWithImageAndVideoArray:(NSArray *)detailsArr isVideoShow: (BOOL)isShow;

- (void)playWithUrl: (NSURL*)url;
- (void)stopPlaying;

@end

NS_ASSUME_NONNULL_END
