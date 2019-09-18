//
//  FNCustomeNavigationBar.m
//  Two_Code
//
//  Created by jimmy on 2017/2/9.
//  Copyright © 2017年 Jimmy_Ng. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */
#import "FNCustomeNavigationBar.h"
#define CNBMargin 10

#define CNBMidMargin (isIphoneX? 40:20)
@implementation FNCustomeNavigationBar
@synthesize rightButton = _rightButton,leftButton = _leftButton;
+ (instancetype)customeNavigationBarWithTextFieldFrame:(CGRect)frame  andPlaceholder:(NSString *)palceholder{
    FNCustomeNavigationBar *navgationBar = [[FNCustomeNavigationBar alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, JMNavBarHeigth))];
    navgationBar.textField.frame = frame;
    navgationBar.textField.placeholder = palceholder; 
    return navgationBar;
}
+ (instancetype)customeNavigationBarWithSearchBarFrame:(CGRect)frame andPlaceholder:(NSString*)palceholder{
    FNCustomeNavigationBar *navgationBar = [[FNCustomeNavigationBar alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, JMNavBarHeigth))];
    navgationBar.searchBar.frame = frame;
    navgationBar.searchBar.placeholder = palceholder;
    navgationBar.searchBar.delegate = navgationBar;
    return navgationBar;
}

+ (instancetype)customeNavigationBarWithTitle:(NSString *)title{
    FNCustomeNavigationBar *navgationBar = [[FNCustomeNavigationBar alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, JMNavBarHeigth))];
    navgationBar.titleLabel.text = title;
    [navgationBar.titleLabel sizeToFit];
    navgationBar.titleLabel.centerY = (navgationBar.height-CNBMidMargin)*0.5+CNBMidMargin;
    navgationBar.titleLabel.centerX = navgationBar.width*0.5;
    return navgationBar;
}
+ (instancetype)customeNavigationBarWithCustomeView:(UIView *)customeview{
    FNCustomeNavigationBar *navgationBar = [[FNCustomeNavigationBar alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, JMNavBarHeigth))];
    navgationBar.customeview = customeview;
    navgationBar.customeview.centerY = (navgationBar.height-CNBMidMargin)*0.5+CNBMidMargin;
    navgationBar.customeview.centerX = navgationBar.width*0.5;
    return navgationBar;
}

+ (instancetype)customeNavigationBarWithBgImageViewAddLable:(UIView *)customeview withTitle:(NSString*)title{
    FNCustomeNavigationBar *navgationBar = [[FNCustomeNavigationBar alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, JMNavBarHeigth))];
    navgationBar.customeview = customeview;
    //navgationBar.customeview.centerY = (navgationBar.height-CNBMidMargin)*0.5+CNBMidMargin;
    //navgationBar.customeview.centerX = navgationBar.width*0.5;
    navgationBar.customeview.frame=CGRectMake(0, 0, XYScreenWidth, JMNavBarHeigth);
    navgationBar.ImagetitleLabel.text = title;
    [navgationBar.ImagetitleLabel sizeToFit];
    navgationBar.ImagetitleLabel.centerY = (navgationBar.height-CNBMidMargin)*0.5+CNBMidMargin;
    navgationBar.ImagetitleLabel.centerX = navgationBar.customeview.centerX;
    
    return navgationBar;
}
#pragma mark - setter ,getter
 
- (UISearchBar *)searchBar{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.backgroundImage = [UIImage createImageWithColor:FNWhiteColor];
        [self addSubview:_searchBar];
    }
    return _searchBar;
}
- (FNCustomSearchBar *)textField{
    if (_textField == nil) {
        _textField = [[FNCustomSearchBar alloc]init];
        _textField.backgroundColor = FNWhiteColor;
        _textField.font = kFONT14;
        [self addSubview:_textField];
    }
    return _textField;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = FNWhiteColor;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIView *)rightButton{
    if (_rightButton == nil) {
        _rightButton = [UIView new];
        [self addSubview:_rightButton];
    }
    return _rightButton;
}
- (UIView *)leftButton{
    if (_leftButton == nil) {
        _leftButton = [UIView new];;
        [self addSubview:_leftButton];
    }
    return _leftButton;
}

