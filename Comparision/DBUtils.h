//
//  DBUtils.h
//  Practo
//
//  Created by Vikash Jain on 4/16/15.
//  Copyright (c) 2015 Practo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBUtils : NSObject

+(NSDictionary *)getColumnDictionaryForTable:(NSString *)tableName;

@end
