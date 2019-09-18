//
//  CircleOfFriendsCell.m
//  THB
//
//  Created by 李显 on 2018/8/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "CircleOfFriendsCell.h"
#import "CircleOfFriendsFrame.h"
#import "CircleOfFriendsModel.h"
#import "CireleImageLeftBtn.h"
#import "CireleImageBtn.h"

#import "CircPhotoView.h"

@implementation CircleOfFriendsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setCircleFrame:(CircleOfFriendsFrame *)circleFrame{
    _circleFrame = circleFrame;
    
    _iconView.frame = circleFrame.iconFrame;
    _nameLab.frame = circleFrame.nameFrame;
    _goodsClassifyView.frame=circleFrame.goodsClassifyFrame;
    _timeLab.frame = circleFrame.timeFrame;
    _contentLab.frame = circleFrame.contentFrame;
    _likeBtn.frame = circleFrame.likeFrame;
    _disLikeBtn.frame = circleFrame.disLikeFrame;
    _shareBtn.frame = circleFrame.deleteFrame;
    //_goodsClassifyView.backgroundColor=[UIColor lightGrayColor]; 
    //CircleOfFriendsModel *commit = circleFrame.CircleOfFriends;
    CircleOfFriendsProductModel *commit = circleFrame.productModel;
    //左侧图片
    [_iconView sd_setImageWithURL:[NSURL URLWithString:commit.head_img] placeholderImage:IMAGE(@"APP底图.png")];
    //名字
    _nameLab.text = commit.nickname;
    //内容
    _contentLab.text =commit.content;
     //NSInteger time = [commit.add_time integerValue];
    //时间
    _timeLab.text =   [NSString  getTimeStr:commit.time withFormat:@"yyyy-MM-dd HH:mm"];
    //喜欢
    [_likeBtn setTitle:commit.thumbs_num];
    
    //评论
    [_disLikeBtn setTitle:commit.evaluate_num];//commit.unlike_count 
    
    //商品类型
    NSString* shop_type= commit.shop_type;
    if([shop_type isEqualToString:@"taobao"]){
        _goodsClassifyView.image=IMAGE(@"circle_taobao");
    }
    else if([shop_type isEqualToString:@"jingdong"]){
        _goodsClassifyView.image=IMAGE(@"circle_jd");
    }
    else if([shop_type isEqualToString:@"pinduoduo"]){
        _goodsClassifyView.image=IMAGE(@"circle_pdd");
    }
    else if([shop_type isEqualToString:@"tianmao"]){
        _goodsClassifyView.image=IMAGE(@"circle_tmall");
    }else if([shop_type isEqualToString:@"guanfang"]){
        _goodsClassifyView.image=IMAGE(@"circle_official");
    }
    
    //图片
    _photosView.pic_urls = commit.img;
    _photosView.frame = circleFrame.photosFrame;
    [_slinkBtn setImage:IMAGE(@"circle_link") forState:UIControlStateNormal];
    [_shareBtn setImage:IMAGE(@"circle_share") forState:UIControlStateNormal];
    if([commit.shop_type isEqualToString:@"guanfang"]){
        if([commit.type isEqualToString:@"pub_guanggao"] || [commit.type isEqualToString:@"pub_one_goods"]){
            [_detailsLab setTitle:@"查看详情" forState:UIControlStateNormal];
            _detailsLab.height=NO;
            _slinkBtn.height=NO;
            _detailsLab.frame=circleFrame.detailsFrame;
            _slinkBtn.frame=circleFrame.slinkFrame;
        }else{
            _detailsLab.height=YES;
            _slinkBtn.height=YES;
            [_detailsLab setTitle:@"" forState:UIControlStateNormal];
        }
        
    }else{
        _detailsLab.height=YES;
        _slinkBtn.height=YES;
        [_detailsLab setTitle:@"" forState:UIControlStateNormal];
    }
    //是否已点赞 0否 1是
    if( [commit.nickname kr_isNotEmpty]){
        [_disLikeBtn setImage:[UIImage imageNamed:@"circle_comment"]];
        if([commit.is_thumb integerValue]==1){
            [_likeBtn setImage:[UIImage imageNamed:@"circle_love_on"]];
        }else{
            [_likeBtn setImage:[UIImage imageNamed:@"circle_love_off"]];
        }
    }
    
    _lineLab.frame=CGRectMake(0, CGRectGetMaxY(_timeLab.frame)+14, FNDeviceWidth, 0.5);
    [self.contentView setNeedsLayout];
}

