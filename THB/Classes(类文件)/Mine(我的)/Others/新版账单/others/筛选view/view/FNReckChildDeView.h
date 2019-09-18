//
//  FNReckChildDeView.h
//  THB
//
//  Created by Jimmy on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNreckSetDeModel.h"
#import "FNcalendarPopDeView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNReckChildDeViewDegate <NSObject>
// 确定条件
- (void)inConditionConfirmClick:(NSArray*)arr withStart:(NSString*)startdate withOver:(NSString*)overdate;
//刷新类型
-(void)inChildTypeRefresh:(NSString*)type;
//取消
-(void)inChildCancelRefresh;
@end
@interface FNReckChildDeView : UIView

@property(nonatomic ,strong) UIView    *bgView;

@property(nonatomic ,strong) UICollectionView   *conditionView;

@property(nonatomic ,strong) UIButton    *resetBtn;

@property(nonatomic ,strong) UIButton    *confirmBtn;

@property(nonatomic ,strong) UIButton    *startBtn;

@property(nonatomic ,strong) UIButton    *overBtn;

@property(nonatomic ,strong) UIView      *lineTwo;

@property(nonatomic ,strong) UIView      *line;

@property(nonatomic ,strong) NSMutableArray      *typeDataArr;

@property(nonatomic ,assign) NSInteger      dateState;

@property(nonatomic ,strong) NSString       *startDate;

@property(nonatomic ,strong) NSString       *overDate;

@property(nonatomic ,assign) NSInteger      popState;
//如果等于yes
@property(nonatomic ,assign) BOOL      OneSingSeleted;

@property(nonatomic ,assign) NSInteger      typeInt;//1代表我的订单取消

-(void)showOneView;

-(void)hideViewAction;

@property(nonatomic ,weak) id<FNReckChildDeViewDegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame withState:(NSInteger)popstate;

@end

NS_ASSUME_NONNULL_END
