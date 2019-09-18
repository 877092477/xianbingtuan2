//
//  CircleOfFriendsCell.h
//  THB
//
//  Created by 李显 on 2018/8/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CircleOfFriendsFrame,CireleImageLeftBtn,CircPhotoView,CireleImageBtn;

#import "CircPhotoView.h"

@protocol CircleOfFriendsCellDelegate <NSObject>
// 点赞
- (void)likeBtnClickAction:(CireleImageBtn *)sender;
// 评论
- (void)disLikeBtnClickAction:(CireleImageBtn *)sender;
// 分享
-(void)shareBtnClickAction:(UIButton *)sender;
//详情
-(void)detailsClickAction:(UIButton *)sender;
//选择图片
-(void)selectProductAction:(NSInteger)sender row:(NSInteger)row; 
//选择头像
-(void)selectIconImageViewAction:(NSInteger)sender;

@end

@interface CircleOfFriendsCell : UITableViewCell <CircPhotoViewDelegate>

@property(nonatomic, weak) NSIndexPath* ProductIndexpath;
/**  头像 **/
@property(nonatomic, weak) UIImageView* iconView;

/**  名字 **/
@property(nonatomic, weak) UILabel* nameLab;

/**   **/
@property(nonatomic, weak) UILabel* timeLab;

/**  商品分类图片 **/
@property(nonatomic, weak) UIImageView* goodsClassifyView;

/**  内容 **/
@property(nonatomic, weak) UILabel* contentLab;

/**  分享 **/
@property(nonatomic ,weak) UIButton* shareBtn;

/**  点赞 **/
@property(nonatomic, weak) CireleImageBtn* likeBtn;

/**  差评 **/
@property(nonatomic, weak) CireleImageBtn* disLikeBtn;

/**  删除 **/
@property(nonatomic ,weak) UIButton* deleteBtn;

/**  展示图片 **/
@property(nonatomic,weak) CircPhotoView* photosView;

/**  查看详情 **/
@property(nonatomic, weak) UIButton* detailsLab;

/**  链接 **/
@property(nonatomic ,weak) UIButton* slinkBtn;

/**  线 **/
@property(nonatomic ,weak) UILabel *lineLab;


@property(nonatomic, strong) CircleOfFriendsFrame* circleFrame;

 @property (nonatomic, assign)void (^clickedWithProduct)( NSInteger  action,NSInteger  Seletedrow);

-(void)setChildBtnTag:(NSInteger)tag;

@property(nonatomic ,weak) id<CircleOfFriendsCellDelegate> delegate;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
