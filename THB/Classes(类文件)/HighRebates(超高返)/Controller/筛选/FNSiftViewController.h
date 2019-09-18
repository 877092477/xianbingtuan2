//
//  FNSiftViewController.h
//  THB
//
//  Created by jimmy on 2017/5/23.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

@interface FNSiftViewController : SuperViewController

@property (nonatomic, strong)NSString *Sifttype;
@property (nonatomic, copy)void (^completeSiftBlock)(NSDictionary* params);
@end
