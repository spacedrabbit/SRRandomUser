//
//  SRRandomUserPool.h
//  SRRandomUser
//
//  Created by Louis Tur on 4/28/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRRandomUserPool : NSObject

/** Returns an @p SRRandomUserPool which contains an array of SRRandomUsers along with API Version and Seed value
 *
 *  @param userData @p NSDictionary obtained from querying the API
 *  @return @p SRRandomUserPool filled with SRRandomUsers
 */
+(instancetype)randomUserPoolForData:(NSDictionary *)userData;

@end
