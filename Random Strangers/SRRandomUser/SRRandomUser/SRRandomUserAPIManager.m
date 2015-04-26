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

-(void)requestRandomUser{
    
    FSNConnection * fsnConnection = [FSNConnection withUrl:URLIFY(SRRandomUserURL)
                                                    method:FSNRequestMethodGET
                                                   headers:@{}
                                                parameters:@{}
                                                parseBlock:^id(FSNConnection * connection, NSError **error) {
                                                    NSData * responseData = connection.responseData;
                                                    NSDictionary *responseJSON = [responseData dictionaryFromJSONWithError:error];
                                                    
                    return responseJSON;
    }
                                           completionBlock:^(FSNConnection *connection) {
                                               NSLog(@"Complete: %@", connection);
        
    }
                                             progressBlock:nil];
    [fsnConnection start];
    
}

@end
