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

@implementation SRRandomUserPool

+(instancetype)randomUserPoolForData:(NSArray *)userData{
    
    for (NSDictionary *userInfo in userData) {
        
        NSDictionary *user = userInfo[SRUserKey];
        
        NSDictionary *accountDictionary = @{ SREmailKey     : user[SREmailKey],
                                             SRUsernameKey  : user[SRUsernameKey],
                                             SRPasswordKey  : user[SRPasswordKey],
                                             SRRegistrationDateKey : user[SRRegistrationDateKey],
                                             SRDOBKey       : user[SRDOBKey],
                                             SRPhoneKey     : user[SRPhoneKey],
                                             SRCellKey      : user[SRCellKey],
                                             SRNationalityKey : user[SRNationalityKey],
                                             SRGenderKey    : user[SRGenderKey] };
        
        SRRandomUser *randomUser = [SRRandomUser randomUserWithName:user[SRFullNameKey]
                                                            address:user[SRLocationKey]
                                                            account:accountDictionary
                                                      profileImages:user[SRImageGalleryKey] ];
    }
    
    return nil;
}

-(instancetype) initPoolWithSeed:(NSString *)seed version:(NSString *)version{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
