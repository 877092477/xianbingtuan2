//
//  UIImageView+BXExtension.m
//  JYJ不得姐
//
//  Created by JYJ on 16/5/4.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "UIImageView+BXExtension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (BXExtension)
- (void)setHeader:(NSString *)url
{
    UIImage *placeholder = [DEFAULT circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
}

- (void)setUrlImg:(NSString *)url{
    UIImage *placeholder = DEFAULT;
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType == SDImageCacheTypeNone || cacheType == SDImageCacheTypeDisk) {
            self.image = image;
            self.alpha = 0;
            [UIView animateWithDuration:1 animations:^{
                self.alpha = 1.f;
            }];
        } else {
            self.image = image;
            self.alpha = 1.f;
        }
    }];
}

- (void)setNoPlaceholderUrlImg:(NSString *)url{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType == SDImageCacheTypeNone || cacheType == SDImageCacheTypeDisk) {
            self.image = image;
            self.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.alpha = 1.f;
            }];
        } else {
            self.image = image;
            self.alpha = 1.f;
        }
    }];
}

@end
