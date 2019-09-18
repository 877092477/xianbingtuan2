//
//  FNcandiesRanSeekCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNcandiesRankingModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNcandiesRanSeekCellDelegate <NSObject>
// 搜索
- (void)didRanSeekWithcontent:(NSString*)str;
@end
@interface FNcandiesRanSeekCell : UICollectionViewCell
@property (nonatomic, strong)UILabel   *dateLB;
@property (nonatomic, strong)UIImageView  *bgImgView;
@property (nonatomic, strong)UIButton  *seekbtn;
@property (nonatomic, strong)UITextField  *compileField;
@property (nonatomic, strong)FNcandiesRankingModel *model;
@property (nonatomic, weak)id<FNcandiesRanSeekCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
