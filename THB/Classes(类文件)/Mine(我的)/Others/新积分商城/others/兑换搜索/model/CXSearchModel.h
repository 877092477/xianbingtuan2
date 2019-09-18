//
//  CXSearchModel.h
//  
//
//
//
//

#import <Foundation/Foundation.h>

@interface CXSearchModel : NSObject

@property (nonatomic, copy) NSString * id;

@property (nonatomic, copy) NSString * name;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
