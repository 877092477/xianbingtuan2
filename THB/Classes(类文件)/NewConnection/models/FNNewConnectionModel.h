//
//  FNNewConnectionModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/6/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface FNNewConnectionNavDataModel : NSObject

@property (nonatomic, copy) NSString *return_img;
@property (nonatomic, copy) NSString *bj_img;
@property (nonatomic, copy) NSString *phb_img;
@property (nonatomic, copy) NSString *msg_img;
@property (nonatomic, copy) NSString *font_color;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *bjimg_bili;
@property (nonatomic, copy) NSString *is_show_phb;
@property (nonatomic, copy) NSString *is_show_msg;
@end

@interface FNNewConnectionNavModel : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *jiange;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<FNNewConnectionNavDataModel*> *list;
@property (nonatomic, copy) NSString *bj_img;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *right_str;
@property (nonatomic, copy) NSString *right_str_color;
@property (nonatomic, copy) NSString *str_color;


@end

@interface FNNewConnectionDataFriendModel : NSObject

@property (nonatomic, copy) NSString *target;
@property (nonatomic, copy) NSString *room;
@property (nonatomic, copy) NSString *Vname_color;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *Vname;
@property (nonatomic, copy) NSString *vip_logo;
@property (nonatomic, copy) NSString *head_img;
@property (nonatomic, copy) NSString *phone_str;
@property (nonatomic, copy) NSString *wechat;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *tg_lv;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *extend_remark;
@property (nonatomic, copy) NSString *is_ingroup;
@property (nonatomic, copy) NSString *tg_str;

@property (nonatomic, copy) NSString *qid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *msg_str;
@property (nonatomic, copy) NSString *content;


@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *sendee_uid;
@property (nonatomic, copy) NSString *unread;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *SkipUIIdentifier;
@property (nonatomic, copy) NSString *next_uid;

@property (nonatomic, copy) NSString *is_jump;
@property (nonatomic, copy) NSString *tip_str;

@end

@interface FNNewConnectionDataModel : NSObject

@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* jiange;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong) NSArray<FNNewConnectionDataFriendModel*>* list;
@property (nonatomic, copy) NSString* bj_img;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* right_str;
@property (nonatomic, copy) NSString* right_str_color;
@property (nonatomic, copy) NSString* str_color;
@property (nonatomic, copy) NSString* str;

@end

@interface FNNewConnectionStatisDetailModel : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* count;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* up_img;
@property (nonatomic, copy) NSString* data_type;

@end


@interface FNNewConnectionStatisDataModel : NSObject

@property (nonatomic, strong) NSArray<FNNewConnectionStatisDetailModel*>* teamcount;
@property (nonatomic, strong) NSArray<FNNewConnectionStatisDetailModel*>* daycount;

@end

@interface FNNewConnectionStatisModel : NSObject

@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* jiange;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong) NSArray<FNNewConnectionStatisDataModel*>* list;
@property (nonatomic, copy) NSString* bj_img;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* right_str;
@property (nonatomic, copy) NSString* right_str_color;
@property (nonatomic, copy) NSString* str_color;

@end

@interface FNNewConnectionContaceModel : NSObject

@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* jiange;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong) NSArray<FNNewConnectionDataFriendModel*>* list;
@property (nonatomic, copy) NSString* bj_img;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* right_str;
@property (nonatomic, copy) NSString* right_str_color;
@property (nonatomic, copy) NSString* str_color;
@property (nonatomic, copy) NSString* str;

@end

@interface FNNewConnectionCateSortModel : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* up_type;
@property (nonatomic, copy) NSString* list_cate;

@end

@interface FNNewConnectionCateListModel : NSObject

@property (nonatomic, copy) NSString* search_img;
@property (nonatomic, copy) NSString* btn_img;
@property (nonatomic, copy) NSString* search_str;
@property (nonatomic, copy) NSString* tip_str;
@property (nonatomic, strong) NSArray<FNNewConnectionCateSortModel*>* sort;

@end

@interface FNNewConnectionCateModel : NSObject

@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* jiange;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong) NSArray<FNNewConnectionCateListModel*>* list;
@property (nonatomic, copy) NSString* bj_img;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* right_str;
@property (nonatomic, copy) NSString* right_str_color;
@property (nonatomic, copy) NSString* str_color;

@end

@interface FNNewConnectionCate2Model : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* up_type;
@property (nonatomic, copy) NSString* list_cate;

@end


@interface FNNewConnectionModel : NSObject

//头部
@property (nonatomic, strong) FNNewConnectionNavModel *topNav;
//推荐人
@property (nonatomic, strong) FNNewConnectionDataModel *extend;
// 数据
@property (nonatomic, strong) FNNewConnectionStatisModel *data;
// 最近联系人
@property (nonatomic, strong) FNNewConnectionContaceModel *contact;
// 群聊
@property (nonatomic, strong) FNNewConnectionContaceModel *group;
// 分类
@property (nonatomic, strong) FNNewConnectionCateModel *cate;

@end

NS_ASSUME_NONNULL_END
