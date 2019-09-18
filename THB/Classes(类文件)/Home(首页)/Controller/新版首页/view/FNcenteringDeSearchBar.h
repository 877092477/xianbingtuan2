//
//  FNcenteringDeSearchBar.h
//  THB
//
//  Created by Jimmy on 2018/12/21.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FNcenteringDeSearchBar : UISearchBar
// searchBar的textField
@property (nonatomic, weak) UITextField *textField;

/**
 清除搜索条以外的控件
 */
- (void)cleanOtherSubViews;
@end


