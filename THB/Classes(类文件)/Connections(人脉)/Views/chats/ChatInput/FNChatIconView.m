//
//  FNChatIconView.m
//  THB
//
//  Created by Weller Zhao on 2019/1/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNChatIconView.h"
#import "ELCVFlowLayout.h"

@interface FNChatIconViewCell: UICollectionViewCell

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation FNChatIconViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.vContent = [[UIView alloc] init];
        self.imgIcon = [[UIImageView alloc] init];
        self.lblTitle = [[UILabel alloc] init];
        
        [self.contentView addSubview:self.vContent];
        [self.vContent addSubview:self.imgIcon];
        [self.vContent addSubview:self.lblTitle];
        
        @weakify(self);
        
        [self.vContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
            make.top.left.greaterThanOrEqualTo(@0);
            make.right.bottom.lessThanOrEqualTo(@0);
        }];
        
        [self.imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(@0);
            make.left.greaterThanOrEqualTo(@0);
            make.right.lessThanOrEqualTo(@0);
        }];
        
        [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(self_weak_.imgIcon.mas_bottom).offset(8);
            make.bottom.equalTo(@0);
            make.left.greaterThanOrEqualTo(@0);
            make.right.lessThanOrEqualTo(@0);
        }];
        
//        self.imgIcon.image = IMAGE(@"chat_input_album");
        
//        self.lblTitle.text = @"相册";
        self.lblTitle.textColor = RGB(255, 51, 153);
        self.lblTitle.font = kFONT11;
        
    }
    return self;
}

@end

@interface FNChatIconView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *clvIcons;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSArray<NSString*>* imageNames;
@property (nonatomic, strong) NSArray<NSString*>* titles;
@property (nonatomic, strong) NSArray<UIColor*>* colors;

@end

@implementation FNChatIconView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _layout = [[ELCVFlowLayout alloc] init];
    _layout.itemSize = CGSizeMake(self.bounds.size.width / 4 - 2, self.bounds.size.height / 2);
    _layout.headerReferenceSize = CGSizeZero;
    _layout.footerReferenceSize = CGSizeZero;
    _layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    self.clvIcons = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    self.clvIcons.delegate = self;
    self.clvIcons.dataSource = self;
    self.clvIcons.backgroundColor = UIColor.whiteColor;
    self.clvIcons.showsVerticalScrollIndicator = NO;
    self.clvIcons.showsHorizontalScrollIndicator = NO;
    self.clvIcons.pagingEnabled = YES;
    [self.clvIcons registerClass:[FNChatIconViewCell class] forCellWithReuseIdentifier:@"FNChatIconViewCell"];
    
    [self addSubview:self.clvIcons];
    [self.clvIcons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = FNHomeBackgroundColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _layout.itemSize = CGSizeMake(self.bounds.size.width / 4 - 2, self.bounds.size.height / 2);
}

- (void)setIcons: (NSArray<NSString*>*) imageURLs withTitles: (NSArray<NSString*>*)titles andTextColors: (NSArray<UIColor*>*)colors {
    _imageNames = imageURLs;
    _titles = titles;
    _colors = colors;
    [self.clvIcons reloadData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageNames == nil ? 0 : _imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FNChatIconViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNChatIconViewCell" forIndexPath:indexPath];
//    cell.imgIcon.image = IMAGE(_imageNames[indexPath.row]);
    [cell.imgIcon sd_setImageWithURL:URL(_imageNames[indexPath.row])];
    cell.lblTitle.text = _titles[indexPath.row];
    cell.lblTitle.textColor = _colors[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(iconView:didSelectAt:)]) {
        [_delegate iconView:self didSelectAt:indexPath.row];
    }
}

@end
