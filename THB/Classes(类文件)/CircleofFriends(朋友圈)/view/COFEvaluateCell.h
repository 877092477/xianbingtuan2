//
//  COFEvaluateCell.h
//  THB
//
//  Created by 李显 on 2018/8/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EvaluateModel.h"           //评价Model

@protocol COFEvaluateCellDelegate <NSObject>

//点击选择头像(或本人名字)
-(void)ClickProfilePhoto:(NSInteger)sender;

//点击内容选择显示的回复人的ID (如果有as_nickname "@的人的昵称" 评论就选择 as_nickname; 否则 就是 pj_nickname 评价人的昵称)
-(void)ClickWithContent:(NSInteger)sender;

@end

@interface COFEvaluateCell : UITableViewCell

/**  lineLB **/
@property(nonatomic, strong) UILabel *lineLB;

/**  BGview **/
@property(nonatomic, strong) UIView *ligryView;

/**  评价图片 **/
@property(nonatomic, strong) UIImageView *evaluateView;

/**  头像图片 **/
@property(nonatomic, strong) UIImageView *headportraiImaget;

/**  名字 **/
@property(nonatomic, strong) UILabel *nameLB;

/**  时间 **/
@property(nonatomic, strong) UILabel *timeLB;

/**  内容 **/
@property(nonatomic, strong) UILabel *contentLB;

/**  model **/
@property(nonatomic, strong) EvaluateModel *evaluate;

@property(nonatomic ,weak) id<COFEvaluateCellDelegate> delegate;

-(void)setChildDetailsTag:(NSInteger)tag;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
