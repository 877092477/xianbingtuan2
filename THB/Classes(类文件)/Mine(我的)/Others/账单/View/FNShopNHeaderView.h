//
//  FNShopNHeaderView.h
//  THB
//
//  Created by Jimmy on 2018/9/6.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FNShopNHeaderViewDelegate <NSObject>

//点击选择类型
-(void)ClickToClassify:(NSUInteger)sender;

@end

@interface FNShopNHeaderView : UITableViewHeaderFooterView

/**  ScrollView **/
@property (nonatomic, strong)UIScrollView *typeScrollView;
/**  数据 **/
@property(nonatomic, strong) NSArray *typeArr;

@property(nonatomic ,weak) id<FNShopNHeaderViewDelegate> delegate;

@property(nonatomic, assign) NSInteger  recordInt;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
