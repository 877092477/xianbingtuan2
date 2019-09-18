//
//  FNteIndentAddressNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNtendOrderDetailsDeModel.h"

@interface FNteIndentAddressNeCell : UITableViewCell
/** BGview **/
@property (nonatomic, strong)UIView* bgView;
/** 联系人电话 **/
@property (nonatomic, strong)UILabel* nameLB;
/** 地址 **/
@property (nonatomic, strong)UILabel* addressLB;
/** 送达时间 **/
@property (nonatomic, strong)UILabel* titleLB;
/** 送达时间 **/
@property (nonatomic, strong)UILabel* dateLB;
@property(nonatomic , strong)FNtendOrderDetailsDeModel *model;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end


