//
//  RBScreenManager.h
//  DentalHelper
//
//  Created by Roman Bugaian on 14/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBScreen.h"

@interface RBScreenManager : NSObject

+ (RBScreenManager *)sharedInstance;

- (RBScreen *)loadRootScreen;


@end
