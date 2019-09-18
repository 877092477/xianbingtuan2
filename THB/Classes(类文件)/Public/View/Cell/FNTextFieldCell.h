//
//  FNTextFieldCell.h
//  THB
//
//  Created by Fnuo-iOS on 2018/6/8.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNTextFieldCell : UITableViewCell

@property (nonatomic, strong)UITextField* textField;
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, copy)void (^textDidChangeBlock)(NSIndexPath* indexPath,NSString* text);
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end
