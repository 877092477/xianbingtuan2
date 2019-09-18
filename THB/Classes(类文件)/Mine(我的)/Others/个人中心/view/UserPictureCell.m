//
//  UserPictureCell.m
//  FnuoApp
//
//  Created by zhongxueyu on 16/3/5.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "UserPictureCell.h"
#import "XYTakePhoto.h"
@implementation UserPictureCell

- (void)awakeFromNib {
    
    //将头像设成圆形
    self.userImg.layer.cornerRadius = self.userImg.bounds.size.width/2;;
    self.userImg.layer.masksToBounds = YES;

    //添加下方分割线
    UIImageView *lineImg=[[UIImageView alloc] initWithFrame:CGRectMake(0, self.contentView.bounds.size.height, XYScreenWidth, 1)];
    
    lineImg.image = IMAGE(@"member_line1");
    [self.contentView addSubview:lineImg];
    
    lineImg.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(XYScreenWidth)
    .heightIs(1);
    
    UITapGestureRecognizer *tapNewview=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImgView:)];
    [self.userImg addGestureRecognizer:tapNewview];
    
    [self setupAutoHeightWithBottomView:lineImg bottomMargin:0];
}

-(void)tapImgView:(UIGestureRecognizer*)sender
{
    [XYTakePhoto sharePicture:^(UIImage *HeadImage){
        
        
        NSData *temp=UIImageJPEGRepresentation(HeadImage ,0.4f);
        NSString * tempBase64  =[temp base64Encoding];
        XYLog(@"image %@",tempBase64);
//        [[NSUserDefaults standardUserDefaults] setValue:HeadImage forKey:XYhead_img];
        XYLog(@"HeadImage is %@",HeadImage);
        self.userImg.image = HeadImage;
        [self postUserInfo:tempBase64];
        
    }];
   
}
-(void)postUserInfo:(NSString *)base64{
    if (base64) {
        NSMutableDictionary* params= [NSMutableDictionary dictionaryWithDictionary:@{
                 @"time":[NSString GetNowTimes],
                 @"token":UserAccessToken,
                 @"img":base64
                 }];
        params[SignKey] = [NSString getSignStringWithDictionary:params];
        [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_mine_updateUser successBlock:^(id responseBody) {
            NSDictionary *dict = responseBody;
            XYLog(@"responseBody2 is %@",responseBody);
            if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
                
                
                [FNTipsView showTips:@"保存成功"];
                NSNotification *notification =[NSNotification notificationWithName:@"EditProfile" object:nil userInfo:nil];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
            }else
            {
                [XYNetworkAPI queryFinishTip:dict];
                [XYNetworkAPI cancelAllRequest];
            }
            
            
        } failureBlock:^(NSString *error) {
            [SVProgressHUD dismiss];
            [XYNetworkAPI cancelAllRequest];
        }];
    }else{
        [FNTipsView showTips:@"更换头像失败了~"];
    }
   
    
    
}



@end
