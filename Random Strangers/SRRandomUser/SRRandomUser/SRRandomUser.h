//
//  SRRandomUser.h
//  SRRandomUser
//
//  Created by Louis Tur on 4/28/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const SREmailKey;
extern NSString * const SRUsernameKey;
extern NSString * const SRPasswordKey;
extern NSString * const SRRegistrationDateKey;
extern NSString * const SRDOBKey;
extern NSString * const SRPhoneKey;
extern NSString * const SRCellKey;
extern NSString * const SRNationalityKey;
extern NSString * const SRGenderKey;
extern NSString * const SRSSNKey;

@interface SRRandomUser : NSObject

// Basic details
@property (strong, nonatomic, readonly) NSString *firstName;
@property (strong, nonatomic, readonly) NSString *lastName;
@property (strong, nonatomic, readonly) NSString *title;

/** Returns @p SRRandomUser's formatted name
 *  @return @p NSString Formatted string as [Title] [Firstname] [Lastname]
 */
- (NSString *)formattedName;

// Address information
@property (strong, nonatomic, readonly) NSString *streetAddress;
@property (strong, nonatomic, readonly) NSString *city;
@property (strong, nonatomic, readonly) NSString *state;
@property (strong, nonatomic, readonly) NSString *zipCode;

/** Returns @p SRRandomUser's formatted address
 *  @return @p NSString Formatted string as [Street]\n[City], [State] [Zip]
 */
- (NSString *)formattedAddress;

// Account details
@property (strong, nonatomic, readonly) NSString *username;
@property (strong, nonatomic, readonly) NSString *password;
@property (strong, nonatomic, readonly) NSString *gender;
@property (strong, nonatomic, readonly) NSDate *dateOfRegistration;

// Contact details
@property (strong, nonatomic, readonly) NSString *emailAddress;
@property (strong, nonatomic, readonly) NSString *phoneNumber;
@property (strong, nonatomic, readonly) NSString *cellNumber;

// Image details
@property (strong, nonatomic, readonly) NSURL *largeProfileImage;
@property (strong, nonatomic, readonly) NSURL *mediumProfileImage;
@property (strong, nonatomic, readonly) NSURL *thumbnailProfileImage;

// Extended details
@property (strong, nonatomic, readonly) NSString *nationality;
@property (strong, nonatomic, readonly) NSDate *dateOfBirth;

/** Creates a random user with the given attributes
 *
 *  @param fullName @p NSDictionary of name details (first, last, title)
 *  @param address @p NSDictionary of address details (street, city, state, zip)
 *  @param accountDetails @p NSDictionary of account details (username, password, registration)
 *  @param images @p NSDictionary of @p NSURL containing image URLs (large, medium, thumb)
 *
 *  @return Returns an instance of an @p SRRandomUser
 */
+(instancetype)randomUserWithName:(NSDictionary *)fullName
                          address:(NSDictionary *)address
                          account:(NSDictionary *)accountDetails
                    profileImages:(NSDictionary *)images;

@end
