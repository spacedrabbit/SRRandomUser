//
//  SRRandomUser.m
//  SRRandomUser
//
//  Created by Louis Tur on 4/28/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import "SRRandomUser.h"
@import CoreGraphics;

#pragma mark - private consts

static NSString * const SRTitleKey = @"title";
static NSString * const SRFirstNameKey = @"first";
static NSString * const SRLastNameKey = @"last";
static NSString * const SRStreetKey = @"street";
static NSString * const SRCityKey = @"city";
static NSString * const SRStateKey = @"state";
static NSString * const SRZipKey = @"zip";

static NSString * const SRImageLargeKey = @"large";
static NSString * const SRImageMediumKey = @"medium";
static NSString * const SRImageThumbKey = @"thumbnail";

#pragma mark - external consts -

NSString * const SREmailKey = @"email";
NSString * const SRUsernameKey = @"username";
NSString * const SRPasswordKey = @"password";
NSString * const SRRegistrationDateKey = @"registered";
NSString * const SRDOBKey = @"dob";
NSString * const SRPhoneKey = @"phone";
NSString * const SRCellKey = @"cell";
NSString * const SRNationalityKey = @"nationality";
NSString * const SRGenderKey = @"gender";
NSString * const SRSSNKey = @"SSN";


@interface SRRandomUser ()

@property (strong, nonatomic) NSDictionary *fullName;
@property (strong, nonatomic) NSDictionary *address;
@property (strong, nonatomic) NSDictionary *accountDetails;
@property (strong, nonatomic) NSDictionary *images;

@end

@implementation SRRandomUser

#pragma mark - Initializers

+ (instancetype)randomUserWithName:(NSDictionary *)fullName
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

- (instancetype)initWithName:(NSDictionary *)fullName
                    address:(NSDictionary *)address
                    account:(NSDictionary *)accountDetails
              profileImages:(NSDictionary *)images
{
    self = [super init];
    if (self) {
        self.fullName = fullName;
        self.address = address;
        self.accountDetails = accountDetails;
        self.images = images;
    }
    return self;
}

#pragma mark - Formatting Convinience Methods

- (NSString *)formattedName {
    return [NSString stringWithFormat:@"%@ %@ %@", self.title, self.firstName, self.lastName];
}

- (NSString *)formattedAddress {
    return [NSString stringWithFormat:@"%@\n%@, %@ %@", self.streetAddress, self.city, self.state, self.zipCode];
}

#pragma mark - Property Setters

- (void)setFullName:(NSDictionary *)fullName {
    _fullName = fullName;
    
    _firstName = fullName[SRFirstNameKey];
    _lastName = fullName[SRLastNameKey];
    _title = fullName[SRLastNameKey];
}

- (void)setAddress:(NSDictionary *)address {
    _address = address;
    
    _streetAddress = address[SRStreetKey];
    _city = address[SRCityKey];
    _state = address[SRStateKey];
    _zipCode = address[SRZipKey];
}

- (void)setAccountDetails:(NSDictionary *)accountDetails {
    _accountDetails = accountDetails;
    
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

- (void)setImages:(NSDictionary *)images {
    _images = images;
    
    _largeProfileImage = [NSURL URLWithString:images[SRImageLargeKey]];
    _mediumProfileImage = [NSURL URLWithString:images[SRImageMediumKey]];
    _thumbnailProfileImage = [NSURL URLWithString:images[SRImageThumbKey]];
}
@end
