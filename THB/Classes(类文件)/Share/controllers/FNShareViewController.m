//
//  FNShareViewController.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/3.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNShareViewController.h"
#import "FNShareImageTextController.h"
#import "FNShareLinkController.h"
#import "FNShareMiniProgramController.h"
#import "FNShareCateModel.h"

@interface FNShareViewController ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *vMsg;
@property (nonatomic, strong) UIImageView *imgMsg;
@property (nonatomic, strong) UILabel *lblMsg;

@property (nonatomic, strong) NSArray<FNShareCateModel*> *cates;

@end

@implementation FNShareViewController

- (BOOL)isFullScreenShow {
    return YES;
}
- (BOOL)needLogin {
    return YES;
}

- (void)viewDidLoad {
    
//    self.title = @"分享赚";
    
    _vMsg = [[UIView alloc] init];
    _imgMsg = [[UIImageView alloc] init];
    _lblMsg = [[UILabel alloc] init];
    
    [self.view addSubview:_vMsg];
    [_vMsg addSubview:_imgMsg];
    [_vMsg addSubview:_lblMsg];
    
    [_vMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.mas_equalTo(30);
    }];
    [_imgMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(@0);
        make.width.height.mas_equalTo(14);
    }];
    [_lblMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgMsg.mas_right).offset(4);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(@-20);
    }];
    
    _vMsg.hidden = YES;
//    _vMsg.backgroundColor = RGB(255, 51, 102);
    _lblMsg.font = kFONT12;
    _lblMsg.textColor = UIColor.whiteColor;
//    _lblMsg.text = @"奖励收益预估：￥9.8";
    
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = FNWhiteColor;
    // 设置标题字体
    /*
     方式一：
     self.titleFont = [UIFont systemFontOfSize:20];
     */
    // 推荐方式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        //设置标题高度
        *titleHeight = 44;
        // 设置标题字体
        *titleFont = kFONT13;
//        *norColor = RGB(153, 153, 153);
//        *selColor = RGB(255, 51, 102);
        
    }];
    
    
    // 推荐方式（设置下标）
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        // 是否显示标签
        *isShowUnderLine = YES;
        
        // 标题填充模式
//        *underLineColor = RGB(255, 51, 102);
        
        *underLineH = 3;
        
        // 是否需要延迟滚动,下标不会随着拖动而改变
        //        *isDelayScroll = YES;
        
    }];
    
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self apiRequestcCate];
    });
    
//    [self setupChildVC];
}

#pragma mark - set up child view controllers
- (void)setupChildVC{
    if (self.cates.count > 0) {
        @weakify(self)
        [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
            @strongify(self)
            *norColor = [UIColor colorWithHexString:self.cates[0].color];
            *selColor = [UIColor colorWithHexString:self.cates[0].check_color];
            
        }];
        
        
        // 推荐方式（设置下标）
        [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
            @strongify(self)
            // 标题填充模式
            *underLineColor = [UIColor colorWithHexString:self.cates[0].check_color];
            
        }];
    }
    
    for (FNShareCateModel *cate in self.cates) {
        if ([cate.type isEqualToString:@"share_pic"]) {
            FNShareImageTextController *shareController = [[FNShareImageTextController alloc] init];
            shareController.title = cate.name;
            shareController.SkipUIIdentifier = self.SkipUIIdentifier;
            shareController.fnuo_id = self.fnuo_id;
            shareController.type = cate.type;
            [self addChildViewController:shareController];
        } else if ([cate.type isEqualToString:@"share_url"]) {
            FNShareLinkController *linkController = [[FNShareLinkController alloc] init];
            linkController.title = cate.name;
            linkController.SkipUIIdentifier = self.SkipUIIdentifier;
            linkController.fnuo_id = self.fnuo_id;
            linkController.type = cate.type;
            [self addChildViewController:linkController];
        } else if ([cate.type isEqualToString:@"share_miniprogram"]) {
            FNShareMiniProgramController *miniController = [[FNShareMiniProgramController alloc] init];
            miniController.title = cate.name;
            miniController.SkipUIIdentifier = self.SkipUIIdentifier;
            miniController.fnuo_id = self.fnuo_id;
            miniController.type = cate.type;
            [self addChildViewController:miniController];
        }
    }
    
    [self refreshDisplay];
    
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:self.vMsg.hidden ? 0 : 30];
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
    
    [self.view layoutIfNeeded];
    
    
}

#pragma mark - Networking

- (FNRequestTool *)apiRequestcCate{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token": UserAccessToken}];
    if(self.SkipUIIdentifier){
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    }
    if(self.fnuo_id){
        params[@"gid"]=self.fnuo_id;
    }
    NSLog(@"searSkipUIIdentifier:%@",self.SkipUIIdentifier);
    @weakify(self)
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=share_model&ctrl=cate" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        NSString* top_title = respondsObject[@"top_title"];
        NSString* ico = respondsObject[@"ico"];
        NSString* f_str = respondsObject[@"f_str"];
        NSString* bjcolor = respondsObject[@"bjcolor"];
        NSString* color = respondsObject[@"color"];
        NSArray* cate = respondsObject[@"cate"];
        
        self.title = top_title;
        
        self.vMsg.hidden = ![f_str kr_isNotEmpty];
        self.vMsg.backgroundColor = [UIColor colorWithHexString:bjcolor];
        self.lblMsg.text = f_str;
        self.lblMsg.textColor = [UIColor colorWithHexString:color];
        [self.imgMsg sd_setImageWithURL:URL(ico)];
        
        
        self.cates = [FNShareCateModel mj_objectArrayWithKeyValuesArray:cate];
        
        
        [self setupChildVC];
        
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}

@end
