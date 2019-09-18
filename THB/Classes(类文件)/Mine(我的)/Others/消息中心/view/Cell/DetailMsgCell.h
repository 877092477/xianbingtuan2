//
//  DetailMsgCell.h
//  THB
//
//  Created by zhongxueyu on 16/5/4.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailMsgCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *msgTitle;

@property (weak, nonatomic) IBOutlet UITextView *msgContent;

@end
