//
//  CXSearchSectionModel.h
//  
//
//
//
//

#import <Foundation/Foundation.h>

@interface CXSearchSectionModel : NSObject

@property (nonatomic, copy) NSString *section_id;
@property (nonatomic, copy) NSString *section_title;
@property (nonatomic, copy) NSArray *section_contentArray;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
