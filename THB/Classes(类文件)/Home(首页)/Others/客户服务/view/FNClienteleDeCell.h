//
//  FNClienteleDeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/20.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNclienteleDeModel.h"

@protocol FNClienteleDeCellDegate <NSObject>
// 点击联系客户
- (void)relationClienteleClick:(FNclienteleDeModel*)model;
@end

@interface FNClienteleDeCell : UICollectionViewCell
/** img **/
@property (nonatomic, strong)UIImageView* iconImageView;
/** nameLB **/
@property (nonatomic, strong)UILabel* nameLB;
/** right **/
@property (nonatomic, strong)UIButton* rightButton;
/** model **/
@property (nonatomic, strong)FNclienteleDeModel *model;
/** delegate **/
@property(nonatomic ,weak) id<FNClienteleDeCellDegate> delegate;
@end


