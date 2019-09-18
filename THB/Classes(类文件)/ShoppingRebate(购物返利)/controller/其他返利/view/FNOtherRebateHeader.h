//
//  FNOtherRebateHeader.h
//  THB
//
//  Created by Fnuo-iOS on 2018/5/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherRebatetopListModel.h"

@interface FNOtherRebateHeader : UIView<UITextFieldDelegate>

@property (nonatomic, copy)void (^searchBlock)(NSString* text);

@property (nonatomic, strong)OtherRebatetopListModel *Model;

@property (nonatomic, weak)UIImageView* BGImageView;

@property (nonatomic, strong)UIView* btmview;

@property (nonatomic, strong)UITextField* searchTF;

@end
