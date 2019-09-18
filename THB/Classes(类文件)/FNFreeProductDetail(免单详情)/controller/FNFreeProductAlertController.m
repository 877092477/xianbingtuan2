//
//  FNFreeProductAlertController.m
//  THB
//
//  Created by Weller Zhao on 2019/1/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNFreeProductAlertController.h"


@implementation FNFreeProductAlertController

-(NSString*) url {
    return FNBaseSettingModel.settingInstance.miandan_show_url;
}


#pragma mark - Web view delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"webView will load %@",request.URL);
    NSLog(@"navtype is %ld",(long)navigationType);
    NSString *url = request.URL.absoluteString;
    if ([url containsString:@"mod=appapi&act=miandan_course&ctrl=close"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    else {
        return YES;
    }
}

@end
