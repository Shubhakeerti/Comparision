//
//  SQLQueryHandler.h
//  TestFabric
//
//  Created by Mohamed Rafiq on 08/08/14.
//  Copyright (c) 2014 Mohamed Rafiq. All rights reserved.
//

@protocol InsertDelegate
-(void)onInsert:(NSString *)tableName withFlag:(BOOL)isSuccess;
@end

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <FMResultSet.h>


@interface SQLQueryHandler : NSObject

@property (nonatomic,weak) id delegate;
+(FMResultSet *)query:(NSString *)table withProjection:(NSArray *)arrProjection withSelection:(NSString*)selectionArgs withOrderBy:(NSString *)orderBy withOrderType:(NSString *)orderType withLimit:(NSString *)limit_ wiithOFFset:(NSString *)offset;
+(BOOL)insert:(NSString *)table withValues:(NSDictionary *) insertDict;
+(BOOL)update:(NSString *)table withValues:(NSDictionary *)updateDict withSelection:(NSString*)selectionArgs;
+(BOOL)deletee:(NSString *)table withSelection:(NSString *)selectionArgs;
-(int)bulkInsert:(NSString *)table :(NSArray *)allInsertDict :(BOOL)isInsertOrReplace;
+(BOOL)insertOrReplace:(NSString *)table withValues:(NSDictionary *)insertDict;
+(FMResultSet *)queryWithFullString:(NSString *)query;
+(NSUInteger)intForQueryString:(NSString*)string;
@end
