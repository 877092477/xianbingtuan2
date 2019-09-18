//
//  FNmerMembersUsersCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerMembersUsersCell.h"

@implementation FNmerMembersUsersCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.headImg=[[UIImageView alloc]init];
    [self addSubview:self.headImg];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.nameLB.font=[UIFont systemFontOfSize:16];
    self.nameLB.textColor=[UIColor whiteColor];
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.headImg.sd_layout
    .leftSpaceToView(self, 20).topSpaceToView(self, SafeAreaTopHeight+15).widthIs(40).heightIs(40);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImg, 15).centerYEqualToView(self.headImg).rightSpaceToView(self, 30).heightIs(20);
    
    self.headImg.borderWidth=2;
    self.headImg.borderColor = [UIColor whiteColor];
    self.headImg.cornerRadius=20;
    self.headImg.clipsToBounds = YES;
    
}
@end
