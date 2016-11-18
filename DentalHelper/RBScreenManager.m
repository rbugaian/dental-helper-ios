//
//  RBScreenManager.m
//  DentalHelper
//
//  Created by Roman Bugaian on 14/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBScreenManager.h"

@interface RBScreenManager()

@property NSDictionary *mainJsonDict;
@property RBScreen *rootScreen;

@end

@implementation RBScreenManager

+ (RBScreenManager *)sharedInstance {
    static RBScreenManager *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil) {
            sharedMyManager = [[self alloc] init];
            [sharedMyManager load];
        }
    }
    return sharedMyManager;
}

- (void)load {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"screen_structure" ofType:@".json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    NSError *jsonError;
    _mainJsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                          options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    _rootScreen = [RBScreen screenWithDict: _mainJsonDict];
    
    if (jsonError) {
        NSLog(@"%@", jsonError);
    } else {
        NSLog(@"Main JSON Data: %@", _mainJsonDict);
    }
}

- (RBScreen *)loadRootScreen {
    
    return _rootScreen;
}


@end
