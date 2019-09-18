//
//  CircleOfFriendsFrame.m
//  THB
//
//  Created by 李显 on 2018/8/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//


#import "CircleOfFriendsFrame.h"
#import "CircleOfFriendsModel.h"

@implementation CircleOfFriendsFrame
-(void)setCircleOfFriends:(CircleOfFriendsModel *)CircleOfFriends{
    //_CircleOfFriends = CircleOfFriends;
    
    //[self setUpAllViewFrame];
    
}
-(void)setProductModel:(CircleOfFriendsProductModel *)productModel{
    _productModel = productModel;
     NSLog(@"nickname:%@",productModel.nickname);
     NSLog(@"content:%@",productModel.content);
     NSLog(@"imgData:%@",productModel.img);
    
    [self setUpAllViewFrame];
    
}


-(void)setUpAllViewFrame{
    //图片
    CGFloat iconX = 15;
    CGFloat iconWH = HeightRealValue(100);
    CGFloat iconY = 10;
    self.iconFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //名字
    CGRect nameSize = [_productModel.nickname boundingRectWithSize:CGSizeMake(MAXFLOAT, 16)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                     context:nil]; 
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + 15;
    CGFloat nameW =  [self getWidthWithText:_productModel.nickname height:16 font:15];
    CGFloat namemaxW= FNDeviceWidth - nameX - 50;
    if(nameSize.size.width>namemaxW){
        nameW = namemaxW;
    }
    CGFloat nameY = 13;
    CGFloat nameH = 16;
    self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
   
    //商品类型
    CGFloat goodsClassifyX = CGRectGetMaxX(self.nameFrame) + 10;
    CGFloat goodsClassifyW = 40;
    CGFloat goodsClassifyY = 13;
    CGFloat goodsClassifyH = 16;
    self.goodsClassifyFrame = CGRectMake(goodsClassifyX, goodsClassifyY, goodsClassifyW, goodsClassifyH);
    
    //内容
    CGFloat contentX = nameX;
    CGFloat contentY = CGRectGetMaxY(_nameFrame)+10;
    CGFloat contentW = FNDeviceWidth - contentX - 15;
    CGSize conSize = [_productModel.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(contentW, MAXFLOAT)];
    self.contentFrame = CGRectMake(contentX, contentY, contentW, conSize.height);
    
    //图片
    if (_productModel.img.count) {
        CGFloat photoX = nameX;
        CGFloat photoY = CGRectGetMaxY(self.contentFrame)+10;
        CGSize photoSize = [self photosSizeWithCount:_productModel.img.count photoX:photoX];
        self.photosFrame = CGRectMake(photoX, photoY, photoSize.width, photoSize.height);
    }
   
    
    //查看详情
    CGFloat detailsX = nameX;
    CGFloat detailsY = _productModel.img.count > 0 ? CGRectGetMaxY(_photosFrame)+10  : CGRectGetMaxY(_contentFrame) + 10;
    CGFloat detailsW = 60;
    CGFloat detailsH = 18;
    if([_productModel.shop_type isEqualToString:@"guanfang"]){
        if([_productModel.type isEqualToString:@"pub_guanggao"] || [_productModel.type isEqualToString:@"pub_one_goods"]){
            detailsW = 60;
            detailsH = 18;
            
        }else{
            detailsW=0;
            detailsH=0;
            
        }
        
    }else{
        detailsW=0;
        detailsH=0;
       
    }
   
    self.detailsFrame=CGRectMake(detailsX, detailsY, detailsW, detailsH);
    
    //链接
    CGFloat slinksX = CGRectGetMaxX(self.detailsFrame) + 10;
    CGFloat slinkY = _productModel.img.count > 0 ? CGRectGetMaxY(_photosFrame)+10  : CGRectGetMaxY(_contentFrame) + 10;
    CGFloat slinkW = 15;
    CGFloat slinkH = 15;
    if([_productModel.shop_type isEqualToString:@"guanfang"]){
        if([_productModel.type isEqualToString:@"pub_guanggao"] || [_productModel.type isEqualToString:@"pub_one_goods"]){
            
            slinkW = 15;
            slinkH = 15;
        }else{
            
            slinkW = 15;
            slinkH = 15;
        }
        
    }else{
        
        slinkW=0;
        slinkH=0;
    }
   
   
    
    self.slinkFrame=CGRectMake(slinksX, slinkY, slinkW, slinkH);
    
    
    CGFloat likeY =    CGRectGetMaxY(_detailsFrame) + 10;
    
    //时间
    //NSLog(@"比例:%.2f",HeightRealValue(100));
    CGFloat timeW = 120;
    CGFloat timeX = nameX;
    CGFloat timeY = likeY;
    self.timeFrame = CGRectMake(timeX, timeY, timeW, 18);
    
    //评论
    NSString *commentNumber=_productModel.evaluate_num;
    CGFloat commentW =  [self getWidthWithText:commentNumber height:18 font:12];
    CGFloat dislikeY = likeY;
    CGFloat dislikeW = commentW+19;
    CGFloat dislikeX = FNDeviceWidth-dislikeW-15; //CGRectGetMaxX(self.likeFrame) + 5;
    CGFloat dislikeH =  18;
    self.disLikeFrame = CGRectMake(dislikeX, dislikeY, dislikeW, dislikeH);
    
    //喜欢
    NSString *likeNumber=_productModel.thumbs_num;
    CGFloat likelength =  [self getWidthWithText:likeNumber height:18 font:12];
    CGFloat likeX = dislikeX-likelength-19-10;
    CGFloat likeW = likelength+19;
    CGFloat likeH =  18;
    self.likeFrame = CGRectMake(likeX, likeY, likeW, likeH);
    
    //分享
    CGFloat deleteW = 15;
    CGFloat deleteH = 15;
    CGFloat deleteX = likeX-25;
    CGFloat deleteY = likeY;
    self.deleteFrame = CGRectMake(deleteX, deleteY, deleteW, deleteH);
    
    self.cellHeight = CGRectGetMaxY(_likeFrame) + 15;
    
    
}
// 计算配图的尺寸
-(CGSize)photosSizeWithCount:(NSUInteger)count photoX:(CGFloat)photoX{
    NSLog(@"photocount:%lu",(unsigned long)count);
    // 获取总的列数
    //NSUInteger cols = count == 4 ? 2 : 3;
    NSUInteger cols =3;
    // 获取总的行数 （总个数 - 1）/ 总列数
    NSUInteger rols = (count - 1 ) / cols + 1;
    
    // 计算图片的宽高
    CGFloat photoWH = (FNDeviceWidth - photoX - 15 - 2 * 10) / 3;
    NSLog(@"cols:%lu",(unsigned long)cols);
    NSLog(@"rols:%lu",(unsigned long)rols);
    NSLog(@"photoWH:%lu",(unsigned long)photoWH);
    CGFloat W = cols * photoWH + (cols - 1) * 10;
    CGFloat H = rols * photoWH + (cols - 1) * 10;
    if(count==1){
        W=FNDeviceWidth - photoX - 100;
        H=FNDeviceWidth - photoX - 100;
    }
    return CGSizeMake(W, H);
}
//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}

@end
