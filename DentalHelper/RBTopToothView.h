//
//  RBToothView.h
//  DentalHelper
//
//  Created by Roman Bugaian on 01/08/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface RBTopToothView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *toothTopView;
@property (weak, nonatomic) IBOutlet UIImageView *toothRootView;
@property (weak, nonatomic) IBOutlet UILabel *toothNumber;

@end
