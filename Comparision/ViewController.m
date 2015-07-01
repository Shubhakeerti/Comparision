//
//  ViewController.m
//  Comparision
//
//  Created by Shubhakeerti Alagundagi on 30/06/15.
//  Copyright (c) 2015 Shubhakeerti Alagundagi. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "SQLQueryHandler.h"
#import "Patient.h"
#import <FMDB/FMResultSet.h>
#define authToken @"6812aa2da2aef7482c546596d8ff66b1be72dcd0"
//#define authToken @"b67a7640a60facf1aaa17a470f2a97e340250b8d"

@interface ViewController (){
    NSDate *countDate;
    NSInteger *patientCount;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.syncButton addTarget:self action:@selector(syncButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.fetchFromDBButton addTarget:self action:@selector(fetchingFromDB:) forControlEvents:UIControlEventTouchUpInside];
    patientCount = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - FMDB methods

-(void)syncButtonAction:(UIButton *)button
{
    countDate = [NSDate date];
    [self patientAPICall:@"https://solo.practo.com/patients?limit=500"];
    [self.syncLabel setText:@"Syncing..."];
}

-(void)patientAPICall:(NSString *)modifiedAfter
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:authToken forHTTPHeaderField:@"x-auth-token"];
    [manager.requestSerializer setValue:@"3.6" forHTTPHeaderField:@"x-ios-version"];
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [manager GET:modifiedAfter parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"patients"] count] > 0)
        {
            if (patientCount == 0)
            {
                patientCount = [[dict objectForKey:@"count"] integerValue];

            }
            [self.syncLabel setText:[NSString stringWithFormat:@"%d patients remaining",[[dict objectForKey:@"count"] intValue]]];
            __block NSString *modifiedAt = [[[dict objectForKey:@"patients"] lastObject] objectForKey:@"modified_at"];
            NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
            [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *patientModifiedAt = [dateFormater dateFromString:modifiedAt];
            modifiedAt = [dateFormater stringFromDate:patientModifiedAt];
            
            // inserting into db
            if ([self savePatientsToDB:[dict objectForKey:@"patients"]])
            {
                NSLog(@"https://solo.practo.com/patients?limit=500&modified_after=%@",modifiedAt);
                [self patientAPICall:[[NSString stringWithFormat:@"https://solo.practo.com/patients?limit=500&modified_after=%@",modifiedAt] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            }
        }
        else
        {
            float count = [[NSDate date] timeIntervalSinceDate:countDate];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Done" message:[NSString stringWithFormat:@"to Sync %d patients it took %f seconds",[[dict objectForKey:@"count"] integerValue],count] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ERROR" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

-(BOOL)savePatientsToDB:(NSArray *)arrPatients
{
    SQLQueryHandler *queryHandler = [[SQLQueryHandler alloc]init];
    BOOL flag=[queryHandler bulkInsert:PATIENT_TABLE :arrPatients:true];
    return flag;
}

-(int)fetchFromDB
{
    int count = 0;
    NSString *selectionArg=[NSString stringWithFormat:@"select * from %@ ",PATIENT_TABLE];
    FMResultSet *resultSetObj= [SQLQueryHandler queryWithFullString:selectionArg];
    while ([resultSetObj next])
    {
        count ++;
    }
    return count;
}

-(void)fetchingFromDB:(UIButton *)sender
{
    NSDate *date = [NSDate date];
    int dbCount = [self fetchFromDB];
    float timeCount = [[NSDate date] timeIntervalSinceDate:date];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Done" message:[NSString stringWithFormat:@"To fetch %d patients it took %f seconds",dbCount,timeCount] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


#pragma mark - CoreDate Methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
