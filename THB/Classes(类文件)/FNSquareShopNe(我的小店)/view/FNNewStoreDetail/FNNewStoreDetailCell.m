//
//  FNNewStoreDetailCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreDetailCell.h"
#import "FNImageCollectionViewCell.h"

@interface FNNewStoreDetailCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIView *vStars;
@property (nonatomic, strong) UILabel *lblComment;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UIView *vLine2;
@property (nonatomic, strong) UILabel *lblType;
@property (nonatomic, strong) UICollectionView *clvImages;
@property (nonatomic, strong) UIImageView *imgShop;
@property (nonatomic, strong) UILabel *lblStatus;
@property (nonatomic, strong) UIView *vLine3;
@property (nonatomic, strong) UILabel *lblTime;
@property (nonatomic, strong) UIView *vLine4;

@property (nonatomic, strong) UIImageView *imgLocation;
@property (nonatomic, strong) UILabel *lblLocation;
@property (nonatomic, strong) UILabel *lblDistance;
@property (nonatomic, strong) UIButton *btnLocation;
@property (nonatomic, strong) UIButton *btnCall;

@property (nonatomic, strong) UIButton *btnPay;
@property (nonatomic, strong) UIView *vPay;
@property (nonatomic, strong) UIImageView *imgPay;
@property (nonatomic, strong) UILabel *lblPayTitle;
@property (nonatomic, strong) UILabel *lblPayDesc;

@property (nonatomic, strong) NSMutableArray<UIImageView*> *stars;
@property (nonatomic, strong) FNstoreInformationDaModel *model;

@end

