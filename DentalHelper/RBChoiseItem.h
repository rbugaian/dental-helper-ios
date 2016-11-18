//
//  RBChoiseItem.h
//  DentalHelper
//
//  Created by Roman Bugaian on 17/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBItem.h"

@interface RBChoiseItem : RBItem

@property (strong, nonatomic) NSString *title;
@property BOOL isSelected;

+ (RBItem *)itemWithTitle:(NSString *)title;

@end
