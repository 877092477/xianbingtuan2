//
//  JMInvitedRankingView.m
//  THB
//
//  Created by jimmy on 2017/4/7.
//  Copyright © 2017年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "JMInvitedRankingView.h"
#import "FNSectionHeaderView.h"
#import "JMInviteFriendModel.h"
static NSString* const _cell_desFormmat = @"已获%@元返利";
static  CGFloat  const _cell_imgHeight = 40.0;
static NSString* const _zero = @"0";
@interface JMInvitedRankingListCell : UITableViewCell
@property (nonatomic, weak) UIImageView* rankImgView;
@property (nonatomic, weak) UILabel* rankLabel;
@property (nonatomic, weak) UIImageView* avatarImgView;
@property (nonatomic, weak) UILabel* nameLabel;
@property (nonatomic, weak) UILabel* desLabel;
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)JMInviteFriendRankingModel* model;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
@implementation JMInvitedRankingListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    UIImageView* rankImgview = [UIImageView new];
    rankImgview.image = IMAGE(@"invite_list_gold");
    [rankImgview sizeToFit];
    [self.contentView addSubview:rankImgview];
    _rankImgView = rankImgview;
    
    UILabel* rankLabel = [UILabel new];
    rankLabel.font = [UIFont boldSystemFontOfSize:25];
    [self.contentView addSubview:rankLabel];
    _rankLabel = rankLabel;
    
    UIImageView* avatarImgView = [UIImageView new];
    avatarImgView.cornerRadius = _cell_imgHeight*0.5;
    [self.contentView addSubview:avatarImgView];
    _avatarImgView = avatarImgView;
    
    UILabel* nameLabel = [UILabel new];
    nameLabel.textColor = FNColor(74, 44, 12);
    nameLabel.font = kFONT12;
    [self.contentView addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    
    UILabel* desLabel = [UILabel new];
    desLabel.font = kFONT12;
    desLabel.text = [NSString stringWithFormat:_cell_desFormmat,_zero];
    [self.contentView addSubview:desLabel];
    _desLabel = desLabel;
    
    //layout
    [_rankImgView autoSetDimensionsToSize:(_rankImgView.size)];
    [_rankImgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
    [_rankImgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_rankLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:_rankImgView];
    [_rankLabel autoAlignAxis:(ALAxisVertical) toSameAxisOfView:_rankImgView];
    [_rankLabel autoSetDimension:(ALDimensionWidth) toSize:_rankImgView.width relation:(NSLayoutRelationLessThanOrEqual)];
    
    [_avatarImgView autoSetDimensionsToSize:(CGSizeMake(_cell_imgHeight, _cell_imgHeight))];
    [_avatarImgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_avatarImgView autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_rankImgView withOffset:5];
    
    [_nameLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_avatarImgView withOffset:5];
    [_nameLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_desLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
    
}
- (void)setModel:(JMInviteFriendRankingModel *)model{
    _model = model;
    if (_model) {
        _nameLabel.text = _model.nickname;
//        _desLabel.text = [NSString stringWithFormat:_cell_desFormmat,_model.commission_sum];
        _desLabel.text = _model.yqfl_mxwz;
        NSMutableAttributedString* att = [[NSMutableAttributedString alloc]initWithString:_desLabel.text];
        [att addAttribute:NSForegroundColorAttributeName value:RED range:[_desLabel.text rangeOfString:_model.commission_sum]];
        _desLabel.attributedText  = att;
        [_avatarImgView setUrlImg:_model.head_img];
        if (_model.num.integerValue <= 3) {
            if (_model.num.integerValue == 1) {
                _rankImgView.image = IMAGE(@"invite_list_gold");
            }
            if (_model.num.integerValue == 2) {
                _rankImgView.image = IMAGE(@"invite_list_silver");
            }
            if (_model.num.integerValue == 3) {
                _rankImgView.image = IMAGE(@"invite_list_copper");
            }
            _rankImgView.hidden = NO;
            _rankLabel.hidden = YES;
        }else{
            _rankImgView.hidden = YES;
            _rankLabel.hidden = NO;
            _rankLabel.text = _model.num;
        }
    }
    
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"JMInvitedRankingListCell";
    JMInvitedRankingListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[JMInvitedRankingListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}

@end
@interface JMInvitedRankingView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak)UIImageView* bgImgView;

@property (nonatomic, strong)FNSectionHeaderView* footerView;
@property (nonatomic, strong) NSLayoutConstraint* listHeightCons;
@property (nonatomic, assign)CGFloat rate;
@end
@implementation JMInvitedRankingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    UIImageView* bgImgView = [UIImageView new];
    bgImgView.image =IMAGE(@"invite_list_bj1");
    [bgImgView sizeToFit];
    self.rate = bgImgView.width/bgImgView.height;
    [self addSubview:bgImgView];
    _bgImgView = bgImgView;
    
    _footerView  =[[FNSectionHeaderView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth-2*_jm_leftMargin, 40))];
    _footerView.titleLabel.text = @"每日0点准时更新榜单";
    _footerView.titleLabel.textColor = FNGlobalTextGrayColor;
    _footerView.titleLabel.textAlignment = NSTextAlignmentCenter;
    _footerView.backgroundColor = FNWhiteColor;
    
    UITableView* listTableView = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    listTableView.cornerRadius = 15;
    listTableView.dataSource =self;
    listTableView.delegate = self;
    listTableView.backgroundColor  = [UIColor clearColor];
    listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    listTableView.tableFooterView = _footerView;
    [self addSubview:listTableView];
    _listTableView =listTableView;
    
    //layout
    [_bgImgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    
    [_listTableView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
    [_listTableView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
    [_listTableView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:_bgImgView withOffset:_jm_leftMargin*2];
    _listHeightCons = [_listTableView autoSetDimension:(ALDimensionHeight) toSize:5*60+40];
    
    [_bgImgView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_listTableView withOffset:_jm_leftMargin];
    [self layoutIfNeeded];
    self.height = CGRectGetMaxY(_bgImgView.frame);
    self.viewHeight = CGRectGetMaxY(_bgImgView.frame);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.phb.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JMInvitedRankingListCell* cell = [JMInvitedRankingListCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.model = self.model.phb[indexPath.row];
    return  cell;
}


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 60;
    return height;
}
- (void)setModel:(JMInviteFriendModel *)model{
    _model = model;
    if (_model) {
        if (self.model.phb.count < 5) {
            self.hidden = NO;
            CGFloat height = 60*self.model.phb.count + 40;
            CGFloat tmp = (FNDeviceWidth-_jm_margin10*2)/self.rate - _jm_leftMargin*3;
            if (height< tmp) {
                height = tmp;
            }
            self.listHeightCons.constant = height;
            [self layoutIfNeeded];
            self.height = CGRectGetMaxY(_bgImgView.frame);
            self.viewHeight = CGRectGetMaxY(_bgImgView.frame);
            if (self.changeHeight) {
                self.changeHeight(self.viewHeight);
            }
            
        }
        NSString* flag = [FNBaseSettingModel settingInstance].app_invitation_list_onoff;
        if (self.model.phb.count == 0 || !flag.boolValue) {
            self.hidden = YES;
            self.listHeightCons.constant = 60*self.model.phb.count + 40;
            self.height = 0;
            self.viewHeight = 0;
            if (self.changeHeight) {
                self.changeHeight(self.viewHeight);
            }
        }
        [self.listTableView reloadData];
        self.footerView.titleLabel.text = self.model.str5;
    }
}
@end