@implementation FNNewStoreDetailCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _stars = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    _vStars = [[UIView alloc] init];
    _lblComment = [[UILabel alloc] init];
    _vLine = [[UIView alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _vLine2 = [[UIView alloc] init];
    _lblType = [[UILabel alloc] init];
    _imgShop = [[UIImageView alloc] init];
    _lblStatus = [[UILabel alloc] init];
    _vLine3 = [[UIView alloc] init];
    _lblTime = [[UILabel alloc] init];
    _vLine4 = [[UIView alloc] init];
    _imgLocation = [[UIImageView alloc] init];
    _lblLocation = [[UILabel alloc] init];
    _lblDistance = [[UILabel alloc] init];
    _btnLocation = [[UIButton alloc] init];
    _btnCall = [[UIButton alloc] init];
    _btnPay = [[UIButton alloc] init];
    _vPay = [[UIView alloc] init];
    _imgPay = [[UIImageView alloc] init];
    _lblPayTitle = [[UILabel alloc] init];
    _lblPayDesc = [[UILabel alloc] init];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(130, 100);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _clvImages = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _clvImages.delegate = self;
    _clvImages.dataSource = self;
    _clvImages.showsHorizontalScrollIndicator = NO;
    _clvImages.showsVerticalScrollIndicator = NO;
    [_clvImages registerClass:[FNImageCollectionViewCell class] forCellWithReuseIdentifier:@"FNImageCollectionViewCell"];
    
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_vStars];
    [self.contentView addSubview:_lblComment];
    [self.contentView addSubview:_vLine];
    [self.contentView addSubview:_lblPrice];
    [self.contentView addSubview:_vLine2];
    [self.contentView addSubview:_lblType];
    [self.contentView addSubview:_clvImages];
    [self.contentView addSubview:_imgShop];
    [self.contentView addSubview:_lblStatus];
    [self.contentView addSubview:_vLine3];
    [self.contentView addSubview:_lblTime];
    [self.contentView addSubview:_vLine4];
    [self.contentView addSubview:_imgLocation];
    [self.contentView addSubview:_lblLocation];
    [self.contentView addSubview:_lblDistance];
    [self.contentView addSubview:_btnLocation];
    [self.contentView addSubview:_btnCall];
    [self.contentView addSubview:_btnPay];
    [self.contentView addSubview:_vPay];
    [_vPay addSubview:_imgPay];
    [_vPay addSubview:_lblPayTitle];
    [_vPay addSubview:_lblPayDesc];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@16);
        make.right.lessThanOrEqualTo(@-16);
    }];
    [_vStars mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(12);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(80);
    }];
    [_lblComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vStars.mas_right).offset(10);
        make.centerY.equalTo(self.vStars);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vStars);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(1);
        make.left.equalTo(self.lblComment.mas_right).offset(10);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vLine.mas_right).offset(10);
        make.centerY.equalTo(self.vStars);
    }];
    [_vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vStars);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(1);
        make.left.equalTo(self.lblPrice.mas_right).offset(10);
    }];
    [_lblType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vLine2.mas_right).offset(10);
        make.centerY.equalTo(self.vStars);
        make.right.lessThanOrEqualTo(@-16);
    }];
    [_clvImages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.vStars.mas_bottom).offset(10);
        make.right.equalTo(@0);
        make.height.mas_equalTo(100);
    }];
    [_imgShop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.clvImages.mas_bottom).offset(14);
        make.width.height.mas_equalTo(16);
    }];
    [_lblStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgShop.mas_right).offset(8);
        make.centerY.equalTo(self.imgShop);
    }];
    [_vLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblStatus.mas_right).offset(8);
        make.centerY.equalTo(self.imgShop);
        make.width.mas_equalTo(2);
        make.height.mas_equalTo(12);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vLine3.mas_right).offset(8);
        make.centerY.equalTo(self.imgShop);
        make.right.lessThanOrEqualTo(@-16);
    }];
    [_vLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.right.equalTo(@-16);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.imgShop.mas_bottom).offset(14);
    }];
    [_imgLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.vLine4.mas_bottom).offset(14);
        make.width.height.mas_equalTo(16);
    }];
    [_lblLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgLocation.mas_right).offset(8);
        make.centerY.equalTo(self.imgLocation);
        make.right.lessThanOrEqualTo(self.btnLocation.mas_left).offset(-10);
    }];
    [_lblDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgLocation.mas_right).offset(8);
        make.top.equalTo(self.lblLocation.mas_bottom).offset(8);
        make.right.lessThanOrEqualTo(self.btnLocation.mas_left).offset(-10);
    }];
    [_btnLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnCall.mas_left).offset(-30);
        make.width.height.mas_equalTo(22);
        make.centerY.equalTo(self.btnCall);
    }];
    [_btnCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-16);
        make.top.equalTo(self.imgLocation).offset(8);
        make.width.height.mas_equalTo(22);
    }];
    [_btnPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnCall.mas_bottom).offset(24);
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.height.mas_equalTo(64);
    }];
    [_vPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.btnPay);
        make.left.top.greaterThanOrEqualTo(@10);
        make.right.bottom.lessThanOrEqualTo(@-10);
    }];
    [_imgPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        make.width.height.mas_equalTo(35);
    }];
    [_lblPayTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgPay.mas_right).offset(8);
        make.top.equalTo(@4);
        make.right.lessThanOrEqualTo(@0);
    }];
    [_lblPayDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgPay.mas_right).offset(8);
        make.bottom.equalTo(@-2);
        make.right.lessThanOrEqualTo(@0);
    }];
    
    self.backgroundColor = UIColor.whiteColor;
    
    _imgShop.contentMode = UIViewContentModeScaleAspectFill;
    _imgShop.clipsToBounds = YES;
    
    _lblTitle.textColor = RGB(60, 60, 60);
    _lblTitle.font = [UIFont systemFontOfSize:24];
    
    _lblComment.textColor = UIColor.blackColor;
    _lblComment.font = kFONT13;
    
    _vLine.backgroundColor = RGB(237, 237, 237);
    
    _lblPrice.textColor = UIColor.blackColor;
    _lblPrice.font = kFONT13;
    
    _vLine2.backgroundColor = RGB(237, 237, 237);
    
    _lblType.textColor = UIColor.blackColor;
    _lblType.font = kFONT13;
    
    _clvImages.backgroundColor = UIColor.clearColor;
    
    _lblStatus.textColor = RGB(51, 51, 51);
    _lblStatus.font = kFONT16;
    
    _vLine3.backgroundColor = RGB(51, 51, 51);
    
    _lblTime.textColor = RGB(51, 51, 51);
    _lblTime.font = kFONT16;
    
    _vLine4.backgroundColor = RGB(240, 240, 240);
    
    _lblLocation.textColor = RGB(51, 51, 51);
    _lblLocation.font = kFONT16;
    
    _lblDistance.textColor = RGB(128, 128, 128);
    _lblDistance.font = kFONT12;
    
    _btnPay.layer.backgroundColor = UIColor.whiteColor.CGColor;
    _btnPay.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.04].CGColor;
    _btnPay.layer.shadowOffset = CGSizeMake(0,0);
    _btnPay.layer.shadowOpacity = 1;
    _btnPay.layer.shadowRadius = 3;
    _btnPay.layer.borderWidth = 0.5;
    _btnPay.layer.borderColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0].CGColor;
    _btnPay.layer.cornerRadius = 5;
    
    _lblPayTitle.textColor = RGB(51, 51, 51);
    _lblPayTitle.font = kFONT14;
    _lblPayDesc.textColor = RGB(153, 153, 153);
    _lblPayDesc.font = [UIFont systemFontOfSize:9];
    
    
    for (NSInteger index = 0; index < 5; index++) {
        UIImageView *imgStar = [[UIImageView alloc] init];
        [_vStars addSubview:imgStar];
        [_stars addObject: imgStar];
        [imgStar mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(_stars[index - 1].mas_right).offset(1);
            }
            make.width.height.mas_equalTo(15);
        }];
    }
    
    [_btnLocation addTarget:self action:@selector(onLocationClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnCall addTarget:self action:@selector(onCallClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnPay addTarget:self action:@selector(onPayClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel: (FNstoreInformationDaModel*)model {
    _model = model;
    _lblTitle.text = model.name;
    _lblComment.text = model.comment_counts_str;
    _lblPrice.text = model.str2;
    _lblType.text = model.cate_str;
    
    [_imgShop sd_setImageWithURL: URL(model.store_icon)];
    _lblStatus.text = model.open_str;
    _lblTime.text = model.open_time_str;
    
    [_imgLocation sd_setImageWithURL:URL(model.map_icon)];
    _lblLocation.text = model.address;
    _lblDistance.text = model.distance2;
    
    [_btnLocation sd_setBackgroundImageWithURL: URL(model.icon_location) forState: UIControlStateNormal];
    [_btnCall sd_setBackgroundImageWithURL: URL(model.icon_phone) forState: UIControlStateNormal];
    
    NSDictionary *fukuan = model.fukuan;
    [_imgPay sd_setImageWithURL: URL(fukuan[@"img"])];
    _imgPay.userInteractionEnabled= NO;
    _vPay.userInteractionEnabled= NO;
    _lblPayTitle.text = fukuan[@"str"];
    _lblPayDesc.text = fukuan[@"tips"];
    
    int count = model.average_star.intValue;
    for (NSInteger index = 0; index < _stars.count; index++) {
        if (index < count) {
            [_stars[index] sd_setImageWithURL: URL(model.good_star)];
        } else {
            [_stars[index] sd_setImageWithURL: URL(model.bad_star)];
        }
    }
    
    [_clvImages mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.model.album_list.count > 0 ? 100 : 0);
    }];
    
    [_clvImages reloadData];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _model == nil ? 0 : self.model.album_list.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *imageUrl = self.model.album_list[indexPath.row];
    FNImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNImageCollectionViewCell" forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL: URL(imageUrl)];
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(130, 100);

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(cell:didImageClickAt:)]) {
        [_delegate cell:self didImageClickAt: indexPath.row];
    }
}

#pragma mark - Action
- (void)onLocationClick {
    if ([_delegate respondsToSelector:@selector(cellDidLocationClick:)]) {
        [_delegate cellDidLocationClick:self];
    }
}
- (void)onCallClick {
    if ([_delegate respondsToSelector:@selector(cellDidCallClick:)]) {
        [_delegate cellDidCallClick:self];
    }
}
- (void)onPayClick {
    if ([_delegate respondsToSelector:@selector(cellDidPayClick:)]) {
        [_delegate cellDidPayClick:self];
    }
}

@end
