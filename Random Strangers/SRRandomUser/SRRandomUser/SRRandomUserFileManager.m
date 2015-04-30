//
//  SRRandomUserFileManager.m
//  SRRandomUser
//
//  Created by Louis Tur on 4/29/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import "SRRandomUserFileManager.h"

static NSString * const SRRandomUserPoolDirectory = @"Random User Requests";

@interface SRRandomUserFileManager ()

@property (strong, nonatomic) SRRandomUserFileManager *fileManager;
@property (strong, nonatomic) NSURL *randomUserURL;

@end

@implementation SRRandomUserFileManager

+ (instancetype)sharedFileManager {
    
    static SRRandomUserFileManager *_sharedFileMananger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFileMananger = [[SRRandomUserFileManager alloc] init];
    });
    return _sharedFileMananger;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _fileManager = (SRRandomUserFileManager *)[NSFileManager defaultManager];
        _randomUserURL = [NSURL fileURLWithPath:[self checkIfPoolDirectoryExists]];
    }
    return self;
}

- (NSString *)checkIfPoolDirectoryExists {
    
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) firstObject];
    NSString *poolPath = [filePath stringByAppendingPathComponent:SRRandomUserPoolDirectory];
    if (![self.fileManager fileExistsAtPath:poolPath]) {
        [self.fileManager createDirectoryAtPath:poolPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return poolPath;
}

// TODO: See if i really want to save this as a file
- (NSString *)checkForExistingSavedRequests{
    
    return nil;
}

@end
