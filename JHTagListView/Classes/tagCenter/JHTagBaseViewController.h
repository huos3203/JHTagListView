//
//  JHTagBaseViewController.h
//  JHTagListView_Example
//
//  Created by admin on 2018/9/12.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHTagBanliModel.h"

@interface JHTagBaseViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) TagListType curTagType;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end
