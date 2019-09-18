//
//  FNdefinHuntHaderView.h
//  THB
//
//  Created by Jimmy on 2019/1/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FNdefinHuntHaderViewDelegate<NSObject>
- (void)delectData;
@end
@interface FNdefinHuntHaderView : UICollectionReusableView
@property (nonatomic,strong) UIButton *delectButton;

@property (nonatomic,strong) UILabel* textLabel;

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) id<FNdefinHuntHaderViewDelegate> delectDelegate;

- (void) setText:(NSString*)text;



@end

NS_ASSUME_NONNULL_END
