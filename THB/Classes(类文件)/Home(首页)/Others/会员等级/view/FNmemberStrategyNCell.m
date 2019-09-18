//
//  FNmemberStrategyNCell.m
//  THB
//
//  Created by 李显 on 2018/9/8.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNmemberStrategyNCell.h"
#import "GradeMemberNModel.h"
#import "FNGradelItemNView.h"


@implementation FNmemberStrategyNCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"memberStrategyCell";
    FNmemberStrategyNCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    
    return cell;
}

#pragma mark - 加载

-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor=[UIColor clearColor];
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    
    //橙色view
    self.orangeBgView=[UIView new];
    self.orangeBgView.backgroundColor=FNColor(241, 157, 57);
    self.orangeBgView.cornerRadius=5;
    [self.contentView addSubview:self.orangeBgView];
    
    //备注1
    self.remarkOneLB=[UILabel new];
    self.remarkOneLB.numberOfLines=0;
    self.remarkOneLB.textAlignment=NSTextAlignmentLeft;
    [self addOneLabelWithLabView:self.remarkOneLB TextColor:[UIColor whiteColor] fontSize:10 addSub:self.orangeBgView];
    
    //备注2
    self.remarkTwoLB=[UILabel new];
    [self addOneLabelWithLabView:self.remarkTwoLB TextColor:[UIColor whiteColor] fontSize:12 addSub:self.orangeBgView];
    
    //灰色长条1
    self.orangelineImage=[UIImageView new];
    self.orangelineImage.backgroundColor=[UIColor whiteColor];
    [self.orangeBgView addSubview:self.orangelineImage];
   
    //白色view
    self.whiteBgView=[UIView new];
    self.whiteBgView.backgroundColor=[UIColor whiteColor];
    self.whiteBgView.cornerRadius=5;
    [self.contentView addSubview:self.whiteBgView];
    //[self.contentView bringSubviewToFront:self.whiteBgView];

    //self.GoodsImage.contentMode=UIViewContentModeScaleToFill;
    //self.GoodsImage.image=IMAGE(@"APP底图.png");
    
    //等级大图片
    self.gradeImageView=[UIImageView new];
    self.gradeImageView.contentMode=UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.gradeImageView];
    [self.contentView bringSubviewToFront:self.gradeImageView];
    
    //等级数字图片
    self.gradeNumberImageView=[UIImageView new];
    self.gradeNumberImageView.contentMode=UIViewContentModeScaleToFill;
    [self.whiteBgView addSubview:self.gradeNumberImageView];
    
    //值scrollView
    self.priceScrollView = [UIScrollView new];
    self.priceScrollView.contentSize = CGSizeMake(JMScreenWidth-120, 100);
    self.priceScrollView.showsVerticalScrollIndicator=NO;
    [self.whiteBgView addSubview:self.priceScrollView];
    
    //灰色长条1
    self.grayOneImageView=[UIImageView new];
    self.grayOneImageView.cornerRadius=5/2;
    self.grayOneImageView.backgroundColor=FNColor(242, 242, 242);
    [self.whiteBgView addSubview:self.grayOneImageView];
    
    //灰色长条2
    self.grayTwoImageView=[UIImageView new];
    self.grayTwoImageView.cornerRadius=5/2;
    self.grayTwoImageView.backgroundColor=FNColor(242, 242, 242);
    [self.whiteBgView addSubview:self.grayTwoImageView];
    
    //等级
    self.gradeLB=[UILabel new];
    [self addOneLabelWithLabView:self.gradeLB TextColor:[UIColor blackColor] fontSize:12 addSub:self.whiteBgView];
    
    //累计人标题
    self.addUpPeopleTitleLB=[UILabel new];
    [self addOneLabelWithLabView:self.addUpPeopleTitleLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.whiteBgView];
    
    //累计人数
    self.addUpPeopleNumberLB=[UILabel new];
    self.addUpPeopleNumberLB.textAlignment=NSTextAlignmentRight;
    [self addOneLabelWithLabView:self.addUpPeopleNumberLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.whiteBgView];
    
    //累计其他标题
    self.addUpValTitleLB=[UILabel new];
    [self addOneLabelWithLabView:self.addUpValTitleLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.whiteBgView];
    
    //累计其他值
    self.addUpValNumberLB=[UILabel new];
    self.addUpValNumberLB.textAlignment=NSTextAlignmentRight;
    [self addOneLabelWithLabView:self.addUpValNumberLB TextColor:[UIColor grayColor] fontSize:10 addSub:self.whiteBgView];
    
    
    
    [self initdistribute];
    
    
}
-(void)initdistribute{
    //橙色view
    self.orangeBgView.sd_layout
    .leftSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 15).heightIs(self.contentView.height*0.2).bottomSpaceToView(self.contentView,5);
     //白色view
    self.whiteBgView.sd_layout
    .leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, self.contentView.height*0.2).bottomSpaceToView(self.contentView, self.contentView.height*0.2-2);
    //.heightIs(JMScreenWidth-80-10);
    UILabel *line=[UILabel new];
    //line.backgroundColor=[UIColor whiteColor];
    [self.whiteBgView addSubview:line];
    line.sd_layout
    .heightIs(0.5).centerYEqualToView(self.whiteBgView).widthIs(100).centerXEqualToView(self.whiteBgView);
    //等级
    self.gradeLB.sd_layout
    .centerXEqualToView(self.whiteBgView).topSpaceToView(line, 0).heightIs(20);
    //.centerXEqualToView(self.whiteBgView).centerYEqualToView(self.whiteBgView);
    [self.gradeLB setSingleLineAutoResizeWithMaxWidth:100];
    //等级数字图片
    self.gradeNumberImageView.sd_layout
    .centerYEqualToView(self.gradeLB).rightSpaceToView(self.gradeLB, 10).heightIs(20).widthIs(20);
    //.centerYEqualToView(self.whiteBgView).rightSpaceToView(self.gradeLB, 10).heightIs(20).widthIs(20);
    //灰色长条1
    //self.grayOneImageView.sd_layout.leftSpaceToView(self.whiteBgView, 20).rightSpaceToView(self.whiteBgView, 20).topSpaceToView(self.gradeLB, 20).heightIs(5);
    
    //累计人标题
    //self.addUpPeopleTitleLB.sd_layout.leftSpaceToView(self.whiteBgView, 20).topSpaceToView(self.grayOneImageView, 10).heightIs(15);
    //[self.addUpPeopleTitleLB setSingleLineAutoResizeWithMaxWidth:150];
    //累计人数
    //self.addUpPeopleNumberLB.sd_layout.rightSpaceToView(self.whiteBgView, 20).topSpaceToView(self.grayOneImageView, 10).heightIs(15);
    //[self.addUpPeopleNumberLB setSingleLineAutoResizeWithMaxWidth:80];
    
   
    //灰色长条2
    //self.grayTwoImageView.sd_layout.leftSpaceToView(self.whiteBgView, 20).rightSpaceToView(self.whiteBgView, 20).topSpaceToView(self.addUpPeopleNumberLB, 10).heightIs(5);
    
    //累计其他标题
    //self.addUpValTitleLB.sd_layout.leftSpaceToView(self.whiteBgView, 20).topSpaceToView(self.grayTwoImageView, 10).heightIs(15);
    //[self.addUpValTitleLB setSingleLineAutoResizeWithMaxWidth:150];
    
    //累计其他值
    //self.addUpValNumberLB.sd_layout.rightSpaceToView(self.whiteBgView, 20).topSpaceToView(self.grayTwoImageView, 10).heightIs(15);
    //[self.addUpValNumberLB setSingleLineAutoResizeWithMaxWidth:80];
    
    //灰色长条1
