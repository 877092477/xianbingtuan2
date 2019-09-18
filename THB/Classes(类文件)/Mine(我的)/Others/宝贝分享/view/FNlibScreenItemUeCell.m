//
//  FNlibScreenItemUeCell.m
//  THB
//
//  Created by 李显 on 2019/1/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNlibScreenItemUeCell.h"

@implementation FNlibScreenItemUeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{ 
    self.nameLB=[UILabel new];
    self.nameLB.font=kFONT12;
    self.nameLB.textColor=RGB(130, 130, 130);
    [self addSubview:self.nameLB];
    
    self.sortImageView=[UIImageView new];
    self.sortImageView.hidden=YES;
    [self addSubview:self.sortImageView];
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).centerYEqualToView(self).heightIs(35);
    
    
    
}
-(void)setModel:(FNSomeGoodsCateModel *)model{
    _model=model;
    if(model){
        NSString *addType=model.addType;
        if([addType isEqualToString:@"sort"]){
          self.sortImageView.hidden=NO;
          self.nameLB.text=model.name;
          self.nameLB.textAlignment=NSTextAlignmentLeft;
          self.sortImageView.image=IMAGE(@"FS_grayPX_img");
          CGFloat nameW=[self getWidthWithText:self.nameLB.text height:35 font:12];
          self.nameLB.sd_layout
          .leftSpaceToView(self, 50).rightSpaceToView(self, 0).centerYEqualToView(self).heightIs(35);
          self.sortImageView.sd_layout
          .leftSpaceToView(self, nameW +60).centerYEqualToView(self.nameLB).widthIs(10).heightIs(10);
        }
        if([addType isEqualToString:@"cate"]){
          self.sortImageView.hidden=YES;
          self.nameLB.text=model.category_name;
          self.nameLB.textAlignment=NSTextAlignmentCenter;
          self.nameLB.sd_layout
          .leftSpaceToView(self, 0).rightSpaceToView(self, 0).centerYEqualToView(self).heightIs(35);
        }
    }
}

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
@end
