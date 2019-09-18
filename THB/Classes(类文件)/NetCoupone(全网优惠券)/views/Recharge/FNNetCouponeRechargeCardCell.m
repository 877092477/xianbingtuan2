//
//  FNNetCouponeRechargeCardCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNetCouponeRechargeCardCell.h"
#import "FNNetCouponeRechargeCardCollectionCell.h"
#import "FNNetCouponeRechargeModel.h"

@interface FNNetCouponeRechargeCardCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *clvCard;
@property (nonatomic, strong) NSArray<FNNetCouponeRechargeCardModel*>* cards;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation FNNetCouponeRechargeCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _currentIndex = 0;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(81, 71);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _clvCard = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _clvCard.backgroundColor = UIColor.clearColor;
    _clvCard.showsHorizontalScrollIndicator = NO;
    _clvCard.showsVerticalScrollIndicator = NO;
    _clvCard.delegate = self;
    _clvCard.dataSource = self;
    [_clvCard registerClass:[FNNetCouponeRechargeCardCollectionCell class] forCellWithReuseIdentifier:@"FNNetCouponeRechargeCardCollectionCell"];
    [self addSubview:_clvCard];
    [_clvCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.bottom.right.equalTo(@0);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setCards: (NSArray<FNNetCouponeRechargeCardModel*>*)cards {
    _cards = cards;
    [_clvCard reloadData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cards.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    FNNetCouponeRechargeCardCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNetCouponeRechargeCardCollectionCell" forIndexPath:indexPath];

    FNNetCouponeRechargeCardModel* card = _cards[indexPath.row];
    cell.lblTitle.text = card.cost_price_str;
    cell.lblTitle.textColor = [UIColor colorWithHexString: card.cost_price_color];
    cell.lblPrice.text = card.price_str;
    cell.lblPrice.textColor = [UIColor colorWithHexString: card.price_color];
    [cell.imgNormal sd_setImageWithURL: URL(card.bjimg)];
    [cell.imgSelected sd_setImageWithURL: URL(card.check_bjimg)];

    [cell setIsSelected: indexPath.row == _currentIndex];


    return cell;
   
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(cell:didSelectAt:)]) {
        [_delegate cell:self didSelectAt: indexPath.row];
    }
    _currentIndex = indexPath.row;
    [self.clvCard reloadData];
}

- (void)setSelectedAt: (NSInteger)index {
    _currentIndex = index;
    [self.clvCard reloadData];
}

@end
