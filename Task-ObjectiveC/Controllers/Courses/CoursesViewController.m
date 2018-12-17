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
#import "PDFViewController.h"

static NSString *cellIdentifier = @"SB_CourseTableViewCell";

@interface CoursesViewController ()

@end


@implementation CoursesViewController

@synthesize coursesArray, _coursesTable;

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:true animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    coursesArray = [[NSMutableArray alloc] init];

    _coursesTable.delegate = self;
    _coursesTable.dataSource = self;
    
    [self CoursesRequest];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [coursesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    CourseTableViewCell *cell = [_coursesTable dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[CourseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if([coursesArray count] != 0) {
        
        CoursesResponseModel *obj = [coursesArray objectAtIndex:indexPath.row];
        
        cell.courseName.text = obj.CouseName;
        cell.courseDescription.text = obj.CouseDesc;
        [cell.courseImage sd_setImageWithURL:[NSURL URLWithString:obj.CouseImage] placeholderImage: nil];
        
        cell.openPDF.tag = indexPath.row;
        [cell.openPDF addTarget:self action:@selector(OpenPDF:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
}

- (void)OpenPDF:(UIButton *)sender {
    
    NSLog(@"%li", sender.tag);
    
    CoursesResponseModel *obj = [coursesArray objectAtIndex:sender.tag];
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PDFViewController *pdfViewController = [storyboard instantiateViewControllerWithIdentifier:@"SB_PDFViewController"];
    pdfViewController._url = obj.pdfURL;
    [self.navigationController pushViewController:pdfViewController animated:YES];
    
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
                    
                    [self->coursesArray addObject:obj];
                    
                }
                
                self->_coursesTable.reloadData;
                
                
            }
            
        }
    }];
    
}


@end
