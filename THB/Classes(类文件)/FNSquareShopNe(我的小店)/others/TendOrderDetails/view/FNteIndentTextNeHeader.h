//
//  FNteIndentTextNeHeader.h
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNtendOrderDetailsDeModel.h"

@interface FNteIndentTextNeHeader : UITableViewHeaderFooterView
/**  文本        **/
@property(nonatomic, strong)UILabel *titleName;  
/**  line       **/
@property(nonatomic, strong) UILabel *lineLb;
@property(nonatomic , strong)FNtendOrderDetailsDeModel *model;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end

 
