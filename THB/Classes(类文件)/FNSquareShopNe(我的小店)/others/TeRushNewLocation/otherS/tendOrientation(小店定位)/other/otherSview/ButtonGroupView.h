//
//  ButtonGroupView.h
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityButton.h"
@class ButtonGroupView;

@protocol ButtonGroupViewDelegate <NSObject>

@optional
- (void)ButtonGroupView:(ButtonGroupView *)buttonGroupView didClickedItem:(CityButton *)item;

@end

@interface ButtonGroupView : UIView
@property (nonatomic, strong) id package;
@property (nonatomic, assign) NSInteger columns;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, assign) id<ButtonGroupViewDelegate> delegate;
@end


