//
//  Utils.h
//  DentalHelper
//
//  Created by Roman Bugaian on 27/06/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSDate *)getLocalDate;
+ (NSDate *)getLocalDate:(NSDate *)sourceDate;
+ (NSString *)dateStringFromDate:(NSDate *)date;


@end
