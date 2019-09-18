//
//  FNteamPullNewHeaderView.h
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/5/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "teamPullNewModel.h"
#import "FNCmbDoubleTextButton.h"

@interface FNteamPullNewHeaderView : UIView

@property (nonatomic,strong)teamPullNewModel *model;

@property (nonatomic,weak)UIImageView *Headportrait;

@property (nonatomic,weak)UIImageView *QRCodeImage;

@property (nonatomic,weak)UILabel *Name;

@property (nonatomic, strong)FNCmbDoubleTextButton* leftBtn;
@property (nonatomic, strong)FNCmbDoubleTextButton* midBtn;
@property (nonatomic, strong)FNCmbDoubleTextButton* rightBtn;

@end
