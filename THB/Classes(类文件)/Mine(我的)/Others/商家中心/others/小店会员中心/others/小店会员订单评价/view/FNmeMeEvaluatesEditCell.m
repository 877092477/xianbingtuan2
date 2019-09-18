//
//  FNmeMeEvaluatesEditCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeMeEvaluatesEditCell.h"

@implementation FNmeMeEvaluatesEditCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    
    self.grayView=[[UIView alloc]init];
    [self.bgView addSubview:self.grayView];
    self.grayView.backgroundColor=RGB(245, 246, 247);
    self.grayView.cornerRadius=5;
    
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.bgView.cornerRadius=5;
    self.bgView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 89);
    
    self.grayView.sd_layout
    .leftSpaceToView(self.bgView, 20).topSpaceToView(self.bgView, 66).rightSpaceToView(self.bgView, 20).heightIs(118);
    
    self.titleLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.titleLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:17];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    
    self.evaluateView=[[UITextView alloc]init];
    self.evaluateView.textAlignment=NSTextAlignmentLeft;
    self.evaluateView.editable = YES;
    self.evaluateView.delegate = self;
    self.evaluateView.font = kFONT14;
    self.evaluateView.scrollEnabled = YES;
    self.evaluateView.cornerRadius=5;
    self.evaluateView.textColor=RGB(102, 102, 102);
    self.evaluateView.backgroundColor=RGB(245, 246, 247);
    [self.bgView addSubview:self.evaluateView];
    self.evaluateView.sd_layout
    .leftSpaceToView(self.bgView, 25).topSpaceToView(self.bgView, 66).rightSpaceToView(self.bgView, 25).heightIs(118);
    
    self.evaluateHint=[[UILabel alloc]init];
    [self.bgView addSubview:self.evaluateHint];
    self.evaluateHint.font=[UIFont systemFontOfSize:13];
    self.evaluateHint.textColor=RGB(182, 194, 206);
    self.evaluateHint.textAlignment=NSTextAlignmentLeft;
    
    self.submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.submitBtn];
    
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font=kFONT17;
    self.submitBtn.cornerRadius=44/2;
    //self.submitBtn.backgroundColor=RGB(252, 166, 42);
    self.submitBtn.sd_layout
    .leftSpaceToView(self, 37).rightSpaceToView(self, 37).bottomSpaceToView(self, 20).heightIs(44);
    self.submitBtn.imageView.sd_layout
    .leftSpaceToView(self.submitBtn, 0).rightSpaceToView(self.submitBtn, 0).topSpaceToView(self.submitBtn, 0).bottomSpaceToView(self.submitBtn, 0);
    self.submitBtn.imageView.contentMode=UIViewContentModeScaleAspectFill;
    self.submitBtn.clipsToBounds=YES;
    self.submitBtn.titleLabel.sd_layout
    .leftSpaceToView(self.submitBtn, 0).rightSpaceToView(self.submitBtn, 0).topSpaceToView(self.submitBtn, 0).bottomSpaceToView(self.submitBtn, 0);
    self.submitBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    self.titleLB.sd_layout
    .rightSpaceToView(self.bgView, 10).leftSpaceToView(self.bgView, 10).heightIs(21).topSpaceToView(self.bgView, 28);
    
    self.evaluateHint.sd_layout
    .leftSpaceToView(self.bgView, 30).topSpaceToView(self.bgView, 74).rightSpaceToView(self.bgView, 30).heightIs(17);
   
    CGFloat width = FNDeviceWidth-20;
    self.photoView = [HXPhotoView photoManager:self.manager];
    self.photoView.frame = CGRectMake(20, 199, width - 40, 0);
    self.photoView.delegate = self;
    self.photoView.lineCount = 4;
    self.photoView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:self.photoView];
    self.photoView.sd_layout
    .leftSpaceToView(self.bgView, 20).topSpaceToView(self.bgView, 199).rightSpaceToView(self.bgView, 20).bottomSpaceToView(self.bgView, 30);
}
- (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
//        _manager.openCamera = NO;
//        _manager.cacheAlbum = YES;
//        _manager.lookLivePhoto = YES;
//        _manager.outerCamera = NO;
//        _manager.cameraType = HXPhotoManagerCameraTypeFullScreen;
//        _manager.videoMaxNum = 0;
//
//        _manager.videoMaxDuration = 10.f;
//        _manager.saveSystemAblum = NO;
//        _manager.style = HXPhotoAlbumStylesSystem;
//        //        _manager.reverseDate = YES;
//        _manager.showDateHeaderSection = NO;
//        _manager.selectTogether = NO;
        _manager.rowCount = 4;
        _manager.UIManager.photoViewAddImageName=@"FN_meMemberAddimg";
        _manager.saveSystemAblum = YES;
        _manager.photoMaxNum=4;
        _manager.maxNum = 4;
        //_manager.showDeleteNetworkPhotoAlert=YES;
        _manager.UIManager.navBar = ^(UINavigationBar *navBar) {
            
        };
    }
    return _manager;
}
//当textView的内容发生改变的时候调用
- (void)textViewDidChange:(UITextView *)textView {
    if([textView.text kr_isNotEmpty]){
        self.evaluateHint.hidden = YES;
    }else{
        self.evaluateHint.hidden = NO;
    }
    if ([self.delegate respondsToSelector:@selector(didmeMeEvaluatesEdit:)]) {
        [self.delegate didmeMeEvaluatesEdit:textView.text];
    } 
}
#pragma mark - 图片代理方法
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal { 
    [HXPhotoTools getImageForSelectedPhoto:photos type:HXPhotoToolsFetchOriginalImageTpe completion:^(NSArray<UIImage *> *images) {
        //XYLog(@"images:%@",images);
        if ([self.delegate respondsToSelector:@selector(didmeMeEvaluatesAction:)]) {
            [self.delegate didmeMeEvaluatesAction:images];
        }
    }];
}
- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"networkPhotoUrl:%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    
//    CGFloat imgsHeight=frame.size.height;
   
