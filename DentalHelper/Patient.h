//
//  Patient.h
//  DentalHelper
//
//  Created by Roman Bugaian on 27/06/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface Patient : RLMObject

@property NSInteger id;

@property NSString *firstName;

@property NSString *lastName;

@property NSString *telephoneNumber;

@property NSString *mobileNumber;

@property NSString *emailAddress;

@property NSString *notes;

@property NSDate *birthDate;

@end
