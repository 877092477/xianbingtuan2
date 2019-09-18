//
//  FNRushLocationDeViewController.h
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#import "FNHContactModel.h"

@protocol FNRushLocationDeViewControllerDelegate <NSObject>

//选择地址 
-(void)inSelectLocationAction:(NSString*)send withlLongitude:(CGFloat)longitude withLatitude:(CGFloat)latitude;

//选择地址
-(void)inSelectLocationAction:(FNHsearchModel*)send;

@end

@interface FNRushLocationDeViewController : SuperViewController

@property(nonatomic ,weak) id<FNRushLocationDeViewControllerDelegate> delegate;
@property (nonatomic, strong) FNHsearchModel *locationModel;
@end


@interface AMapPOISearchResponse_OnePage : NSObject

@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger status; //-1:未开始 0:成功 1:失败
@property (nonatomic, strong) NSArray<AMapPOI*> *pois;

@end


@interface AMapPOISearchResponse_AllResults : NSObject

@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, strong) NSMutableArray<AMapPOISearchResponse_OnePage*> *allPages;

@end

typedef void(^MAKeyWordsPOISearchCallback)(AMapPOISearchResponse_AllResults* result);

@interface MAAllResultsSearch : NSObject

@property (nonatomic, strong) AMapSearchAPI *searchAPI;

- (void)searchAllPOIsWith:(AMapPOIKeywordsSearchRequest *)req resultCallback:(MAKeyWordsPOISearchCallback)resultCallback;

@end
