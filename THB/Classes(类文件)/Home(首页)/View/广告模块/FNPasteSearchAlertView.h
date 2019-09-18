//
//  FNPasteSearchAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/26.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewProductDetailModel.h"
#import "FNIntelligentSearchNeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNPasteSearchAlertView : UIView

@property (nonatomic, strong)NSString* prasestring;

@property (nonatomic, strong)NSString* fnIDstring;
@property (nonatomic, strong) FNNewProductDetailModel *model;

@property (nonatomic, copy)void (^purchaseBlock) (id model);

@property (nonatomic, copy) StoreTypeBlock storeTypeBlock;
//@property (nonatomic, copy)void (^storeTypeBlock) (FNIntelligentSearchType type,NSString* content,FNNewProductDetailModel* model);

+ (void)showWithModel:(id)model view:(UIView *)view storeTypeblock:(StoreTypeBlock)Typeblock;

+ (void)showWithContent:(NSString*)content view:(UIView *)view withfnID:(NSString*)fuID type: (FNIntelligentSearchType)type yhq_url: (NSString*)yhq_url storeTypeblock:(StoreTypeBlock)Typeblock;
+ (void)dismiss;


@end

NS_ASSUME_NONNULL_END
