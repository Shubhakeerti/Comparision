//
//  SQLQueryHandler.m
//  TestFabric
//
//  Created by Mohamed Rafiq on 08/08/14.
//  Copyright (c) 2014 Mohamed Rafiq. All rights reserved.
//

#import <FMDB/FMDatabaseQueue.h>
#import "SQLQueryHandler.h"
#import <FMDatabase.h>

#import "SQLConstants.h"
#import "DBManager.h"
#import "DBUtils.h"
#import <FMDatabaseAdditions.h>

@implementation SQLQueryHandler
@synthesize delegate;

+(FMResultSet *)query:(NSString *)table withProjection:(NSArray *)arrProjection withSelection:(NSString*)selectionArgs withOrderBy:(NSString *)orderBy withOrderType:(NSString *)orderType withLimit:(NSString *)limit_ wiithOFFset:(NSString *)offset{
    FMResultSet *resultSet;
    NSString *query = nil;
    NSString *projectionString = @"*";
    //  orderType = ASC;
    NSString *orderString = nil;
    FMDatabase *database = [[DBManager getSharedInstance] getDatabaseInstance];
    if(arrProjection != nil){
        projectionString = [arrProjection componentsJoinedByString:@","];
    }
    query = [NSString stringWithFormat:@"%@ %@ %@ %@",SELECT, projectionString,FROM, table];
    if (selectionArgs !=nil) {
        query = [query stringByAppendingString:[NSString stringWithFormat:@" %@ %@ ",WHERE,selectionArgs]];
    }
    if (orderType !=nil ) {
        orderString = [NSString stringWithFormat:@"%@ %@",orderBy,orderType];
        query =[query stringByAppendingString:[NSString stringWithFormat:@" %@ %@",ORDER,orderString]];
    }
    if(limit_!=nil)
    {
        query=[NSString stringWithFormat:@"%@ %@ %@",query,LIMIT_,limit_];
    }
    if(offset!=nil)
    {
        query=[NSString stringWithFormat:@"%@ %@ %@",query,OFFSET_,offset];
    }
   NSLog(@"query:%@",query);
    if(database.open){
        resultSet = [database executeQuery:query];
        query = nil;
        projectionString = nil;
        orderString = nil;
        database = nil;
        return resultSet;
        //        while ([resultSet next]) {
        //           NSLog(@"Name of the city %@",[resultSet stringForColumn:NAME]);
        //        }
    }
    if(!database.close){
        // log if something went wrong
    }
    return resultSet;
}


+(FMResultSet *)queryWithFullString:(NSString *)query
{
    FMResultSet *resultSet;
    FMDatabase *database = [[DBManager getSharedInstance] getDatabaseInstance];
    
    if(database.open){
        resultSet = [database executeQuery:query];
        query = nil;
        database = nil;
        return resultSet;
    }
    if(!database.close){
        // log if something went wrong
    }
    return resultSet;
}

+(BOOL)insert:(NSString *)table withValues:(NSDictionary *)insertDict{
    FMDatabase *database = [[DBManager getSharedInstance] getDatabaseInstance];
    if (database.open) {
        NSMutableArray* cols = [[NSMutableArray alloc] init];
        NSMutableArray* vals = [[NSMutableArray alloc] init];
        
        NSDictionary *columnDictionary =  [DBUtils getColumnDictionaryForTable:table];

        for (id key in insertDict) {
            if(columnDictionary == nil || [columnDictionary objectForKey:key])
            {
                [cols addObject:[NSString stringWithFormat:@"'%@'", key]];
                
                if([[insertDict objectForKey:key] isKindOfClass:[NSString class]])
                {
                    [vals addObject:[NSString stringWithFormat:@"'%@'", [[insertDict objectForKey:key] stringByReplacingOccurrencesOfString:@"'" withString:@"''"]]];
                }
                else
                {
                    [vals addObject:[NSString stringWithFormat:@"'%@'", [insertDict objectForKey:key]]];
                }
            }
        }
        NSString* sql = [NSString stringWithFormat:@"%@ %@ (%@) values (%@)", INSERT, table, [cols componentsJoinedByString:@", "], [vals componentsJoinedByString:@", "]];
    //    DebugLog(@"%@", sql);
        [database executeUpdate:sql];
        if(!database.close){
            
        }
        database = nil;
        cols = nil;
        vals = nil;
        sql = nil;
        return true;
    }else{
        return false;
    }
    return YES;
}
+(BOOL)insertOrReplace:(NSString *)table withValues:(NSDictionary *)insertDict{
    FMDatabase *database = [[DBManager getSharedInstance] getDatabaseInstance];
    if (database.open) {
        NSMutableArray* cols = [[NSMutableArray alloc] init];
        NSMutableArray* vals = [[NSMutableArray alloc] init];
        
        NSDictionary *columnDictionary =  [DBUtils getColumnDictionaryForTable:table];
       
        for (id key in insertDict) {
            if(columnDictionary == nil || [columnDictionary objectForKey:key])
            {
                [cols addObject:[NSString stringWithFormat:@"'%@'", key]];
                
                if([[insertDict objectForKey:key] isKindOfClass:[NSString class]])
                {
                    [vals addObject:[NSString stringWithFormat:@"'%@'", [[insertDict objectForKey:key] stringByReplacingOccurrencesOfString:@"'" withString:@"''"]]];
                }
                else
                {
                    [vals addObject:[NSString stringWithFormat:@"'%@'", [insertDict objectForKey:key]]];
                }
            }
        }
        NSString* sql = [NSString stringWithFormat:@"%@ %@ (%@) values (%@)", INSERT_OR_REPLACE, table, [cols componentsJoinedByString:@", "], [vals componentsJoinedByString:@", "]];
        NSLog(@"%@", sql);
        [database executeUpdate:sql];
        if(!database.close){
            
        }
        database = nil;
        cols = nil;
        vals = nil;
        sql = nil;
        return true;
    }else{
        return false;
    }
    return YES;
}


