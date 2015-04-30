//
//  SRRandomUserPool.m
//  SRRandomUser
//
//  Created by Louis Tur on 4/28/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import "SRRandomUserPool.h"
#import "SRRandomUser.h"


static NSString * const SRFullNameKey = @"name";
static NSString * const SRLocationKey = @"location";
static NSString * const SRImageGalleryKey = @"picture";
static NSString * const SRUserKey = @"user";
static NSString * const SRSeedKey = @"seed";
static NSString * const SRAllResultsKey = @"results";
static NSString * const SRAPIVersionKey = @"version";

@interface SRRandomUserPool ()

@property (strong, nonatomic) NSString *seed;
@property (strong, nonatomic) NSString *apiVersion;
@property (strong, nonatomic) NSArray *pool;

@end

@implementation SRRandomUserPool

+ (instancetype)randomUserPoolForData:(NSDictionary *)userData{
    
    NSMutableArray *userPool = [[NSMutableArray alloc] init];
    NSArray *allResults = userData[SRAllResultsKey];
    
    static NSString *_seed, *_version;
    
    for (NSDictionary *userInfo in allResults) {
        
        NSDictionary *user = userInfo[SRUserKey];
        NSDictionary *accountDictionary = @{          SREmailKey : user[SREmailKey],
                                                   SRUsernameKey : user[SRUsernameKey],
                                                   SRPasswordKey : user[SRPasswordKey],
                                           SRRegistrationDateKey : user[SRRegistrationDateKey],
                                                        SRDOBKey : user[SRDOBKey],
                                                      SRPhoneKey : user[SRPhoneKey],
                                                       SRCellKey : user[SRCellKey],
                                                SRNationalityKey : user[SRNationalityKey],
                                                     SRGenderKey : user[SRGenderKey]         };
        
        SRRandomUser *randomUser = [SRRandomUser randomUserWithName:user[SRFullNameKey]
                                                            address:user[SRLocationKey]
                                                            account:accountDictionary
                                                      profileImages:user[SRImageGalleryKey] ];
        
        // only want the first seed value,
        // ensure this only happens once per pool
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _seed = userInfo[SRSeedKey];
            _version = user[SRAPIVersionKey];
        });
        
        [userPool addObject:randomUser];
    }
    
    SRRandomUserPool *pool = [[SRRandomUserPool alloc] initPool:userPool WithSeed:_seed version:_version];
    
    return pool;
}

- (instancetype) initPool:(NSArray *)pool WithSeed:(NSString *)seed version:(NSString *)version{
    self = [super init];
    if (self) {
        _seed = seed;
        _apiVersion = version;
        _pool = pool;
    }
    return self;
}

- (NSString *)seedForPool:(SRRandomUserPool *)pool{
    return pool.seed;
}


@end
