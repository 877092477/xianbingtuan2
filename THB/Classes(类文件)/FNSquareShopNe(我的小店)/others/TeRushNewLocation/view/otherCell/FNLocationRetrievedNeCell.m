//
//  FNLocationRetrievedNeCell.m
//  69橙子
//
//  Created by 李显 on 2018/12/10.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNLocationRetrievedNeCell.h"

@implementation FNLocationRetrievedNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=FNWhiteColor;
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    
    self.stateImage=[[UIImageView alloc]init];
    
    [self.contentView addSubview:self.stateImage];
    
    //名字
    self.name=[UILabel new];
    
    self.name.font=kFONT15;
    [self.contentView addSubview:self.name];
    
    //名字
    self.address=[UILabel new];
    
    self.address.font=kFONT13;
    [self.contentView addSubview:self.address];
    
    //名字
    self.distance=[UILabel new];
    self.distance.text=@"设为默认地址";
    self.distance.font=kFONT13;
    [self.contentView addSubview:self.distance];
    
    [self initializedSubviews];
    
}



#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    CGFloat interval_10 = 10;
    
    self.stateImage.sd_layout
    .centerYEqualToView(self.contentView).widthIs(18).heightIs(18).leftSpaceToView(self.contentView, interval_10);
    
    //右边标题
    self.name.sd_layout
    .topSpaceToView(self.contentView, interval_10).leftSpaceToView(self.stateImage, interval_10).heightIs(20).rightSpaceToView(self.contentView, 10);
    
    //右边标题
    self.address.sd_layout
    .topSpaceToView(self.name, interval_10).leftSpaceToView(self.stateImage, interval_10).heightIs(20).rightSpaceToView(self.contentView, 10);
    
}

-(void)setModel:(FNHsearchModel *)model{
    _model=model;
    if(model){
        self.name.text=model.name;
        self.address.text=model.address;
        if(model.state==0){
            self.stateImage.image=IMAGE(@"Fn_locationBlue");
        }else{
            self.stateImage.image=IMAGE(@"Fn_locationCircle");
        }
        
    }
}
@end
