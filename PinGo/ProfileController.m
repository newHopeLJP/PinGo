//
//  ProfileController.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/22.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "ProfileController.h"

@implementation ProfileController

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10.0;
    }
    return 5.0;
}

@end
