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
    
    self.lblOpacity.layer.shadowOpacity = 0.50f;
    self.lblOpacity.layer.shadowRadius = 10.0f;
    self.lblOpacity.layer.shadowColor = [[UIColor blackColor] CGColor];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
