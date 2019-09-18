//
//  FNmerIssueEditOCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerIssueEditOCell.h"

@implementation FNmerIssueEditOCell
//+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath withStyle:(NSInteger)styleInt{
//    static NSString *reuseIdentifier = @"FNmerIssueEditOCellID";
//    FNmerIssueEditOCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.index = indexPath; 
//    cell.styleState=styleInt;
//    if (cell.bgView.superview != cell) {
//      // [cell initializedSubviews];
//    }
//    return cell;
//}
 

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    
    self.dibuView=[[UIView alloc]init];
    [self.bgView addSubview:self.dibuView];
    
    self.leftTitleLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.leftTitleLB];
    
    self.hintBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.hintBtn];
    
//    self.rightLB=[[UILabel alloc]init];
//    [self.bgView addSubview:self.rightLB];
//
//    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.bgView addSubview:self.rightBtn];
//
//    self.switchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.bgView addSubview:self.switchBtn];
//
//    self.onlineBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.bgView addSubview:self.onlineBtn];
//
//    self.offlineBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.bgView addSubview:self.offlineBtn];
    
    [self.onlineBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    [self.offlineBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    self.onlineBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.offlineBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.onlineBtn.titleLabel.font=kFONT14;
    self.offlineBtn.titleLabel.font=kFONT14;
    
    self.leftTitleLB.font=[UIFont systemFontOfSize:14];
    self.leftTitleLB.textColor=RGB(24, 24, 24);
    self.leftTitleLB.textAlignment=NSTextAlignmentLeft;
    
    self.rightLB.font=[UIFont systemFontOfSize:14];
    self.rightLB.textColor=RGB(24, 24, 24);
    self.rightLB.textAlignment=NSTextAlignmentRight;
    
    self.hintBtn.titleLabel.font=[UIFont systemFontOfSize:11];
    [self.hintBtn setTitleColor:RGB(24, 24, 24) forState:UIControlStateNormal];
    self.hintBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.bgView.cornerRadius=5;
    
    
    
//    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
//    self.compileField.delegate=self;
//    self.compileField.font = kFONT14;
//    //self.compileField.keyboardType = UIKeyboardTypeDecimalPad;//UIKeyboardTypePhonePad;
//    self.compileField.textAlignment=NSTextAlignmentRight;
//    [self.bgView addSubview:self.compileField];
//    [self.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//    self.switchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.bgView addSubview:self.switchBtn];
    
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 20).rightSpaceToView(self, 20).topSpaceToView(self, 0).heightIs(45);
    
    self.dibuView.sd_layout
    .rightSpaceToView(self.bgView, 20).heightIs(2).widthIs(2).bottomEqualToView(self.bgView);
    
    self.leftTitleLB.sd_layout
    .leftSpaceToView(self.bgView, 15).centerYEqualToView(self.bgView).widthIs(150).heightIs(20);
    
    self.hintBtn.sd_layout
    .leftSpaceToView(self, 35).rightSpaceToView(self, 37).topSpaceToView(self.bgView, 2).bottomSpaceToView(self, 5);//.heightIs(20)
    self.hintBtn.titleLabel.sd_layout
    .leftSpaceToView(self.hintBtn, 0).rightSpaceToView(self.hintBtn, 0).topSpaceToView(self.hintBtn, 0).bottomSpaceToView(self.hintBtn, 0);//.heightIs(20).centerYEqualToView(self.hintBtn);
    
    [self addStyleView];
    
//    self.rightLB.sd_layout
//    .rightSpaceToView(self.bgView, 15).centerYEqualToView(self.bgView).widthIs(30).heightIs(20);
//
//    self.compileField.sd_layout
//    .rightSpaceToView(self.bgView, 47).centerYEqualToView(self.bgView).heightIs(25).leftSpaceToView(self.leftTitleLB, 10);
//
//    self.rightBtn.sd_layout
//    .rightSpaceToView(self.bgView, 15).centerYEqualToView(self.bgView).heightIs(30).leftSpaceToView(self.leftTitleLB, 10);
//
//    self.rightBtn.imageView.sd_layout
//    .centerYEqualToView(self.rightBtn).widthIs(6).heightIs(11).rightSpaceToView(self.rightBtn, 2);
//
//    self.rightBtn.titleLabel.sd_layout
//    .centerYEqualToView(self.rightBtn).leftSpaceToView(self.rightBtn, 5).heightIs(20).rightSpaceToView(self.rightBtn, 25);
//
//    self.switchBtn.sd_layout
//    .rightSpaceToView(self.bgView, 15).centerYEqualToView(self.leftTitleLB).widthIs(34).heightIs(22);
//
//    self.offlineBtn.sd_layout
//    .rightSpaceToView(self.bgView, 10).centerYEqualToView(self.bgView).heightIs(30).widthIs(55);
//
//    self.offlineBtn.imageView.sd_layout
//    .centerYEqualToView(self.offlineBtn).widthIs(14).heightIs(14).leftSpaceToView(self.offlineBtn, 0);
//
//    self.offlineBtn.titleLabel.sd_layout
//    .centerYEqualToView(self.offlineBtn).leftSpaceToView(self.offlineBtn, 16).heightIs(20).rightSpaceToView(self.offlineBtn, 4);
//
//    self.onlineBtn.sd_layout
//    .rightSpaceToView(self.offlineBtn, 65).centerYEqualToView(self.bgView).heightIs(30).widthIs(55);
//
//    self.onlineBtn.imageView.sd_layout
//    .centerYEqualToView(self.onlineBtn).widthIs(14).heightIs(14).leftSpaceToView(self.onlineBtn, 0);
//
//    self.onlineBtn.titleLabel.sd_layout
//    .centerYEqualToView(self.onlineBtn).leftSpaceToView(self.onlineBtn, 16).heightIs(20).rightSpaceToView(self.onlineBtn, 4);
    
    
    self.rightBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    //[self.rightBtn setImage:IMAGE(@"FJ_orsj_img") forState:UIControlStateNormal];
    [self.rightBtn setImage:IMAGE(@"integral_order_image_more") forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font=kFONT14;
    [self.hintBtn addTarget:self action:@selector(hintBtnClick:)];
    [self.rightBtn addTarget:self action:@selector(rightBtnClick:)];
    [self.switchBtn addTarget:self action:@selector(switchBtnClick:)]; 
    [self.offlineBtn addTarget:self action:@selector(offlineBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.onlineBtn addTarget:self action:@selector(onlineBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.hintBtn.selected=NO;
    self.offlineBtn.selected=NO;
    self.onlineBtn.selected=NO;
    
    [self.offlineBtn setImage:IMAGE(@"FN_CXNorKuangimg") forState:UIControlStateNormal];
    [self.offlineBtn setImage:IMAGE(@"FN_CXYKuangimg") forState:UIControlStateSelected];
    [self.onlineBtn setImage:IMAGE(@"FN_CXNorKuangimg") forState:UIControlStateNormal];
    [self.onlineBtn setImage:IMAGE(@"FN_CXYKuangimg") forState:UIControlStateSelected];
    
    self.compileField.hidden=YES;
    self.rightLB.hidden=YES;
    self.rightBtn.hidden=YES;
    self.switchBtn.hidden=YES;
    self.offlineBtn.hidden=YES;
    self.onlineBtn.hidden=YES;
    
   
    
}
-(void)addStyleView{
    //1:只编辑 2:只显示文字 3:编辑+单位  4:不能编辑显示选择文字 5:不能编辑 只选择开关 6:线上线下按钮
  //  if(self.styleState==1 || self.styleState==2){
        self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
        self.compileField.delegate=self;
        self.compileField.font = kFONT14;
        //self.compileField.keyboardType = UIKeyboardTypeDecimalPad;//UIKeyboardTypePhonePad;
        self.compileField.textAlignment=NSTextAlignmentRight;
        [self.bgView addSubview:self.compileField];
        [self.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.compileField.sd_layout
        .rightSpaceToView(self.bgView, 15).centerYEqualToView(self.bgView).heightIs(25).leftSpaceToView(self.leftTitleLB, 10);
       // if(self.styleState==1){
       //     [self.compileField setEnabled:YES];
       // }
       // if(self.styleState==2){
       //     [self.compileField setEnabled:NO];
       // }
//    }
    
   // if(self.styleState==3){
//        self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
//        self.compileField.delegate=self;
//        self.compileField.font = kFONT14;
//        self.compileField.textAlignment=NSTextAlignmentRight;
//        [self.bgView addSubview:self.compileField];
//        self.compileField.sd_layout
//        .rightSpaceToView(self.bgView, 47).centerYEqualToView(self.bgView).heightIs(25).leftSpaceToView(self.leftTitleLB, 10);
    
        self.rightLB=[[UILabel alloc]init];
        [self.bgView addSubview:self.rightLB];
        
        self.rightLB.font=[UIFont systemFontOfSize:14];
        self.rightLB.textColor=RGB(24, 24, 24);
        self.rightLB.textAlignment=NSTextAlignmentRight;
        
        self.rightLB.sd_layout
        .rightSpaceToView(self.bgView, 15).centerYEqualToView(self.bgView).widthIs(30).heightIs(20);
        
 //   }
 //   if(self.styleState==4){
        self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgView addSubview:self.rightBtn];
        
        self.rightBtn.titleLabel.textAlignment=NSTextAlignmentRight;
        //[self.rightBtn setImage:IMAGE(@"FJ_orsj_img") forState:UIControlStateNormal];
        [self.rightBtn setImage:IMAGE(@"integral_order_image_more") forState:UIControlStateNormal];
        self.rightBtn.titleLabel.font=kFONT14;
        
        self.rightBtn.sd_layout
        .rightSpaceToView(self.bgView, 15).centerYEqualToView(self.bgView).heightIs(30).leftSpaceToView(self.leftTitleLB, 10);
        
        self.rightBtn.imageView.sd_layout
        .centerYEqualToView(self.rightBtn).widthIs(6).heightIs(11).rightSpaceToView(self.rightBtn, 2);
        
        self.rightBtn.titleLabel.sd_layout
        .centerYEqualToView(self.rightBtn).leftSpaceToView(self.rightBtn, 5).heightIs(20).rightSpaceToView(self.rightBtn, 25);
  //  }
   // if(self.styleState==5){
        self.switchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgView addSubview:self.switchBtn];
        self.switchBtn.sd_layout
        .rightSpaceToView(self.bgView, 15).centerYEqualToView(self.leftTitleLB).widthIs(34).heightIs(22);
  //  }
  //  if(self.styleState==6){
        self.onlineBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgView addSubview:self.onlineBtn];
        
        self.offlineBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgView addSubview:self.offlineBtn];
        
        [self.onlineBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        [self.offlineBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        self.onlineBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
        self.offlineBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
        self.onlineBtn.titleLabel.font=kFONT14;
        self.offlineBtn.titleLabel.font=kFONT14;
        
        self.offlineBtn.sd_layout
        .rightSpaceToView(self.bgView, 10).centerYEqualToView(self.bgView).heightIs(30).widthIs(55);
        
        self.offlineBtn.imageView.sd_layout
        .centerYEqualToView(self.offlineBtn).widthIs(14).heightIs(14).leftSpaceToView(self.offlineBtn, 0);
        
        self.offlineBtn.titleLabel.sd_layout
        .centerYEqualToView(self.offlineBtn).leftSpaceToView(self.offlineBtn, 16).heightIs(20).rightSpaceToView(self.offlineBtn, 4);
        
        self.onlineBtn.sd_layout
        .rightSpaceToView(self.offlineBtn, 65).centerYEqualToView(self.bgView).heightIs(30).widthIs(55);
        
        self.onlineBtn.imageView.sd_layout
        .centerYEqualToView(self.onlineBtn).widthIs(14).heightIs(14).leftSpaceToView(self.onlineBtn, 0);
        
        self.onlineBtn.titleLabel.sd_layout
        .centerYEqualToView(self.onlineBtn).leftSpaceToView(self.onlineBtn, 16).heightIs(20).rightSpaceToView(self.onlineBtn, 4);
  //  }
  //  [self setNeedsLayout];
}
- (void)textFieldDidChange:(id)sender{
    //UITextField *field = (UITextField *)sender;
}

-(void)hintBtnClick:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(didMerIssueLuckIndex:withLuck:)]) {
        [self.delegate didMerIssueLuckIndex:self.index withLuck:@""];
    }
}
-(void)rightBtnClick:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(didMerIssueCouponUseIndex:withView:)]) {
        [self.delegate didMerIssueCouponUseIndex:self.index withView:self];
    }
}
-(void)switchBtnClick:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(didMerIssueEditSwitch:withView:)]) {
        [self.delegate didMerIssueEditSwitch:self.index withView:self];
    }
}
-(void)offlineBtnClick:(UIButton*)btn{
    btn.selected=!btn.selected;
    NSString *methodStr=@"0";
    if(btn.selected==YES){
       methodStr=@"1";
    }else{
       methodStr=@"0";
    }
    if ([self.delegate respondsToSelector:@selector(didMerIssueEditPaymentMethod:withOnShop:)]) {
        [self.delegate didMerIssueEditPaymentMethod:self.index withOnShop:methodStr];
    }
}
-(void)onlineBtnClick:(UIButton*)btn{
    btn.selected=!btn.selected;
    NSString *methodStr=@"0";
    if(btn.selected==YES){
       methodStr=@"1";
    }else{
       methodStr=@"0";
    }
    if ([self.delegate respondsToSelector:@selector(didMerIssueEditPaymentMethod:withOnLine:)]) {
        [self.delegate didMerIssueEditPaymentMethod:self.index withOnLine:methodStr];
    } 
}

