//
//  CXSearchModel.m
//  
//
//
//

#import "CXSearchModel.h"

#define FAST_DirectoryModel_SET_VALUE_FOR_STRING(dictname,value) dictionary[dictname]!= nil &&dictionary[dictname]!=[NSNull null]? dictionary[dictname] : value;


@implementation CXSearchModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = FAST_DirectoryModel_SET_VALUE_FOR_STRING(@"name", @"");
        self.id   = FAST_DirectoryModel_SET_VALUE_FOR_STRING(@"id", @"");
    }
    return self;
}

@end
