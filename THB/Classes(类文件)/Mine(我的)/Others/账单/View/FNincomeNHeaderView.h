//
//  FNincomeNHeaderView.h
//  THB
//
//  Created by Jimmy on 2018/9/6.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FNincomeNHeaderViewDelegate <NSObject>

//点击选择类型
-(void)ClickToIncomeClassify:(NSUInteger)sender;

@end
@interface FNincomeNHeaderView : UITableViewHeaderFooterView

/** 自购获得 **/
@property (nonatomic, strong)UIImageView *imagebgView;
/** 冻结金额 **/
@property (nonatomic, strong)UILabel *frostTitle;
/** 到账金额 **/
@property (nonatomic, strong)UILabel *arriveTitle;
/** 冻结金额 **/
@property (nonatomic, strong)UILabel *frostNumber;
/** 到账金额 **/
@property (nonatomic, strong)UILabel *arriveNumber;

/**  ScrollView **/
@property (nonatomic, strong)UIScrollView *typeScrollView;

/**  头部数据 **/
@property(nonatomic, strong) NSArray *headerArr;

/**  数据 **/
@property(nonatomic, strong) NSArray *typeArr;

@property(nonatomic ,weak) id<FNincomeNHeaderViewDelegate> delegate;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifie;
@end
