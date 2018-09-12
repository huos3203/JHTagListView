//
//  JHTagBaseViewController.m
//  JHTagListView_Example
//
//  Created by admin on 2018/9/12.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import "JHTagBaseViewController.h"
#import "MJRefresh.h"

#import "DaiBanCellModel.h"
@interface JHTagBaseViewController ()<UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation JHTagBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
    }];
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        //
    }];
    
    DaiBanCellModel *model = [DaiBanCellModel new];
    model.tagType = DaiBanType;
    model.Name = @"测试数据";
    model.Address = @"工作测试上地";
    DaiBanCellModel *model2 = [DaiBanCellModel new];
    model2.tagType = YiBanType;
    model2.Name = @"测试数据2";
    model2.Address = @"工作测试上地2";
    DaiBanCellModel *model3 = [DaiBanCellModel new];
    model3.tagType = GuanliType;
    model3.Name = @"测试数据3";
    model3.Address = @"工作测试上地3";
    [self.dataArray addObjectsFromArray:@[model,model2,model3]];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark getter/setter
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    //TODO:通过curTagType筛选要显示的列表数据
    
    return _dataArray;
}

@end
