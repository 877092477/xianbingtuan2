//
//  FNPromotionalListController.h
//  THB
//
//  Created by Jimmy on 2017/12/22.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNPromotionalListViewModel.h"
@interface FNPromotionalListController : SuperViewController
@property (nonatomic, strong)FNPromotionalListViewModel* viewmodel;
@property (nonatomic, copy)NSString* titleImg;
@property (nonatomic, weak)RACSubject* filtersubject;
@property (nonatomic, copy)NSString* show_name;

@end
