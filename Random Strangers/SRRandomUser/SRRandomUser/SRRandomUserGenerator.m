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
#import "SRRandomUserFileManager.h"

@interface SRRandomUserGenerator()

@property (strong, nonatomic) SRRandomUserAPIManager *sharedAPIManager;
@property (strong, nonatomic) SRRandomUserGenerator *sharedRandomUserManager;


@property (nonatomic) SRRandomUserResultsFormat defaultResultsFormat;
@property (nonatomic) BOOL makeLegoRequests;

@end


@implementation SRRandomUserGenerator

#pragma mark - Initializers

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
        _shouldSaveResults = NO;
    }
    return self;
}

-(void)saveRandomRequestResults:(BOOL)saveResults{
    _shouldSaveResults = saveResults;
}

// TODO: Figure out if I really want to save a file...
-(BOOL)previousRequestsExist{
    SRRandomUserFileManager *fileManager = [SRRandomUserFileManager sharedFileManager];
    return NO;
}

# pragma mark - Request Methods 

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

#pragma mark - Retrieve Requests from Disk

-(void)retrievePreviousRequests:(SRRandomUserRetrievalBlock)retrievalBlock{
    
    
}

@end
