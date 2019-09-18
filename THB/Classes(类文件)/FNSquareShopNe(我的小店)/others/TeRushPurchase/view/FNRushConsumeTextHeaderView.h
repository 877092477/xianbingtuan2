//
//  FNRushConsumeTextHeaderView.h
//  69橙子
//
//  Created by Jimmy on 2018/11/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

 

@interface FNRushConsumeTextHeaderView : UITableViewHeaderFooterView
/**  文本        **/
@property(nonatomic, strong)UILabel *titleName;
/**  topLineLb  **/
@property(nonatomic, strong) UILabel *topLineLb;

/**  line       **/
@property(nonatomic, strong) UILabel *lineLb;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end

 