- (UILabel *)ImagetitleLabel{
    if (_ImagetitleLabel == nil) {
        _ImagetitleLabel = [UILabel new];
        _ImagetitleLabel.font = [UIFont boldSystemFontOfSize:16];
        _ImagetitleLabel.textColor = FNWhiteColor;
        [_customeview addSubview:_ImagetitleLabel];
    }
    return _ImagetitleLabel;
}
- (void)setRightButton:(UIView *)rightButton{
    _rightButton = rightButton;
    _rightButton.x = self.width -_rightButton.width - CNBMargin;
    _rightButton.centerY =(self.height-CNBMidMargin)*0.5+CNBMidMargin;
    [self addSubview:_rightButton];
    if ( _textField) {
        if (_leftButton) {
            self.textField.x = CGRectGetMaxX(_leftButton.frame)+CNBMargin;
            self.textField.width = self.width-_rightButton.width-_leftButton.width-CNBMargin*4;
        }else{
            self.textField.width = self.width-_rightButton.width-CNBMargin*3;
        }
        self.textField.centerY =   _leftButton.centerY ;
    }
    if (_searchBar) {
        
        if (_leftButton) {
            self.searchBar.x = CGRectGetMaxX(_leftButton.frame)+CNBMargin;
            self.searchBar.width = self.width-_rightButton.width-_leftButton.width-CNBMargin*4;
        }else{
            self.searchBar.width = self.width-_rightButton.width-CNBMargin*3;
        }
        self.searchBar.centerY =   _leftButton.centerY ;
    }
}
- (void)setLeftButton:(UIView *)leftButton{
    _leftButton = leftButton;
    _leftButton.x = CNBMargin;
    _leftButton.centerY =(self.height-CNBMidMargin)*0.5+CNBMidMargin;
    [self addSubview:_leftButton];
    if (_textField) {
        if (_rightButton) {
            self.textField.width = self.width-_rightButton.width-_leftButton.width-CNBMargin*4;
        }else{
            self.textField.width = self.width-_leftButton.width-CNBMargin*3;
        }
        self.textField.x = CGRectGetMaxX(_leftButton.frame)+CNBMargin;
        self.textField.centerY =   _leftButton.centerY ;
    }
    if (_searchBar) {
        if (_rightButton) {
            self.searchBar.width = self.width-_rightButton.width-_leftButton.width-CNBMargin*4;
        }else{
            self.searchBar.width = self.width-_leftButton.width-CNBMargin*3;
        }
        self.searchBar.x = CGRectGetMaxX(_leftButton.frame)+CNBMargin;
        self.searchBar.centerY =   _leftButton.centerY ;
    }
}

- (void)setCustomeview:(UIView *)customeview{
    _customeview = customeview;
    if (_customeview) {
        [self addSubview:_customeview];
    }
}

#pragma mark - Search bar delegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    if (self.SearchBarDidBeginEditing) {
        self.SearchBarDidBeginEditing(searchBar);
    }
    
   
}
-(void)setSearchImg:(NSString *)searchImg{
    _searchImg=searchImg;
    if (searchImg) {
        XYLog(@"searchImg=:%@",searchImg);
        if ([searchImg kr_isNotEmpty]) {
            [_searchBar setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:URL(searchImg)]] forSearchBarIcon:UISearchBarIconSearch  state:UIControlStateNormal];
        }
    }
}
-(void)setSearchColor:(NSString *)searchColor{
    _searchColor=searchColor;
    if (searchColor) {
        XYLog(@"searchColor=:%@",searchColor);
        UITextField *searchField = [_searchBar valueForKey:@"searchField"];
        if (searchField) {
            //[UIColor colorWithHexString:searchColor];
            if ([_searchBar.placeholder kr_isNotEmpty]) {
                NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:_searchBar.placeholder attributes:
                                                  @{NSForegroundColorAttributeName:[UIColor colorWithHexString:searchColor],
                                                    NSFontAttributeName:[UIFont systemFontOfSize:14]}];
                searchField.attributedPlaceholder = attrString;
            }
        }
    }
}
@end

