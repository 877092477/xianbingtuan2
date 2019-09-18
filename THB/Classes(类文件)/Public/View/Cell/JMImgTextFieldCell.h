//
//  JMImgTextFieldCell.h
//  THB
//
//  Created by jimmy on 2017/3/31.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMImgTextFieldCell : UITableViewCell
@property (nonatomic, strong)UIImageView* imgView;
@property (nonatomic, strong)UITextField* textField;
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, copy)void (^textDidChangeBlock)(NSIndexPath* indexPath,NSString* text);
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
