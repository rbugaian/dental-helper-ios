//
//  RBScreenItem.h
//  DentalHelper
//
//  Created by Roman Bugaian on 14/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBItem.h"
#import "RBScreen.h"
#import "RBScreenItemTableViewCell.h"

@interface RBScreenItem : RBItem

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) RBScreen *screen;
@property (strong, nonatomic) RBScreenItemTableViewCell *cell;

+ (RBScreenItem *)itemWithDict:(NSDictionary *)dict;


@end
