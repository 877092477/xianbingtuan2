//
//  JMViewModel.m
//  SuperMode
//
//  Created by jimmy on 2017/6/8.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"

@implementation JMViewModel
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    JMViewModel* viewmodel = [super allocWithZone:zone];
    if (viewmodel) {
        [viewmodel jm_initialize];
        viewmodel.jm_page = 1;
    }
    return viewmodel;
}
- (instancetype)initWithModel:(id)model
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)jm_initialize{
}

#pragma mark - setter && getter
- (RACSubject *)refreshUI{
    if (_refreshUI == nil) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}
- (RACSubject *)refreshEndSubject{
    if (_refreshEndSubject == nil) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}
- (RACSubject *)cellClickSubject{
    if (_cellClickSubject == nil) {
        
        _cellClickSubject = [RACSubject subject];
    }
    
    return _cellClickSubject;
}
- (RACCommand *)refreshDataCommand{
    if (_refreshDataCommand == nil) {
        @weakify(self);
        _refreshDataCommand =[ [RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            NSLog(@"fdfdf");
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                if (self.observingRefreshDataCommand) {
                    return self.observingRefreshDataCommand(subscriber,input);
                } else {
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                    return nil;
                }
            }];
        }];
    }
    return _refreshDataCommand;
}
- (RACCommand *)refreshFooterCommand{
    if (_refreshFooterCommand == nil) {
        @weakify(self);
        _refreshFooterCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            //
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //网络请求
                @strongify(self);
                if (self.observingRefreshFooterCommand) {
                    return self.observingRefreshFooterCommand(subscriber, input);
                } else {
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                    return nil;
                }
            }];
        }];
    }
    return _refreshFooterCommand;
}
@end
