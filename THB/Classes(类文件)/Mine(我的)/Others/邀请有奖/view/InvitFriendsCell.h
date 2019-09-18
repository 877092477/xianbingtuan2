//
//  InvitFriendsCell.h
//  THB
//
//  Created by zhongxueyu on 16/5/1.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyInvitModel.h"
@interface InvitFriendsCell : UITableViewCell
@property (strong, nonatomic)  UILabel *label;

@property (strong,nonatomic) MyInvitModel *model;

@property (strong,nonatomic) NSMutableArray *textArray;






@end
