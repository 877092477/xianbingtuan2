//
//  FNwelfTextNeReusableView.h
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNwelfDeModel.h"

@interface FNwelfTextNeReusableView : UICollectionReusableView
/** 图片 **/
@property (nonatomic, strong)UIImageView* advertisingView;

/** right **/
@property (nonatomic, strong)UIButton* rightButton;


@property (nonatomic, strong)FNwelfDeModel *model;
@end


