//
//  FNPDDCategorySectionHeader.h
//  THB
//
//  Created by Weller Zhao on 2019/3/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreeningView.h"
#import "QJSlideButtonView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FNPDDCategorySectionHeaderDelegate <NSObject>

- (void)didRowStyleClick: (BOOL)isSingle;
- (void)didCuponClick: (BOOL)isOn;

@end

@interface FNPDDCategorySectionHeader : UICollectionReusableView

@property (nonatomic, strong) ScreeningView *screeningView;
@property (nonatomic, weak) id<FNPDDCategorySectionHeaderDelegate> delegate;

-(void) setTitles: (NSMutableArray<NSString*>*)titles withBlock: (SBViewBlock)block;
-(void)setCategoryAt: (NSInteger)index;
-(void)showFilter;

@end

NS_ASSUME_NONNULL_END
