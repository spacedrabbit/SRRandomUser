//
//  SRRandomUser.m
//  SRRandomUser
//
//  Created by Tur, Louis on 4/23/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import "SRRandomUserGenerator.h"

#import "SRRandomUser.h"
#import "SRRandomUserPool.h"
#import "SRRandomUserAPIManager.h"

@interface SRRandomUserGenerator()

@property (strong, nonatomic) SRRandomUserAPIManager *sharedAPIManager;
@property (strong, nonatomic) SRRandomUserGenerator *sharedRandomUserManager;


@property (nonatomic) SRRandomUserResultsFormat defaultResultsFormat;
@property (nonatomic) BOOL makeLegoRequests;

@end


@implementation SRRandomUserGenerator

+ (instancetype)sharedRandomUserManager{
    
    __block SRRandomUserGenerator *sharedManager;
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[SRRandomUserGenerator alloc] init];
    });
    return sharedManager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _sharedRandomUserManager = [[SRRandomUserGenerator alloc] init];
        _sharedAPIManager = [SRRandomUserAPIManager sharedAPIManager];
        _defaultResultsFormat = SRRandomUserResultsFormatJSON;
        _makeLegoRequests = YES;
    }
    return self;
}

+(void)randomUserRequestWithCompletion:(SRRandomUserCompletionBlock)completion{
    
    [[SRRandomUserAPIManager sharedAPIManager] requestRandomUser:^(FSNConnection * connection) {
        
        if (connection.httpResponse.statusCode == 200) {
            NSDictionary *jsonResponse = (NSDictionary *)connection.parseResult;
            SRRandomUserPool *resultsPool = [SRRandomUserPool randomUserPoolForData:jsonResponse];
            
            completion(resultsPool, YES);
        }
        else if (connection.httpResponse.statusCode > 400){
            NSLog(@"Error in completing request: %@", connection.error);
            completion(nil, NO);
        }
        
    }];
}

+(void)randomUsersRequest:(NSUInteger)quantity completion:(SRRandomUserCompletionBlock)completion{
    
    
}

+(void)randomUsersRequest:(NSUInteger)quantity withGender:(SRRandomUserGender)gender completion:(SRRandomUserCompletionBlock)completion{
    
    
}

+(void)randomUsersRequest:(NSUInteger)quantity withGender:(SRRandomUserGender)gender andNationality:(SRRandomUserNationality)nationality completion:(SRRandomUserCompletionBlock)completion{
    
}

@end
