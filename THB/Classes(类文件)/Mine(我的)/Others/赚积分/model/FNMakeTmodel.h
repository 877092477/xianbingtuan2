//
//  FNMakeTmodel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNMakeTmodel : NSObject
@property (nonatomic, copy) NSString *task_s_title;
@property (nonatomic, copy) NSString *task_font_color;
@property (nonatomic, copy) NSString *task_bg;
@property (nonatomic, copy) NSString *task_btnbg;
@property (nonatomic, copy) NSString *task_btn_content;
@property (nonatomic, copy) NSString *task_jf_explain;
@property (nonatomic, copy) NSString *task_SkipUIIdentifier;
@property (nonatomic, copy) NSString *task_jf_btn_words;
@property (nonatomic, copy) NSString *task_btn_clolr;
@property (nonatomic, copy) NSString *task_jf_clolr;
@property (nonatomic, copy) NSString *task_title;
@property (nonatomic, copy) NSString *task_jf_btn_bg;
@property (nonatomic, copy) NSString *task_back_img;
@property (nonatomic, copy) NSArray  *jf;
@property (nonatomic, copy) NSArray  *jf_and_yj;
@property (nonatomic, copy) NSArray  *all_task;
@property (nonatomic, copy) NSDictionary  *skip;
@property (nonatomic, copy) NSString *jf_explain;
@end

@interface FNMakeJFTmodel : NSObject
@property (nonatomic, copy) NSString *jf;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *is_add;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *type;
@end

@interface FNMakeTaskTmodel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *task_count;
@property (nonatomic, copy) NSString *task;
@property (nonatomic, copy) NSString *task_bg;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSArray  *tasks;
@end
@interface FNMakeTaskItemTmodel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *cate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *desc_img;
@property (nonatomic, copy) NSString *integral;
@property (nonatomic, copy) NSString *unfinish_btn_wrods;
@property (nonatomic, copy) NSString *finish_btn_wrods;
@property (nonatomic, copy) NSString *lingqu_btn_wrods;
@property (nonatomic, copy) NSString *jifen_btn;
@property (nonatomic, copy) NSString *jifen_color;
@property (nonatomic, copy) NSString *describe_color;
@property (nonatomic, copy) NSString *name_color;
@property (nonatomic, copy) NSString *task_number;
@property (nonatomic, copy) NSString *task_progress_detail;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *SkipUIIdentifier;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *btn_status;
@property (nonatomic, copy) NSDictionary  *skip;

@property (nonatomic, assign) NSInteger lineState;
@property (nonatomic, copy) NSArray  *jf_and_yj;

@property (nonatomic, copy) NSString *award_type;
@property (nonatomic, copy) NSString *commission;
@property (nonatomic, copy) NSString *yj_text;
@property (nonatomic, copy) NSString *yj_color;
@property (nonatomic, copy) NSString *jf_text;
@property (nonatomic, copy) NSString *yongjin_btn;

@property (nonatomic, copy) NSString *in_audit_btn;
@property (nonatomic, copy) NSString *reaudit_btn;
@property (nonatomic, copy) NSString *show_explain_btn;
@property (nonatomic, copy) NSString *task_explain;

@property (nonatomic, copy) NSString *failMsg;//   失败原因文字
@property (nonatomic, copy) NSString *fail_str;//   按钮文字
@property (nonatomic, copy) NSString *fail_color;// 按钮背景色
@property (nonatomic, copy) NSString *fail_fontcolor;//  按钮文字颜色


@end

@interface FNMakeTaskJFYJTmodel : NSObject



@end

@interface FNMakeTaskShotModel : NSObject
@property (nonatomic, copy) NSString *task_sub_btn;
@property (nonatomic, copy) NSString *task_select_sub_btn;
@property (nonatomic, copy) NSString *task_tijiao_title;
@property (nonatomic, copy) NSString *pic_count;


@end
NS_ASSUME_NONNULL_END
