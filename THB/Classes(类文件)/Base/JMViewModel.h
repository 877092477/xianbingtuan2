//
//  JMViewModel.h
//  SuperMode
//
//  Created by jimmy on 2017/6/8.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMViewModelProtocol.h"
@class RACSubscriber;
@interface JMViewModel : NSObject<JMViewModelProtocol>
@property (nonatomic, assign)NSInteger jm_page;

@property (nonatomic, strong) RACSubject *refreshEndSubject;

@property (nonatomic, strong) RACSubject *refreshUI;

@property (nonatomic, strong) RACSubject *cellClickSubject;

@property (nonatomic, strong)RACCommand* refreshDataCommand;
@property (nonatomic, copy)RACDisposable * (^observingRefreshDataCommand)(id<RACSubscriber> subscriber,id input);

@property (nonatomic, strong)RACCommand* refreshFooterCommand;
@property (nonatomic, copy)RACDisposable * (^observingRefreshFooterCommand)(id<RACSubscriber> subscriber,id input);

@end
