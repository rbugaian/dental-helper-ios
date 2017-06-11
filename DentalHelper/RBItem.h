//
//  RBItem.h
//  DentalHelper
//
//  Created by Roman Bugaian on 14/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RBScreen;

@interface RBItem : NSObject

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *section;

@property (strong, nonatomic) NSString *dequeIdentifier;
@property (strong, nonatomic) NSString *nibName;

@property (strong, nonatomic) RBScreen *parentScreen;

+ (RBItem *)itemWithDict:(NSDictionary *)dict;
+ (RBItem *)itemWithDict:(NSDictionary *)dict andParentScreen:(RBScreen *)screen;

- (void)processTableViewCell:(UITableViewCell *)cell;
- (void)didSelectInViewController:(UIViewController *)viewController;

@end
