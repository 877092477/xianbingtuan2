//
//  FNConnectionsSearchView.m
//  THB
//
//  Created by Weller Zhao on 2019/2/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsSearchView.h"
#import "FNConnectionsSearchCell.h"

@interface FNConnectionsSearchView() <UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UICollectionView *clvIcon;
@property (nonatomic, strong) UITextField *txfSearch;

@property (nonatomic, strong) NSArray<NSString*>* iconUrls;

@end

@implementation FNConnectionsSearchView

#define SIZE 40
#define MAX_COUNT 5

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.backgroundColor = UIColor.whiteColor;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SIZE, SIZE);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _clvIcon = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _clvIcon.backgroundColor = UIColor.clearColor;
    _clvIcon.showsHorizontalScrollIndicator = NO;
    _clvIcon.showsVerticalScrollIndicator = NO;
    _clvIcon.delegate = self;
    _clvIcon.dataSource = self;
    [_clvIcon registerClass:[FNConnectionsSearchCell class] forCellWithReuseIdentifier:@"FNConnectionsSearchCell"];
    [self addSubview:_clvIcon];
    
    _txfSearch = [[UITextField alloc] init];
    [self addSubview:_txfSearch];
    
    @weakify(self)
    [_clvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.bottom.equalTo(@0);
        make.width.mas_equalTo(0);
    }];
    
    [_txfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self_weak_.clvIcon.mas_right);
        make.top.bottom.equalTo(@0);
        make.right.equalTo(@0);
    }];
    
    UIImageView *imgSearch = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    imgSearch.image = IMAGE(@"order_image_search");
    imgSearch.contentMode = UIViewContentModeCenter;
    _txfSearch.leftView = imgSearch;
    _txfSearch.leftViewMode = UITextFieldViewModeAlways;
    _txfSearch.placeholder = @"搜索";
    _txfSearch.font = kFONT16;
    _txfSearch.returnKeyType = UIReturnKeySearch;
    _txfSearch.delegate = self;
}

- (void) setIcons: (NSArray<NSString*>*)iconUrls {
    _iconUrls = iconUrls;
    [_clvIcon reloadData];
    NSInteger count = iconUrls.count > MAX_COUNT ? MAX_COUNT : iconUrls.count;
    @weakify(self)
    [UIView animateWithDuration:0.2 animations:^{
        [self_weak_.clvIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(count * SIZE);
        }];
        [self layoutIfNeeded];
    }];
    [_clvIcon scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:iconUrls.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _iconUrls == nil ? 0 : _iconUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FNConnectionsSearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNConnectionsSearchCell" forIndexPath:indexPath];
    [cell.imgHeader sd_setImageWithURL:URL(_iconUrls[indexPath.row])];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(searchView:didItemSelectedAt:)]) {
        [_delegate searchView:self didItemSelectedAt:indexPath.row];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(searchView:didSearch:)]) {
        [_delegate searchView:self didSearch:textField.text];
    }
    [textField endEditing:YES];
    return YES;
}


@end
