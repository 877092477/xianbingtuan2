//
//  NSString+Emoji.m
//  THB
//
//  Created by Weller on 2019/3/1.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "NSString+Emoji.h"

@implementation NSString (Emoji)

- (NSString*) emojiEncode {
    
    NSString *regexStr =@"(?:[\\uD83C\\uDF00-\\uD83D\\uDDFF]|[\\uD83E\\uDD00-\\uD83E\\uDDFF]|[\\uD83D\\uDE00-\\uD83D\\uDE4F]|[\\uD83D\\uDE80-\\uD83D\\uDEFF]|[\\u2600-\\u26FF]\\uFE0F?|[\\u2700-\\u27BF]\\uFE0F?|\\u24C2\\uFE0F?|[\\uD83C\\uDDE6-\\uD83C\\uDDFF]{1,2}|[\\uD83C\\uDD70\\uD83C\\uDD71\\uD83C\\uDD7E\\uD83C\\uDD7F\\uD83C\\uDD8E\\uD83C\\uDD91-\\uD83C\\uDD9A]\\uFE0F?|[\\u0023\\u002A\\u0030-\\u0039]\\uFE0F?\\u20E3|[\\u2194-\\u2199\\u21A9-\\u21AA]\\uFE0F?|[\\u2B05-\\u2B07\\u2B1B\\u2B1C\\u2B50\\u2B55]\\uFE0F?|[\\u2934\\u2935]\\uFE0F?|[\\u3030\\u303D]\\uFE0F?|[\\u3297\\u3299]\\uFE0F?|[\\uD83C\\uDE01\\uD83C\\uDE02\\uD83C\\uDE1A\\uD83C\\uDE2F\\uD83C\\uDE32-\\uD83C\\uDE3A\\uD83C\\uDE50\\uD83C\\uDE51]\\uFE0F?|[\\u203C\\u2049]\\uFE0F?|[\\u25AA\\u25AB\\u25B6\\u25C0\\u25FB-\\u25FE]\\uFE0F?|[\\u00A9\\u00AE]\\uFE0F?|[\\u2122\\u2139]\\uFE0F?|\\uD83C\\uDC04\\uFE0F?|\\uD83C\\uDCCF\\uFE0F?|[\\u231A\\u231B\\u2328\\u23CF\\u23E9-\\u23F3\\u23F8-\\u23FA]\\uFE0F?)";
    NSError *error;
    
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:regexStr
                                                                           options:0
                                                                             error:&error];
    
    NSArray<NSTextCheckingResult*> *array = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    NSMutableString *result = [[NSMutableString alloc] initWithString:self];
    for (NSInteger index = array.count - 1; index >= 0; index--) {
        NSString *str = [self substringWithRange:array[index].range];
        [result replaceCharactersInRange:array[index].range withString:[NSString stringWithFormat:@"[emoji]%@[/emoji]", [str kr_encodeBase64]]];
        
    }
    return result;
}
- (NSString*) emojiDecode {
    
    NSString *regexStr =@"\\[emoji\\]([\\s\\S]*?)\\[\\/emoji\\]";
    NSError *error;
    
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:regexStr
                                                                           options:0
                                                                             error:&error];
    
    NSArray<NSTextCheckingResult*> *array = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    NSMutableString *result = [[NSMutableString alloc] initWithString:self];
    for (NSInteger index = array.count - 1; index >= 0; index--) {
        NSString *str = [self substringWithRange:array[index].range];
        NSString *decodeStr = [[str substringWithRange:NSMakeRange(7, str.length - 15)] kr_decodeBase64];
        [result replaceCharactersInRange:array[index].range withString:decodeStr];
        
    }
    
    return result;
}

@end
