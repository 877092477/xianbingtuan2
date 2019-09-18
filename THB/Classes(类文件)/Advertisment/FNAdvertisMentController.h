//
//  FNAdvertisMentController.h
//  SuperMode
//
//  Created by Jimmy Ng on 2017/11/29.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

@interface FNAdvertisMentController : SuperViewController
@property (nonatomic, strong)UIImage* image;
@property (nonatomic, copy)void (^imageClicked)(NSString* url);
@property (nonatomic, copy)void (^removWindow)(void);


@end
