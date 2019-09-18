//
//  FNMakeTaskTCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMakeTaskTCell.h"

@implementation FNMakeTaskTCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNMakeTaskTCellID";
    FNMakeTaskTCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews{
    self.bgView=[[UIView alloc]init];
    self.bgImgView=[[UIImageView alloc]init];
    self.titleLB=[[UILabel alloc]init];
    self.rightLB=[[UILabel alloc]init];
    self.line=[[UIView alloc]init];
    [self addSubview:self.bgView];
    [self addSubview:self.bgImgView];
    [self addSubview:self.titleLB];
    [self addSubview:self.rightLB];
    [self addSubview:self.line];
    
    self.bgImgView.contentMode=UIViewContentModeScaleToFill;
    
    self.titleLB.font=kFONT15;
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    self.rightLB.font=kFONT12;
    self.rightLB.textColor=RGB(153, 153, 153);
    self.rightLB.textAlignment=NSTextAlignmentRight;
    self.line.backgroundColor=RGB(247, 246, 249);
    
    
    self.listView=[[FNmakeTakeListView alloc]initWithFrame:CGRectMake(0, 22, FNDeviceWidth-44, 0)];
    [self addSubview:self.listView];
    [self incomposition]; 
    
    
    //self.titleLB.backgroundColor=[UIColor lightGrayColor];
}
-(void)incomposition{
    self.bgView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).topSpaceToView(self, 0);
    //121215
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).topSpaceToView(self, 0);
    self.titleLB.sd_layout
    .leftSpaceToView(self, 22).topSpaceToView(self, 5).heightIs(45).widthIs(140);
    //[self.titleLB setSingleLineAutoResizeWithMaxWidth:140];
    self.rightLB.sd_layout
    .rightSpaceToView(self, 30).topSpaceToView(self, 5).heightIs(45).widthIs(120);
    
    self.line.sd_layout
    .leftSpaceToView(self, 22).rightSpaceToView(self, 22).topSpaceToView(self, 50).heightIs(1);
    
    self.listView.sd_layout
    .topSpaceToView(self.line, 0).leftSpaceToView(self, 15).rightSpaceToView(self, 15).bottomSpaceToView(self, 20);
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(@-15);
        make.top.equalTo(self.line.mas_bottom).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
    }];
    
}

-(void)setModel:(FNMakeTaskTmodel *)model{
    _model=model;
    if (model) {
        self.titleLB.text=model.name;
        self.rightLB.text=model.detail;
        [self.bgImgView setNoPlaceholderUrlImg:model.task_bg];
        self.listView.dataArr=model.tasks;
 
    }
}
@end
