//
//  CircPhotoView.h
//  THB
//
//  Created by 李显 on 2018/8/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CircPhotoViewDelegate <NSObject>
// 选中
- (void)pitchOnClickAction:(NSInteger )sender;

@end

@interface CircPhotoView : UIView
@property(nonatomic, strong) NSArray *pic_urls;
@property(nonatomic, assign)void (^clickedWithseleted)(NSInteger  action);
@property(nonatomic ,weak) id<CircPhotoViewDelegate> delegate;
@end


