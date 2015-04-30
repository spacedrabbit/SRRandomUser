//
//  SRRandomUserAPIManager.h
//  SRRandomUser
//
//  Created by Tur, Louis on 4/23/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FSNetworking/FSNConnection.h>

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

/** Requests a single, random user
 *  @param completion An @p FSNCompletionBlock with access to API query results
 *  @remarks You should not need to call this method directly
 */
- (void)requestRandomUser:(FSNCompletionBlock)completion;

/** Requests a specified number of random users
 *  @param completion An @p FSNCompletionBlock with access to API query results
 *  @param numberOfUsers The number of random users to request
 *  @remarks You should not need to call this method directly
 */
- (void)requestRandomUsers:(NSUInteger)numberOfUsers
                completion:(FSNCompletionBlock)completion;

/** Requests a specified number of random users of a specified gender
 *  @param completion An @p FSNCompletionBlock with access to API query results
 *  @param numberOfUsers The number of random users to request
 *  @param gender A value representing an @p SRRandomUserGender value
 *  @remarks You should not need to call this method directly
 */
- (void)requestRandomUsers:(NSUInteger)numberOfUsers
                  ofGender:(SRRandomUserGender)gender
                completion:(FSNCompletionBlock)completion;

/** Requests a specified number of random users of a specified gender and nationality
 *  @param completion An @p FSNCompletionBlock with access to API query results
 *  @param numberOfUsers The number of random users to request
 *  @param gender A value representing an @p SRRandomUserGender value
 *  @param nationality A value representing an @P SRRandomUserNationality value
 *  @note Currently only supports US and GB
 *  @remarks You should not need to call this method directly
 */
- (void)requestRandomUsers:(NSUInteger)numberOfUsers
                  ofGender:(SRRandomUserGender)gender
            andNationality:(SRRandomUserNationality)nationality
                completion:(FSNCompletionBlock)completion;

/** Requests all of the same random users generated from a particular seed
 *  @param completion An @p FSNCompletionBlock with access to API query results
 *  @remarks You should not need to call this method directly
 */
- (void)requestRandomUsersFromSeed:(NSString *)seed
                        completion:(FSNCompletionBlock)completion;

/** Used to change the response format, JSON is set by default
 *  @param format A valie representing an @p SRRandomUserResultsFormat
 *  @note Formats can be JSON, CSV, SQL, or YML
 */
- (void)returnResultsAsType:(SRRandomUserResultsFormat)format;

/** Used to determine if results should be Lego-lized, defaults to NO
 *  @param lego A @p BOOL that determines if results are lego-lized
 */
- (void)requestOnlyLego:(BOOL)lego;

/** Resets results type to JSON and lego-lization to NO
 */
- (void)resetToDefaults;

@end
