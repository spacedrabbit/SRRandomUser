//
//  SRRandomUser.h
//  SRRandomUser
//
//  Created by Tur, Louis on 4/23/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRRandomUserAPIManager.h"

@interface SRRandomUser : NSObject

+ (instancetype)randomUserWithAttributes:(NSDictionary *)attributes;

@end
