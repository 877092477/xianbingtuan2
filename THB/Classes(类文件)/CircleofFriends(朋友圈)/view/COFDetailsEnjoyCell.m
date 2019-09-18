//
//  COFDetailsEnjoyCell.m
//  THB
//
//  Created by 李显 on 2018/8/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//点赞cell
#import "COFDetailsEnjoyCell.h"

@implementation COFDetailsEnjoyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
//UI
-(void)setCompositionView{
    //三角view
    _triangleView = [[UIImageView alloc]init];
    [self.contentView addSubview:_triangleView];
    //self.triangleView=triangleView;
    
    //背景view
    _ligryView = [UIView new];
    _ligryView.backgroundColor= FNColor(249,249,249);
    _ligryView.cornerRadius=5;
    [self.contentView addSubview:_ligryView];
    
    //喜欢
    _likeView = [[UIImageView alloc]init];
    //_likeView.contentMode = UIViewContentModeCenter;
    [self.ligryView addSubview:_likeView];
    
    //图片scrollView
    _ImageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 0, JMScreenWidth-100, 45)];
    _ImageScrollView.alwaysBounceHorizontal = YES; // 水平方向弹簧效果
    _ImageScrollView.alwaysBounceVertical = NO;
    _ImageScrollView.directionalLockEnabled = YES;
    _ImageScrollView.contentSize = CGSizeMake(JMScreenWidth, 45);
    [self.ligryView addSubview:_ImageScrollView];
    
    
    [self placeView];
    
}

//布局
-(void)placeView{
    CGFloat interval_10=10;
    self.triangleView.sd_layout
    .leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 20).heightIs(5).widthIs(interval_10);
    self.ligryView.sd_layout
    .leftSpaceToView(self.contentView, interval_10).rightSpaceToView(self.contentView, interval_10).topSpaceToView(self.triangleView, 0).bottomSpaceToView(self.contentView, 0);
    self.likeView.sd_layout
    .leftSpaceToView(self.ligryView, interval_10).topSpaceToView(self.ligryView, 20).heightIs(15).widthIs(16);
    self.ImageScrollView.sd_layout
    .leftSpaceToView(self.likeView, interval_10).topSpaceToView(self.ligryView, 5).bottomSpaceToView(self.ligryView, 5).rightSpaceToView(self.ligryView, 0);
   
}
-(void)setHeadArr:(NSArray *)headArr{
    
    XYLog(@"like:%@",headArr);
    _headArr=headArr;
    _triangleView.image=IMAGE(@"circle_triangle");
    _likeView.image=IMAGE(@"circle_lover");
    _ImageScrollView.contentSize = CGSizeMake(_headArr.count*55, 45);
    CGFloat itemWidth = 45;
    CGFloat itemHeight = 45;
    NSInteger loc = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSInteger i = 0; i < _headArr.count; i ++) {
        LikeHeadPortraitModel *model=_headArr[i];
        loc = i % _headArr.count ;
        x = (itemWidth+10) * loc ;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, itemWidth, itemHeight)];
        button.cornerRadius=5;
        button.tag =  i;
        [button.imageView  setUrlImg:model.head_img];
        [button setImage:button.imageView.image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.ImageScrollView addSubview:button];
    }
}

//点击头像
-(void)selectClick:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(ClickToChooseThePicture:)] ) {
        [self.delegate ClickToChooseThePicture:btn];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
