//
//  SRRandomUserAPIManager.m
//  SRRandomUser
//
//  Created by Tur, Louis on 4/23/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

@import CoreGraphics;
@import UIKit;
#import "SRRandomUserAPIManager.h"
#import <FSNetworking/FSNConnection.h>

#define URLIFY(string) [NSURL URLWithString:string]

static NSString * const SRRandomUserURL = @"http://api.randomuser.me/";
static NSString * const SRRandomUserAPIKey = @"";

#pragma mark - Request URL Parameter Keys
static NSString * const SRRandomUserNationalityParameter = @"nat";
static NSString * const SRRandomUserGenderParameter = @"gender";
static NSString * const SRRandomUserQuantityParameter = @"results";
static NSString * const SRRandomUserSeedParameter = @"seed";
static NSString * const SRRandomUserResultFormatParameter = @"format";
static NSString * const SRRandomUserLegoParameter = @"lego";

#pragma mark - Request URL Parameter Values
// Gender
static NSString * const SRRandomUserGenderMaleURLValue = @"male";
static NSString * const SRRandomUserGenderFemaleURLValue = @"female";
static NSString * const SRRandomUserGenderAnyURLValue = @"";

// Results Format
static NSString * const SRRandomUserFormatJSONURLValue = @"json";
static NSString * const SRRandomUserFormatCSVURLValue = @"csv";
static NSString * const SRRandomUserFormatSQLURLValue = @"sql";
static NSString * const SRRandomUserFormatYAMLURLValue = @"yaml";

// Nationality
static NSString * const SRRandomUserUSNationalityValue = @"us";
static NSString * const SRRandomUserGBNationalityValue = @"gb";
static NSString * const SRRandomUserAnyNationalityValue = @"";


@interface SRRandomUserAPIManager()

@property (strong, nonatomic) FSNConnection *mostRecentConnection;

@property (copy, nonatomic) FSNParseBlock defaultParseBlock;

@property (nonatomic) BOOL shouldMakeLegoRequests;
@property (nonatomic) SRRandomUserResultsFormat defaultResultsFormat;
@property (nonatomic) SRRandomUserResultsFormat userDefinedResultsFormat;

@end

@implementation SRRandomUserAPIManager

#pragma mark - Initializers and Setters

+ (instancetype)sharedAPIManager {
    static SRRandomUserAPIManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[SRRandomUserAPIManager alloc] init];
    });
    return _sharedManager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _shouldMakeLegoRequests = NO;
        _defaultResultsFormat = SRRandomUserResultsFormatJSON;
    }
    return self;
}

- (FSNParseBlock)defaultParseBlock {
    
    if (!_defaultParseBlock) {
        _defaultParseBlock = ^id(FSNConnection *connection, NSError **error) {
            
            NSData *responseData = connection.responseData;
            NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData
                                                               options:0
                                                                 error:error];
                
                if (*error || ![responseJSON isKindOfClass:[NSDictionary class]]) {
                    return nil;
                }
            return responseJSON;
        };
    }
        return _defaultParseBlock;
}

#pragma mark - Request Methods

- (void)requestRandomUser:(FSNCompletionBlock)completion{
    [self requestRandomUsers:1
                    ofGender:SRRandomUserGenderAny
              andNationality:SRRandomUserNationalityAll
                  completion:completion];
}

- (void)requestRandomUsers:(NSUInteger)numberOfUsers completion:(FSNCompletionBlock)completion{
    [self requestRandomUsers:numberOfUsers
                    ofGender:SRRandomUserGenderAny
              andNationality:SRRandomUserNationalityAll
                  completion:completion];
}

- (void)requestRandomUsers:(NSUInteger)numberOfUsers ofGender:(SRRandomUserGender)gender completion:(FSNCompletionBlock)completion{
    
    [self requestRandomUsers:numberOfUsers
                    ofGender:gender
              andNationality:SRRandomUserNationalityAll
                  completion:completion];
}