//    self.bgView.sd_layout
//    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).heightIs(imgsHeight+230);
//    self.photoView.sd_layout
//    .leftSpaceToView(self.bgView, 15).topSpaceToView(self.bgView, 199).rightSpaceToView(self.bgView, 15).bottomSpaceToView(self.bgView, 20);
   
    
//    CGFloat rowHeight=imgsHeight+230+89;
//            if ([self.delegate respondsToSelector:@selector(didmeMeEvaluatesEditClickIndex:)]) {
//                [self.delegate didmeMeEvaluatesEditClickIndex:rowHeight];
//            }
    //NSSLog(@"高=%@",NSStringFromCGRect(frame));
    
    
}

-(void)setModel:(FNmeMemberEvaluatesModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.comment_title;//@"给这次评个价吧 ~";
        self.evaluateHint.text=model.comment_tips;//@"写下你这次的评价吧";
        [self.submitBtn setTitle:model.btn_str forState:UIControlStateNormal];
        [self.submitBtn setTitleColor:[UIColor colorWithHexString:model.btn_color] forState:UIControlStateNormal];
        //[self.submitBtn sd_setBackgroundImageWithURL:URL(model.btn_bj) forState:UIControlStateNormal]; 
        [self.submitBtn sd_setImageWithURL:URL(model.btn_bj) forState:UIControlStateNormal];
    }
}

-(void)setAlterModel:(FNmerchentReviewModel *)alterModel{
    _alterModel=alterModel; 
    if(alterModel){
        self.evaluateView.text=alterModel.content;
        if([alterModel.content kr_isNotEmpty]){
            self.evaluateHint.hidden = YES;
        }else{
            self.evaluateHint.hidden = NO;
        }
        NSArray *arrImgs=alterModel.imgs;
        NSMutableArray *arrayImgs =[NSMutableArray arrayWithCapacity:0] ;
        [arrayImgs addObjectsFromArray:arrImgs];
        self.manager.networkPhotoUrls=arrayImgs;
        //self.manager.endSelectedPhotos=arrayImgs;
        //self.manager.selectPhoto=YES;
        self.photoView.manager=self.manager;
        [self.photoView refreshView];
    }
}
@end