-(void)setUpAllView{
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.userInteractionEnabled = YES;
    UITapGestureRecognizer *icontap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconViewlick:)];
    [iconView addGestureRecognizer:icontap];
    CGFloat iconWH = HeightRealValue(100);
    iconView.cornerRadius=iconWH/2;
    [self.contentView addSubview:iconView];
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    //[iconView zj_cornerRadiusRoundingRect];
    _iconView = iconView;
    
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *nameLabtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconViewlick:)];
    [nameLab addGestureRecognizer:nameLabtap];
    [self addOneLabelWithLab:nameLab TextColor:FNColor(89,101,149) fontSize:15 isBold:NO];
    _nameLab = nameLab;
    
    UIImageView *goodsClassifyView = [[UIImageView alloc]init];
    goodsClassifyView.cornerRadius=5;
    [self.contentView addSubview:goodsClassifyView];
    goodsClassifyView.contentMode = UIViewContentModeScaleAspectFill;
    //[goodsClassifyView zj_cornerRadiusRoundingRect];
    _goodsClassifyView = goodsClassifyView;
    
    //时间
    UILabel *timeLab = [[UILabel alloc]init];
    [self addOneLabelWithLab:timeLab TextColor:FNColor(154,154,154) fontSize:12 isBold:NO];
    timeLab.textAlignment = NSTextAlignmentLeft;
    _timeLab = timeLab;
    //内容
    UILabel *contentLab = [[UILabel alloc]init];
    [self addOneLabelWithLab:contentLab TextColor:[UIColor blackColor] fontSize:14 isBold:NO];
    contentLab.numberOfLines = 0;
    _contentLab = contentLab;
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    longPressGesture.minimumPressDuration =2;
    _contentLab.userInteractionEnabled = YES;
    [_contentLab addGestureRecognizer:longPressGesture];
   
    //喜欢
    CireleImageBtn *likeBtn = [[CireleImageBtn alloc]init];
    likeBtn.titleLabel.textColor=FNColor(154,154,154);
    //[likeBtn setImage:[UIImage imageNamed:@"circle_love_off"]];
    likeBtn.ImageWide=15;
    likeBtn.ImageHigh=15;
    likeBtn.longestFloat=80;
    likeBtn.imageViewPosition = XYPositionLeft;
    likeBtn.subViewsMargin = 5;
    likeBtn.titleLabel.font =[UIFont systemFontOfSize:12];
    [self.contentView addSubview:likeBtn];
    [likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _likeBtn = likeBtn;
    
    //分享
    UIButton *shareBtn = [UIButton new];
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:shareBtn];
    _shareBtn = shareBtn;
    
    
    //评论
    CireleImageBtn *disLikeBtn = [[CireleImageBtn alloc]init];
    disLikeBtn.titleLabel.textColor=FNColor(154,154,154);
    disLikeBtn.ImageWide=15;
    disLikeBtn.ImageHigh=15;
    disLikeBtn.longestFloat=80;
    disLikeBtn.imageViewPosition = XYPositionLeft;
    disLikeBtn.subViewsMargin = 5;
    //[disLikeBtn setImage:[UIImage imageNamed:@"circle_comment"]];
    disLikeBtn.titleLabel.font =[UIFont systemFontOfSize:12];
    [self.contentView addSubview:disLikeBtn];
    _disLikeBtn = disLikeBtn;
    
    [disLikeBtn addTarget:self action:@selector(disLikeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     //图片
    CircPhotoView *photosView = [[CircPhotoView alloc]init]; 
    photosView.delegate=self;
    [self.contentView addSubview:photosView]; 
    _photosView = photosView;
    //详情
    UIButton *detailsBtn = [UIButton new];
    detailsBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    detailsBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    [detailsBtn addTarget:self action:@selector(detailsClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:detailsBtn];
    [detailsBtn setTitleColor:FNColor(89,101,149) forState:UIControlStateNormal];
    [detailsBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    _detailsLab = detailsBtn;
    UIButton *slinkBtn = [UIButton new];
    [slinkBtn addTarget:self action:@selector(detailsClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:slinkBtn];
    _slinkBtn = slinkBtn;
    
    
    UILabel *lineLab = [[UILabel alloc]init];
    lineLab.backgroundColor=FNColor(246, 246, 246);
    [self addOneLabelWithLab:lineLab TextColor:[UIColor whiteColor] fontSize:0 isBold:NO];
    _lineLab=lineLab;
}

-(void)handleTap:(UIGestureRecognizer*) recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        return;
    }else if (recognizer.state == UIGestureRecognizerStateBegan){
        [self becomeFirstResponder];
        UIMenuItem * item = [[UIMenuItem alloc]initWithTitle:@"复制文案" action:@selector(newFunc)];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [UIMenuController sharedMenuController].menuItems = @[item];
        [UIMenuController sharedMenuController].menuVisible = YES;
    }
}

-(void)newFunc{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.contentLab.text;
    [FNTipsView showTips:@"文案已复制到剪切板"];
}

-(BOOL)canBecomeFirstResponder {
    
    return YES;
}

// 可以响应的方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(newFunc)) {
        return YES;
    }
    return NO;
}



