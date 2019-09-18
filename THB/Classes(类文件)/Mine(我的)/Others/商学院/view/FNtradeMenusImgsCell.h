//
//  FNtradeMenusImgsCell.h
//  THB
//
//  Created by Jimmy on 2019/6/24.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNtradeMenusImgsCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *allImgView;
@property(nonatomic,assign)NSInteger typeInt;//(1代表幻灯片)//2:代表横滑菜单
@end

NS_ASSUME_NONNULL_END
