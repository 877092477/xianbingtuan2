//
//  FNConvertCompileItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConvertCompileItemCell.h"

@implementation FNConvertCompileItemCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNConvertCompileItemCellID";
    FNConvertCompileItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews{
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    self.rightBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    //[self.rightBtn setTitleColor:RGB(255, 108, 65) forState:UIControlStateNormal];
    
    
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    self.compileField.delegate=self;
    self.compileField.font = kFONT15;
    //self.compileField.keyboardType = UIKeyboardTypeDecimalPad;//UIKeyboardTypePhonePad;
    [self addSubview:self.compileField];
    
    //[self.compileField becomeFirstResponder];
    
    [self.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self, 19).rightSpaceToView(self, 15).heightIs(20);
    
    self.compileField.sd_layout
    .leftSpaceToView(self, 15).bottomSpaceToView(self, 7).rightSpaceToView(self, 85).heightIs(20);
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 10).bottomSpaceToView(self, 7).heightIs(20);//.widthIs(70);
    
    [self.rightBtn setupAutoSizeWithHorizontalPadding:10 buttonHeight:20];
    
    //self.titleLB.text=@"兑换积分数(分)";
    //self.compileField.placeholder=@"最多可兑换数";
    //self.compileField.textColor=RGB(255, 108, 65);
    //[self.rightBtn setTitle:@"全部" forState:UIControlStateNormal];
    
    UIView *line=[UIView new];
    line.backgroundColor=RGB(240, 240, 240);
    [self addSubview:line];
    line.sd_layout
    .leftSpaceToView(self, 15).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(1);
    
}
 
- (void)textFieldDidEndEditing:(UITextField *)textField{ 
//    if ([self.delegate respondsToSelector:@selector(didCompileItemAction:withContent:)]) {
//        [self.delegate didCompileItemAction:self.index withContent:textField.text];
//    }
}
- (void)textFieldDidChange:(id)sender{
    UITextField *field = (UITextField *)sender;
    if ([self.delegate respondsToSelector:@selector(didCompileItemAction:withContent:)]) {
        [self.delegate didCompileItemAction:self.index withContent:field.text];
    }
}
-(void)setModel:(FNConvertEditItemfeModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.titleStr;
        self.compileField.placeholder=model.hintStr;
        //self.compileField.textColor=RGB(255, 108, 65);
        self.compileField.text=model.valueStr;
        if(model.moreShow==1){
            self.rightBtn.hidden=NO;
            [self.rightBtn setTitle:model.msgStr forState:UIControlStateNormal];
            self.compileField.enabled=YES;
        }else{
            self.rightBtn.hidden=YES;
            [self.rightBtn setTitle:@"" forState:UIControlStateNormal];
            self.compileField.enabled=NO;
        }
        NSString *valueStr=@"";
        if([model.compute_type isEqualToString:@"int"]){
           self.compileField.keyboardType = UIKeyboardTypePhonePad;
           NSInteger valueInt=[model.titleStr integerValue];
           valueStr=[NSString stringWithFormat:@"%ld",(long)valueInt];
        }
        if([model.compute_type isEqualToString:@"float2"]){
           self.compileField.keyboardType = UIKeyboardTypeDecimalPad;
           CGFloat valueFloat=[model.titleStr floatValue];
           valueStr=[NSString stringWithFormat:@"%.2f",valueFloat];
        }
        self.compileField.text=valueStr;
    }
}
@end
