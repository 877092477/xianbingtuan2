
//
//  JMInviteRuleController.m
//  THB
//
//  Created by jimmy on 2017/4/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMInviteRuleController.h"

@interface JMInviteRuleController ()
@property (nonatomic, strong)UIScrollView* scrollView;
@property (nonatomic, strong)UIImageView* imgView;
@property (nonatomic, strong)NSLayoutConstraint *imgHeightCons;
@end

@implementation JMInviteRuleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializedSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.title = @"邀请规则";
    _scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:_scrollView];
    [_scrollView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    @WeakObj(self);
    _imgView = [UIImageView new];
    [_imgView addJXTouch:^{
        [selfWeak umengShare];
    }];
    [self.scrollView addSubview:_imgView];
    [_imgView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    [_imgView autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth];
    [_imgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    self.imgHeightCons = [_imgView autoSetDimension:(ALDimensionHeight) toSize:0];
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_ruleImg] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            selfWeak.imgHeightCons.constant = image.size.height*FNDeviceWidth/image.size.width;
            [selfWeak.scrollView layoutIfNeeded];
        }
    }];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.imgHeightCons.constant  > FNDeviceHeight) {
        self.scrollView.contentSize = CGSizeMake(FNDeviceWidth, self.imgHeightCons.constant);
    }
}


-(void)umengShare{

    NSString *shareText = UserShareWord;             //分享内嵌文字
    NSString *shareUrl = [NSString encodeToPercentEscapeString:ShareUrl];
    
    [self umengShareWithURL:shareUrl image:UserShareImg shareTitle:nil andInfo:shareText];

}
@end
