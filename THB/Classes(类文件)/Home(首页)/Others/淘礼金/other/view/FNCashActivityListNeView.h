//
//  FNCashActivityListNeView.h
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCashActivityNeModel.h"
@protocol FNCashActivityListNeViewDelegate <NSObject>
/** 点击商品**/
- (void)caActivityListAction:(id)sender;
@end
@interface FNCashActivityListNeView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView* ActivityCollectionview;
@property(nonatomic,strong)NSArray* dataArr;
/** delegate **/
@property(nonatomic ,weak) id<FNCashActivityListNeViewDelegate> delegate;
@end
