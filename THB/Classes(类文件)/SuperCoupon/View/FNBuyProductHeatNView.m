//
//  FNBuyProductHeatNView.m
//  THB
//
//  Created by 李显 on 2018/9/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//过去一小时卖爆了
#import "FNBuyProductHeatNView.h"
#import "FNheatProductNCell.h"
@implementation FNBuyProductHeatNView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    if (self) {
       [self HeatViewUI];
        
    }
    return self;
}

#pragma mark -  单元
-(void)HeatViewUI{
    
    // [UIImage imageNamed:@"home_brand_to"].size;
    //标题Image 过去一小时卖爆了
    self.titleImage=[UIImageView new];
    [self addSubview:self.titleImage];
    
    //标题2Image 每小时更新
    self.titleTwoImage=[UIImageView new];
    [self addSubview:self.titleTwoImage];
    
    self.titleImage.sd_layout
    .topSpaceToView(self, 16).leftSpaceToView(self, 10).heightIs(18).widthIs(FNDeviceWidth/3+20);
    self.titleTwoImage.sd_layout
    .topSpaceToView(self, 17.5).leftSpaceToView(self.titleImage, 10).heightIs(15).widthIs(60);
    
    
    self.directionView=[UIImageView new];
    [self addSubview:self.directionView];
    self.directionView.image=IMAGE(@"high_right");
    
    self.checkBtn=[UIButton new];
    [self.checkBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    self.checkBtn.titleLabel.font=[UIFont fontWithDevice:11];
    [self.checkBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self addSubview:self.checkBtn];
    [self.checkBtn addTarget:self action:@selector(checkClick)];
    
    self.directionView.sd_layout
    .heightIs(15).widthIs(8).rightSpaceToView(self, 10).centerYEqualToView(self.titleImage);
    self.checkBtn.sd_layout
    .heightIs(15).widthIs(60).rightSpaceToView(self.directionView, 5).centerYEqualToView(self.titleImage);
    
    self.timeBgView = [UIImageView new];
    [self addSubview:self.timeBgView];
    
    self.timeLabel = [[MZTimerLabel alloc]initWithTimerType:(MZTimerLabelTypeTimer)];
    self.timeLabel.frame=CGRectMake(130, 5, 120, 40);
    self.timeLabel.timeFormat = @"HH   mm   ss";
    self.timeLabel.font = kFONT12;
    self.timeLabel.textColor = FNWhiteColor;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.timeLabel];
    [_timeLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_timeBgView];
    [_timeLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_timeBgView];
    [_timeLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:_timeBgView];
    
    
    
    CGFloat with=JMScreenWidth/3+60;
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing = 10;
    //flowayout.sectionHeadersPinToVisibleBounds = NO;
    //flowayout.sectionFootersPinToVisibleBounds = NO;
    flowayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.goodscollectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, FNDeviceWidth, with) collectionViewLayout:flowayout];
    self.goodscollectionview.dataSource = self;
    self.goodscollectionview.delegate = self;
    self.goodscollectionview.backgroundColor=[UIColor whiteColor];
    [self  addSubview: self.goodscollectionview];
    [self.goodscollectionview registerClass:[FNheatProductNCell class] forCellWithReuseIdentifier:@"HeatCell"];
    self.goodscollectionview.showsVerticalScrollIndicator = NO;
    self.goodscollectionview.showsHorizontalScrollIndicator = NO;
}

-(void)checkClick{
    //NSLog(@"查看全部");
    if ([self.delegate respondsToSelector:@selector(CheckProductAction)]) {
        [self.delegate CheckProductAction];
    }
    
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.heatArr.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNheatProductNCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeatCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.indexPath=indexPath;
    //FNBaseProductModel *item=_heatArr[indexPath.row];
    //NSLog(@"name:%@",item.name);
    cell.model=self.heatArr[indexPath.row];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNBaseProductModel *item=_heatArr[indexPath.row];
     
    if (self.selectHeatCommodityNow) {
        self.selectHeatCommodityNow(item);
    }
    
    if ([self.delegate respondsToSelector:@selector(ProductHeatClickAction:)]) {
        [self.delegate ProductHeatClickAction:item];
    }
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=JMScreenWidth/3;
    CGSize size = CGSizeMake(with, with+60);
    return size;
}

-(void)setRecordInt:(NSUInteger)recordInt{
    _recordInt=recordInt;
    if(recordInt==1){
        self.directionView.hidden=NO;
        self.checkBtn.hidden=NO;
        self.titleImage.hidden=NO;
        self.timeBgView.hidden=NO;
        self.timeLabel.hidden=NO;
        self.titleTwoImage.hidden=YES;
        self.titleImage.sd_layout
        .topSpaceToView(self, 16).leftSpaceToView(self, 10).heightIs(15).widthIs(80);
    }else if(recordInt==2){
        self.titleTwoImage.hidden=NO;
        self.directionView.hidden=YES;
        self.checkBtn.hidden=YES;
        self.titleImage.hidden=NO;
        self.timeBgView.hidden=YES;
        self.timeLabel.hidden=YES;
    }
}
-(void)setHeatArr:(NSMutableArray *)heatArr{
    NSLog(@"heatArr:%@",heatArr);
    _heatArr=heatArr;
    if(_heatArr.count>0){
        self.goodscollectionview.hidden=NO;
    }else{
        self.goodscollectionview.hidden=YES;
    }
    [self.goodscollectionview reloadData];
    
}
-(void)setImageDic:(NSDictionary *)imageDic{
    NSLog(@"imageDic:%@",imageDic);
    if(self.recordInt==1){
        
        self.titleImage.image=IMAGE(@"htitle1");
        self.timeBgView.image = IMAGE(@"home_seckill_se_time");
        [self.timeBgView sizeToFit];
        self.timeBgView.sd_layout
        .leftSpaceToView(self.titleImage, 10).widthIs(self.timeBgView.size.width).heightIs(self.timeBgView.size.height).centerYEqualToView(self.titleImage);
        
        NSDictionary *minuDic=imageDic[@"list"][0];
        NSString *timer=minuDic[@"end_time"];
        NSTimeInterval time = timer.integerValue - [NSDate new].timeIntervalSince1970;
        if (time<0) {
            time = 0;
        }
        [self.timeLabel setCountDownTime:time];
        [self.timeLabel start];
        
    }else if(self.recordInt==2){
        [self.titleImage setUrlImg:imageDic[@"img1"]];
        [self.titleTwoImage  setUrlImg:imageDic[@"img2"]];
    }
    
   
    
}


@end
