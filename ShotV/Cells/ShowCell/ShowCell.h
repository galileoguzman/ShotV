//
//  ShowCell.h
//  ShotV
//
//  Created by Galileo Guzman on 19/11/15.
//  Copyright © 2015 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblShowName;
@property (strong, nonatomic) IBOutlet UIImageView *imgShow;
@property (strong, nonatomic) IBOutlet UILabel *lblOpacity;
@property (strong, nonatomic) IBOutlet UILabel *lblSummary;

@end
