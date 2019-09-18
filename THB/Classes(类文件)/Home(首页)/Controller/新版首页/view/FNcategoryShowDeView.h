//
//  FNcategoryShowDeView.h
//  THB
//
//  Created by Jimmy on 2018/12/17.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNLeftclassifyModel.h"
@protocol FNcategoryShowDeViewDelegate <NSObject>
// 选择分类
- (void)showDeRightViewAction:(FNRightclassifyModel*)sender;
@end

@interface FNcategoryShowDeView : UIView<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>

/** 左边 **/
@property (nonatomic,strong)UITableView *leftTableview;
/** 右边 **/
@property (nonatomic,strong)UICollectionView *rightCollectionview;
@property (nonatomic,strong)NSMutableArray *leftDataArr;
@property(nonatomic ,weak) id<FNcategoryShowDeViewDelegate> delegate;
@end


