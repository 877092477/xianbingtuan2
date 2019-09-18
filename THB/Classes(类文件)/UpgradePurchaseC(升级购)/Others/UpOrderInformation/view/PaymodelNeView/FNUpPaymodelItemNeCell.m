//
//  FNUpPaymodelItemNeCell.m
//  THB
//
//  Created by Jimmy on 2018/9/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpPaymodelItemNeCell.h"

@implementation FNUpPaymodelItemNeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubView];
    }
    return self;
}
- (void)createSubView{
    
    _iconImgView = [[UIImageView alloc]init];
    [self.contentView addSubview:_iconImgView];
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = kFONT14;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImgView.mas_right).offset(10);
        make.top.mas_equalTo(10);
        make.centerY.equalTo(self);
    }];
    
    _stateView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pay_normal"]];
    [self.contentView addSubview:_stateView];
    [_stateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _desLabel = [[UILabel alloc]init];
    _desLabel.textColor = [UIColor grayColor];
    _desLabel.font = kFONT10;
    [self.contentView addSubview:_desLabel];
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.stateView.mas_left).offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(25);
        make.height.mas_equalTo(20);
    }];
    UILabel* lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor =FNColor(240, 240, 240);
    lineLabel.frame=CGRectMake(0, 0, FNDeviceWidth, 1);
    [self.contentView addSubview:lineLabel];
    
    /*_iconImgView.image=[UIImage imageNamed:@"APP底图"];
    _stateView.image=[UIImage imageNamed:@"APP底图"];
    _titleLabel.text=@"支付宝";
    _desLabel.text=@"21.47元";*/
    
}

-(void)setModel:(id)model{
    _model=model;
}
@end
