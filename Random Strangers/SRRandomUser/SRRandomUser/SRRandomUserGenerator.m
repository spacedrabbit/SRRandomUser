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
    
    static SRRandomUserGenerator *_sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[SRRandomUserGenerator alloc] init];
    });
    return _sharedManager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _defaultResultsFormat = SRRandomUserResultsFormatJSON;
        _makeLegoRequests = NO;
    }
    return self;
}

- (void)randomUserRequestWithCompletion:(SRRandomUserCompletionBlock)completion{
    
    [[SRRandomUserGenerator sharedRandomUserManager] randomUsersRequest:1
                                                             withGender:SRRandomUserGenderAny
                                                         andNationality:SRRandomUserNationalityAll
                                                             completion:completion];
}

- (void)randomUsersRequest:(NSUInteger)quantity completion:(SRRandomUserCompletionBlock)completion{
    
    [[SRRandomUserGenerator sharedRandomUserManager] randomUsersRequest:quantity
                                                             withGender:SRRandomUserGenderAny
                                                         andNationality:SRRandomUserNationalityAll
                                                             completion:completion];
    
}

- (void)randomUsersRequest:(NSUInteger)quantity withGender:(SRRandomUserGender)gender completion:(SRRandomUserCompletionBlock)completion{
    
    [[SRRandomUserGenerator sharedRandomUserManager] randomUsersRequest:quantity
                                                             withGender:gender
                                                         andNationality:SRRandomUserNationalityAll
                                                             completion:completion];
}

- (void)randomUsersRequest:(NSUInteger)quantity withGender:(SRRandomUserGender)gender andNationality:(SRRandomUserNationality)nationality completion:(SRRandomUserCompletionBlock)completion{
    
    [[SRRandomUserAPIManager sharedAPIManager] requestOnlyLego:self.makeLegoRequests];
    [[SRRandomUserAPIManager sharedAPIManager] requestRandomUsers:quantity
                                                         ofGender:gender
                                                   andNationality:nationality
                                                       completion:^(FSNConnection *connection)
    {

        if (connection.httpResponse.statusCode == 200) {
            NSDictionary *response = (NSDictionary *)connection.parseResult;
            SRRandomUserPool *resultsPool = [SRRandomUserPool randomUserPoolForData:response];
            
            completion(resultsPool, YES);
        }
        else if (connection.httpResponse.statusCode > 400){
            NSLog(@"Error in completing request: %@", connection.error);
            completion(nil, NO);
        }
        
    }];
    
}

@end
