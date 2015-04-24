//
//  SRRandomUserAPIManager.h
//  SRRandomUser
//
//  Created by Tur, Louis on 4/23/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SRRandomUserGender){
    SRRandomUserGenderMale = 0,
    SRRandomUserGenderFemale,
    SRRandomUserGenderAny
};

typedef NS_ENUM(NSUInteger, SRRandomUserResultsFormat){
    SRRandomUserResultsFormatJSON = 0,
    SRRandomUserResultsFormatCSV,
    SRRandomUserResultsFormatSQL,
    SRRandomUserResultsFormatYAML
};

typedef NS_ENUM(NSUInteger, SRRandomUserNationality) {
    SRRandomUserNationalityUS = 0,
    SRRandomUserNationalityGB,
    SRRandomUserNationalityAll
};

@interface SRRandomUserAPIManager : NSObject

+ (instancetype)sharedAPIManager;

- (void)requestRandomUser;
- (void)requestRandomUsers:(NSUInteger)numberOfUsers;
- (void)requestRandomUsers:(NSUInteger)numberOfUsers ofGender:(SRRandomUserGender)gender;

- (void)returnResultsAsType:(SRRandomUserResultsFormat)format;
- (void)changeNationalityTo:(SRRandomUserNationality)nationality;
- (NSString *)getSeedFromLastRequest;
- (void)requestOnlyLego:(BOOL)lego;

@end
