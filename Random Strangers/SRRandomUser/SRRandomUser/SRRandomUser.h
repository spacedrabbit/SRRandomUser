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
/** An @p SRRandomUser's first name
 *  @sa -(NSString *)formattedName
 */
@property (strong, nonatomic, readonly) NSString *firstName;
/** An @p SRRandomUser's last name 
 *  @sa -(NSString *)formattedName
 */
@property (strong, nonatomic, readonly) NSString *lastName;
/** An @p SRRandomUser's title, such as Mr. Mrs. and Ms. 
 *  @sa -(NSString *)formattedName
 */
@property (strong, nonatomic, readonly) NSString *title;

/** Returns @p SRRandomUser's formatted name
 *  @return @p NSString Formatted string as [Title] [Firstname] [Lastname]
 */
- (NSString *)formattedName;

// Address information
/** An @p SRRandomUser's street address
 *  @sa -(NSString *)formattedAddress
 */
@property (strong, nonatomic, readonly) NSString *streetAddress;
/** An @p SRRandomUser's city
 *  @sa -(NSString *)formattedAddress
 */
@property (strong, nonatomic, readonly) NSString *city;
/** An @p SRRandomUser's state/county
 *  @sa -(NSString *)formattedAddress
 */
@property (strong, nonatomic, readonly) NSString *state;
/** An @p SRRandomUser's zip code
 *  @sa -(NSString *)formattedAddress
 */
@property (strong, nonatomic, readonly) NSString *zipCode;

/** Returns @p SRRandomUser's formatted address
 *  @return @p NSString Formatted string as [Street]\n[City], [State] [Zip]
 */
- (NSString *)formattedAddress;

// Account details
/** An @p SRRandomUser's username */
@property (strong, nonatomic, readonly) NSString *username;
/** An @p SRRandomUser's password */
@property (strong, nonatomic, readonly) NSString *password;
/** An @p SRRandomUser's gender */
@property (strong, nonatomic, readonly) NSString *gender;
/** An @p SRRandomUser's date of registration as a date determined from the number of seconds since 1970
 *  @remarks May require additional formatting through use of @p NSDateFormatter depending on your needs
 */
@property (strong, nonatomic, readonly) NSDate *dateOfRegistration;

// Contact details
/** An @p SRRandomUser's email address */
@property (strong, nonatomic, readonly) NSString *emailAddress;
/** An @p SRRandomUser's phone number */
@property (strong, nonatomic, readonly) NSString *phoneNumber;
/** An @p SRRandomUser's cell phone number */
@property (strong, nonatomic, readonly) NSString *cellNumber;

// Image details - See all user photos: https://randomuser.me/photos
/** An @p SRRandomUser's URL for a large profile image */
@property (strong, nonatomic, readonly) NSURL *largeProfileImage;
/** An @p SRRandomUser's URL for a medium profile image */
@property (strong, nonatomic, readonly) NSURL *mediumProfileImage;
/** An @p SRRandomUser's URL for a thumbnail profile image */
@property (strong, nonatomic, readonly) NSURL *thumbnailProfileImage;

// Extended details
/** An @p SRRandomUser's nationality
 *  @remarks Currently the API only supports GB and US
 */
@property (strong, nonatomic, readonly) NSString *nationality;
/** An @p SRRandomUser's date of registration as a date determined from the number of seconds since 1970
 *  @remarks May require additional formatting through use of @p NSDateFormatter depending on your needs
 */
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
