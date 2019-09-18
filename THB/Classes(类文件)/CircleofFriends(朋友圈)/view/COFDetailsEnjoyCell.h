//
//  COFDetailsEnjoyCell.h
//  THB
//
//  Created by 李显 on 2018/8/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EvaluateModel.h"    //评价

@protocol COFDetailsEnjoyCellDelegate <NSObject>

//点击选择头像
-(void)ClickToChooseThePicture:(UIButton *)sender;

@end

@interface COFDetailsEnjoyCell : UITableViewCell

/**  likeImagView **/
@property(nonatomic, strong) UIImageView *triangleView;

/**  BGview **/
@property(nonatomic, strong) UIView *ligryView;

/**  likeImagView **/
@property(nonatomic, strong) UIImageView *likeView;

/**  likeImagView **/
@property(nonatomic, strong) UIScrollView *ImageScrollView;

/**  数据 **/
@property(nonatomic, strong) NSArray *headArr;

@property(nonatomic ,weak) id<COFDetailsEnjoyCellDelegate> delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