//    self.orangelineImage.sd_layout
//    .centerYEqualToView(self.orangeBgView).leftSpaceToView(self.orangeBgView, 10).rightSpaceToView(self.orangeBgView, 10).heightIs(0.5);
    
    //备注1
    //self.remarkOneLB
    //.sd_layout.rightSpaceToView(self.orangeBgView, 20).leftSpaceToView(self.orangeBgView, 20).bottomSpaceToView(self.orangeBgView, 5);
    
    //.sd_layout.rightSpaceToView(self.orangeBgView, 20).leftSpaceToView(self.orangeBgView, 20).topSpaceToView(self.orangeBgView, 7).bottomSpaceToView(self.orangelineImage, 5);
    
    //备注2
//    self.remarkTwoLB.sd_layout
//    .rightSpaceToView(self.orangeBgView, 20).leftSpaceToView(self.orangeBgView, 20).topSpaceToView(self.remarkOneLB, 5).bottomSpaceToView(self.orangeBgView, 5);
    
    //等级大图片
    self.gradeImageView.sd_layout
    .leftSpaceToView(self.contentView, 20).rightSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).heightIs(self.contentView.height*0.45);
    
    //值scrollView
    self.priceScrollView.sd_layout
    .leftSpaceToView(self.whiteBgView, 20).rightSpaceToView(self.whiteBgView, 20).topSpaceToView(self.gradeLB, 5).bottomSpaceToView(self.whiteBgView, 5);
    
}

