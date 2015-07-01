//
//  Patient.m
//  Comparision
//
//  Created by Shubhakeerti Alagundagi on 30/06/15.
//  Copyright (c) 2015 Shubhakeerti Alagundagi. All rights reserved.
//

#import "Patient.h"
#import "SQLConstants.h"

NSString *const PATIENT_TABLE=@"patient";

NSString *const name = @"name";
NSString *const primary_email = @"primary_email";
NSString *const practice_id = @"practice_id";
NSString *const residing_address = @"residing_address";
NSString *const pincode = @"pincode";
NSString *const date_of_birth = @"date_of_birth";
NSString *const age = @"age";
NSString *const birthday = @"birthday";
NSString *const year_of_birth = @"year_of_birth";
NSString *const birthday_wishes_blacklisted = @"birthday_wishes_blacklisted";
NSString *const blood_group = @"blood_group";
NSString *const gender = @"gender";
NSString *const has_photo = @"has_photo";
NSString *const follow_up_blacklisted = @"follow_up_blacklisted";
NSString *const city = @"city";
NSString *const locality = @"locality";
NSString *const pretty_age = @"pretty_age";
NSString *const national_id = @"national_id";
NSString *const immunisation_reminder = @"immunisation_reminder";
NSString *const created_at = @"created_at";
NSString *const created_by_user_id = @"created_by_user_id";
NSString *const modified_at = @"modified_at";
NSString *const modified_by_user_id = @"modified_by_user_id";
NSString *const patient_Id = @"patient_Id";
NSString *const soft_deleted = @"soft_deleted";
NSString *const uuid = @"uuid";

@implementation Patient

+(NSString *)getCreateQuery{
    return [NSString stringWithFormat:@"%@ %@ (%@ INTEGER PRIMARY KEY, %@ TEXT , %@ TEXT, %@ TEXT , %@ TEXT, %@ TEXT, %@ TEXT,%@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT ,%@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT)",CREATE,PATIENT_TABLE,patient_Id,name,primary_email,practice_id,residing_address,pincode,date_of_birth,age,birthday,year_of_birth,birthday_wishes_blacklisted,blood_group,gender,has_photo,follow_up_blacklisted,city,locality,pretty_age,national_id,immunisation_reminder,created_at,created_by_user_id,modified_at,modified_by_user_id,soft_deleted,uuid];
}
@end
