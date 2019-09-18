//
//  FNcardActTeModel.h
//  THB
//
//  Created by 李显 on 2019/2/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNcardActTeModel : NSObject
@property(nonatomic,strong)NSString *sign_rule_bjimg;
@property(nonatomic,strong)NSString *sign_rule_font;
@property(nonatomic,strong)NSString *sign_rule_title;
@property(nonatomic,strong)NSString *sign_rule_title2;
@property(nonatomic,strong)NSArray *explain; 
@property(nonatomic,strong)NSArray *rule;
@end

NS_ASSUME_NONNULL_END