+(BOOL)deletee:(NSString *)table withSelection:(NSString *)selectionArgs{
    FMDatabase *database= [[DBManager getSharedInstance] getDatabaseInstance];
    NSString *deleteQuery;
    if (database.open) {
        deleteQuery=[NSString stringWithFormat:@"%@ %@",DELETE,table];
        if(selectionArgs!=nil)
        {
            deleteQuery=[NSString stringWithFormat:@"%@ %@ %@",deleteQuery,WHERE,selectionArgs];
        }
        
        NSLog(@"delete query:%@", deleteQuery);
        [database executeUpdate:deleteQuery];
        if(!database.close){
        }
        database=nil;
        deleteQuery=nil;
        return true;
    }else{
        return false;
    }
    
    return YES;
}


+(BOOL)update:(NSString *)table withValues:(NSDictionary *)updateDict withSelection:(NSString*)selectionArgs
{
    FMDatabase *database = [[DBManager getSharedInstance] getDatabaseInstance];
    if (database.open) {
        NSString *updateQuery=[NSString stringWithFormat:@"%@ %@ %@ ",UPDATE,table,SET];
        NSMutableArray *UpdateCol=[[NSMutableArray alloc]init];
        
        NSDictionary *columnDictionary =  [DBUtils getColumnDictionaryForTable:table];

        for (id key in updateDict) {
            if(columnDictionary == nil || [columnDictionary objectForKey:key])
            {
                [UpdateCol addObject:[NSString stringWithFormat:@"%@ = '%@'",key,[updateDict objectForKey:key]]];
            }
        }
        if([UpdateCol count] > 0)
        {
            updateQuery=[NSString stringWithFormat:@"%@ %@ %@ %@",updateQuery, [UpdateCol componentsJoinedByString:@", "],WHERE,selectionArgs];
            NSLog(@"update query:%@", updateQuery);
            BOOL isSuccssss=[database executeUpdate:updateQuery];
            NSLog(@"Success :%d",isSuccssss);
            if(!database.close){
                
            }
        }
        UpdateCol=nil;
        database=nil;
        updateQuery=nil;
        return true;
        
    }
    else
    {
        return false;
    }
    return YES;
}

-(int)bulkInsert:(NSString *)table :(NSArray *)allInsertDict :(BOOL)isInsertOrReplace
{
    __block BOOL isSuccess=false;
   // DBManager *dbManagerObj=[[DBManager alloc] init];
    DBManager *dbManagerObj=[DBManager getSharedInstance];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[dbManagerObj getDBpath]];
    
    NSString *insertQuery=@"";
    NSDictionary *insertDict;
    FMDatabase *db = [dbManagerObj getDatabase];
    dbManagerObj=nil;
    
    NSDictionary *columnDictionary =  [DBUtils getColumnDictionaryForTable:table];
    
    if(db.open)
    {
        for(int j=0;j<[allInsertDict count];j++)
        {
            insertDict=[allInsertDict objectAtIndex:j];
            NSMutableArray* cols = [[NSMutableArray alloc] init];
            NSMutableArray* vals = [[NSMutableArray alloc] init];
            for (id key in insertDict)
            {
                if(columnDictionary == nil || [columnDictionary objectForKey:key])
                {
                    [cols addObject:[NSString stringWithFormat:@"'%@'", key]];
                    
                    if([[insertDict objectForKey:key] isKindOfClass:[NSString class]])
                    {
                        [vals addObject:[NSString stringWithFormat:@"'%@'", [[insertDict objectForKey:key] stringByReplacingOccurrencesOfString:@"'" withString:@"''"]]];
                    }
                    else
                    {
                        [vals addObject:[NSString stringWithFormat:@"'%@'", [insertDict objectForKey:key]]];
                    }
                }

            }
            NSString* sql;
            if(isInsertOrReplace)
            {
                sql=[NSString stringWithFormat:@"%@ %@ (%@) values (%@)", INSERT_OR_REPLACE, table, [cols componentsJoinedByString:@", "], [vals componentsJoinedByString:@", "]];
            }
            else
            {
                sql=[NSString stringWithFormat:@"%@ %@ (%@) values (%@)", INSERT, table, [cols componentsJoinedByString:@", "], [vals componentsJoinedByString:@", "]];
            }
            
            cols = nil;
            vals = nil;
            insertQuery=[NSString stringWithFormat:@"%@%@;",insertQuery,sql];
            sql = nil;
            insertDict=nil;
        }
        [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            isSuccess=[db executeStatements:insertQuery];
            NSLog(@"Table Name :%@ is success :%d",table,isSuccess);
            NSLog(@"Main thread %d",[NSThread isMainThread]);
            
        }];
        
        NSLog(@"bool here :%d",isSuccess);
        
        insertQuery=nil;
        queue=nil;
        db=nil;
        allInsertDict=nil;
        
        
    }
    return isSuccess;
}


+(NSUInteger)intForQueryString:(NSString*)string
{
    FMDatabase *database = [[DBManager getSharedInstance] getDatabaseInstance];
    return [database intForQuery:string];
}
@end
