//
//  FNScrollmonkeyView.h
//  超级模式
//
//  Created by Fnuo-iOS on 2018/3/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNScrollTextView.h"
#import "Index_paomadeng_01Model.h"

@interface FNScrollmonkeyView : UIView<FNScrollTextViewDelegate>

@property (nonatomic, strong)NSMutableArray *super_msglist;

@property (nonatomic, strong)UIImageView *Image;

@property (nonatomic, strong)FNScrollTextView* ScrollTextView;//跑马灯文字模块

@end
