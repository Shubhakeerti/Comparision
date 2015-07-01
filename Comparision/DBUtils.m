//
//  DBUtils.m
//  Practo
//
//  Created by Vikash Jain on 4/16/15.
//  Copyright (c) 2015 Practo. All rights reserved.
//

#import "DBUtils.h"

#import "Patient.h"
//#import "MedicalHistory.h"

@implementation DBUtils


static NSDictionary *columnDictionaryForUserTable =nil;
static NSDictionary *columnDictionaryForAppointmentHistoryTable =nil;
static NSDictionary *columnDictionaryForSpecialityTable =nil;
static NSDictionary *columnDictionaryForSpecialitySearchTable =nil;
static NSDictionary *columnDictionaryForLocalitySearchTable =nil;
static NSDictionary *columnDictionaryForCityTable =nil;

+(NSDictionary *)getColumnDictionaryForTable:(NSString *)tableName
{
    if([tableName isEqualToString:PATIENT_TABLE])
    {
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
        if(columnDictionaryForUserTable == nil){
            columnDictionaryForUserTable =  [[NSDictionary alloc] initWithObjectsAndKeys:
                                             name,name,
                                             primary_email,primary_email,
                                             practice_id,practice_id,
                                             residing_address,residing_address,
                                             pincode,pincode,
                                             date_of_birth,date_of_birth,
                                             age,age,
                                             birthday,birthday,
                                             year_of_birth,year_of_birth,
                                             birthday_wishes_blacklisted,birthday_wishes_blacklisted,
                                             blood_group,blood_group,
                                             gender,gender,
                                             has_photo,has_photo,
                                             follow_up_blacklisted,follow_up_blacklisted,
                                             city,city,
                                             locality,locality,
                                             pretty_age,pretty_age,
                                             national_id,national_id,
                                             immunisation_reminder,immunisation_reminder,
                                             created_at,created_at,
                                             created_by_user_id,created_by_user_id,
                                             modified_at,modified_at,
                                             modified_by_user_id,modified_by_user_id,
                                             patient_Id,patient_Id,
                                             soft_deleted,soft_deleted,
                                             uuid,uuid,
                                             nil];
        }
        return columnDictionaryForUserTable;
    }
    /*
    else if([tableName isEqualToString:APPOINTMENT_HISTORY_TABLE_NAME])
    {
        if(columnDictionaryForAppointmentHistoryTable == nil){
            columnDictionaryForAppointmentHistoryTable =  [[NSDictionary alloc] initWithObjectsAndKeys:
                                                           kAppoHistory_id,kAppoHistory_id,
                                                           cityName,cityName,
                                                           kStatus,kStatus,
                                                           kAppointment_From,kAppointment_From,
                                                           kDoctorId,kDoctorId,
                                                           kDoctorName,kDoctorName,
                                                           kClinicName,kClinicName,
                                                           kPracticeId,kPracticeId,
                                                           kClinicLat,kClinicLat,
                                                           kClinicLon,kClinicLon,
                                                           kClinicLocation,kClinicLocation,
                                                           kMobile,kMobile,
                                                           kName,kName,
                                                           kPractice_doctor_id,kPractice_doctor_id,
                                                           kPhotoUrl,kPhotoUrl,
                                                           kStreetAddress,kStreetAddress,
                                                           kAppointmentType,kAppointmentType,
                                                           kDoctorSpecality,kDoctorSpecality,
                                                           kFeedbackCollected,kFeedbackCollected,
                                                           kClinicNumber,kClinicNumber,
                                                           nil];
        }
        return columnDictionaryForAppointmentHistoryTable;
    }
    else if([tableName isEqualToString:SPECIALITY_TABLE_NAME])
    {
        if(columnDictionaryForSpecialityTable == nil){
            columnDictionaryForSpecialityTable =  [[NSDictionary alloc] initWithObjectsAndKeys:
                                                   ID,ID,
                                                   NAME,NAME,
                                                   RANKING,RANKING,
                                                   RANKING_LOCAL,RANKING_LOCAL,
                                                   PROMOTED,PROMOTED,
                                                   CREATED_AT,CREATED_AT,
                                                   MODIFIED_AT,MODIFIED_AT,
                                                   IS_SUBSPECIALIZATION,IS_SUBSPECIALIZATION,
                                                   NAME,NAME,
                                                   IS_SUBSPECIALIZATION,IS_SUBSPECIALIZATION,
                                                   nil];
        }
        return columnDictionaryForSpecialityTable;
    }
    else if([tableName isEqualToString:SPECIALITY_SEARCH_TABLE_NAME])
    {
        if(columnDictionaryForSpecialitySearchTable == nil){
            columnDictionaryForSpecialitySearchTable =  [[NSDictionary alloc] initWithObjectsAndKeys:
                                                         kName,kName,
                                                         kType,kType,
                                                         kId,kId,
                                                         kLabel,kLabel,
                                                         kNew_Slug,kNew_Slug,
                                                         kRanking,kRanking,
                                                         kRelatedName,kRelatedName,
                                                         COUNTRY_NAME,COUNTRY_NAME,
                                                         kcity,kcity,
                                                         nil];
        }
        return columnDictionaryForSpecialitySearchTable;
    }
    else if([tableName isEqualToString:LOCATION_SEARCH_TABLE_NAME])
    {
        if(columnDictionaryForLocalitySearchTable == nil){
            columnDictionaryForLocalitySearchTable =  [[NSDictionary alloc] initWithObjectsAndKeys:
                                                       kName,kName,
                                                       kId,kId,
                                                       kType,kType,
                                                       kcity,kcity,
                                                       KEY_LOCALITY,KEY_LOCALITY,
                                                       kRanking,kRanking,
                                                       nil];
        }
        return columnDictionaryForLocalitySearchTable;
    }
    else if([tableName isEqualToString:CITY_TABLE_NAME])
    {
        if(columnDictionaryForCityTable == nil){
            columnDictionaryForCityTable =  [[NSDictionary alloc] initWithObjectsAndKeys:
                                             ID,ID,
                                             NAME,NAME,
                                             STATE_ID, STATE_ID,
                                             STATE_NAME,STATE_NAME,
                                             COUNTRY_ID, COUNTRY_ID,
                                             COUNTRY_NAME,COUNTRY_NAME,
                                             CURRENCY,CURRENCY,
                                             HELPLINE_NUMBER, HELPLINE_NUMBER,
                                             TZDATA_IDENTIFIER, TZDATA_IDENTIFIER,
                                             TZ_OFFSET,TZ_OFFSET,
                                             COUNTRY_CODE, COUNTRY_CODE,
                                             RANKING,RANKING,
                                             PROMOTED, PROMOTED,
                                             CREATED_AT, CREATED_AT,
                                             MODIFIED_AT, MODIFIED_AT,
                                             LOCALITY_MODIFIED_AFTER, LOCALITY_MODIFIED_AFTER,
                                             PUBLISHED, PUBLISHED,                                                       nil];
        }
        return columnDictionaryForCityTable;
    }
    */
    return nil;
}

@end