-(void)requestRandomUsers:(NSUInteger)numberOfUsers ofGender:(SRRandomUserGender)gender andNationality:(SRRandomUserNationality)nationality completion:(FSNCompletionBlock)completion{
    
    NSDictionary *urlParameters = [self defineRequestParametersForUsers:numberOfUsers gender:gender nationality:nationality];
    
    FSNConnection * fsnConnection = [FSNConnection withUrl:URLIFY(SRRandomUserURL)
                                                    method:FSNRequestMethodGET
                                                   headers:@{}
                                                parameters:urlParameters
                                                parseBlock:self.defaultParseBlock
                                           completionBlock:completion
                                             progressBlock:nil];
    [fsnConnection start];
    self.mostRecentConnection = fsnConnection;
    
}

// TODO: Refactor
- (void)requestRandomUsersFromSeed:(NSString *)seed completion:(FSNCompletionBlock)completion{
    FSNConnection * fsnConnection = [FSNConnection withUrl:URLIFY(SRRandomUserURL)
                                                    method:FSNRequestMethodGET
                                                   headers:@{}
                                                parameters:@{ SRRandomUserSeedParameter : seed }
                                                parseBlock:self.defaultParseBlock
                                           completionBlock:completion
                                             progressBlock:nil];
    [fsnConnection start];
    self.mostRecentConnection = fsnConnection;
}

#pragma mark - Private Convinience Methods

- (NSDictionary *)defineRequestParametersForUsers:(NSUInteger)quantity gender:(SRRandomUserGender)gender nationality:(SRRandomUserNationality)nationality{
    
    NSMutableDictionary *paramsDictionary = [[NSMutableDictionary alloc] init];
    
    NSString *genderValue = [self genderForType:gender];
    NSString *nationalityValue = [self nationalityForType:nationality];
    NSString *formatValue = [self resultsFormatForType:self.userDefinedResultsFormat ? : self.defaultResultsFormat];
    
    // Gender, default is SRRandomUserGenderAny
    if (![genderValue isEqualToString:SRRandomUserGenderAnyURLValue]) {
        [paramsDictionary setObject:genderValue forKey:SRRandomUserGenderParameter];
    }
    // Nationality, default is SRRandomUserNationalityAll
    if (![nationalityValue isEqualToString:SRRandomUserAnyNationalityValue]) {
        [paramsDictionary setObject:nationalityValue forKey:SRRandomUserNationalityParameter];
    }
    // Lego People, default is NO
    if (self.shouldMakeLegoRequests) {
        [paramsDictionary setObject:@"YES" forKey:SRRandomUserLegoParameter];
    }
    
    [paramsDictionary setObject:formatValue forKey:SRRandomUserResultFormatParameter];
    [paramsDictionary setObject:@(quantity) forKey:SRRandomUserQuantityParameter];
    
    return paramsDictionary.copy;
}

- (NSString *)genderForType:(SRRandomUserGender)gender{
    switch (gender) {
        case SRRandomUserGenderFemale:
            return SRRandomUserGenderFemaleURLValue;
        case SRRandomUserGenderMale:
            return SRRandomUserGenderMaleURLValue;
        case SRRandomUserGenderAny:
        default:
            return SRRandomUserGenderAnyURLValue;
    }
}

- (NSString *)nationalityForType:(SRRandomUserNationality)nationality{
    switch (nationality) {
        case SRRandomUserNationalityGB:
            return SRRandomUserGBNationalityValue;
        case SRRandomUserNationalityUS:
            return SRRandomUserGBNationalityValue;
        case SRRandomUserNationalityAll:
        default:
            return SRRandomUserAnyNationalityValue;
    }
}

- (NSString *)resultsFormatForType:(SRRandomUserResultsFormat)format{
    switch (format) {
        case SRRandomUserResultsFormatCSV:
            return SRRandomUserFormatCSVURLValue;
        case SRRandomUserResultsFormatSQL:
            return SRRandomUserFormatSQLURLValue;
        case SRRandomUserResultsFormatYAML:
            return SRRandomUserFormatYAMLURLValue;
        case SRRandomUserResultsFormatJSON:
        default:
            return SRRandomUserFormatJSONURLValue;
    }
}

#pragma mark - Convinience methods to alter API request parameters

- (void)returnResultsAsType:(SRRandomUserResultsFormat)format{
    self.userDefinedResultsFormat = format;
}

- (void)requestOnlyLego:(BOOL)lego{
    self.shouldMakeLegoRequests = lego;
}

- (void)resetToDefaults{
    self.userDefinedResultsFormat = self.defaultResultsFormat;
    self.shouldMakeLegoRequests = NO;
}

@end
