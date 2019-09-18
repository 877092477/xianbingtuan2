//
//  FNSiteItemDaNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/11/30.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNrushSiteDaNeModel.h"
@protocol FNSiteItemDaNeCellDelegate <NSObject>
// 编辑
- (void)SiteItemCopyreaderAction:(NSIndexPath *)indexPath;

@end

@interface FNSiteItemDaNeCell : UITableViewCell
/** 地名 **/
@property (nonatomic, strong)UILabel* nameLabel;
/** 地址 **/
@property (nonatomic, strong)UILabel* siteLabel;
/** 编辑 **/
@property (nonatomic, strong)UIButton *compileButton;
/** 名字和电话 **/
@property (nonatomic, strong)UILabel* phoneNameLB;
/** Line **/
@property (nonatomic, strong)UILabel* LineLB;
/** model **/
@property (nonatomic, strong)NSDictionary* model;
/** other **/
@property (nonatomic, strong)NSIndexPath *indexPath;
/** delegate **/
@property(nonatomic ,weak) id<FNSiteItemDaNeCellDelegate> delegate;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end


