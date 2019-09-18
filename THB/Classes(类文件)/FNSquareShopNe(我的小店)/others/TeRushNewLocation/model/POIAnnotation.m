//
//  POIAnnotation.m
//  69橙子
//
//  Created by 李显 on 2018/12/10.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "POIAnnotation.h"
@interface POIAnnotation ()

@property (nonatomic, readwrite, strong) AMapPOI *poi;

@end

@implementation POIAnnotation

@synthesize poi = _poi;

#pragma mark - MAAnnotation Protocol

- (NSString *)title
{
    return self.poi.name;
}

- (NSString *)subtitle
{
    return self.poi.address;
}

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.poi.location.latitude, self.poi.location.longitude);
}

#pragma mark - Life Cycle

- (id)initWithPOI:(AMapPOI *)poi
{
    if (self = [super init])
    {
        self.poi = poi;
    }
    
    return self;
}
@end
