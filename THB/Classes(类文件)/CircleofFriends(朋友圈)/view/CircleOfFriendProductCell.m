//
//  CircleOfFriendProductCell.m
//  THB
//
//  Created by Weller on 2018/12/18.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "CircleOfFriendProductCell.h"
#import "COFPriceView.h"

@interface CircleOfFriendCommandView: UIView

@property (nonatomic, strong) UILabel *lblCommand;
@property (nonatomic, strong) UIButton *btnCommand;

@property (nonatomic, weak) id<CircleOfFriendCommandViewDelegate> delegate;

@end

@implementation CircleOfFriendCommandView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lblCommand = [[UILabel alloc] init];
    _btnCommand = [[UIButton alloc] init];
    
    [self addSubview: _lblCommand];
    [self addSubview: _btnCommand];
    
    
    self.backgroundColor = RGB(245, 245, 245);
    self.cornerRadius = 8;
    
    [_lblCommand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@8);
        make.right.lessThanOrEqualTo(@-30);
    }];
    
    [_btnCommand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblCommand.mas_bottom).offset(10);
        make.right.equalTo(@-10);
        make.bottom.equalTo(@-10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(25);
    }];
    
    _lblCommand.textColor = RGB(155, 155, 155);
    _lblCommand.font = kFONT13;
    _lblCommand.numberOfLines = 0;
    
//    [_btnCommand setBackgroundImage:IMAGE(@"circle_copy_bg") forState:UIControlStateNormal];
//    [_btnCommand setImage:IMAGE(@"circle_copy") forState:UIControlStateNormal];
//    [_btnCommand setTitle:@"复制评论" forState:UIControlStateNormal];
//    [_btnCommand setTitleColor:FNWhiteColor forState:UIControlStateNormal];
//    _btnCommand.titleLabel.font = kFONT10;
//    [_btnCommand addTarget:self action:@selector(onClick)];
    [_btnCommand addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onClick {
    if ([_delegate respondsToSelector:@selector(didCommandViewClick:)]) {
        [_delegate didCommandViewClick:self];
    }
}

@end

@interface CircleOfFriendProductCell() <CircleOfFriendCommandViewDelegate>

@property (nonatomic, strong) UIView *vBackgroound;

@property (nonatomic, strong) UIView *vImages;
@property (nonatomic, strong) NSMutableArray<UIButton*> *imageViews;


@property (nonatomic, strong) UIView *vLine;


@property (nonatomic, strong) UIView *vCommands;
@property (nonatomic, strong) NSMutableArray<CircleOfFriendCommandView*> *commandViews;

@end

@implementation CircleOfFriendProductCell

#define ColunmCount 3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageViews = [[NSMutableArray alloc] init];
        _commandViews = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vBackgroound = [[UIView alloc] init];
    _btnHeader = [[UIButton alloc] init];
    _lblStore = [[UILabel alloc] init];
    _imgStore = [[UIImageView alloc] init];
    _lblTime = [[UILabel alloc] init];
    _btnSaveAlbum = [[UIButton alloc] init];
    _btnShare = [[UIButton alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _vImages = [[UIView alloc] init];
    _imgCommission = [[UIImageView alloc] init];
    _lblCommission = [[UILabel alloc] init];
    _btnLike = [[UIButton alloc] init];
    _btnCommand = [[UIButton alloc] init];
    _vCommands = [[UIView alloc] init];
    _vLine = [[UIView alloc] init];
    
    [self.contentView addSubview:_vBackgroound];
    [_vBackgroound addSubview:_btnHeader];
    [_vBackgroound addSubview:_lblStore];
    [_vBackgroound addSubview:_imgStore];
    [_vBackgroound addSubview:_lblTime];
    [_vBackgroound addSubview:_btnSaveAlbum];
    [_vBackgroound addSubview:_btnShare];
    [_vBackgroound addSubview:_lblTitle];
    [_vBackgroound addSubview:_vImages];
    [_vBackgroound addSubview:_imgCommission];
    [_vBackgroound addSubview:_lblCommission];
    [_vBackgroound addSubview:_btnLike];
    [_vBackgroound addSubview:_btnCommand];
    [_vBackgroound addSubview:_vCommands];
    [_vBackgroound addSubview:_vLine];
    
    [_vBackgroound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 14, 0));
    }];
    [_btnHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@14);
        make.width.height.mas_equalTo(40);
    }];
    [_lblStore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_btnHeader.mas_right).offset(10);
        make.top.equalTo(_btnHeader).offset(2);
    }];
    [_imgStore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblStore.mas_right).offset(10);
        make.width.mas_equalTo(34);
        make.height.mas_equalTo(14);
        make.right.lessThanOrEqualTo(_btnSaveAlbum.mas_left).offset(-10);
        make.centerY.equalTo(_lblStore);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_btnHeader.mas_right).offset(10);
        make.bottom.equalTo(_btnHeader).offset(-4);
        make.right.lessThanOrEqualTo(_btnSaveAlbum.mas_left).offset(-10);
    }];
    [_btnSaveAlbum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_btnShare.mas_left).offset(-10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(25);
        make.top.equalTo(@20);
    }];
    [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(25);
        make.top.equalTo(@20);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.btnHeader.mas_bottom).offset(14);
        make.height.mas_equalTo(1);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_vLine.mas_bottom).offset(20);
        make.left.equalTo(_btnHeader);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_vImages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_btnHeader);
        make.right.equalTo(@-14);
        make.top.equalTo(_lblTitle.mas_bottom).offset(10);
    }];
    [_imgCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_btnHeader);
        make.top.equalTo(_vImages.mas_bottom).offset(10);
    }];
    [_lblCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgCommission.mas_right).offset(10);
        make.centerY.equalTo(_imgCommission);
        make.right.lessThanOrEqualTo(_btnLike.mas_left).offset(-20);
    }];
    [_btnLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_imgCommission);
        make.right.equalTo(_btnCommand.mas_left).offset(-10);
    }];
    [_btnCommand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_imgCommission);
        make.right.equalTo(@-20);
    }];
    [_vCommands mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_btnHeader);
        make.right.equalTo(@-20);
        make.top.equalTo(_imgCommission.mas_bottom).offset(10);
        make.bottom.equalTo(@-20);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColor.clearColor;
    _vBackgroound.backgroundColor = UIColor.whiteColor;
