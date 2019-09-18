//
//  FNsortHomeListNeController.h
//  THB
//
//  Created by Jimmy on 2018/12/14.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

@class FNsortHomeListNeController;
@protocol FNMaskControllerDelegate <NSObject>

- (void)controller: (FNsortHomeListNeController*)controller didMaskBackground: (NSString*)bgImgUrl foreground: (NSString*)foreImgUrl percent: (CGFloat)percent;

@end

@interface FNsortHomeListNeController : SuperViewController

@property (nonatomic, weak) id<FNMaskControllerDelegate> delegate;

/**分类Id */
@property (nonatomic,strong) NSString *categoryId;
@property (nonatomic,strong) NSString *showtype;
@property (nonatomic,strong) NSString *keyword;

- (void)stopBanner;
- (void)playBanner;

@end


