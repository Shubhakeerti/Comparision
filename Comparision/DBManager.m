//
//  DBManager.m
//  TestFabric
//
//  Created by Mohamed Rafiq on 07/08/14.
//  Copyright (c) 2014 Mohamed Rafiq. All rights reserved.
//
#import "DBManager.h"
#import "Patient.h"

static DBManager *sharedInstance = nil;
static FMDatabase *database = nil;
// Added user table - version 2
static int DBVersion = 1;
@implementation DBManager

+(DBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
//        [sharedInstance upgradeDB];
    }
    return sharedInstance;
}

-(NSString *)getDBpath
{
    NSString *databasePath;
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: @"shub.sqlite"]];
    NSLog(@"DB path :%@",databasePath);
    docsDir = nil;
    dirPaths = nil;
    return databasePath;
}

-(void)createDB
{
    database = [FMDatabase databaseWithPath:[self getDBpath]];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: [self getDBpath] ] == NO)
    {
        [database open];
        if([database executeUpdate:[Patient getCreateQuery]])
        {
//            [Utils setSharedInt:DBVersion withKey:kDBVersion];
            NSLog(@"Database creation successful");
        }else{
            NSLog(@"Database creation not successful");
        }
    }else {
        NSLog(@"Database already exists");
    }
    filemgr = nil;
}
/*
-(void)upgradeDB
{
    database = [FMDatabase databaseWithPath:[self getDBpath]];
    [database open];
    if ([Utils getShareinteger:kDBVersion] < DBVersion){
        [Utils setSharedBoolean:true withKey:kMigrating];
        [database executeUpdate:[User getCreateQuery]];
        [database executeUpdate:[AppoHistoryConstants getCreateQuery]];
        [database executeUpdate:[City getAlterTableQuery]];
        [database executeUpdate:[AppoHistoryConstants getAlterTableQuery]];
        [database executeUpdate:[AppoHistoryConstants getAlterTableQueryFeedback]];
        [database executeUpdate:[AppoHistoryConstants getAlterTableQueryStreetAddress]];
        [database executeUpdate:[AppoHistoryConstants getAlterTableQueryAppointmentType]];
        [database executeUpdate:[AppoHistoryConstants getAlterTableQueryDoctorSpecality]];
        [database executeUpdate:[AppoHistoryConstants getAlterTableQueryClinicNumber]];
        [database executeUpdate:[SpecialitySearchConstant getCreateQuery]];
        [database executeUpdate:[LocationSearchConstant getCreateQuery]];
        SyncHelper *syncHelper=[SyncHelper getInstance];
        [syncHelper startAppointmentSync];
    }
    [Utils setSharedInt:DBVersion withKey:kDBVersion];
}
 */

-(FMDatabase*)getDatabaseInstance{
    return database;
}

-(FMDatabase *)getDatabase{
    return [FMDatabase databaseWithPath:[self getDBpath]];
}
@end
