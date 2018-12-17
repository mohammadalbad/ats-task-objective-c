//
//  CoursesViewController.m
//  Task-ObjectiveC
//
//  Created by Mohammad Albadarneh on 12/16/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

#import "CoursesViewController.h"
#import "APIRequestManger.h"
#import "UtilityAPIHost.h"
#import "ProgressIndicatorManger.h"
#import "CoursesResponseModel.h"
#import "CourseTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *cellIdentifier = @"SB_CourseTableViewCell";

@interface CoursesViewController ()

@end

@implementation CoursesViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:true animated:true];
    
    _coursesArray = [[NSMutableArray alloc] init];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __coursesTable.delegate = self;
    __coursesTable.dataSource = self;
    
    [self CoursesRequest];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_coursesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CoursesResponseModel *obj = [_coursesArray objectAtIndex:indexPath.row];
    
    CourseTableViewCell *cell = [__coursesTable dequeueReusableCellWithIdentifier:cellIdentifier];

    
    cell.courseName.text = obj.CouseName;
    cell.courseDescription.text = obj.CouseDesc;
    
    [cell.courseImage sd_setImageWithURL:[NSURL URLWithString:obj.CouseImage] placeholderImage: nil];
    
    return cell;
}


- (void)CoursesRequest
{
    
    [ProgressIndicatorManger showProgressHUD];
    
    NSString *_URL = [NSString stringWithFormat:@"%@%@", HOST, COURSES];
    
    [APIRequestManger APIRequest:_URL withBlock:^(BOOL isSuccess, NSInteger statusCode, id response) {
        
        [ProgressIndicatorManger hideProgressHUD];
        
        if (isSuccess) {
            
            NSError *error;
            NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
            
            if ([json count] != 0) {
                
                for (int i = 0; i < [json count]; i++)
                {
                    NSString *CouseID = json[i][@"CouseID"];
                    NSString *UserID = json[i][@"UserID"];
                    NSString *CouseName = json[i][@"CouseName"];
                    NSString *CouseDesc = json[i][@"CouseDesc"];
                    NSString *CouseImage = json[i][@"CouseImage"];
                    NSString *pdfURL = json[i][@"pdfURL"];
                    
                    CoursesResponseModel *obj = [[CoursesResponseModel alloc] init];
                    obj.CouseID = CouseID;
                    obj.UserID = UserID;
                    obj.CouseName = CouseName;
                    obj.CouseDesc = CouseDesc;
                    obj.CouseImage = CouseImage;
                    obj.pdfURL = pdfURL;

                    [self->_coursesArray addObject:obj];
                    
                }
                
                self->__coursesTable.reloadData;

               
            }
            
        }
    }];
    
}


@end
