//
//  FNCreaditCardHeaderView.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FNCreaditCardHeaderViewDelegate <NSObject>

- (void)didIconClick: (NSInteger) index;

@end

@interface FNCreaditCardHeaderView : UIView

@property (nonatomic, weak) id<FNCreaditCardHeaderViewDelegate> delegate;

-(void)setImages:(NSArray *)images names: (NSArray*)names ;

@end

NS_ASSUME_NONNULL_END
