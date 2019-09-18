//
//  FNmerIssueDateSCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmerIssueDateSCell : UICollectionViewCell
@property (nonatomic, strong)UIView    *bgView;
@property (nonatomic, strong)UIView    *lineView;
@property (nonatomic, strong)UILabel   *leftStartLB;
@property (nonatomic, strong)UILabel   *leftEndLB;
@property (nonatomic, strong)UILabel   *hintLB;
@property (nonatomic, strong)UIButton  *startBtn;
@property (nonatomic, strong)UIButton  *endBtn;
@property (nonatomic, strong)UIButton  *issueBtn;
@property (nonatomic, strong)NSString  *typeStr;

@end

NS_ASSUME_NONNULL_END