//    _vBackgroound.cornerRadius = 8;
    
    _lblStore.textColor = RGB(51, 51, 51);
    _lblStore.font = [UIFont boldSystemFontOfSize:15];
    
    _imgStore.contentMode = UIViewContentModeScaleAspectFit;
    
    _lblTime.textColor = RGB(153, 153, 153);
    _lblTime.font = kFONT10;
    
    _vLine.backgroundColor = RGB(240, 240, 240);
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT13;
    _lblTitle.numberOfLines = 0;
    
    _imgCommission.image = [UIImage imageNamed:@"circle_commission"];
    _imgCommission.hidden = [FNCurrentVersion isEqualToString:Setting_checkVersion];
    
    _lblCommission.font = kFONT11;
    _lblCommission.textColor = RGB(221, 56, 60);
    _lblCommission.hidden = [FNCurrentVersion isEqualToString:Setting_checkVersion];
    
    [_btnLike setTitleColor:RGB(221, 56, 60) forState:UIControlStateNormal];
    _btnLike.titleLabel.font = kFONT10;
    [_btnLike setImage:IMAGE(@"circle_like_selected") forState:UIControlStateNormal];
//    [_btnLike setImage:IMAGE(@"circle_like_selected") forState:UIControlStateSelected];
    [_btnLike layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:4];
    
    [_btnCommand setTitleColor:RGB(221, 56, 60) forState:UIControlStateNormal];
    _btnCommand.titleLabel.font = kFONT10;
    [_btnCommand setImage:IMAGE(@"circle_command") forState:UIControlStateNormal];
    [_btnCommand layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:4];
    
    [_btnHeader addTarget:self action:@selector(onHeaderClick)];
    [_btnSaveAlbum addTarget:self action:@selector(onSaveClick)];
    [_btnShare addTarget:self action:@selector(onShareClick)];
    [_btnLike addTarget:self action:@selector(onLikeClick)];
    [_btnCommand addTarget:self action:@selector(onCommentClick)];
    
}

