//
//  ShowCell.m
//  ShotV
//
//  Created by Galileo Guzman on 19/11/15.
//  Copyright © 2015 Galileo Guzman. All rights reserved.
//

#import "ShowCell.h"

@implementation ShowCell

- (void)awakeFromNib {
    // Initialization code
    
    self.lblOpacity.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
