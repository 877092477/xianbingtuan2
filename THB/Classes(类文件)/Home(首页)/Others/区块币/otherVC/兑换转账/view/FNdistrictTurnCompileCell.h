//
//  FNdistrictTurnCompileCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FNdistrictTurnCompileCellDelegate <NSObject>
// 编辑
- (void)didTurnCompileAction:(NSIndexPath*)index withContent:(NSString*)content;

@end
@interface FNdistrictTurnCompileCell : UICollectionViewCell
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UILabel *numLB;
@property(nonatomic,strong)UILabel *numTitleLB;
@property(nonatomic,strong)UITextField *compileField;

@property (nonatomic, strong)NSIndexPath *index;
@property (nonatomic ,weak) id<FNdistrictTurnCompileCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
