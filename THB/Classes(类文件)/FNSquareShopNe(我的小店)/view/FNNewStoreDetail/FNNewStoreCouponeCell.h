//
//  FNNewStoreCouponeCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNstoreInformationDaModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNNewStoreCouponeCell : UICollectionViewCell

- (void)setModel: (NSArray<FNstoreCouponeModel*>*)yhq_list;

@end

NS_ASSUME_NONNULL_END
