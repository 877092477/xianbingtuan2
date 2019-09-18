//
//  FNConvertCompileItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNdistrictConvertTypefeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNConvertCompileItemCellDelegate <NSObject>
// 编辑
- (void)didCompileItemAction:(NSIndexPath*)index withContent:(NSString*)content;

@end
@interface FNConvertCompileItemCell : UICollectionViewCell<UITextFieldDelegate>
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UIButton  *rightBtn;
@property (nonatomic, strong)UITextField  *compileField;
@property (nonatomic, strong)FNConvertEditItemfeModel  *model;
@property (nonatomic, strong)NSIndexPath *index;
@property (nonatomic ,weak) id<FNConvertCompileItemCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
