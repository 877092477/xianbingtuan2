//
//  NSString+Emoji.h
//  THB
//
//  Created by Weller on 2019/3/1.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Emoji)

- (NSString*) emojiEncode;
- (NSString*) emojiDecode;

@end

NS_ASSUME_NONNULL_END
