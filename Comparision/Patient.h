//
//  Patient.h
//  Comparision
//
//  Created by Shubhakeerti Alagundagi on 30/06/15.
//  Copyright (c) 2015 Shubhakeerti Alagundagi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Patient : NSObject

extern NSString *const PATIENT_TABLE;

extern NSString *const name;
extern NSString *const primary_email;
extern NSString *const practice_id;
extern NSString *const residing_address;
extern NSString *const pincode;
extern NSString *const date_of_birth;
extern NSString *const age;
extern NSString *const birthday;
extern NSString *const year_of_birth;
extern NSString *const birthday_wishes_blacklisted;
extern NSString *const blood_group;
extern NSString *const gender;
extern NSString *const has_photo;
extern NSString *const follow_up_blacklisted;
extern NSString *const city;
extern NSString *const locality;
extern NSString *const pretty_age;
extern NSString *const national_id;
extern NSString *const immunisation_reminder;
extern NSString *const created_at;
extern NSString *const created_by_user_id;
extern NSString *const modified_at;
extern NSString *const modified_by_user_id;
extern NSString *const patient_Id;
extern NSString *const soft_deleted;
extern NSString *const uuid;

+(NSString *)getCreateQuery;

@end
