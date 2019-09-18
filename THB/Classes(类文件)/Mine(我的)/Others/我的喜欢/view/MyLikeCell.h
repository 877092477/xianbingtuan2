//
//  MyLikeCell.h
//  THB
//
//  Created by zhongxueyu on 16/3/31.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSuperTableViewCell.h"
#import "MyLikeListModel.h"
@protocol deleteBtnClickDelegate <NSObject>
-(void)OnClickEmailBtn:(NSString *)sender;
@end
@interface MyLikeCell : XYSuperTableViewCell

@property (nonatomic, weak) id<deleteBtnClickDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *originalPrice;

@property (weak, nonatomic) IBOutlet UILabel *isrebates;

@property (weak, nonatomic) IBOutlet UILabel *isValid;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (strong,nonatomic) MyLikeListModel *model;

@end
