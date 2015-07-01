//
//  DBManager.h
//  TestFabric
//
//  Created by Mohamed Rafiq on 07/08/14.
//  Copyright (c) 2014 Mohamed Rafiq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import <FMDatabase.h>

@interface DBManager : NSObject
{
    FMDatabase *database;
}
+(DBManager*)getSharedInstance;
-(void)createDB;
-(FMDatabase*)getDatabaseInstance;
-(NSString *)getDBpath;
-(FMDatabase *)getDatabase;

@end
