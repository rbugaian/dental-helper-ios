//
//  RBScreen.h
//  DentalHelper
//
//  Created by Roman Bugaian on 14/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RBItem;

@interface RBScreen : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) UIViewController *viewController;

@property (strong, nonatomic) RBItem *parentItem;

+ (RBScreen *) screenWithDict:(NSDictionary *)dict;


@end
