//
//  CoursesViewController.h
//  Task-ObjectiveC
//
//  Created by Mohammad Albadarneh on 12/16/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoursesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *coursesArray;

- (void)CoursesRequest;

@property (weak, nonatomic) IBOutlet UITableView *_coursesTable;

@end
