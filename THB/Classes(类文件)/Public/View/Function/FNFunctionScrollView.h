//
//  FNFunctionScrollView.h
//  SuperMode
//
//  Created by jimmy on 2017/6/7.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNFunctionScrollView : UIScrollView
@property (nonatomic, strong)NSArray* datas;
@property (nonatomic, strong)NSArray<UIImage *>* images;
@property (nonatomic, strong)UIFont* font;
@property (nonatomic, copy)void (^observingClicked)(NSInteger index);
@property (nonatomic, assign)BOOL isScale;
@end
