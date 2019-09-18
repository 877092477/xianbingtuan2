//
//  MsgDetailViewController.m
//  THB
//
//  Created by zhongxueyu on 16/5/4.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "MsgDetailViewController.h"

@interface MsgDetailViewController ()

@end

@implementation MsgDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self loadMyMsgDataMethod];
    self.msgContent.text = self.msgDetails;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark 获取数据
-(void)loadMyMsgDataMethod
{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"token":UserAccessToken,
                                                                                 @"id":self.msgId,
                                                                                 @"type":self.type              }];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_getMsgDetail successBlock:^(id responseBody) {
        
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            NSArray *tempArray = [dict objectForKey:XYData];
            NSString *msg = [NSString stringWithFormat:@"%@",[tempArray valueForKey:@"msg"][0]];
            XYLog(@"MyjsonData is %@",msg);
            self.msgContent.text = [tempArray valueForKey:@"msg"][0];
            self.title = [tempArray valueForKey:@"title"][0];
            
            [SVProgressHUD dismiss];
            
            
        }else{
            
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
        
    }];
    
}
@end
