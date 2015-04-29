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

@interface SRRandomUserGenerator : NSObject

+ (instancetype)sharedRandomUserManager;

- (void)randomUserRequestWithCompletion:(SRRandomUserCompletionBlock)completion;
- (void)randomUsersRequest:(NSUInteger)quantity completion:(SRRandomUserCompletionBlock)completion;
- (void)randomUsersRequest:(NSUInteger)quantity withGender:(SRRandomUserGender)gender completion:(SRRandomUserCompletionBlock)completion;
- (void)randomUsersRequest:(NSUInteger)quantity withGender:(SRRandomUserGender)gender andNationality:(SRRandomUserNationality)nationality completion:(SRRandomUserCompletionBlock)completion;


@end
