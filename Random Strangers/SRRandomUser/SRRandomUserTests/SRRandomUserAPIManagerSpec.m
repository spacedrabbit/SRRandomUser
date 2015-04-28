//
//  SRRandomUserAPIManagerSpec.m
//  SRRandomUser
//
//  Created by Tur, Louis on 4/23/15.
//  Copyright 2015 Tur, Louis. All rights reserved.
//

#import "Specta.h"
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "SRRandomUserAPIManager.h"

SpecBegin(SRRandomUserAPIManager)

describe(@"+[SRRandomUserAPIManager sharedAPIManager]", ^{
    
    __block SRRandomUserAPIManager *sharedAPIManager;
    beforeAll(^{
        sharedAPIManager = [SRRandomUserAPIManager sharedAPIManager];
    });
    
    it(@"Should return instancetype and not nil", ^{
        expect(sharedAPIManager).toNot.beNil;
        expect(sharedAPIManager).to.beMemberOf([SRRandomUserAPIManager class]);
    });  
    
});

describe(@"-[SRRandomUserAPIManager requestRandomUser:]", ^{
    
    __block SRRandomUserAPIManager *sharedAPIManager;
    __block NSDictionary *singleUserJSON;
    
    beforeAll(^{
        sharedAPIManager = [SRRandomUserAPIManager sharedAPIManager];
    });
    
    it(@"Should complete request and return a single random user", ^{
        
        NSData *sampleJSONFile = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"singleRandomUserTest" withExtension:@"json"]];
        NSDictionary *singleUserJSON = [NSJSONSerialization JSONObjectWithData:sampleJSONFile options:0 error:nil];
        
        
    });
    
});

SpecEnd
