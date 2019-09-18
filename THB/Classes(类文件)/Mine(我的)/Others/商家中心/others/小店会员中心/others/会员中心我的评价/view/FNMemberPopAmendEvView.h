//
//  FNMemberPopAmendEvView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHPopupContainer.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNMemberPopAmendEvViewDelegate <NSObject>
//选择
- (void)didMemberPopAmendTypeAction:(NSInteger)indexs;

@end
@interface FNMemberPopAmendEvView : UIView<DSHCustomPopupView,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)NSArray *dataArr;
@property (nonatomic, weak)id<FNMemberPopAmendEvViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
