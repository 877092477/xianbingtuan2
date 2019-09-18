//
//  FNConnectionsHomeHeaderView.m
//  THB
//
//  Created by Weller Zhao on 2019/1/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsHomeHeaderView.h"

@interface FNConnectionsHomeHeaderButtonView()

@end

@implementation FNConnectionsHomeHeaderButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.vContent = [[UIView alloc] init];
    self.imgIcon = [[UIImageView alloc] init];
    self.lblTitle = [[UILabel alloc] init];
    self.lblBadge = [[UILabel alloc] init];
    
    [self addSubview:self.vContent];
    [self addSubview:self.imgIcon];
    [self addSubview:self.lblTitle];
    [self addSubview:self.lblBadge];
    
    @weakify(self)
    [self.vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.greaterThanOrEqualTo(@0);
        make.bottom.lessThanOrEqualTo(@0);
    }];
    
    [self.imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.top.equalTo(@0);
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self_weak_.imgIcon.mas_bottom).offset(8);
        make.bottom.equalTo(@0);
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
    }];
    [self.lblTitle setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.lblBadge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.centerX.equalTo(self_weak_.imgIcon.mas_right);
        make.centerY.equalTo(self_weak_.imgIcon.mas_top);
        make.width.mas_greaterThanOrEqualTo(10);
    }];
    
    _imgIcon.contentMode = UIViewContentModeScaleAspectFit;
    
    _lblTitle.font = [UIFont systemFontOfSize:9];
    
    self.lblBadge.cornerRadius = 5;
    self.lblBadge.textColor = UIColor.whiteColor;
    self.lblBadge.backgroundColor = RGB(232, 79, 39);
    self.lblBadge.font = [UIFont systemFontOfSize:5];
    self.lblBadge.textAlignment = NSTextAlignmentCenter;
}

@end

@interface FNConnectionsHomeHeaderView()

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIImageView *imgBackground;

@property (nonatomic, strong) NSMutableArray<FNConnectionsHomeHeaderButtonView*> *buttons;

@end

@implementation FNConnectionsHomeHeaderView

//每行个数
#define LineCount 5
#define LineHeight 60

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttons = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.vContent = [[UIView alloc] init];
    [self addSubview:_vContent];
    [self.vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.height.mas_equalTo(0);
    }];
    self.imgBackground = [[UIImageView alloc] init];
    [self.vContent addSubview:self.imgBackground];
    [self.imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
}

- (void) setBackgroundImageUrl: (NSString*)url {
    [_imgBackground sd_setImageWithURL:URL(url)];
}

- (void) setTitles: (NSArray<NSString*>*) titles withColors: (NSArray<UIColor*>*)colors imageUrls: (NSArray<NSString*>*) imageUrls badges: (NSArray<NSNumber*>*) badges {
    if (titles.count != imageUrls.count ||
        titles.count != colors.count ||
        titles.count != badges.count) {
        return;
    }
    for (FNConnectionsHomeHeaderButtonView *view in self.buttons) {
        [view removeFromSuperview];
    }
    [self.buttons removeAllObjects];
    
    NSInteger line = (titles.count - 1) / LineCount + 1;
    [self.vContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        make.height.mas_equalTo(line < 0 ? 0 :line * LineHeight + 40);
    }];
    
    for (NSInteger index = 0; index < titles.count; index++) {
        FNConnectionsHomeHeaderButtonView *view = [[FNConnectionsHomeHeaderButtonView alloc] init];
        [self.vContent addSubview:view];
        [self.buttons addObject:view];
        
        [view.imgIcon sd_setImageWithURL:URL(imageUrls[index])];
        view.lblTitle.text = titles[index];
        view.lblTitle.textColor = colors[index];
        view.lblBadge.text = [NSString stringWithFormat:@"%d", badges[index].intValue];
        [view.lblBadge setHidden:badges[index].intValue <= 0];
        
        NSInteger row = index / LineCount;
        NSInteger column = index % LineCount;
        @weakify(self)
        
        NSInteger i = index;
        
        [view addJXTouch:^{
            if ([self_weak_.delegate respondsToSelector:@selector(headerView:didSelectedAt:)]) {
                [self_weak_.delegate headerView:self_weak_ didSelectedAt:i];
            }
        }];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (column == 0) {
                make.left.equalTo(@10);
            } else {
                make.left.equalTo(self_weak_.buttons[index - 1].mas_right).offset(10);
                make.width.equalTo(self_weak_.buttons[index - 1]);
            }
            
            if (row == 0) {
                make.top.equalTo(@20);
            } else {
                make.top.equalTo(self_weak_.buttons[index - LineCount].mas_bottom).offset(20);
            }
            
            if (column == LineCount - 1) {
                make.right.equalTo(@-10);
            }
            make.height.mas_equalTo(LineHeight);
        }];
    }
}

@end
