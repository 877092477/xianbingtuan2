//
//  FNrushPhoneListDeController.h
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FNrushPhoneListDeControllerDelegate <NSObject>

//选择电话
-(void)inSelectPhoneAction:(NSString*)send;

@end

@interface FNrushPhoneListDeController : UITableViewController
@property(nonatomic ,weak) id<FNrushPhoneListDeControllerDelegate> delegate;
@end


