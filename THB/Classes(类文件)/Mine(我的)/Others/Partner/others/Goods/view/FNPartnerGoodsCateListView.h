//
//  FNPartnerGoodsCateListView.h
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"

@interface FNPartnerGoodsCateListView : JMView
@property (nonatomic, strong)NSArray* list;
@property (nonatomic, assign)NSInteger selectedIndex;
@property (nonatomic, copy)void (^selectedBlock)(NSInteger index,NSString* string);
@end
