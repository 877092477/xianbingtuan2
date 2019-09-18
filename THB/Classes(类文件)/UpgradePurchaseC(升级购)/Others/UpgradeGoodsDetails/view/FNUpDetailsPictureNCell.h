//
//  FNUpDetailsPictureNCell.h
//  THB
//
//  Created by Jimmy on 2018/9/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNUpDetailsPictureNCell : UITableViewCell
@property (nonatomic,strong)NSIndexPath* indexPath;
@property (nonatomic,strong)UIView* imgBgview;
@property (nonatomic,strong)UIImageView* imgview;
@property (nonatomic, copy)NSString* image;
@property (nonatomic,strong)NSLayoutConstraint* imgconh;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
