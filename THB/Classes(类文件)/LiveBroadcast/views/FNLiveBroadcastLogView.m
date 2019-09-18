//
//  FNLiveBroadcastLogView.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveBroadcastLogView.h"
#import "FNLiveBroadcastLogCell.h"

@interface FNLiveBroadcastLogView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tbvLog;

@property (nonatomic, strong) NSMutableArray *logs;
@property (nonatomic, strong) NSMutableArray *imgs;
@property (nonatomic, strong) NSMutableArray *icons;

@property (nonatomic, strong) FNLiveBroadcastLogCellView *bottomView ;

@end

@implementation FNLiveBroadcastLogView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _logs = [[NSMutableArray alloc] init];
        _imgs = [[NSMutableArray alloc] init];
        _icons = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _tbvLog = [[UITableView alloc] init];
    [self addSubview:_tbvLog];
    [_tbvLog mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    _tbvLog.dataSource = self;
    _tbvLog.delegate = self;
    [_tbvLog registerClass:[FNLiveBroadcastLogCell class] forCellReuseIdentifier:@"FNLiveBroadcastLogCell"];
    _tbvLog.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tbvLog.showsVerticalScrollIndicator = NO;
    _tbvLog.showsHorizontalScrollIndicator = NO;
    _tbvLog.scrollEnabled = NO;
    _tbvLog.backgroundColor = UIColor.clearColor;
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _logs.count;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FNLiveBroadcastLogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNLiveBroadcastLogCell"];
    NSInteger index = 3 - _logs.count;
    if (indexPath.row < index) {
        cell.hidden = YES;
    } else  {
        
        cell.hidden = NO;
//        [cell setLog:_logs[indexPath.row - index] withImgUrl:_imgs[indexPath.row - index] alpha:((indexPath.row + 1) / 4.0)];
        [cell setLog:_logs[indexPath.row - index] withTypeImg:_imgs[indexPath.row - index] rightImg:_icons[indexPath.row - index] alpha:((indexPath.row + 1) / 4.0)];
    }
    
    return cell;
}

- (void)appendLog: (NSString*)log withImage: (NSString*)imgUrl icon: (NSString*)iconUrl {
    
    if (_bottomView == nil) {
        _bottomView = [[FNLiveBroadcastLogCellView alloc] init];
        [self addSubview:_bottomView];
    }
    [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.mas_bottom);
    }];
    [_bottomView setLog:log withTypeImg:imgUrl rightImg:iconUrl alpha:1];

    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    
    [self.tbvLog reloadData];
    
    
    [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self setNeedsLayout];
    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        
        [self.logs addObject:log];
        [self.imgs addObject:imgUrl];
        [self.icons addObject:iconUrl];
        if (self.logs.count > 3) {
            [self.logs removeObjectAtIndex:0];
            [self.imgs removeObjectAtIndex:0];
            [self.icons removeObjectAtIndex:0];
        }
        
    }];
}

-(UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView* tmpView = [super hitTest:point withEvent:event];
    
    if (tmpView.superview == self) {
        return nil;
    }
    return tmpView;
    
}

@end
