//
//  FNmerDiscussQueryView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDiscussQueryView.h"

@implementation FNmerDiscussQueryView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews{
    self.bgBaseView=[[UIView alloc]init];
    [self addSubview:self.bgBaseView];
    
    self.bgBaseView.backgroundColor = [UIColor whiteColor];
    
    self.bgBaseView.frame=CGRectMake(0, FNDeviceHeight, FNDeviceWidth,426);
    
    self.titleLB=[[UILabel alloc]init];
    [self.bgBaseView addSubview:self.titleLB];
    self.titleLB.font=kFONT16;
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.rightBtn setImage:IMAGE(@"FN_merChaYWimg") forState:UIControlStateNormal];
    [self.bgBaseView addSubview:self.rightBtn];
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.bgBaseView, 50).rightSpaceToView(self.bgBaseView, 50).topSpaceToView(self.bgBaseView, 0).heightIs(45);
    self.rightBtn.sd_layout
    .rightSpaceToView(self.bgBaseView, 0).topSpaceToView(self.bgBaseView, 0).heightIs(45).widthIs(45);
    self.rightBtn.imageView.sd_layout
    .centerXEqualToView(self.rightBtn).centerYEqualToView(self.rightBtn).heightIs(15).widthIs(15);
    
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(15, 45, FNDeviceWidth-30, 264) collectionViewLayout:flowlayout];
    self.collectionview.backgroundColor=[UIColor whiteColor];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.showsVerticalScrollIndicator=NO;
    self.collectionview.showsHorizontalScrollIndicator=NO;
    [self.collectionview registerClass:[FNmerDisQueryItemCell class] forCellWithReuseIdentifier:@"FNmerDisQueryItemCellID"];
    [self.bgBaseView addSubview:self.collectionview];
    
    self.collectionview.sd_layout
    .leftSpaceToView(self.bgBaseView, 15).rightSpaceToView(self.bgBaseView, 15).topSpaceToView(self.bgBaseView, 45).bottomSpaceToView(self.bgBaseView, 125);
    
    
    self.compileView=[[UITextView alloc]init];
    self.compileView.backgroundColor=RGB(239, 240, 244);
    self.compileView.textAlignment=NSTextAlignmentLeft;
    self.compileView.editable = YES;
    self.compileView.delegate = self; 
    self.compileView.font = kFONT14;
    self.compileView.scrollEnabled = YES;
    self.compileView.textColor=RGB(140, 140, 140);
    [self.bgBaseView addSubview:self.compileView];
    
    self.compileView.sd_layout
    .leftSpaceToView(self.bgBaseView, 15).heightIs(65).bottomSpaceToView(self.bgBaseView, 60).rightSpaceToView(self.bgBaseView, 15);
    
    self.hintLb=[[UILabel alloc]init];
    [self.bgBaseView addSubview:self.hintLb];
    self.hintLb.font=[UIFont systemFontOfSize:10];
    self.hintLb.textColor=RGB(204, 204, 204);
    self.hintLb.textAlignment=NSTextAlignmentLeft;
    
    self.hintLb.sd_layout
    .leftSpaceToView(self.bgBaseView, 26).bottomSpaceToView(self.bgBaseView, 102).rightSpaceToView(self.bgBaseView, 26).heightIs(14);
    
    self.affirmBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.bgBaseView addSubview:self.affirmBtn];
    [self.affirmBtn setTitleColor:RGB(24, 24, 24) forState:UIControlStateNormal];
    self.affirmBtn.titleLabel.font=kFONT17;
    self.affirmBtn.sd_layout
    .leftSpaceToView(self.bgBaseView, 0).rightSpaceToView(self.bgBaseView, 0).bottomSpaceToView(self.bgBaseView, 0).heightIs(49);
    
    [self.affirmBtn addTarget:self action:@selector(affirmBtnClick)];
    
    UIView *lineView=[[UIView alloc]init];
    [self.bgBaseView addSubview:lineView];
    lineView.backgroundColor=RGB(246, 245, 245);
    
    lineView.sd_layout
    .leftSpaceToView(self.bgBaseView, 0).rightSpaceToView(self.bgBaseView, 0).bottomSpaceToView(self.bgBaseView, 49).heightIs(1);
    
    
    
}

-(void)affirmBtnClick{
   
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    for (FNmerReviewQueryItemModel *itemModel in self.typeArr) {
        if(itemModel.state==1){
            [arrM addObject:itemModel.type];
        }
    }
    if(arrM.count==0){
        [FNTipsView showTips:@"请选择原因"];
        return;
    }
    if(arrM.count>0){
        self.jointType=[arrM componentsJoinedByString:@","];
        NSString *describeStr=@"";
        if([self.compileView.text kr_isNotEmpty]){
            describeStr=self.compileView.text;
        }else{
            describeStr=@"";
        }
        if ([self.delegate respondsToSelector:@selector(didMerAffirmQueryIndex:withType:withContent:)]) {
            [self.delegate didMerAffirmQueryIndex:self.backIndex withType:self.jointType withContent:describeStr];
        }
    }
    
}
//当textView的内容发生改变的时候调用
- (void)textViewDidChange:(UITextView *)textView {
    XYLog(@"textView:%@",textView.text);
        if([textView.text kr_isNotEmpty]){
            self.hintLb.hidden = YES;
        }else{
            self.hintLb.hidden = NO;
        } 

    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (![text isEqualToString:@""]){
        //self.hintLb.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1){
        
        //self.hintLb.hidden = NO;
    }
    return YES;
    
}

#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.typeArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{ 
    
    FNmerDisQueryItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDisQueryItemCellID" forIndexPath:indexPath];
    cell.model=self.typeArr[indexPath.row];
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=44;
    CGFloat with=FNDeviceWidth;
    CGSize size = CGSizeMake(with, height);
    return size;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if ([self.delegate respondsToSelector:@selector(inRecommendXViewAction:)]) {
//        [self.delegate inRecommendXViewAction:indexPath.row];
//    }
    
    FNmerReviewQueryItemModel *itemModel=self.typeArr[indexPath.row];
    if(itemModel.state==0){
       itemModel.state=1;
    }else{
       itemModel.state=0;
    }
    [self.collectionview reloadData];
}


-(void)showView{
    CGFloat topGap=FNDeviceHeight-426;
    [UIView animateWithDuration:0.3 animations:^{
        self.bgBaseView.frame=CGRectMake(0, topGap, FNDeviceWidth,426);
        self.backgroundColor = [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.3];
    } completion:^(BOOL finished) {
        
    }];
}
-(void)dismissView{
    [UIView animateWithDuration:0.3 animations:^{
        self.bgBaseView.frame=CGRectMake(0, FNDeviceHeight, FNDeviceWidth,426);
        self.backgroundColor = [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.3];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)setModel:(FNmerReviewQueryModel *)model{
    _model=model;
    if(model){
        self.hintLb.text=model.content_tips;
        self.titleLB.text=[NSString stringWithFormat:@"%@",model.title];//@"对此评论有疑问(多选)";
        self.typeArr=[NSMutableArray arrayWithCapacity:0];
        [self.affirmBtn setTitle:model.btn forState:UIControlStateNormal];
        if(model.type.count>0){
            NSArray *listArr=model.type;
            [listArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNmerReviewQueryItemModel *itemModel=[FNmerReviewQueryItemModel mj_objectWithKeyValues:obj];
                itemModel.state=0;
                [self.typeArr addObject:itemModel];
            }];
            [self.collectionview reloadData];
        }
    }
}

- (NSMutableArray *)typeArr{
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}
@end
