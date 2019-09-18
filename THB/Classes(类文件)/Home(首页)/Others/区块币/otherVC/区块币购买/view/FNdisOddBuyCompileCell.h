//
//  FNdisOddBuyCompileCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//@protocol FNdisOddBuyCompileCellDelegate <NSObject>
//// 编辑
//- (void)didOddBuyCompileAction:(NSIndexPath*)index with:(NSString*)content;
//
//@end
@interface FNdisOddBuyCompileCell : UICollectionViewCell
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UITextField  *compileField;
@property (nonatomic, strong)UIButton  *rightBtn;
@property (nonatomic, strong)UIView *line;

//@property(nonatomic,strong)NSIndexPath *index;
//@property(nonatomic,weak) id<FNdisOddBuyCompileCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
