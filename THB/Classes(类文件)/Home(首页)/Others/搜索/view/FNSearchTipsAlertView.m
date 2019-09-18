//
//  FNSearchTipsAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNSearchTipsAlertView.h"

@interface FNSearchTipsAlertView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tbvTips;

@property (nonatomic, strong) NSMutableArray<NSString*> *tips;

@end

@implementation FNSearchTipsAlertView

- (NSMutableArray<NSString*>*) tips {
    if (_tips == nil) {
        _tips = [[NSMutableArray alloc] init];
    }
    
    return _tips;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _tbvTips = [[UITableView alloc] init];
    [self addSubview:_tbvTips];
    [_tbvTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    _tbvTips.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tbvTips.backgroundColor=[UIColor whiteColor];
    _tbvTips.dataSource = self;
    _tbvTips.delegate = self;
    _tbvTips.showsVerticalScrollIndicator = NO;
    _tbvTips.showsHorizontalScrollIndicator = NO;
    [_tbvTips registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark -  UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tips.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.tips[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *tip = self.tips[indexPath.row];
    if ([_delegate respondsToSelector:@selector(didTipsSelect:)]) {
        [_delegate didTipsSelect:tip];
    }
}

- (void)showTips: (NSString*)keyword SkipUIIdentifier: SkipUIIdentifier {
    
    [self requestTips: keyword SkipUIIdentifier: SkipUIIdentifier];
}

- (void)dismiss {
    self.hidden = YES;
}


#pragma mark - Networking
- (void)requestTips: (NSString*)keyword SkipUIIdentifier: (NSString*) SkipUIIdentifier; {
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"keyword": keyword, @"SkipUIIdentifier": SkipUIIdentifier}];
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_keyword&ctrl=getKeyword" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        self.hidden = NO;
        [self.tips removeAllObjects];
        for (NSDictionary *dict in respondsObject) {
            NSString *title = dict[@"title"];
            [self.tips addObject: title];
        }
        
        [self.tbvTips reloadData];

    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:NO];
}

@end
