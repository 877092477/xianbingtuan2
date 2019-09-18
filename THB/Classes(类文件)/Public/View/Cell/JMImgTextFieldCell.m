//
//  JMImgTextFieldCell.m
//  THB
//
//  Created by jimmy on 2017/3/31.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMImgTextFieldCell.h"

@implementation JMImgTextFieldCell

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
        UIView*line = [UIView new];
        line.backgroundColor = FNHomeBackgroundColor;
        [self addSubview:line];
        [line autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
        [line autoSetDimension:(ALDimensionHeight) toSize:1.0];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    _imgView = [UIImageView new];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imgView];
    
    _textField = [UITextField new];
    _textField.font = kFONT14;
    [self.contentView addSubview:_textField];
    
    [_imgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [_imgView autoSetDimensionsToSize:(CGSizeMake(20, 20))];
    [_imgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_textField autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.imgView withOffset: LeftSpace];
    [_textField autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_textField autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:LeftSpace];
    [_textField autoSetDimension:(ALDimensionHeight) toSize:40];
    
    [FNNotificationCenter addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_textField];
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"JMImgTextFieldCell";
    JMImgTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[JMImgTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
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
