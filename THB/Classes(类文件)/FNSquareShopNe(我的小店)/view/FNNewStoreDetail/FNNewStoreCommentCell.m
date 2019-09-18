//
//  FNNewStoreCommentCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/25.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreCommentCell.h"

@interface FNNewStoreCommentCell()

@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblTime;
@property (nonatomic, strong) UIView *vTag;
@property (nonatomic, strong) UILabel *lblTag;
@property (nonatomic, strong) UILabel *lblStar;
@property (nonatomic, strong) UIView *vStar;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UIView *vImages;
@property (nonatomic, strong) UIView *vCount;
@property (nonatomic, strong) UILabel *lblCount;

@property (nonatomic, strong) UILabel *lblViews;

@property (nonatomic, strong) UIButton *btnQuestion;
@property (nonatomic, strong) UIView *vQuestion;
@property (nonatomic, strong) UIImageView *icoQuestion;
@property (nonatomic, strong) UILabel *lblQuestion;
@property (nonatomic, strong) UIButton *btnLike;
@property (nonatomic, strong) UIView *vLike;
@property (nonatomic, strong) UIImageView *icoLike;
@property (nonatomic, strong) UILabel *lblLike;

@property (nonatomic, strong) NSMutableArray<UIImageView*> *stars;
@property (nonatomic, strong) NSMutableArray<UIImageView*> *images;

@end