- (void)setImages: (NSArray<CircleOfFriendsImageModel*>*)models {
    for (UIButton *imageView in _imageViews) {
        [imageView removeFromSuperview];
    }
    [_imageViews removeAllObjects];
    
    CGFloat width = (XYScreenWidth - 50) / 3;
    for (NSInteger index = 0; index < models.count; index ++ ) {
        UIButton *imageView = [[UIButton alloc] init];
        [_vImages addSubview:imageView];
        [_imageViews addObject:imageView];
        [imageView addTarget:self action:@selector(onImageClick:)];
        
        NSInteger row = index / ColunmCount;
        NSInteger column = index % ColunmCount;
        [imageView sd_setBackgroundImageWithURL:URL(models[index].img) forState:UIControlStateNormal];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (column == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(_imageViews[index - 1].mas_right).offset(4);
            }
            if (row == 0) {
                make.top.equalTo(@0);
            } else {
                make.top.equalTo(_imageViews[index - ColunmCount].mas_bottom).offset(4);
            }
            
//            make.bottom.lessThanOrEqualTo(@0);
            make.width.mas_equalTo(width);
            make.height.equalTo(imageView.mas_width);
            if (index == models.count - 1) {
                make.bottom.equalTo(@0);
            }
        }];
        
        if ([models[index].is_show_price isEqualToString:@"1"]) {
            COFPriceView *vPrice = [[COFPriceView alloc] init];
            UILabel *lblPrice = [[UILabel alloc] init];
            [imageView addSubview:vPrice];
            [vPrice addSubview:lblPrice];
            [vPrice mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(@0);
                make.height.mas_equalTo(20);
            }];
            
            [lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(@0);
                make.left.equalTo(@8);
                make.right.equalTo(@-8);
            }];
            
//            vPrice.backgroundColor = [UIColor colorWithHexString:models[index].price_color];
            vPrice.backgroundColor = UIColor.blueColor;
            
            lblPrice.textColor = [UIColor colorWithHexString:models[index].price_fontcolor];
            lblPrice.text = [NSString stringWithFormat:@"%@￥%@", models[index].price_str, models[index].goods_price];
            lblPrice.font = [UIFont systemFontOfSize:10];
            lblPrice.textAlignment = NSTextAlignmentCenter;
            vPrice.layer.backgroundColor = [[UIColor colorWithHexString:models[index].price_color] colorWithAlphaComponent: 0.8].CGColor;
            
        }
        
        
    }
    [_vImages layoutIfNeeded];
}

- (void)setCommands: (NSArray<NSString*>*) commands withColors: (NSArray<UIColor*>*)colors ButtonUrl: (NSArray<NSString*>*)urls;{
    if (commands.count != colors.count || commands.count != urls.count)
        return;
    for (UIView *view in _commandViews) {
        [view removeFromSuperview];
    }
    [_commandViews removeAllObjects];
    
    for (NSInteger index = 0; index < commands.count; index ++) {
        CircleOfFriendCommandView *view = [[CircleOfFriendCommandView alloc] init];
        [_commandViews addObject:view];
        [_vCommands addSubview:view];
        view.delegate = self;
        
        view.lblCommand.text = commands[index];
        view.lblCommand.textColor = colors[index];
        [view.btnCommand sd_setBackgroundImageWithURL:URL(urls[index]) forState:UIControlStateNormal];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.top.equalTo(@0);
            } else {
                make.top.equalTo(_commandViews[index - 1].mas_bottom).offset(10);
            }
            make.left.right.equalTo(@0);
            if (index == commands.count - 1) {
                make.bottom.equalTo(@0);
            }
        }];
    }
    [_vCommands layoutIfNeeded];
}

#pragma mark - Action

- (void)onHeaderClick {
    if ([_delegate respondsToSelector:@selector(productCellDidHeaderClick:)]) {
        [_delegate productCellDidHeaderClick:self];
    }
}

- (void)onSaveClick {
    if ([_delegate respondsToSelector:@selector(productCellDidSaveClick:)]) {
        [_delegate productCellDidSaveClick:self];
    }
}

- (void)onShareClick {
    if ([_delegate respondsToSelector:@selector(productCellDidShareClick:)]) {
        [_delegate productCellDidShareClick:self];
    }
}

- (void)onLikeClick {
    if ([_delegate respondsToSelector:@selector(productCellDidLikeClick:)]) {
        [_delegate productCellDidLikeClick:self];
    }
}

- (void)onCommentClick {
    if ([_delegate respondsToSelector:@selector(productCellDidCommentClick:)]) {
        [_delegate productCellDidCommentClick:self];
    }
}

- (void)onImageClick: (UITapGestureRecognizer*)sender {
    
    if ([_delegate respondsToSelector:@selector(productCell:didPhotoClickAtIndex:)]) {
        
        UIButton *button = (UIButton*)sender.view;
        NSInteger index = [_imageViews indexOfObject:button];
        [_delegate productCell:self didPhotoClickAtIndex:index];
    }
    
}

#pragma mark - CircleOfFriendCommandViewDelegate
- (void)didCommandViewClick:(id)view {
    if ([_delegate respondsToSelector:@selector(productCell:didCopyClickAtIndex:)]) {
        NSInteger index = [_commandViews indexOfObject:view];
        [_delegate productCell:self didCopyClickAtIndex:index];
    }
}

@end

