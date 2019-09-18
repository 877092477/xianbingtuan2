//
//  EvaluateFrame.m
//  THB
//
//  Created by Jimmy on 2018/8/31.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

//评价cell高度
#import "EvaluateFrame.h"

@implementation EvaluateFrame

-(void)setModel:(EvaluateModel *)model{
    _model = model;
    NSString *replyString=@"回复";
    NSString *contentString=@"";
    NSString *as_nicknamestring=_model.as_nickname;
    if([as_nicknamestring kr_isNotEmpty]){
        as_nicknamestring=[NSString stringWithFormat:@"%@:",as_nicknamestring];
        contentString=[NSString stringWithFormat:@"%@%@%@",replyString,as_nicknamestring,_model.content];
    }else{
        contentString=[NSString stringWithFormat:@"%@",_model.content];
    }
    CGFloat contentW = FNDeviceWidth - 105;
    CGSize conSize = [contentString sizeWithFont:[UIFont fontWithDevice:12] constrainedToSize:CGSizeMake(contentW, MAXFLOAT)];
    
    self.cellHeight = conSize.height + 10 + 36;
}
@end
