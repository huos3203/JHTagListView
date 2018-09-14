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
#import "JHTagBanliModel.h"
@interface JHTagBaseViewController ()
@property (strong, nonatomic) NSMutableArray *allTypeArr;
@end

@implementation JHTagBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //隐藏多余cell的分割线
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
    }];
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        //
    }];
    
    DaiBanCellModel *model = [DaiBanCellModel new];
    model.tagType = DaiBanType;
    model.Name = @"测试数据";
    model.time = @"2018-09-19";
    model.xchaPeople = @"李四";
    model.address = @"工作测试上地";
    model.statusColor = @"FF5C4D";
    JHTagBanliModel *model2 = [JHTagBanliModel new];
    model2.tagType = YiBanType;
    model2.Name = @"测试数据2";
    model2.time = @"2018-09-10";
    model2.address = @"工作测试上地2";
    model2.zhfResult = @"执法完成";
    model2.zhfPeople = @"占三";
    model2.xchaPeople = @"李四";
    model2.statusColor = @"3B92FF";
    JHTagBanliModel *model3 = [JHTagBanliModel new];
    model3.tagType = GuanliType;
    model3.Name = @"测试数据3";
    model3.address = @"工作测试上地3";
    model3.zhfResult = @"执法完成";
    model3.time = @"2018-09-10";
    model3.xchaPeople = @"李四";
    model3.statusColor = @"333333";
    JHTagBanliModel *model4 = [JHTagBanliModel new];
    model4.tagType = GuanliType;
    model4.time = @"2018-09-10";
    model4.Name = @"测试数据4";
    model4.address = @"工作测试上地4";
    model4.zhfResult = @"执法完成";
    model4.zhfPeople = @"guanlidd";
    model4.xchaPeople = @"李四";
    model4.statusColor = @"87BA4B";
    [self.allTypeArr addObjectsFromArray:@[model,model2,model3,model4]];
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
-(NSMutableArray *)allTypeArr
{
    if (!_allTypeArr) {
        _allTypeArr = [NSMutableArray new];
    }
    return _allTypeArr;
}

-(NSMutableArray *)dataArray
{
    //TODO:通过curTagType筛选要显示的列表数据
    NSArray *typeArr = [_allTypeArr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"tagType = %d",self.curTagType]];
    return [typeArr mutableCopy];
}

@end
