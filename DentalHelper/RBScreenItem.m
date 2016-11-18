//
//  RBScreenItem.m
//  DentalHelper
//
//  Created by Roman Bugaian on 14/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBScreenItem.h"
#import "RBScreenItemTableViewCell.h"

@implementation RBScreenItem

+ (RBScreenItem *)itemWithDict:(NSDictionary *)dict {
    
    RBScreenItem *item = [[RBScreenItem alloc] init];
    item.title = dict[@"title"];
    item.screen = [RBScreen screenWithDict:dict[@"screen"]];
    item.type = dict[@"item_type"];
    item.dequeIdentifier = @"screenItem";
    item.nibName = @"RBScreenItemTableViewCell";

    
    return item;
}

- (void)processTableViewCell:(RBScreenItemTableViewCell *)cell {
    if ([cell isKindOfClass:[RBScreenItemTableViewCell class]]) {
        cell.screenTitle.text = self.title;
    }
}

- (void)didSelectInViewController:(UIViewController *)viewController {
    [viewController.navigationController showViewController:self.screen.viewController sender:viewController];
}

@end
