//
//  FNRushConsumeHeaderNeView.h
//  69橙子
//
//  Created by Jimmy on 2018/11/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNrushPurchaseNeModel.h"

@class FNRushConsumeHeaderNeView;
@protocol FNRushConsumeHeaderNeViewDelegate <NSObject>

- (void)consumeHeader: (FNRushConsumeHeaderNeView*)view didItemSelectedAt: (NSInteger)index;

@end

@interface FNRushConsumeHeaderNeView : UITableViewHeaderFooterView

/**  delegate **/
@property(nonatomic ,weak) id<FNRushConsumeHeaderNeViewDelegate> delegate;
/**  arr   **/
@property(nonatomic, strong)NSArray *buyArr;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)setSelectAt:(NSInteger)index;

@end


