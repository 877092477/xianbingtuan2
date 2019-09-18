//
//  FNPasteSearchUpdateAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/5.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewProductDetailModel.h"
#import "FNIntelligentSearchNeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNPasteSearchUpdateAlertView : UIView

@property (nonatomic, strong)NSString* prasestring;

@property (nonatomic, strong)NSString* fnIDstring;
@property (nonatomic, strong) FNNewProductDetailModel *model;

@property (nonatomic, copy)void (^purchaseBlock) (id model);

@property (nonatomic, copy) StoreTypeBlock storeTypeBlock;
//@property (nonatomic, copy)void (^storeTypeBlock) (FNIntelligentSearchType type,NSString* content,FNNewProductDetailModel* model);


//+ (void)showWithContent:(NSString*)content view:(UIView *)view withfnID:(NSString*)fuID SkipUIIdentifier: (NSString*)SkipUIIdentifier storeTypeblock:(StoreTypeBlock)Typeblock;
+ (void)showWithData:(NSDictionary*)dict view:(UIView *)view SkipUIIdentifier: (NSString*) SkipUIIdentifier withTypeblock:(StoreTypeBlock)Typeblock;
+ (void)dismiss;

@end

NS_ASSUME_NONNULL_END
