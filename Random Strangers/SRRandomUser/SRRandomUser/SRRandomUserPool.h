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

/** Used to retrieve the seed generated from a particular pool of users. This seed can be used to make future requests and to ensure that the same pool of random users is returned
 *  @param pool The @p SRRandomUserPool you wish to request again
 *  @return @p NSString the value of the seed
 *  @sa 
 */
- (NSString *)seedForPool:(SRRandomUserPool *)pool;
@end