//代理
-(void)likeBtnClick:(CireleImageBtn *)sender{
    
    if ([self.delegate respondsToSelector:@selector(likeBtnClickAction:)] ) {
        [self.delegate likeBtnClickAction:sender];
    }
}
//评论
-(void)disLikeBtnClick:(CireleImageBtn *)sender{
    
    if ([self.delegate respondsToSelector:@selector(disLikeBtnClickAction:)]) {
        [self.delegate disLikeBtnClickAction:sender];
    }
    
}
//分享
-(void)shareBtnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(shareBtnClickAction:)]) {
        [self.delegate shareBtnClickAction:sender];
    }
}
//详情
-(void)detailsClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(detailsClickAction:)]) {
        [self.delegate detailsClickAction:sender];
    }
 
}
// 头像图片点击事件
-(void)iconViewlick:(UITapGestureRecognizer *)sender{ 
    if ([self.delegate respondsToSelector:@selector(selectIconImageViewAction:)] ) {
       [self.delegate selectIconImageViewAction:sender.view.tag];
    }
}
-(void)setChildBtnTag:(NSInteger)tag{
    _deleteBtn.tag = tag;
    _likeBtn.tag = tag;
    _disLikeBtn.tag = tag;
    _detailsLab.tag = tag;
    _slinkBtn.tag = tag;
    _iconView.tag = tag;
    _nameLab.tag = tag;
    _shareBtn.tag = tag;
    
}
//选择图片
- (void)pitchOnClickAction:(NSInteger )sender{
    XYLog(@"点击图片%ld",(long)sender);
    if ([self.delegate respondsToSelector:@selector(detailsClickAction:)]) {
        [self.delegate selectProductAction:sender row:self.ProductIndexpath.row];
    }
    
    
}


//LB
-(void)addOneLabelWithLab:(UILabel *)label TextColor:(UIColor *)textColor fontSize:(float)fontSize isBold:(BOOL)isBold{
    
    label.textColor = textColor;
    
    if (isBold) {
        label.font = [UIFont boldSystemFontOfSize:fontSize];
    }else{
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    [self.contentView addSubview:label];
    
}

//+(instancetype)cellWithTableView:(UITableView *)tableView{
//    static NSString *ID = @"ZJCommitCell";
//    id cell  = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//
//    return cell;
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
