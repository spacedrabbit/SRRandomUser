//
//  SRRandomUser.h
//  SRRandomUser
//
//  Created by Tur, Louis on 4/23/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRRandomUserAPIManager.h"

@class SRRandomUserPool;

typedef void(^SRRandomUserCompletionBlock)(SRRandomUserPool *, BOOL success);
typedef void(^SRRandomUserRetrievalBlock)(NSArray *, BOOL success);

@interface SRRandomUserGenerator : NSObject

/** Determines if user requests are saved to disk in the current request format, NO by default
 */
@property (nonatomic, readonly) BOOL shouldSaveResults;
- (void)saveRandomRequestResults:(BOOL)saveResults;

/** BOOL used to check if there are previously saved requests
 */
@property (nonatomic, readonly) BOOL previousRequestsExist;

/** Returns an @p SRRandomUserPool singleton with JSON and LegoRequests = NO as defaults
 *  @return @p SRRandomUserPool singleton
 */
+ (instancetype)sharedRandomUserManager;

/** Basic random user request. Requests 1 user of any gender and nationality formatted as JSON
 *  @param completion @p SRRandomUserCompletionBlock completion block @p (void)^(SRRandomUserPool *, BOOL success)
 *  @remarks @p completion provides access to the random user pool. Be sure to first check that @p success is @p YES
 */
- (void)randomUserRequestWithCompletion:(SRRandomUserCompletionBlock)completion;

/** Random user request. Requests a specified quantity of users of any gender and nationality, formatted as JSON
 *  @param quantity The number of users to request
 *  @param completion @p SRRandomUserCompletionBlock completion block @p (void)^(SRRandomUserPool *, BOOL success)
 *  @remarks @p completion provides access to the random user pool. Be sure to first check that @p success is @p YES
 */
- (void)randomUsersRequest:(NSUInteger)quantity completion:(SRRandomUserCompletionBlock)completion;
- (void)randomUsersRequest:(NSUInteger)quantity withGender:(SRRandomUserGender)gender completion:(SRRandomUserCompletionBlock)completion;
- (void)randomUsersRequest:(NSUInteger)quantity withGender:(SRRandomUserGender)gender andNationality:(SRRandomUserNationality)nationality completion:(SRRandomUserCompletionBlock)completion;

- (void)retrievePreviousRequests:(SRRandomUserRetrievalBlock)retrievalBlock;

@end
