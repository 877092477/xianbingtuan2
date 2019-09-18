//
//  FNLiveCouponeSpecialView.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveCouponeSpecialView.h"
#import "MZTimerLabel.h"
#import "MenuModel.h"
static const CGFloat _special_margin = 1;

@interface FNLiveCouponeSpecialSubView : UIView
@property (nonatomic, strong)UIImageView* titleImgView;
@property (nonatomic, strong)NSLayoutConstraint* titleimgconsw;
@property (nonatomic, assign)CGFloat titleimgmaxw;
@property (nonatomic, strong)UILabel* desLabel;
@property (nonatomic, strong)UIImageView* proImgView;
@property (nonatomic, strong)MZTimerLabel* timeLabel;
@property (nonatomic, strong)UIImageView* timeBgView;
@property (nonatomic, strong)UILabel* countLabel;
@property (nonatomic, strong)UIImageView* imgGo;
@end
@implementation FNLiveCouponeSpecialSubView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    if (!([FNBaseSettingModel settingInstance].tw &&[FNBaseSettingModel settingInstance].tw.length>=1)) {
        self.backgroundColor = FNWhiteColor;
    }
    _titleImgView = [UIImageView new];
    _titleImgView.size = [UIImage imageNamed:@"home_brand_to"].size;
    [self addSubview:_titleImgView];
    [_titleImgView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:5];
    [_titleImgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
    [_titleImgView autoSetDimension:(ALDimensionHeight) toSize:_titleImgView.height];
    self.titleimgconsw = [_titleImgView autoSetDimension:(ALDimensionWidth) toSize:_titleImgView.width];
    
    _desLabel = [UILabel new];
    _desLabel.font = kFONT12;
    _desLabel.textColor = GrayColor;
    [self addSubview:_desLabel];
    [_desLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_titleImgView];
    [_desLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_titleImgView];
    
    _proImgView = [UIImageView new];
    _proImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_proImgView];
    [_proImgView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:6];
    [_proImgView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:6];
    [_proImgView autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionHeight) ofView:self withMultiplier:0.6];
    
    
    _timeBgView = [UIImageView new];
    [self addSubview:_timeBgView];
    
    _countLabel = [UILabel new];
    _countLabel.font = kFONT12;
    _countLabel.textColor = FNMainGobalControlsColor;
    [self addSubview:_countLabel];
    
    
    _timeLabel = [[MZTimerLabel alloc]initWithTimerType:(MZTimerLabelTypeTimer)];
    _timeLabel.timeFormat = @"HH   mm   ss";
    _timeLabel.font = kFONT12;
    _timeLabel.textColor = FNWhiteColor;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_timeLabel];
    [_timeLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_timeBgView];
    [_timeLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_timeBgView];
    [_timeLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:_timeBgView];
    
    _imgGo = [[UIImageView alloc] init];
    [self addSubview:_imgGo];
    [_imgGo autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self withOffset:-14];
    [_imgGo autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:_proImgView withOffset:4];
    [_imgGo autoSetDimension:(ALDimensionWidth) toSize:46];
    [_imgGo autoSetDimension:(ALDimensionHeight) toSize:20];
    
}

@end
@interface FNLiveCouponeSpecialView ()
@property (nonatomic, strong) NSMutableArray<FNLiveCouponeSpecialSubView *>* views;

