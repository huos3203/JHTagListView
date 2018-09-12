//
//  SearchShopsViewController.m
//  YGPatrol(github地址)
//
//  Created by admin on 2018/5/14.
//Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "SearchShopsViewController.h"
#import "FilterPatrolStoreCellView.h"

@interface SearchShopsViewController()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *ibTableView;
@end

@implementation SearchShopsViewController
{
    NSMutableArray *_shopDataArray;
    dispatch_group_t _group;
}

#pragma mark - def
//MARK: override
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    _shopDataArray = [NSMutableArray new];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewDidAppear:(BOOL)animated{
//    if (!_firstLoaded) {
//        _firstLoaded = YES;
//        [self setupShopTableView];
//    }
}

-(void)setupShopTableView{
    _ibTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    __weak typeof(self) weakSelf = self;
//    [_ibShopTableView addFooterWithCallback:^{
//        [weakSelf loadDataList];
//    }];
    [self loadDataList];
}

-(void)loadDataList{
    //    [Utility showProgressDialogText:@"正在加载..."];
    if (!_group) {
        _group = dispatch_group_create();
    }
    
    dispatch_group_notify(_group, dispatch_get_global_queue(0, 0), ^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //            [Utility hideProgressDialog];
            ///先加载已经指定的检查情况
//            [self parseFilterStoreStatus];
            [_ibTableView reloadData];
        }];
    });
}

#pragma mark - table dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _shopDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FilterPatrolStoreCellView *shopCell = [tableView dequeueReusableCellWithIdentifier:@"FilterPatrolStoreCellView"];
    RestStoreListModel *model = [_shopDataArray objectAtIndex:indexPath.row];
    shopCell.storeModel = model;
    return shopCell;
}

@end

