//
//  OrderHeaderView.m
//  THB
//
//  Created by Weller Zhao on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "OrderHeaderView.h"

@interface OrderHeaderView()

@property (nonatomic, strong) UILabel *lblStartTime;
@property (nonatomic, strong) UILabel *lblEndTime;
@property (nonatomic, strong) UIImageView *imgStartTime;
@property (nonatomic, strong) UIImageView *imgEndTime;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UILabel *jointTimeLB;
@end

@implementation OrderHeaderView

- (instancetype)initWithFrame: (CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    self.lblOrder = [[UILabel alloc] init];
//    self.imgStartTime = [[UIImageView alloc] init];
//    self.lblStartTime = [[UILabel alloc] init];
//    self.imgEndTime = [[UIImageView alloc] init];
//    self.lblEndTime = [[UILabel alloc] init];
//    self.vLine = [[UIView alloc] init];
    
    [self addSubview:self.lblOrder];
//    [self addSubview:self.imgStartTime];
//    [self addSubview:self.lblStartTime];
//    [self addSubview:self.imgEndTime];
//    [self addSubview:self.lblEndTime];
//    [self addSubview:self.vLine];
    
    
    
    [self.lblOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@10);
    }];
//    [self.imgStartTime mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(@0);
//        make.right.equalTo(self.lblStartTime.mas_left).offset(-4);
//        make.width.height.mas_equalTo(14);
//    }];
//    [self.lblStartTime mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(@0);
//        make.right.equalTo(self.vLine.mas_left).offset(-4);
//
//    }];
//    [self.imgEndTime mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(@0);
//        make.right.equalTo(self.lblEndTime.mas_left).offset(-4);
//        make.width.height.mas_equalTo(14);
//    }];
//    [self.lblEndTime mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(@0);
//        make.right.equalTo(@-10);
//    }];
//    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(1);
//        make.centerY.equalTo(@0);
//        make.width.mas_equalTo(14);
//        make.right.equalTo(_imgEndTime.mas_left).offset(-4);
//    }];
//
//
//
////    self.lblOrder.text = @"订单数：13笔";
    self.lblOrder.font = kFONT12;
    self.lblOrder.textColor = RGB(60, 60, 60);
//
//    self.imgStartTime.image = IMAGE(@"order_image_calendar");
//
//    self.imgEndTime.image = IMAGE(@"order_image_calendar");
//
////    self.lblStartTime.text = @"2018/12/17";
//    self.lblStartTime.font = kFONT12;
//    self.lblStartTime.textColor = RGB(60, 60, 60);
//
////    self.lblEndTime.text = @"2018/12/17";
//    self.lblEndTime.font = kFONT12;
//    self.lblEndTime.textColor = RGB(60, 60, 60);
//
//    self.vLine.backgroundColor = RGB(200, 200, 200);
//
//    @weakify(self);
//    [self.lblStartTime addJXTouch:^{
//        @strongify(self);
//        if ([self.delegate respondsToSelector:@selector(didStartTimeClick:)]) {
//            [self.delegate didStartTimeClick:self];
//        }
//    }];
//
//    [self.lblEndTime addJXTouch:^{
//        @strongify(self);
//        if ([self.delegate respondsToSelector:@selector(didEndTimeClick:)]) {
//            [self.delegate didEndTimeClick:self];
//        }
//    }];
    
    //新加
    self.jointTimeLB = [[UILabel alloc] init];
    [self addSubview:self.jointTimeLB];
    self.jointTimeLB.font = kFONT12;
    self.jointTimeLB.textColor = RGB(65, 65, 65);
    
    self.screenBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.screenBtn.selected=NO;
    [self.screenBtn setImage:IMAGE(@"FN_xingzhuangImg") forState:UIControlStateNormal];//FJ_norsj_img
    [self.screenBtn setImage:IMAGE(@"FJ_norsj_img") forState:UIControlStateSelected];//FN_xingzhuangImg//FJ_orsj_img
    [self.screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [self.screenBtn setTitle:@"筛选" forState:UIControlStateSelected];
    [self.screenBtn setTitleColor:RGB(65, 65, 65) forState:UIControlStateNormal];
    [self.screenBtn setTitleColor:RGB(65, 65, 65) forState:UIControlStateSelected];
    self.screenBtn.titleLabel.font=kFONT12;
    [self addSubview:self.screenBtn];
    
    self.screenBtn.sd_layout
    .centerYEqualToView(self).heightIs(20).rightSpaceToView(self, 0).widthIs(75);
    [self.screenBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    
    self.jointTimeLB.sd_layout
    .centerYEqualToView(self).centerXEqualToView(self).heightIs(20).widthIs(100); 
    
}

- (void)setStartTime:(NSString *)startTime {
    self.lblStartTime.text = startTime;
}

- (void)setEndTime:(NSString *)endTime {
    self.lblEndTime.text = endTime;
}
-(void)setJointTime:(NSString *)jointTime{
    self.jointTimeLB.text = jointTime;
    CGFloat jointTimeLBW=[jointTime kr_getWidthWithTextHeight:20 font:12];
    if(jointTimeLBW>150){
       jointTimeLBW=150;
    }
    self.jointTimeLB.sd_layout
    .centerYEqualToView(self).centerXEqualToView(self).heightIs(20).widthIs(jointTimeLBW);
    
    
}
@end
