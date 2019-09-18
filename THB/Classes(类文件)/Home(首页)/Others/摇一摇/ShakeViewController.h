//
//  ShakeViewController.h
//  THB
//
//  Created by zhongxueyu on 16/5/4.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "SuperViewController.h"
#import "secondViewController.h"
#import "ALBBDetailsViewController.h"
@interface ShakeViewController : SuperViewController

@property (weak, nonatomic) IBOutlet UIImageView *productImg;

@property (weak, nonatomic) IBOutlet UILabel *productTitle;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *rebates;

@property (weak, nonatomic) IBOutlet UIImageView *shakeImg;

@property (weak, nonatomic) IBOutlet UIView *productBg;

@end
