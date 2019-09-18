//
//  COFEvaluateCell.m
//  THB
//
//  Created by 李显 on 2018/8/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

//评价
#import "COFEvaluateCell.h"

@implementation COFEvaluateCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
//UI
-(void)setCompositionView{
    
    //背景view
    _ligryView = [UIView new];
    _ligryView.backgroundColor= FNColor(249,249,249);
    _ligryView.cornerRadius=5;
    [self.contentView addSubview:_ligryView];
    
    //评价图片
    _evaluateView = [[UIImageView alloc]init];
    //_evaluateView.contentMode = UIViewContentModeCenter;
    //_evaluateView.image=IMAGE(@"circle_comment");
    [_ligryView addSubview:_evaluateView];
    
    //头像
    _headportraiImaget = [[UIImageView alloc]init];
    //_headportraiImaget.backgroundColor=[UIColor whiteColor];
    _headportraiImaget.userInteractionEnabled = YES;
    UITapGestureRecognizer *headtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headportraiClick:)];
    [_headportraiImaget addGestureRecognizer:headtap];
    [_ligryView addSubview:_headportraiImaget];
    
    //名字
    _nameLB=[UILabel new];
    _nameLB.font=[UIFont fontWithDevice:12];
    _nameLB.textColor=FNColor(89,101,149);
    _nameLB.userInteractionEnabled = YES;
    UITapGestureRecognizer *nametap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headportraiClick:)];
    [_nameLB addGestureRecognizer:nametap];
    [_ligryView addSubview:_nameLB];
    
    //时间
    _timeLB=[UILabel new];
    _timeLB.font=[UIFont fontWithDevice:11];
    _timeLB.textAlignment=NSTextAlignmentRight;
    _timeLB.textColor=FNColor(153,153,153);
    [_ligryView addSubview:_timeLB];
    
    //内容
    _contentLB=[UILabel new];
    _contentLB.numberOfLines=0;
    _contentLB.font=[UIFont fontWithDevice:12];
    _contentLB.userInteractionEnabled = YES;
    UITapGestureRecognizer *contenttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentClick:)];
    [_contentLB addGestureRecognizer:contenttap];
    [_ligryView addSubview:_contentLB];
    
    [self placeView];
    
}

//布局
-(void)placeView{
    CGFloat interval_10=10;
    CGFloat interval_20=20;
    //BGview
    self.ligryView.sd_layout
    .leftSpaceToView(self.contentView, interval_10).topSpaceToView(self.contentView, 0.5).rightSpaceToView(self.contentView, interval_10).bottomSpaceToView(self.contentView, 0);
    
    //评论图片
    self.evaluateView.sd_layout
    .leftSpaceToView(self.ligryView, interval_10).topSpaceToView(self.ligryView, interval_20).widthIs(16).heightIs(15);
    
    //头像图片
    self.headportraiImaget.sd_layout
    .leftSpaceToView(self.evaluateView, interval_10).topSpaceToView(self.ligryView, interval_10).widthIs(35).heightIs(35);
    
    //名字
    self.nameLB.sd_layout
    .leftSpaceToView(self.headportraiImaget, interval_10).topSpaceToView(self.ligryView, interval_10).heightIs(15);
    [self.nameLB setSingleLineAutoResizeWithMaxWidth:(120)];
    
    //时间
    self.timeLB.sd_layout
    .rightSpaceToView(self.ligryView, interval_10).topSpaceToView(self.ligryView, interval_10).heightIs(15);
    [self.nameLB setSingleLineAutoResizeWithMaxWidth:(100)];
    
    //内容
    self.contentLB.sd_layout
    .leftSpaceToView(self.headportraiImaget, interval_10).topSpaceToView(self.nameLB, 10).rightSpaceToView(self.ligryView, interval_10).heightIs(50);
    
    
    
}

-(void)setEvaluate:(EvaluateModel *)evaluate{
    
    _evaluate=evaluate;
    XYLog(@"pj_nickname:%@",_evaluate.pj_nickname);
    [self.headportraiImaget setUrlImg:_evaluate.pj_head_img];
    self.nameLB.text=_evaluate.pj_nickname;
    self.timeLB.text=[NSString  getTimeStr:_evaluate.time withFormat:@"yyyy-MM-dd HH:mm"];
    NSString *replyString=@"回复";
    NSString *contentString=@"";
    NSString *as_nicknamestring=_evaluate.as_nickname;
    if([as_nicknamestring kr_isNotEmpty]){
        as_nicknamestring=[NSString stringWithFormat:@"%@:",as_nicknamestring];
        contentString=[NSString stringWithFormat:@"%@%@%@",replyString,as_nicknamestring,_evaluate.content];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: contentString];
        [attributedString addAttribute:NSForegroundColorAttributeName value:FNColor(89,101,149) range:NSMakeRange(2, as_nicknamestring.length)];
        self.contentLB.attributedText = attributedString;
    }else{
        contentString=[NSString stringWithFormat:@"%@",_evaluate.content];
        
        self.contentLB.text=contentString;
    }
    CGFloat contentW = FNDeviceWidth - 105;
    CGSize conSize = [contentString sizeWithFont:[UIFont fontWithDevice:12] constrainedToSize:CGSizeMake(contentW, MAXFLOAT)];
   
    
    
    
    
    
    
   
    //内容
    self.contentLB.sd_layout
    .leftSpaceToView(self.headportraiImaget, 10).topSpaceToView(self.nameLB, 10).rightSpaceToView(self.ligryView, 10).heightIs(conSize.height);
    
    
    
}
-(void)setChildDetailsTag:(NSInteger)tag{
    _headportraiImaget.tag=tag;
    _nameLB.tag=tag;
    _contentLB.tag=tag;
}
// 头像图片点击事件
-(void)headportraiClick:(UITapGestureRecognizer *)sender{
    if ([self.delegate respondsToSelector:@selector(ClickProfilePhoto:)] ) {
        [self.delegate ClickProfilePhoto:sender.view.tag];
    }
}
//点击内容选择显示的回复人的ID
-(void)contentClick:(UITapGestureRecognizer *)sender{
    if ([self.delegate respondsToSelector:@selector(ClickWithContent:)] ) {
        [self.delegate ClickWithContent:sender.view.tag];
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
