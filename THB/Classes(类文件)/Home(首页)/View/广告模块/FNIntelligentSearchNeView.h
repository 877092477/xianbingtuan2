//
//  FNIntelligentSearchNeView.h
//  THB
//
//  Created by 李显 on 2018/10/9.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewProductDetailModel.h"

typedef enum : NSUInteger {
    Detail,
    TaoBao,
    PDD,
    JD,
    WPH
} FNIntelligentSearchType;

@interface FNIntelligentSearchNeView : UIView

typedef void(^StoreTypeBlock) (FNIntelligentSearchType type,NSString* content,FNNewProductDetailModel* model);

@property (nonatomic, strong)NSString* prasestring;

@property (nonatomic, strong)NSString* fnIDstring;
@property (nonatomic, strong) FNNewProductDetailModel *model;

@property (nonatomic, copy)void (^purchaseBlock) (id model);

@property (nonatomic, copy) StoreTypeBlock storeTypeBlock;
//@property (nonatomic, copy)void (^storeTypeBlock) (FNIntelligentSearchType type,NSString* content,FNNewProductDetailModel* model);

+ (void)showWithModel:(id)model view:(UIView *)view storeTypeblock:(StoreTypeBlock) Typeblock;

+ (void)showWithContent:(NSString*)content view:(UIView *)view withfnID:(NSString*)fuID type: (FNIntelligentSearchType)type yhq_url: (NSString*)yhq_url storeTypeblock:(StoreTypeBlock)Typeblock;
+ (void)dismiss;
@end
