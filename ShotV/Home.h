//
//  ViewController.h
//  ShotV
//
//  Created by Galileo Guzman on 18/11/15.
//  Copyright © 2015 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tblShows;

@end

