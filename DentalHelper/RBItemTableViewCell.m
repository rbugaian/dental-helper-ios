//
//  RBItemTableViewCell.m
//  DentalHelper
//
//  Created by Roman Bugaian on 17/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBItemTableViewCell.h"

@implementation RBItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
