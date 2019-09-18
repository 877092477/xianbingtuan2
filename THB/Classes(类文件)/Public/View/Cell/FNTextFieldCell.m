//
//  FNTextFieldCell.m
//  THB
//
//  Created by Fnuo-iOS on 2018/6/8.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNTextFieldCell.h"

@implementation FNTextFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    _textField = [UITextField new];
    _textField.font = kFONT14;
    _textField.borderColor=FNGlobalTextGrayColor;
    _textField.borderWidth=1;
    _textField.cornerRadius=5;
    [self.contentView addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.equalTo(@5);
        make.bottom.equalTo(@-5);
    }];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, self.frame.size.height)];
    _textField.leftViewMode=UITextFieldViewModeAlways;
    _textField.leftView=view;
    
    [FNNotificationCenter addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_textField];
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNTextFieldCell";
    FNTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark -  observing
- (void)textFieldTextDidChange:(NSNotification *)ntf{
    if (self.textDidChangeBlock) {
        self.textDidChangeBlock(_indexPath,_textField.text);
    }
}
- (void)dealloc{
    [FNNotificationCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