@implementation FNNewStoreCommentCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _stars = [[NSMutableArray alloc] init];
        _images = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgHeader = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblTime = [[UILabel alloc] init];
    _vTag = [[UIView alloc] init];
    _lblTag = [[UILabel alloc] init];
    _lblStar = [[UILabel alloc] init];
    _vStar = [[UILabel alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _vImages = [[UIView alloc] init];
    _vCount = [[UILabel alloc] init];
    _lblCount = [[UILabel alloc] init];
    _lblViews = [[UILabel alloc] init];
    _btnQuestion = [[UIButton alloc] init];
    _vQuestion = [[UIView alloc] init];
    _icoQuestion = [[UIImageView alloc] init];
    _lblQuestion = [[UILabel alloc] init];
    _btnLike = [[UIButton alloc] init];
    _vLike = [[UIView alloc] init];
    _icoLike = [[UIImageView alloc] init];
    _lblLike = [[UILabel alloc] init];
    
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblTime];
    [self.contentView addSubview:_vTag];
    [_vTag addSubview: _lblTag];
    [self.contentView addSubview:_lblStar];
    [self.contentView addSubview:_vStar];
    [self.contentView addSubview:_lblPrice];
    [self.contentView addSubview:_lblDesc];
    [self.contentView addSubview:_vImages];
    [_vImages addSubview:_vCount];
    [_vCount addSubview:_lblCount];
    [self.contentView addSubview:_lblViews];
    [self.contentView addSubview:_btnQuestion];
    [self.contentView addSubview:_vQuestion];
    [_vQuestion addSubview:_icoQuestion];
    [_vQuestion addSubview:_lblQuestion];
    [self.contentView addSubview:_btnLike];
    [self.contentView addSubview:_vLike];
    [_vLike addSubview:_icoLike];
    [_vLike addSubview:_lblLike];
    
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.top.equalTo(@17);
        make.width.height.mas_equalTo(40);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgHeader);
        make.left.equalTo(self.imgHeader.mas_right).offset(12);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgHeader).offset(-6);
        make.left.equalTo(self.imgHeader.mas_right).offset(12);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_vTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(12);
        make.right.lessThanOrEqualTo(@-20);
        make.top.equalTo(self.imgHeader.mas_bottom).offset(4);
        make.height.mas_equalTo(16);
    }];
    [_lblTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.right.equalTo(@-8);
        make.centerY.equalTo(@0);
    }];
    [_lblStar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(12);
        make.top.equalTo(self.vTag.mas_bottom).offset(10);
    }];
    [_vStar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblStar.mas_right).offset(6);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(80);
        make.centerY.equalTo(self.lblStar);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vStar.mas_right).offset(12);
        make.centerY.equalTo(self.lblStar);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(12);
        make.top.equalTo(self.lblStar.mas_bottom).offset(12);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_vImages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(12);
        make.top.equalTo(self.lblDesc.mas_bottom).offset(12);
        make.right.equalTo(@-12);
        make.height.mas_equalTo(0);
    }];
    [_vCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vImages).offset(5);
        make.bottom.equalTo(self.vImages).offset(-5);
        make.height.mas_equalTo(24);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.right.equalTo(@-5);
        make.centerY.equalTo(@0);
    }];
    [_lblViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(12);
        make.right.lessThanOrEqualTo(self.btnQuestion.mas_left).offset(-12);
        make.centerY.equalTo(self.btnQuestion);
    }];
    [_btnQuestion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnLike.mas_left).offset(-10);
        make.top.equalTo(self.vImages.mas_bottom).offset(10);
        make.height.mas_equalTo(28);
        make.width.mas_greaterThanOrEqualTo(70);
    }];
    [_vQuestion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.btnQuestion);
        make.left.greaterThanOrEqualTo(self.btnQuestion).offset(10);
        make.right.lessThanOrEqualTo(self.btnQuestion).offset(-10);
        make.height.equalTo(self.btnQuestion);
    }];
    [_icoQuestion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.height.mas_equalTo(14);
    }];
    [_lblQuestion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icoQuestion.mas_right).offset(2);
        make.right.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    [_btnLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-12);
        make.top.equalTo(self.vImages.mas_bottom).offset(10);
        make.height.mas_equalTo(28);
        make.width.mas_greaterThanOrEqualTo(70);
    }];
    [_vLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.btnLike);
        make.left.greaterThanOrEqualTo(self.btnLike).offset(10);
        make.right.lessThanOrEqualTo(self.btnLike).offset(-10);
        make.height.equalTo(self.btnLike);
    }];
    [_icoLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.height.mas_equalTo(14);
    }];
    [_lblLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icoLike.mas_right).offset(2);
        make.right.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    
    _imgHeader.cornerRadius = 20;
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT13;
    
    _lblTime.textColor = RGB(153, 153, 153);
    _lblTime.font = kFONT13;
    
    _vTag.layer.cornerRadius = 4;
    _vTag.layer.borderWidth = 1;
    _vTag.layer.borderColor = RGB(242, 58, 77).CGColor;
    _vTag.layer.backgroundColor = RGB(255, 238, 240).CGColor;
    
    _lblTag.font = kFONT11;
    _lblTag.textColor = RGB(242, 58, 77);
    
    _lblStar.textColor = RGB(102, 102, 102);
    _lblStar.font = kFONT13;
    _lblStar.text = @"评分：";
    
    _lblPrice.textColor = RGB(102, 102, 102);
    _lblPrice.font = kFONT13;
    
    _lblDesc.textColor = RGB(51, 51, 51);
    _lblDesc.font = kFONT14;
    _lblDesc.numberOfLines = 0;
    
    _vImages.hidden = YES;
    
    _vCount.backgroundColor = RGBA(0, 0, 0, 0.2);
    
    _lblCount.textColor = UIColor.whiteColor;
    _lblCount.font = kFONT14;
    
    _lblViews.textColor = RGB(102, 102, 102);
    _lblViews.font = kFONT11;
 
    _lblQuestion.textColor = RGB(102, 102, 102);
    _lblQuestion.font = kFONT11;

    _lblLike.textColor = RGB(102, 102, 102);
    _lblLike.font = kFONT11;
    
    _icoLike.userInteractionEnabled = NO;
    _vLike.userInteractionEnabled = NO;
    _icoQuestion.userInteractionEnabled = NO;
    _vQuestion.userInteractionEnabled = NO;
    
    _btnQuestion.layer.borderWidth = 1;
    _btnQuestion.layer.borderColor = RGB(216, 216, 216).CGColor;
    _btnQuestion.layer.cornerRadius = 14;
    
    _btnLike.layer.borderWidth = 1;
    _btnLike.layer.borderColor = RGB(216, 216, 216).CGColor;
    _btnLike.layer.cornerRadius = 14;
    
    for (NSInteger index = 0; index < 5; index++) {
        UIImageView *imgStar = [[UIImageView alloc] init];
        [_vStar addSubview:imgStar];
        [_stars addObject: imgStar];
        [imgStar mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(_stars[index - 1].mas_right).offset(1);
            }
            make.width.height.mas_equalTo(15);
            make.centerY.equalTo(@0);
        }];
    }
    
    [_btnQuestion addTarget:self action:@selector(onQuestionClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnLike addTarget:self action:@selector(onThumbClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel: (FNStoreCommentModel*)model {
    [_imgHeader sd_setImageWithURL: URL(model.head_img)];
    _lblTitle.text = model.username;
    _lblTime.text = model.time;
    _lblPrice.text = model.average_price;
    _lblDesc.text = model.content;
    _lblViews.text = model.c_number;
    
    _lblQuestion.text = model.doubt;
    _lblLike.text = model.vote;
    
    [_icoQuestion sd_setImageWithURL: URL(model.doubt_img)];
//    [_icoLike sd_setImageWithURL: URL(model.vote_img)];
    
    if ([model.has_vote isEqualToString:@"1"]) {
        [_icoLike sd_setImageWithURL: URL(model.vote_img1)];
        _lblLike.textColor = [UIColor colorWithHexString: model.vote_color1];
        _btnLike.layer.borderColor = [UIColor colorWithHexString: model.vote_color1].CGColor;
    } else {
        [_icoLike sd_setImageWithURL: URL(model.vote_img)];
        _lblLike.textColor = [UIColor colorWithHexString: model.vote_color];
        _btnLike.layer.borderColor = [UIColor colorWithHexString: model.vote_color].CGColor;
    }
    
    int count = model.star.intValue;
    for (NSInteger index = 0; index < _stars.count; index++) {
        if (index < count) {
            [_stars[index] sd_setImageWithURL: URL(model.good_star)];
        } else {
            [_stars[index] sd_setImageWithURL: URL(model.bad_star)];
        }
    }
    
    _lblCount.text = [NSString stringWithFormat: @"共%ld张", model.imgs.count];
    _vImages.hidden = model.imgs.count == 0;
    [_vImages mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo( model.imgs.count == 0 ? 0 : 96);
    }];
    for (NSInteger index = 0; index < model.imgs.count && index < 3; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [_images addObject:imageView];
        [_vImages addSubview: imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(_images[index - 1].mas_right).offset(3);
            }
            make.width.height.mas_equalTo(96);
            make.centerY.equalTo(@0);
        }];
        [imageView sd_setImageWithURL: URL(model.imgs[index])];
        imageView.cornerRadius = 4;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        NSInteger i = index;
        @weakify(self);
        [imageView addJXTouch:^{
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(commentCell:didImageClickAt:)]) {
                [self.delegate commentCell:self didImageClickAt: i];
            }
        }];
    }
    
    [_vImages bringSubviewToFront:self.vCount];
    _lblTag.text = model.star_str;
    [self.contentView layoutIfNeeded];
    
}

- (CGFloat) getHeight {
    return self.btnQuestion.frame.origin.y, self.btnQuestion.frame.size.height + 20;
}

- (void)onQuestionClick {
    if ([_delegate respondsToSelector:@selector(didQuestionClick:)]) {
        [_delegate didQuestionClick:self];
    }
}

- (void)onThumbClick {
    if ([_delegate respondsToSelector:@selector(didThumbClick:)]) {
        [_delegate didThumbClick:self];
    }
}

@end
