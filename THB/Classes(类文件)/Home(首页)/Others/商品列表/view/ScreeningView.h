//
//  ScreeningView.h
//  如意贝
//
//  Created by Fnuo-iOS on 2018/4/27.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "JMView.h"

@interface ScreeningView : JMView
@property (nonatomic, strong)void (^clickedWithType)(NSString *type);
@property (nonatomic, strong)void (^clickedWithSiteType)(NSString *type,NSInteger site);
@property (nonatomic, strong) NSString* genreString;//(==@"record" :表示首页点击时只做记录点击了那个)
@property (nonatomic, strong) NSMutableArray* types;
@property (nonatomic, strong) NSMutableArray<UIView*>* views;
-(void)setTitles:(NSMutableArray *)titles images:(NSMutableArray *)images selectedImage:(NSMutableArray *)selectedImage types:(NSMutableArray *)types;
- (void)setButtonAtIndex:(NSInteger)index;
@end
