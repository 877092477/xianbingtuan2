//
//  FNReportListViewController.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/5/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FNReportListViewControllerDelegate <NSObject>

-(void)onItemClick: (NSInteger)index;

@end
@interface FNReportListViewController : UITableViewController

@property (nonatomic, weak) id<FNReportListViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
