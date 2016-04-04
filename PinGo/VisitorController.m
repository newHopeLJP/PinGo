//
//  VisitorController.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/21.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "VisitorController.h"
#import "VisitorRecord.h"
#import "VisitorCell.h"
#import "VisitorHeaderView.h"
#import "NSDate+Extension.h"

@interface VisitorController ()
@property (nonatomic,copy) NSArray *dataList;
@end

@implementation VisitorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    WS(ws);//weak self
    
    [VisitorRecord fetchVisitorRecordCompletion:^(NSArray * visitorRecordList) {
        ws.dataList=visitorRecordList;
        dispatch_async(dispatch_get_main_queue(), ^{
            ws.tableView.rowHeight=50;
            [ws.tableView reloadData];
        });
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)dataList{
    if (!_dataList) {
        _dataList=[[NSMutableArray alloc] init];
    }
    return _dataList;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VisitorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VisitorCell" forIndexPath:indexPath];
    cell.visitorRecord = self.dataList[indexPath.row];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section!=0) {
        return nil;
    }
    if (self.dataList.count==0) {
        return nil;
    }
    
    VisitorHeaderView *headerView=[VisitorHeaderView loadFromNib];
    NSPredicate *predicate=[NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        VisitorRecord *recode=evaluatedObject;
        NSDate *date=[NSDate dateWithTimeStamp:recode.visitTime];
        return [date isToday];
    }];
//    NSUInteger todayVisitor=[self.dataList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"isToday=YES"]]].count;
    NSUInteger todayVisitor=[self.dataList filteredArrayUsingPredicate:predicate].count;
    [headerView setVisitorCount:self.dataList.count];
    [headerView setVisitorTodayCount:todayVisitor];
    return headerView;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
