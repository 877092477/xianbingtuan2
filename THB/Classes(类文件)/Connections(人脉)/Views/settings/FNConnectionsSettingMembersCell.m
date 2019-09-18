//
//  FNConnectionsSettingMembersCell.m
//  THB
//
//  Created by Weller Zhao on 2019/3/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsSettingMembersCell.h"
#import "FNImageText.h"

@interface FNConnectionsSettingMembersCell()<FNImageTextDelegate>

@property (nonatomic, strong) NSMutableArray<FNImageText*> *headers;

@property (nonatomic, assign) BOOL isGrouper;

@end

@implementation FNConnectionsSettingMembersCell

#define MAX_COLUMN 5
#define PADDING 10

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headers = [[NSMutableArray alloc] init];
        _isGrouper = NO;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setImages: (NSArray<NSString*>*)imgNames withTitles: (NSArray<NSString*>*)titles isGrouper: (BOOL)isGrouper {
    if (imgNames.count != titles.count) {
        return;
    }
    for (UIButton *button in _headers) {
        [button removeFromSuperview];
    }
    [_headers removeAllObjects];
    for (NSInteger index = 0; index < imgNames.count; index++) {
        FNImageText *button = [[FNImageText alloc] init];
        [button.imgIcon sd_setImageWithURL:URL(imgNames[index])];
        button.imgIcon.cornerRadius = 4;
        button.lblTitle.text = titles[index];
//        button.lblBadge.hidden = YES;
        button.delegate = self;
        [self addHeader:button];
    }
    _isGrouper = isGrouper;
    if (isGrouper) {
        FNImageText *btnAdd = [[FNImageText alloc] init];
        btnAdd.imgIcon.image = IMAGE(@"connections_setting_add");
        btnAdd.delegate = self;
        [self addHeader:btnAdd];
        
        FNImageText *btnSub = [[FNImageText alloc] init];
        btnSub.imgIcon.image = IMAGE(@"connections_setting_sub");
        btnSub.delegate = self;
        [self addHeader:btnSub];
    }
}

- (void)addHeader: (FNImageText*)header {
    [self.contentView addSubview:header];
    [self.headers addObject:header];
    
    NSInteger index = self.headers.count - 1;
    NSInteger column = index % MAX_COLUMN;
    NSInteger row = index / MAX_COLUMN;
    CGFloat width = (XYScreenWidth - PADDING * (MAX_COLUMN + 1)) / MAX_COLUMN;
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        if (row == 0) {
            make.top.equalTo(@20);
        } else {
            make.top.equalTo(self.headers[index - MAX_COLUMN].mas_bottom).offset(PADDING);
        }
        if (column == 0) {
            make.left.equalTo(@PADDING);
        } else {
            make.left.equalTo(self.headers[index - 1].mas_right).offset(PADDING);
        }
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(width + 20);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
}

#pragma mark - FNImageTextDelegate
- (void)didIconClick:(FNImageText *)icon {
    NSInteger index = [self.headers indexOfObject:icon];
    if (_isGrouper) {
        index = index - (self.headers.count - 2);
        if (index == 0) {
            if ([_delegate respondsToSelector:@selector(didAddClick)]) {
                [_delegate didAddClick];
            }
        } else if (index == 1) {
            if ([_delegate respondsToSelector:@selector(didRemoveClick)]) {
                [_delegate didRemoveClick];
            }
        }
        return;
    }
    if ([_delegate respondsToSelector:@selector(didMembersClickAt:)]) {
        [_delegate didMembersClickAt:index];
    }
}


@end