-(void)setModel:(FNmerIssueocModel *)model{
    _model=model;
    if(model){
        self.leftTitleLB.text=model.title;
        self.rightLB.text=model.unit;
        [self.hintBtn setTitle:model.bottomHint forState:UIControlStateNormal];
        if([model.value kr_isNotEmpty]){
           self.compileField.text=model.value;
        }
        self.compileField.placeholder=model.valueHint;
        
        //底部提示
        if(model.isBoth==1||model.isBoth==2){
            if([model.value1Orange kr_isNotEmpty]){
                [self.hintBtn.titleLabel fn_changeColorWithTextColor:RGB(255, 103, 35) changeText:model.value1Orange];
            }
        }
        if(model.isBoth==2){
            if([model.value1Orange kr_isNotEmpty]&&[model.value2Orange kr_isNotEmpty]){
                [self.hintBtn.titleLabel fn_changeColorWithTextColor:RGB(255, 103, 35) changeTexts:@[model.value1Orange,model.value2Orange]];
            }
            
        }
        
        //编辑键盘样式
        if([model.editType isEqualToString:@"defu"]){
            self.compileField.keyboardType = UIKeyboardTypeDefault;
        }
        else if([model.editType isEqualToString:@"float"]){
            self.compileField.keyboardType = UIKeyboardTypeDecimalPad;
        }
        else if([model.editType isEqualToString:@"int"]){
            self.compileField.keyboardType = UIKeyboardTypeNumberPad;
        }
        else{
            self.compileField.keyboardType = UIKeyboardTypeDefault;
        }
       
        
        if(model.isStyle==1){
            self.compileField.hidden=NO;
            self.rightLB.hidden=YES;
            self.rightBtn.hidden=YES;
            self.switchBtn.hidden=YES;
            self.offlineBtn.hidden=YES;
            self.onlineBtn.hidden=YES;
            self.compileField.sd_resetLayout
            .rightSpaceToView(self.bgView, 15).centerYEqualToView(self.bgView).heightIs(25).leftSpaceToView(self.leftTitleLB, 10);
            [self.compileField setEnabled:YES];
        }
        else if(model.isStyle==2){
            self.compileField.hidden=NO;
            self.rightLB.hidden=YES;
            self.rightBtn.hidden=YES;
            self.switchBtn.hidden=YES;
            self.offlineBtn.hidden=YES;
            self.onlineBtn.hidden=YES;
            self.compileField.sd_resetLayout
            .rightSpaceToView(self.bgView, 15).centerYEqualToView(self.bgView).heightIs(25).leftSpaceToView(self.leftTitleLB, 10);
            [self.compileField setEnabled:NO];
        }
        else if(model.isStyle==3){
            [self.compileField setEnabled:YES];
            self.compileField.hidden=NO;
            self.rightLB.hidden=NO;
            self.rightBtn.hidden=YES;
            self.switchBtn.hidden=YES;
            self.offlineBtn.hidden=YES;
            self.onlineBtn.hidden=YES;
//            self.compileField.sd_layout
//            .rightSpaceToView(self.bgView, 47).centerYEqualToView(self.bgView).heightIs(25).leftSpaceToView(self.leftTitleLB, 10);
            self.compileField.sd_resetLayout
            .rightSpaceToView(self.bgView, 47).centerYEqualToView(self.bgView).heightIs(25).leftSpaceToView(self.leftTitleLB, 10);
            
            self.rightLB.sd_resetLayout
            .rightSpaceToView(self.bgView, 15).centerYEqualToView(self.bgView).widthIs(30).heightIs(20);
        }
        else if(model.isStyle==4){
            self.compileField.hidden=YES;
            self.rightLB.hidden=YES;
            self.rightBtn.hidden=NO;
            self.switchBtn.hidden=YES;
            self.offlineBtn.hidden=YES;
            self.onlineBtn.hidden=YES;
            if([model.value kr_isNotEmpty]){
                [self.rightBtn setTitle:model.value forState:UIControlStateNormal];
                [self.rightBtn setTitleColor:RGB(24, 24, 24) forState:UIControlStateNormal];
            }else{
                [self.rightBtn setTitle:model.valueHint forState:UIControlStateNormal];
                [self.rightBtn setTitleColor:RGB(204, 204, 204) forState:UIControlStateNormal];
            }
//            self.compileField.sd_layout
//            .rightSpaceToView(self.bgView, 47).centerYEqualToView(self.bgView).heightIs(25).leftSpaceToView(self.leftTitleLB, 10);
            self.rightBtn.sd_resetLayout
            .rightSpaceToView(self.bgView, 15).centerYEqualToView(self.bgView).heightIs(30).leftSpaceToView(self.leftTitleLB, 10);
            
            self.rightBtn.imageView.sd_resetLayout
            .centerYEqualToView(self.rightBtn).widthIs(6).heightIs(11).rightSpaceToView(self.rightBtn, 2);
            
            self.rightBtn.titleLabel.sd_resetLayout
            .centerYEqualToView(self.rightBtn).leftSpaceToView(self.rightBtn, 5).heightIs(20).rightSpaceToView(self.rightBtn, 25);
        }
        else if(model.isStyle==5){
            self.compileField.hidden=YES;
            self.rightLB.hidden=YES;
            self.rightBtn.hidden=YES;
            self.switchBtn.hidden=NO;
            self.offlineBtn.hidden=YES;
            self.onlineBtn.hidden=YES;
            if(model.switchState==0){
                [self.switchBtn setBackgroundImage:IMAGE(@"FN_xdSJ_gbimg") forState:UIControlStateNormal];
            }else{
                [self.switchBtn setBackgroundImage:IMAGE(@"FN_xdSJ_kqim") forState:UIControlStateNormal];
            }
//            self.compileField.sd_layout
//            .rightSpaceToView(self.bgView, 47).centerYEqualToView(self.bgView).heightIs(25).leftSpaceToView(self.leftTitleLB, 10);
            
            self.switchBtn.sd_resetLayout
            .rightSpaceToView(self.bgView, 15).centerYEqualToView(self.leftTitleLB).widthIs(34).heightIs(22);
        }
        else if(model.isStyle==6){
            self.compileField.hidden=YES;
            self.rightLB.hidden=YES;
            self.rightBtn.hidden=YES;
            self.switchBtn.hidden=YES;
            self.offlineBtn.hidden=NO;
            self.onlineBtn.hidden=NO;
//            self.compileField.sd_layout
//            .rightSpaceToView(self.bgView, 47).centerYEqualToView(self.bgView).heightIs(25).leftSpaceToView(self.leftTitleLB, 10);
//            self.offlineBtn.hidden=NO;
//            self.onlineBtn.hidden=NO;
            [self.onlineBtn setTitle:model.online forState:UIControlStateNormal];
            [self.offlineBtn setTitle:model.offline forState:UIControlStateNormal];
            
            CGFloat onlineW=[model.online kr_getWidthWithTextHeight:30 font:14];
            CGFloat offlineW=[model.offline kr_getWidthWithTextHeight:30 font:14];
            if(onlineW>60){
               onlineW=60;
            }
            if(offlineW>60){
               offlineW=60;
            }
            self.offlineBtn.sd_resetLayout
            .rightSpaceToView(self.bgView, 10).centerYEqualToView(self.bgView).heightIs(30).widthIs(offlineW+20);
            
            self.offlineBtn.imageView.sd_resetLayout
            .centerYEqualToView(self.offlineBtn).widthIs(14).heightIs(14).leftSpaceToView(self.offlineBtn, 0);
            
            self.offlineBtn.titleLabel.sd_resetLayout
            .centerYEqualToView(self.offlineBtn).leftSpaceToView(self.offlineBtn, 16).heightIs(20).rightSpaceToView(self.offlineBtn, 4);
            
            self.onlineBtn.sd_resetLayout
            .rightSpaceToView(self.offlineBtn, 65).centerYEqualToView(self.bgView).heightIs(30).widthIs(onlineW+20);
            
            self.onlineBtn.imageView.sd_resetLayout
            .centerYEqualToView(self.onlineBtn).widthIs(14).heightIs(14).leftSpaceToView(self.onlineBtn, 0);
            
            self.onlineBtn.titleLabel.sd_resetLayout
            .centerYEqualToView(self.onlineBtn).leftSpaceToView(self.onlineBtn, 16).heightIs(20).rightSpaceToView(self.onlineBtn, 4);
            
            if([model.onlineState integerValue]==0){
                self.onlineBtn.selected=NO;
            }
            if([model.onlineState integerValue]==1){
                self.onlineBtn.selected=YES;
            }
            if([model.offlineState integerValue]==0){
                self.offlineBtn.selected=NO;
            }
            if([model.offlineState integerValue]==1){
               self.offlineBtn.selected=YES;
            }
        }
        else{
//            self.compileField.hidden=YES;
//            self.rightLB.hidden=YES;
//            self.rightBtn.hidden=YES;
//            self.switchBtn.hidden=YES;
//            self.compileField.sd_layout
//            .rightSpaceToView(self.bgView, 47).centerYEqualToView(self.bgView).heightIs(25).leftSpaceToView(self.leftTitleLB, 10);
        }
        if([model.type isEqualToString:@"pub_red_packet_list"]){
           [self.leftTitleLB fn_changeColorWithTextColor:RGB(255, 103, 35) changeText:@"*"];
        }
        if([model.type isEqualToString:@"pub_yhq_list"]){
           [self.leftTitleLB fn_changeColorWithTextColor:RGB(255, 114, 0) changeText:@"*"];
        }
        if([model.type isEqualToString:@"red_packet"]){
           [self.leftTitleLB fn_changeColorWithTextColor:RGB(255, 103, 35) changeText:@"*"];
        }
        if([model.type isEqualToString:@"yhq"]){
           [self.leftTitleLB fn_changeColorWithTextColor:RGB(255, 114, 0) changeText:@"*"];
        }
        if([model.type isEqualToString:@"full_reduction"]){
           [self.leftTitleLB fn_changeColorWithTextColor:RGB(2, 188, 165) changeText:@"*"];
        }
        if([model.type isEqualToString:@"discount"]){
           [self.leftTitleLB fn_changeColorWithTextColor:RGB(255, 76, 74) changeText:@"*"];
        } 
       
    }
} 
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    XYLog(@"开始编辑");
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    XYLog(@"结束编辑=== %@",textField.text);
    if ([self.delegate respondsToSelector:@selector(didMerIssueEditOC:withContent:)]) {
        [self.delegate didMerIssueEditOC:self.index withContent:textField.text];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if([self.model.editType isEqualToString:@"float"]||[self.model.editType isEqualToString:@"int"]){
        //限制只能输入数字
        BOOL isHaveDian = YES;
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            unichar single = [string characterAtIndex:0];//当前输入的字符
            if([self.model.editType isEqualToString:@"int"]){
                if (single == '.') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            if ((single >= '0' && single <= '9') || single == '.') {
                //数据格式正确
                if([textField.text length] == 0){
                    if(single == '.') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                //输入的字符是否是小数点
                if (single == '.') {
                    if(!isHaveDian) {
                        //text中还没有小数点
                        isHaveDian = YES;
                        return YES;
                    }else{
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    //存在小数点
                    if (isHaveDian) {
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 2) {
                            return YES;
                        }else{
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{
                //输入的数据格式不正确
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
    }
    
    return YES;
    
}
@end
