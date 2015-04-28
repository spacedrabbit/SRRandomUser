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
static NSString * const SRRandomUserLegoURL = @"?lego";
static NSString * const SRRandomUserNationalityParameter = @"?nat=";
static NSString *SRRandomUserAPIKey = @"";

@interface SRRandomUserAPIManager()

@property (strong, nonatomic) FSNConnection *mostRecentConnection;

@property (copy) FSNParseBlock randomUserParseBlock;

@property (copy, nonatomic) FSNParseBlock defaultParseBlock;
@property (copy, nonatomic) FSNCompletionBlock defaultCompletionBlock;

@end

@implementation SRRandomUserAPIManager

+(instancetype)sharedAPIManager{
    
    __block SRRandomUserAPIManager *sharedManager;
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[SRRandomUserAPIManager alloc] init];
    });
    return sharedManager;
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

-(void)requestRandomUser:(FSNCompletionBlock)completion{
     [self requestRandomUsers:1 ofGender:SRRandomUserGenderAny completion:completion];
}

-(void)requestRandomUsers:(NSUInteger)numberOfUsers completion:(FSNCompletionBlock)completion{
    [self requestRandomUsers:numberOfUsers ofGender:SRRandomUserGenderAny completion:completion];
}

-(void)requestRandomUsers:(NSUInteger)numberOfUsers ofGender:(SRRandomUserGender)gender completion:(FSNCompletionBlock)completion{
    
    if (!completion){
        completion = ^(FSNConnection *connection){
            
            if (connection.httpResponse.statusCode == 200) {
                NSDictionary *jsonResponse = (NSDictionary *)connection.parseResult;
            }
            else if (connection.httpResponse.statusCode > 400){
                NSLog(@"Error in completing request: %@", connection.error);
            }
        };
    }
    
    FSNConnection * fsnConnection = [FSNConnection withUrl:URLIFY(SRRandomUserURL)
                                                    method:FSNRequestMethodGET
                                                   headers:@{}
                                                parameters:@{}
                                                parseBlock:self.defaultParseBlock
                                           completionBlock:completion
                                             progressBlock:nil];
    [fsnConnection start];
    self.mostRecentConnection = fsnConnection;
}


@end
