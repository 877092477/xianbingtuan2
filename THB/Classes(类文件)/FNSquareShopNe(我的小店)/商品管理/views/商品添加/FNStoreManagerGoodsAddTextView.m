//
//  FNStoreManagerGoodsAddTextView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/14.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerGoodsAddTextView.h"

@interface FNStoreManagerGoodsAddTextView()<UITextViewDelegate>

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UILabel *lblCount;

@end

@implementation FNStoreManagerGoodsAddTextView

#define MAX_LENGTH 70

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vContent = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _txvDesc = [[UITextView alloc] init];
    
    [self addSubview:_vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_txvDesc];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.bottom.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@20);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_txvDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblTitle.mas_bottom).offset(8);
        make.left.equalTo(@14);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(54);
    }];
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.textColor = RGB(24, 24, 24);
    _lblTitle.font = kFONT14;
    
    _txvDesc.font = kFONT12;
    _txvDesc.delegate = self;
    _txvDesc.textColor = RGB(204, 204, 204);
    
    _lblPlaceholder = [[UILabel alloc] init];
    _lblCount = [[UILabel alloc] init];
    
    [_vContent addSubview:_lblPlaceholder];
    [_vContent addSubview:_lblCount];
    
    [_lblPlaceholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txvDesc).offset(8);
        make.left.equalTo(self.txvDesc).offset(8);
        make.right.lessThanOrEqualTo(self.txvDesc).offset(-8);
        
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txvDesc.mas_bottom).offset(10);
        make.left.greaterThanOrEqualTo(@20);
        make.right.equalTo(@-10);
        make.bottom.equalTo(@-10);
    }];
    
    _lblPlaceholder.textColor = RGB(204, 204, 204);
    _lblPlaceholder.font = kFONT12;
    _lblPlaceholder.text = @"请输入商品详情";
    
    _lblCount.textColor = RGB(204, 204, 204);
    _lblCount.font = kFONT12;
//    _lblCount.text = @"0/70";
    _lblCount.text = [NSString stringWithFormat:@"0/%d", MAX_LENGTH];
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length <= 0) {
        self.lblPlaceholder.alpha = 1;
    }else{
        self.lblPlaceholder.alpha = 0;
    }
    _lblCount.text = [NSString stringWithFormat:@"%lu/%d", (unsigned long)textView.text.length, MAX_LENGTH];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
    if (str.length > MAX_LENGTH)
    {
//        NSRange rangeIndex = [str rangeOfComposedCharacterSequenceAtIndex:200];
//
//        if (rangeIndex.length == 1)//字数超限
//        {
//            textView.text = [str substringToIndex:200];
//            //这里重新统计下字数，字数超限，我发现就不走textViewDidChange方法了，你若不统计字数，忽略这行
//            _lblCount.text = [NSString stringWithFormat:@"%lu/%d", (unsigned long)textView.text.length, MAX_LENGTH];
//        }else{
//            NSRange rangeRange = [str rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 200)];
//            textView.text = [str substringWithRange:rangeRange];
//        }
        return NO;
    }
    return YES;
}


@end