@end
@implementation FNLiveCouponeSpecialView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.backgroundColor = FNHomeBackgroundColor;
    _views = [NSMutableArray new];
    
    CGFloat firstWidth = FNDeviceWidth*0.35;
    CGFloat firstHeight = 0.53*FNDeviceWidth - 2;
    FNLiveCouponeSpecialSubView* firstView = [[FNLiveCouponeSpecialSubView alloc]initWithFrame:(CGRectMake(_special_margin, 1, firstWidth, firstHeight))];
    firstView.timeBgView.image = IMAGE(@"home_seckill_se_time");
    firstView.titleimgmaxw = firstWidth-_jmsize_10;
    [firstView.timeBgView sizeToFit];
    
    [firstView.desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
    
    [firstView.timeBgView autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:firstView.titleImgView];
    [firstView.timeBgView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:firstView.desLabel withOffset:5];
    [firstView.timeBgView autoSetDimensionsToSize:firstView.timeBgView.size];
    
    [firstView.proImgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:17];
//    [firstView.proImgView autoSetDimension:(ALDimensionHeight) toSize:(firstWidth-_special_margin*2)];
    
    [self addSubview:firstView];
    [_views addObject:firstView];
    
    CGFloat secondWidth = FNDeviceWidth-3*_special_margin - firstWidth;
    CGFloat secondHeight = ( firstHeight-_special_margin)*0.5;
    FNLiveCouponeSpecialSubView* secondView = [[FNLiveCouponeSpecialSubView alloc]initWithFrame:(CGRectMake(firstWidth+_special_margin*2, firstView.y, secondWidth, secondHeight))];
    secondView.desLabel.numberOfLines = 2;
    secondView.titleimgmaxw = (secondWidth-_jmsize_10)*0.5;
    
    [secondView.proImgView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:6];
    [secondView.proImgView autoSetDimension:(ALDimensionWidth) toSize:(secondHeight-_special_margin*2)];
    
    [secondView.countLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:secondView.titleImgView withOffset:5];
    [secondView.countLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:secondView.titleImgView];
    
    [secondView.desLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:secondView.proImgView withOffset:5];
    
    [self addSubview:secondView];
    [_views addObject:secondView];
    
    CGFloat thirdWidth = (secondWidth-_special_margin)*0.5;
    CGFloat thirdHeight = secondHeight;
    FNLiveCouponeSpecialSubView* thirdView = [[FNLiveCouponeSpecialSubView alloc]initWithFrame:(CGRectMake(secondView.x, secondView.height+_special_margin+1, thirdWidth, thirdHeight))];
    thirdView.titleimgmaxw = thirdWidth-_jmsize_10;
    [thirdView.desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
    [thirdView.desLabel autoSetDimension:(ALDimensionHeight) toSize:15];
    
    [thirdView.proImgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_special_margin];
    [thirdView.proImgView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:thirdView.desLabel withOffset:5];
    
    [self addSubview:thirdView];
    [_views addObject:thirdView];
    
    
    FNLiveCouponeSpecialSubView* fourthView = [[FNLiveCouponeSpecialSubView alloc]initWithFrame:(CGRectMake(thirdView.x+thirdWidth+_special_margin, thirdView.y, thirdWidth, thirdHeight))];
    fourthView.titleimgmaxw = thirdWidth-_jmsize_10;
    [fourthView.desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
    [fourthView.desLabel autoSetDimension:(ALDimensionHeight) toSize:15];
    
    [fourthView.proImgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_special_margin];
    [fourthView.proImgView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:fourthView.desLabel withOffset:5];
    [self addSubview:fourthView];
    [_views addObject:fourthView];
    
    @WeakObj(self);
    [_views enumerateObjectsUsingBlock:^(FNLiveCouponeSpecialSubView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = idx + 100;
        [obj addJXTouchWithObject:^(id oj) {
            FNLiveCouponeSpecialSubView* view = oj;
            NSInteger tag = view.tag - 100;
            if (selfWeak.specialViewClicked) {
                selfWeak.specialViewClicked(tag);
            }
            
        }];
        
    }];
}
- (void)setSpecialArray:(NSArray<MenuModel *> *)specialArray{
    _specialArray = specialArray;
    if (_specialArray.count > 0 ) {
        [_views enumerateObjectsUsingBlock:^(FNLiveCouponeSpecialSubView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx<=_specialArray.count-1) {
                MenuModel* model = _specialArray[idx];
                if (idx == 0) {
                    NSTimeInterval time = _specialArray[idx].activity_time.integerValue - [NSDate new].timeIntervalSince1970;
                    if (time<0) {
                        time = 0;
                    }
                    [obj.timeLabel setCountDownTime:time];
                    [obj.timeLabel start];
                    obj.timeBgView.hidden=YES;
                    obj.timeLabel.hidden=YES;
                }else if (idx == 1){
                    if (model.num.integerValue>=1) {
                        obj.countLabel.text = [NSString stringWithFormat:@"+ %@",model.num];
                    }
                    
                }
                obj.desLabel.text = model.title;
                UIImageView*image=[[UIImageView alloc]init];
                
                [image sd_setImageWithURL:URL(model.font_img) placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    //                    obj.titleImgView.image = image;
                    if (image && [image isKindOfClass:[UIImage class]]) {
                        CGFloat width = image.size.width/image.size.height*obj.titleImgView.height;
                        if (width >= obj.titleimgmaxw) {
                            obj.titleimgconsw.constant = obj.titleimgmaxw;
                        }else{
                            obj.titleimgconsw.constant = width;
                        }
                    }
                    
                    [obj layoutIfNeeded];
                }];
                [obj.titleImgView setUrlImg:model.font_img];
                
                [obj.proImgView setUrlImg:model.img];
                [obj.imgGo setUrlImg:model.go_img];
                
            }
            
        }];
    }
}

@end
