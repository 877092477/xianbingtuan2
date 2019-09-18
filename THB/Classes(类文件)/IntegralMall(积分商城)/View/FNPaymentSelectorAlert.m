//
//  FNPaymentSelectorAlert.m
//  THB
//
//  Created by Weller Zhao on 2019/1/10.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNPaymentSelectorAlert.h"

@interface FNPaymentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNPaymentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.imgIcon = [[UIImageView alloc] init];
    self.lblName = [[UILabel alloc] init];
    self.vLine = [[UIView alloc] init];
    
    [self.contentView addSubview:self.imgIcon];
    [self.contentView addSubview:self.lblName];
    [self.contentView addSubview:self.vLine];
    
    @weakify(self);
    [self.imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.width.height.mas_equalTo(18);
        make.centerY.equalTo(@0);
    }];
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self_weak_.imgIcon.mas_right).offset(12);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
    self.imgIcon.contentMode = UIViewContentModeScaleAspectFit;
    self.lblName.textColor = RGB(60, 60, 60);
    self.lblName.font = kFONT14;
    
    self.vLine.backgroundColor = RGB(245, 245, 245);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end


@interface FNPaymentSelectorAlert() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIView *vContent;

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSArray<NSString*>* titles;
@property (nonatomic, strong) NSArray<NSString*>* imageUrls;

@property (nonatomic, strong) OnItemSelected block;

@end

@implementation FNPaymentSelectorAlert

#define CellHeight 44

+(instancetype) shareInstance
{
    static dispatch_once_t once;
    
    static FNPaymentSelectorAlert* instance = nil;
    dispatch_once(&once, ^ {
        instance = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
    });
    
    return instance ;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
//        [SVProgressHUD show];
    }
    return self;
}

- (void) configUI {
    self.vBackground = [[UIView alloc] init];
    self.vContent = [[UIView alloc] init];
    self.lblTitle = [[UILabel alloc] init];
    self.tableview = [[UITableView alloc] init];
    
    [self addSubview:self.vBackground];
    [self addSubview:self.vContent];
    [self.vContent addSubview:self.lblTitle];
    [self.vContent addSubview:self.tableview];
    
    [self.vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
        make.height.lessThanOrEqualTo(@-80);
    }];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.centerX.equalTo(@0);
        make.top.equalTo(@20);
        make.height.mas_equalTo(16);
    }];
    @weakify(self)
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@-20);
        make.top.equalTo(self_weak_.lblTitle.mas_bottom).offset(20);
        make.height.mas_greaterThanOrEqualTo(CellHeight);
    }];
    
    self.vBackground.backgroundColor = RGBA(0, 0, 0, 0.3);
    
    self.vContent.backgroundColor = UIColor.whiteColor;
    
    self.lblTitle.text = @"支付方式";
    self.lblTitle.font = kFONT14;
    self.lblTitle.textColor = RGB(24, 24, 24);
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.rowHeight = CellHeight;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerClass:[FNPaymentCell class] forCellReuseIdentifier:@"FNPaymentCell"];
    self.tableview.bounces = NO;
    
    [self.vBackground addJXTouch:^{
        [FNPaymentSelectorAlert dismiss];
    }];
    
    [self setHidden: YES];
}

+ (void) show: (NSArray<NSString*>*) titles withImagesUrls: (NSArray<NSString*>*)imagesUrls onItemSelected: (OnItemSelected) block {
    if (titles.count != imagesUrls.count)
        return;
    [FNPaymentSelectorAlert shareInstance].titles = titles;
    [FNPaymentSelectorAlert shareInstance].imageUrls = imagesUrls;
    [FNPaymentSelectorAlert shareInstance].block = block;
    [[FNPaymentSelectorAlert shareInstance].tableview reloadData];
    
    [[FNPaymentSelectorAlert shareInstance].tableview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CellHeight * titles.count);
    }];
    
    if (![FNPaymentSelectorAlert shareInstance].isHidden)
        return;
    [[FNPaymentSelectorAlert shareInstance] removeFromSuperview];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:[FNPaymentSelectorAlert shareInstance]];
    [[FNPaymentSelectorAlert shareInstance] setHidden:NO];
}

+ (void) dismiss {
    
    [[FNPaymentSelectorAlert shareInstance] setHidden: YES];
    [[FNPaymentSelectorAlert shareInstance] removeFromSuperview];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FNPaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNPaymentCell"];
    cell.lblName.text = self.titles[indexPath.row];
    [cell.imgIcon sd_setImageWithURL:URL(self.imageUrls[indexPath.row])];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([FNPaymentSelectorAlert shareInstance].block)
        [FNPaymentSelectorAlert shareInstance].block(indexPath.row);
}



@end
