//
//  FNgradeFiltrateUeCell.h
//  THB
//
//  Created by 李显 on 2019/1/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNgradeUeModel.h"
#import "FNCombinedButton.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNgradeFiltrateUeCellDelegate <NSObject> 
// 点击排序
- (void)filtrateIntegralClickWithPlace:(NSInteger)place WithState:(NSInteger)state;
- (void)filtrateIntegralPhone:(NSString*)phoneString;
@end
@interface FNgradeFiltrateUeCell : UICollectionViewCell<UISearchBarDelegate>
/** 更新时间 **/
@property (nonatomic, strong)UILabel* dateLB;
@property (nonatomic, strong)UISearchBar* searchBar;
@property (nonatomic, strong)UIView *screenView; 
@property (nonatomic, strong)UIImageView* bgImageView;

@property (nonatomic, strong)FNgradeHeadModel *model;
@property (nonatomic, strong)NSMutableArray* btns;
@property (nonatomic, assign)NSInteger sortPalce;

@property (nonatomic, weak) id<FNgradeFiltrateUeCellDelegate> delegate;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
