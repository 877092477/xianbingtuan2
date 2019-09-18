//
//  FNsiteNorNaCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNsiteNorNaCell.h"

@implementation FNsiteNorNaCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    
    // 编辑
    self.nurButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.nurButton.titleLabel.font=kFONT12;
    //[self.nurButton addTarget:self action:@selector(compileAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.nurButton];
    
}

@end
