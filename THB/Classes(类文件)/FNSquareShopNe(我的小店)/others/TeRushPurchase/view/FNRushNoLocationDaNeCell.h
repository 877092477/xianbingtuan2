//
//  FNRushNoLocationDaNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/11/30.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNrushPurchaseNeModel.h"
@protocol FNRushNoLocationDaNeCellDelegate <NSObject>

// 添加地址
- (void)rushAddLoctionAction;

@end 

@interface FNRushNoLocationDaNeCell : UITableViewCell
/**  bg图片 **/
@property(nonatomic, strong) UIImageView* siteImage;
/**  加图片 **/
@property(nonatomic, strong) UIImageView* addImage;
/**  填写地址 **/
@property(nonatomic, strong) UILabel *writeLb;
/**  delegate  **/
@property(nonatomic ,weak) id<FNRushNoLocationDaNeCellDelegate> delegate;
/**  model **/
@property(nonatomic, strong) NSDictionary *model;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

 
