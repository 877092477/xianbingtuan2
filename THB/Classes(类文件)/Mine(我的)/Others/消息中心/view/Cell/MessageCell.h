//
//  MessageCell.h
//  THB
//
//  Created by zhongxueyu on 16/3/31.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *messageLbl;

@property (weak, nonatomic) IBOutlet UILabel *date;

@end
