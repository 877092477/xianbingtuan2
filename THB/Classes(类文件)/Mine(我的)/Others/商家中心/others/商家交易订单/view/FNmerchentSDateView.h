//
//  FNmerchentSDateView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "FNcalendarPopDeView.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerchentSDateView : UIView
@property (nonatomic, strong)UIView    *bgview;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *zhiLB;
@property (nonatomic, strong)UIButton  *startBtn;
@property (nonatomic, strong)UIButton  *endBtn;
@property (nonatomic, strong)UIButton  *cancelBtn;
@property (nonatomic, strong)UIButton  *confirmBtn;
- (void)showView: (NSArray<NSString*>*)types;
-(void)hideViewAction;
- (NSArray*) getSelecteds;
@end

NS_ASSUME_NONNULL_END
