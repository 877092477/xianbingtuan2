//
//  JMTutorialController.h
//  THB
//
//  Created by jimmy on 2017/4/22.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

typedef enum : NSUInteger {
    TutorialTypeTaoBao =0 ,
    TutorialTypeShop,
} TutorialType;
@interface JMTutorialController : SuperViewController
/**
 *  tutorial type
 */
@property (nonatomic, assign)TutorialType tutorialType;

@end
