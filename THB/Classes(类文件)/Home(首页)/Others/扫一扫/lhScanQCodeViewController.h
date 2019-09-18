//
//  lhScanQCodeViewController.h
//  lhScanQCodeTest
//
//  Created by bosheng on 15/10/20.
//  Copyright © 2015年 bosheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

@protocol lhScanQCodeViewControllerDelegate <NSObject>

- (void)didCodeScan: (NSString*)result;

@end

@interface lhScanQCodeViewController : SuperViewController

@property (nonatomic, weak) id<lhScanQCodeViewControllerDelegate> delegate;

@end
