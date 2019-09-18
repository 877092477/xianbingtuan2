//
//  FNIntergralMallDetailRecordCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNIntergralMallDetailRecordCell.h"

@interface FNIntergralMallRecordCell: UITableViewCell

@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation FNIntergralMallRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void) configUI {
    _lblTitle = [[UILabel alloc] init];
    [self.contentView addSubview:_lblTitle];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.lessThanOrEqualTo(@-10);
        //        make.top.bottom.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    
    _lblTitle.textColor = RGB(60, 60, 60);
    _lblTitle.font = kFONT12;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end


@interface FNIntergralMallDetailRecordCell() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIView *vTop;
@property (nonatomic, strong) UIView *vBottom;
@property (nonatomic, strong) UITableView *tbvRecords;

@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UILabel *lblGoods;
@property (nonatomic, strong) UIImageView *imgRight;

@property (nonatomic, strong) NSArray<NSString*> *records;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end

@implementation FNIntergralMallDetailRecordCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)dealloc
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void) configUI {
    self.vBackground = [[UIView alloc] init];
    self.vBottom = [[UIView alloc] init];
    self.vTop = [[UIView alloc] init];
    self.imgRecord = [[UIImageView alloc] init];
    self.tbvRecords = [[UITableView alloc] init];
    self.vLine = [[UIView alloc] init];
    self.lblGoods = [[UILabel alloc] init];
    self.imgRight = [[UIImageView alloc] init];
    
    [self.contentView addSubview:self.vBackground];
    [self.vBackground addSubview:self.vTop];
    [self.vBackground addSubview:self.vBottom];
    [self.vTop addSubview:self.imgRecord];
    [self.vTop addSubview:self.tbvRecords];
    [self.vBackground addSubview:self.vLine];
    [self.vBottom addSubview:self.lblGoods];
    [self.vBottom addSubview:self.imgRight];
    
    [self.vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 0, 0, 0));
        make.width.mas_equalTo(XYScreenWidth);
    }];
    [self.vTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
//        make.bottom.equalTo(self.vBackground.mas_centerY);
        make.height.mas_equalTo(44);
    }];
    [self.vBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
//        make.top.equalTo(self.vBackground.mas_centerY);
        make.top.equalTo(self.vTop.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    [self.imgRecord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.centerY.equalTo(@0);
        make.height.mas_offset(15);
        make.width.mas_offset(56);
    }];
    [self.tbvRecords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgRecord.mas_right).offset(4);
        make.right.equalTo(@-20);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(@0);
    }];
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    [self.lblGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.centerY.equalTo(@0);
        make.bottom.equalTo(@-16);
        make.right.lessThanOrEqualTo(self.imgRight.mas_left).offset(-10);
    }];
    [self.imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-16);
        make.centerY.equalTo(@0);
    }];
    
    self.backgroundColor = UIColor.clearColor;
    self.vBackground.backgroundColor = UIColor.whiteColor;
    
//    self.imgRecord.image = IMAGE(@"integral_mall_image_record");
    self.imgRecord.contentMode = UIViewContentModeScaleAspectFill;
    
    self.vLine.backgroundColor = FNHomeBackgroundColor;
    
    self.lblGoods.text = @"商品选择";
    self.lblGoods.textColor = RGB(24, 24, 24);
    self.lblGoods.font = kFONT14;
    
    self.imgRight.image = IMAGE(@"issue_right");
    
    self.tbvRecords.delegate = self;
    self.tbvRecords.dataSource = self;
    self.tbvRecords.separatorStyle = NSUnderlineStyleNone;
    self.tbvRecords.scrollEnabled = NO;
    [self.tbvRecords registerClass:[FNIntergralMallRecordCell class] forCellReuseIdentifier:@"FNIntergralMallRecordCell"];
    
    @weakify(self);
    [self.vBottom addJXTouch:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(didGoodsClick:)]) {
            [self.delegate didGoodsClick:self];
        }
    }];
    
    self.timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timeSchedule) userInfo:nil repeats:YES];
    
}

- (void)timeSchedule {
    if (self.currentIndexPath) {
        NSInteger row = (self.currentIndexPath.row + 1) % self.records.count;
        self.currentIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self.tbvRecords scrollToRowAtIndexPath:self.currentIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)setRecords: (NSArray<NSString*>*)records {
    _records = records;
    if (records.count > 0)
        _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    else
        _currentIndexPath = nil;
    [self.tbvRecords reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [[UITableViewCell alloc] init];
    FNIntergralMallRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNIntergralMallRecordCell"];
    cell.lblTitle.text = self.records[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20;
}

@end
