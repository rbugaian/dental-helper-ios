//
//  RBItem.m
//  DentalHelper
//
//  Created by Roman Bugaian on 14/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBItem.h"
#import "RBScreenItem.h"
#import "RBItemTableViewCell.h"
#import "RBChoiseItem.h"


@implementation RBItem

- (instancetype)init {
    self = [super init];
    self.dequeIdentifier = @"defaultCell";
    self.nibName = @"RBItemTableViewCell";
    return self;
}

+ (RBItem *)itemWithDict:(NSDictionary *)dict {
    NSMutableDictionary *itemTypes = [NSMutableDictionary dictionary];
    [itemTypes setValue:[RBScreenItem class] forKey:@"screen_item"];
    
    RBItem *item;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        item = [[itemTypes valueForKey:dict[@"item_type"]] itemWithDict:dict];
        item.section = dict[@"section"];
        item.type = dict[@"type"];
    } else {
        item = [RBChoiseItem itemWithTitle:(NSString *)dict];
        item.type = @"choise_item";
        item.section = @"";
    }
    
    if (item == nil) {
        item = [[RBItem alloc] init];
        item.type = @"default";
    }
    
    return item;
}

+ (RBItem *)itemWithDict:(NSDictionary *)dict andParentScreen:(RBScreen *)screen {
    RBItem *item = [RBItem itemWithDict:dict];
    item.parentScreen = screen;
    return item;
}

- (void)processTableViewCell:(UITableViewCell *)cell {
    if ([cell isKindOfClass:[RBItemTableViewCell class]]) {
        cell.textLabel.text = @"RBItem";
    }
}

- (void)didSelectInViewController:(UIViewController *)viewController {
    NSLog(@"Did select raw item.");
}


@end