//AddLB
-(void)addOneLabelWithLabView:(UILabel *)label TextColor:(UIColor *)textColor fontSize:(float)fontSize addSub:(UIView *)View{
    label.textColor = textColor;
    //label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont fontWithDevice:fontSize];
    [View addSubview:label];
    
}

- (void)setModel:(GradeStrategyModel *)model{
    NSLog(@"strategyModel:%@",model.name);
    //self.model=model;
    
    if(model){
        //等级大图
        self.gradeImageView.image=IMAGE(@"level6_pic");
        [self.gradeImageView setUrlImg:model.img];
        //等级
        self.gradeLB.text=model.name;//@"钻石";
        NSInteger gradeNumber= [model.num integerValue];
        NSArray *gradeImageArr=@[@"level1",@"level2",@"level3",@"level4",@"level5",@"level6"];
         
        
        //等级数字图片
        self.gradeNumberImageView.image=IMAGE(gradeImageArr[gradeNumber-1]);
       
        
        //累计人标题
        //self.addUpPeopleTitleLB.text=@"累计邀请完成购物人数";
        //累计人数
        //self.addUpPeopleNumberLB.text=@"8人";
        //累计其他标题
        //self.addUpValTitleLB.text=@"累计赚红包金额";
        //累计其他值
        //self.addUpValNumberLB.text=@"151元";
        //灰色长条1
        self.orangelineImage.image=IMAGE(@"levelbar_on");
        //备注1
        NSString *joint= model.content;
        self.remarkOneLB.text = joint;  
        CGSize size = [self.remarkOneLB sizeThatFits:CGSizeMake(JMScreenWidth-120, MAXFLOAT)];
        self.remarkOneLB.frame = CGRectMake(20,10, JMScreenWidth-120, size.height);
        //self.remarkOneLB.lineBreakMode = NSLineBreakByWordWrapping;
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:joint];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.remarkOneLB.text length])];
        [self.remarkOneLB setAttributedText:attributedString];
        [self.remarkOneLB sizeToFit];
        //备注2
        //self.remarkTwoLB.text=@"邀新用户,邀人红包加强10%";
        NSArray *tiaojian=model.tiaojian;
        NSMutableArray *itemarr=[NSMutableArray arrayWithCapacity:0];
        CGFloat itemWidth=JMScreenWidth-130;
        for (NSDictionary*dictry in tiaojian) {
            [itemarr addObject:[StrategyItemModel  mj_objectWithKeyValues:dictry]];
        }
        self.priceScrollView.contentSize=CGSizeMake(itemWidth, itemarr.count*35);
        //[self.priceScrollView removeFromSuperview];
        for (FNGradelItemNView *ItemView in self.priceScrollView.subviews) {
            [ItemView removeFromSuperview];
        }
        CGFloat W = JMScreenWidth-130;
        CGFloat H = 30;
        for (int i = 0 ; i< itemarr.count; i++) {
            CGFloat X = 0;
            NSUInteger Y = (i / 1) * (H +5);
            CGFloat top = 5;
            StrategyItemModel *model= itemarr[i];
            FNGradelItemNView *ItemView=[FNGradelItemNView new];
            ItemView.frame=CGRectMake(X, Y+top, W, H);
            ItemView.model=model;
            [self.priceScrollView addSubview:ItemView];
            
        }
        
    }
     //[self.contentView setNeedsLayout];
       
}
@end
