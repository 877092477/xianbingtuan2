//
//  CityButton.h
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CityItem.h"

@interface CityButton : UIButton

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) CityItem *cityItem;

@end


