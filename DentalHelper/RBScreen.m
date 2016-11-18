//
//  RBScreen.m
//  DentalHelper
//
//  Created by Roman Bugaian on 14/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBScreen.h"
#import "RBItem.h"
#import "RBSimpleTableViewScreen.h"
#import "RBScreenViewController.h"
#import "RBMultichoiseScreen.h"

@implementation RBScreen

-(instancetype)init {
    self = [super init];

    RBScreen *screen = [super init];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RBScreenViewController" bundle:nil];
    RBScreenViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RBScreenViewController"];
    vc.screen = screen;
    screen.viewController = vc;
    
    return screen;
}

+ (RBScreen *) screenWithDict:(NSDictionary *)dict {
    NSMutableDictionary *screenTypes = [NSMutableDictionary dictionary];
    [screenTypes setValue:[RBSimpleTableViewScreen class] forKey:@"simple_table_view_screen"];
    [screenTypes setValue:[RBMultichoiseScreen class] forKey:@"multi_choice_screen"];

    
    RBScreen *screen = [[screenTypes objectForKey:dict[@"type"]] screenWithDict:dict];
    if (screen == nil) {
        screen  = [[RBScreen alloc] init];
    }
    
    screen.title = dict[@"title"];
    screen.type = dict[@"type"];

    return screen;
}


@end
