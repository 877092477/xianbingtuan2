//
//  FNLiveBroadcastLogCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNLiveBroadcastLogCellView : UIView

- (void)setLog: (NSString*)log withTypeImg: (NSString*)typeImage rightImg: (NSString*)rightImage alpha: (CGFloat)alpha;

@end

@interface FNLiveBroadcastLogCell : UITableViewCell

- (void)setLog: (NSString*)log withTypeImg: (NSString*)typeImage rightImg: (NSString*)rightImage alpha: (CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
