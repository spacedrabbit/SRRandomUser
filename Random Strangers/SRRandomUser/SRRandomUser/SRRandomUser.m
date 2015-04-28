//
//  SRRandomUser.m
//  SRRandomUser
//
//  Created by Louis Tur on 4/28/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import "SRRandomUser.h"
@import CoreGraphics;

static NSString * const SRGenderKey = @"gender";
static NSString * const SRTitleKey = @"title";
static NSString * const SRFirstNameKey = @"first";
static NSString * const SRLastNameKey = @"last";
static NSString * const SRStreetKey = @"street";
static NSString * const SRCityKey = @"city";
static NSString * const SRStateKey = @"state";
static NSString * const SRZipKey = @"zip";
static NSString * const SREmailKey = @"email";
static NSString * const SRUsernameKey = @"username";
static NSString * const SRPasswordKey = @"password";
static NSString * const SRRegistrationDateKey = @"registered";
static NSString * const SRDOBKey = @"dob";
static NSString * const SRPhoneKey = @"phone";
static NSString * const SRCellKey = @"cell";
static NSString * const SRImageLargeKey = @"large";
static NSString * const SRImageMediumKey = @"medium";
static NSString * const SRImageThumbKey = @"thumbnail";
static NSString * const SRNationalityKey = @"nationality";

@interface SRRandomUser ()

@property (strong, nonatomic) NSDictionary *fullName;
@property (strong, nonatomic) NSDictionary *address;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSDictionary *accountDetails;
@property (strong, nonatomic) NSDictionary *images;

@end

@implementation SRRandomUser

+(instancetype)randomUserWithName:(NSDictionary *)fullName
                          address:(NSDictionary *)address
                          account:(NSDictionary *)accountDetails
                    profileImages:(NSDictionary *)images
{
    SRRandomUser *user = [[SRRandomUser alloc] initWithName:fullName
                                                    address:address
                                                    account:accountDetails
                                              profileImages:images];
    return user;
}

-(instancetype)initWithName:(NSDictionary *)fullName
                    address:(NSDictionary *)address
                    account:(NSDictionary *)accountDetails
              profileImages:(NSDictionary *)images
{
    self = [super init];
    if (self) {
        _fullName = fullName;
        _address = address;
        _accountDetails = accountDetails;
        _images = images;
    }
    return self;
}

-(NSString *)formattedName{
    return [NSString stringWithFormat:@"%@ %@ %@", self.title, self.firstName, self.lastName];
}

-(NSString *)formattedAddress{
    return [NSString stringWithFormat:@"%@\n%@, %@ %@", self.streetAddress, self.city, self.state, self.zipCode];
}

// Setters
- (void)setFullName:(NSDictionary *)fullName{
    _firstName = fullName[SRFirstNameKey];
    _lastName = fullName[SRLastNameKey];
    _title = fullName[SRLastNameKey];
}

-(void)setAddress:(NSDictionary *)address{
    _streetAddress = address[SRStreetKey];
    _city = address[SRCityKey];
    _state = address[SRStateKey];
    _zipCode = address[SRZipKey];
}

-(void)setAccountDetails:(NSDictionary *)accountDetails{
    _emailAddress = accountDetails[SREmailKey];
    _username = accountDetails[SRUsernameKey];
    _password = accountDetails[SRPasswordKey];
    _phoneNumber = accountDetails[SRPhoneKey];
    _cellNumber = accountDetails[SRCellKey];
    _nationality = accountDetails[SRNationalityKey];
    _gender = accountDetails[SRGenderKey];
    
    NSString *dateOfBirthString = accountDetails[SRDOBKey];
    CGFloat birthInterval = [dateOfBirthString doubleValue];
    _dateOfBirth = [NSDate dateWithTimeIntervalSince1970:birthInterval];
    
    NSString *registrationString = accountDetails[SRRegistrationDateKey];
    CGFloat timeInterval = [registrationString doubleValue];
    _dateOfRegistration = [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

-(void)setImages:(NSDictionary *)images{
    _largeProfileImage = [NSURL URLWithString:images[SRImageLargeKey]];
    _mediumProfileImage = [NSURL URLWithString:images[SRImageMediumKey]];
    _thumbnailProfileImage = [NSURL URLWithString:images[SRImageThumbKey]];
}
@end
