//
//  FNIndexSelectorView.m
//  THB
//
//  Created by Weller Zhao on 2019/1/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNIndexSelectorView.h"

@interface FNIndexSelectorCell: UITableViewCell

@property (nonatomic, strong) UILabel *label;

@end

@implementation FNIndexSelectorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.label = [[UILabel alloc] init];
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.width.mas_greaterThanOrEqualTo(10);
        make.center.equalTo(@0);
    }];
    
    self.label.textColor = RGB(156, 156, 156);
    self.label.font = kFONT10;
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = UIColor.clearColor;
    self.backgroundColor = UIColor.clearColor;
}

- (void)setSelected:(BOOL)selected {
    
}

@end

@interface FNIndexSelectorView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString*>* titles;

@end

@implementation FNIndexSelectorView

#define RowHeight  12

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.tableView = [[UITableView alloc] init];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = RowHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColor.clearColor;
    [self.tableView setScrollEnabled:NO];
    [self.tableView registerClass:[FNIndexSelectorCell class] forCellReuseIdentifier:@"FNIndexSelectorCell"];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlerPanFrom:)];
    [self addGestureRecognizer:pan];
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles == nil ? 0 : _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FNIndexSelectorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNIndexSelectorCell"];
    cell.label.text = _titles[indexPath.row];

    return cell;
}

-(void)setTitles: (NSArray<NSString*>*)titles {
    _titles = titles;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerY.equalTo(@0);
        make.top.greaterThanOrEqualTo(@0);
        make.bottom.lessThanOrEqualTo(@0);
        make.height.mas_equalTo(RowHeight * titles.count).priorityLow();
    }];
    [self.tableView reloadData];
}

#pragma mark TouchEvent

- (void)handlerPanFrom:(UIPanGestureRecognizer *)recognizer{
    CGPoint location = [recognizer locationInView:self.tableView];
    location.x = location.x < 0 ? 0 : location.x;
    location.x = location.x > self.tableView.width ? self.tableView.width : location.x;
    location.y = location.y < 0 ? 0 : location.y;
    location.y = location.y > self.tableView.height ? self.tableView.height - 1 : location.y;
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self moveHandTo:indexPath];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self moveHandTo:indexPath];
    } else if (recognizer.state == UIGestureRecognizerStateEnded ||
               recognizer.state == UIGestureRecognizerStateFailed ||
               recognizer.state == UIGestureRecognizerStateCancelled) {
        if ([self.delegate respondsToSelector:@selector(selectorViewDidCancle:)]) {
            [self.delegate selectorViewDidCancle:self];
        }
    }

    
    
}

#pragma mark -
- (void) moveHandTo:(NSIndexPath*) indexPath {
    NSLog(@"%ld", indexPath.row);
    NSLog(@"%@", self.titles[indexPath.row]);
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    if ([self.delegate respondsToSelector:@selector(selectorView:didSelectedAt:)]) {
        [self.delegate selectorView:self didSelectedAt:indexPath.row];
    }
}

@end
