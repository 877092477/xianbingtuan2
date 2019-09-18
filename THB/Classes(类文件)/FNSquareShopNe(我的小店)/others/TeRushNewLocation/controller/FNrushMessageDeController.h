//
//  FNrushMessageDeController.h
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "FNHContactModel.h"
@protocol FNrushMessageDeControllerDelegate <NSObject>

//选择电话
-(void)inSelectPhoneAction:(NSString*)send;

@end

@interface FNrushMessageDeController : SuperViewController
@property(nonatomic ,weak) id<FNrushMessageDeControllerDelegate> delegate;
@end

 
