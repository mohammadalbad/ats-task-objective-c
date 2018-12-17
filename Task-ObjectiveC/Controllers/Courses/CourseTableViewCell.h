//
//  CourseTableViewCell.h
//  Task-ObjectiveC
//
//  Created by Mohammad Albadarneh on 12/16/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *courseImage;
@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UIButton *openPDF;
@property (weak, nonatomic) IBOutlet UITextView *courseDescription;

@end
