//
//  JMView.h
//  SuperMode
//
//  Created by jimmy on 2017/6/8.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMViewProtocol.h"
#import "UIScrollView+EmptyDataSet.h"
@interface JMView : UIView<JMViewProtocol,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView* jm_tableview;
@property (nonatomic, strong)UICollectionView* jm_collectionview;

@end
