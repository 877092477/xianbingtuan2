//
//  FNStoreManagerCateCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreManagerCateCell : UITableViewCell

@property (nonatomic, strong) UILabel *lblTitle;

- (void)setIsSelected:(BOOL)selected;

- (void)setCount: (int)count ;

@end

NS_ASSUME_NONNULL_END
