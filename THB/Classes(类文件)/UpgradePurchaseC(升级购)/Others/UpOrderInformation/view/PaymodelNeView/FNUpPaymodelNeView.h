//
//  FNUpPaymodelNeView.h
//  THB
//
//  Created by Jimmy on 2018/9/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectIndex)(NSInteger selectIndex);//编码
typedef void (^SelectValue)(NSString *selectValue);//数值

@interface FNUpPaymodelNeView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *titles;//string数组

@property (nonatomic, copy) SelectIndex selectIndex;
@property (nonatomic, copy) SelectValue selectValue;
@property (nonatomic, strong) UILabel *titleLabel;//标题label
@property (nonatomic, strong) UIButton *closeButton;//关闭按钮

+ (FNUpPaymodelNeView *)showWithTitles:(NSArray *)titles selectIndex:(SelectIndex)selectIndex;
@end
