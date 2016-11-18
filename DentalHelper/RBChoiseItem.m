//
//  RBChoiseItem.m
//  DentalHelper
//
//  Created by Roman Bugaian on 17/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBChoiseItem.h"
#import "RBChoiseItemTableViewCell.h"

@implementation RBChoiseItem

+ (RBChoiseItem *)itemWithDict:(NSDictionary *)dict {
    RBChoiseItem *item = [[RBChoiseItem alloc] init];
    item.title = dict[@"title"];
    item.dequeIdentifier = @"choiseItem";
    item.nibName = @"RBChoiseItemTableViewCell";
    item.isSelected = NO;
    
    return item;
}

+ (RBItem *)itemWithTitle:(NSString *)title {
    return [RBChoiseItem itemWithDict:@{@"title":title}];
}

- (void)processTableViewCell:(UITableViewCell *)cell {
    if ([cell isKindOfClass:[RBChoiseItemTableViewCell class]]) {
        ((RBChoiseItemTableViewCell *)cell).title.text = _title;
        if (self.isSelected) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}


@end
