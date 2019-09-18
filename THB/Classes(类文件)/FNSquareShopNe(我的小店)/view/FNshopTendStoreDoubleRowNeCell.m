//
//  FNshopTendStoreDoubleRowNeCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNshopTendStoreDoubleRowNeCell.h"

@interface FNshopTendStoreDoubleRowNeCell()

@property (nonatomic, strong) UIView *vBackground;

@property (nonatomic, strong) UIImageView *imgStore;
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UIView *vCommission;
@property (nonatomic, strong) UILabel *lblCommission;
@property (nonatomic, strong) UIView *vStars;
@property (nonatomic, strong) UILabel *lblPeople;
@property (nonatomic, strong) UILabel *lblDistance;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UILabel *lblLocation;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UIImageView *imgTime;
@property (nonatomic, strong) UILabel *lblTime;

@property (nonatomic, strong) NSMutableArray<UIImageView*> *stars;

@end

@implementation FNshopTendStoreDoubleRowNeCell

-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        _stars = [[NSMutableArray alloc] init];
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    
//    self.backgroundColor = RGB(245, 245, 245);
    self.backgroundColor = UIColor.clearColor;
    
    _vBackground = [[UIView alloc] init];
    [self.contentView addSubview: _vBackground];
//    _vBackground.cornerRadius = 6;
    
    //店铺
    self.imgStore=[UIImageView new];
    [self.vBackground addSubview:self.imgStore];
    self.imgStore.contentMode = UIViewContentModeScaleAspectFill;
    self.imgStore.cornerRadius = 4;
    
    //店铺
    self.lblName=[UILabel new];
    [self.vBackground addSubview:self.lblName];
    
    
    _vCommission = [[UIView alloc] init];
    _lblCommission = [[UILabel alloc] init];
    _vStars = [[UIView alloc] init];
    _lblPeople = [[UILabel alloc] init];
    _lblDistance = [[UILabel alloc] init];
    _vLine = [[UIView alloc] init];
    _lblLocation = [[UILabel alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _lblTime = [[UILabel alloc] init];
    _imgTime = [[UIImageView alloc] init];
    
    [_imgStore addSubview:_vCommission];
    [_vCommission addSubview:_lblCommission];
    [_vBackground addSubview:_vStars];
    [_vBackground addSubview:_lblPeople];
    [_vBackground addSubview:_lblDistance];
    [_vBackground addSubview:_vLine];
    [_vBackground addSubview:_lblLocation];
    [_vBackground addSubview:_lblPrice];
    [_vBackground addSubview:_imgTime];
    [_vBackground addSubview:_lblTime];
    
    [_vBackground mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 10, 0, 5));
    }];
    
    [_imgStore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.mas_equalTo(108);
    }];
    
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@2);
        make.top.equalTo(self.imgStore.mas_bottom).offset(12);
        make.right.lessThanOrEqualTo(@-4);
    }];
    [_vCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.imgStore);
        make.height.mas_equalTo(25);
    }];
    [_lblCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(4, 4, 4, 4));
    }];
    [_vStars mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblName.mas_bottom).offset(10);
        make.left.equalTo(@2);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(60);
    }];
    [_lblPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vStars.mas_right).offset(10);
        make.centerY.equalTo(self.vStars);
        make.right.lessThanOrEqualTo(@-4);
    }];
    [_lblDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@2);
        make.top.equalTo(self.vStars.mas_bottom).offset(12);
        make.height.mas_equalTo(12);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblDistance.mas_right).offset(8);
        make.centerY.equalTo(self.lblDistance);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(12);
    }];
    [_lblLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vLine.mas_right).offset(8);
        make.centerY.equalTo(self.lblDistance);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblLocation.mas_right).offset(8);
        make.centerY.equalTo(self.lblDistance);
        make.right.lessThanOrEqualTo(@-4);
    }];
    [_imgTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@2);
        make.top.equalTo(self.lblDistance.mas_bottom).offset(20);
        make.width.height.mas_equalTo(15);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgTime.mas_right).offset(8);
        make.centerY.equalTo(self.imgTime);
        make.right.lessThanOrEqualTo(@-4);
    }];
    
    _lblName.textColor = RGB(51, 51, 51);
    _lblName.font = [UIFont boldSystemFontOfSize:15];
    
    _vCommission.backgroundColor = RGBA(251, 88, 1, 0.3);
    
    _lblCommission.textColor = UIColor.whiteColor;
    _lblCommission.font = kFONT12;
    _lblCommission.textAlignment = NSTextAlignmentCenter;
    
    _lblPeople.textColor = RGB(51, 51, 51);
    _lblPeople.font = kFONT12;
    
    _lblDistance.textColor = RGB(51, 51, 51);
    _lblDistance.font = kFONT12;
    
    _vLine.backgroundColor = RGB(240, 240, 240);
    
    _lblLocation.textColor = RGB(51, 51, 51);
    _lblLocation.font = kFONT12;
    
    _lblPrice.textColor = RGB(51, 51, 51);
    _lblPrice.font = kFONT12;
    
    _lblTime.textColor = RGB(51, 51, 51);
    _lblTime.font = kFONT12;
    
    for (NSInteger index = 0; index < 5; index++) {
        UIImageView *imgStar = [[UIImageView alloc] init];
        [_vStars addSubview:imgStar];
        [_stars addObject: imgStar];
        [imgStar mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(_stars[index - 1].mas_right).offset(2);
            }
            make.width.height.mas_equalTo(10);
            make.centerY.equalTo(@0);
        }];
    }
    
}
-(void)setDicModel:(NSDictionary *)dicModel{
    _dicModel=dicModel;
    if(dicModel){
        FNStoreThendNeModel *model=[FNStoreThendNeModel mj_objectWithKeyValues:dicModel];
        [self.imgStore setUrlImg:model.img];
        self.lblName.text = model.name;
        self.lblDistance.text = model.distance;
        self.lblLocation.text = model.district_str;
        self.lblPrice.text = model.str2;
        self.lblPeople.text = model.visitor;
        self.lblCommission.text = model.str;
        self.lblTime.text = model.open_time_str;
        self.lblTime.textColor = [UIColor colorWithHexString: model.open_time_color];
        [self.imgTime sd_setImageWithURL:URL(model.open_time_icon)];
        
        int count = model.average_star.intValue;
        for (NSInteger index = 0; index < _stars.count; index++) {
            if (index < count) {
                [_stars[index] sd_setImageWithURL: URL(model.good_star)];
            } else {
                [_stars[index] sd_setImageWithURL: URL(model.bad_star)];
            }
        }
    }
    [self.contentView layoutIfNeeded];
}

- (void)setIsLeft: (BOOL) isLeft {
    if (isLeft) {
        [_vBackground mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 10, 0, 5));
        }];
    } else {
        [_vBackground mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 5, 0, 10));
        }];
    }
}

@end
