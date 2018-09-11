//
//  SearchShopsViewController.m
//  YGPatrol(github地址)
//
//  Created by admin on 2018/5/14.
//Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "SearchShopsViewController.h"
#import "JHGroupItem.h"
#import "JHTagItem.h"
#import "JHTagGroupItem.h"
#import "YZTagGroupCell.h"
#import "YZGroupHeaderView.h"
#import "PatrolSearchBar.h"

#import "TableCellViewInCell.h"
#import "ReqFilterServer.h"
#import "StoreAllTypeModel.h"
#import "StoreLocationModel.h"

#import "HistoryRecordViewController.h"
#import "ReqFilterStoreModel.h"

//#import "Utility.h"
//#import "MJRefresh.h"

#import "FilterStoreCellView.h"
//#import "ShopStatusViewController.h"
#import "RestStoreListModel.h"

#import "JHTagListView.h"

@implementation RoundLabel

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = [borderColor CGColor];
    _borderColor = borderColor;
}
-(void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0?true:false;
}

@end

@interface SearchShopsViewController()<UITableViewDelegate,UITableViewDataSource,FoldSectionHeaderViewDelegate,UISearchBarDelegate>


@property (nonatomic, strong) NSMutableArray *groups;

@property (strong, nonatomic) IBOutlet UITableView *ibShopTableView;
@property (strong, nonatomic) IBOutlet PatrolSearchBar *ibSearchBar;
@property (strong, nonatomic) ReqFilterStoreModel *filterModel;
@property (strong, nonatomic) IBOutlet UIView *ibErrorView;
@property (strong, nonatomic) IBOutlet UIButton *ibRefreshBtn;

@property (strong, nonatomic) JHTagListView *tagListView;
@end
@implementation SearchShopsViewController
{
    NSMutableDictionary *_foldInfoDic;
    NSMutableArray *_headerViewArray;
    NSBundle *_resourceBundle;
    NSMutableArray *_shopDataArray;
    dispatch_group_t _group;
    BOOL _clearSearchBar;
    BOOL _firstLoaded;
}

#pragma mark - def
//MARK: override
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    _shopDataArray = [NSMutableArray new];
    _foldInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"0":@"1", @"1":@"1",@"2":@"1"}];
    [_tagListView setupFilterView:nil];
    UIColor * grayColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f];
    [_ibRefreshBtn.layer setBorderWidth:1];
    [_ibRefreshBtn.layer setBorderColor:grayColor.CGColor];
    [_ibRefreshBtn.layer setMasksToBounds:YES];
    [_ibRefreshBtn.layer setCornerRadius:15.0];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    if (!_firstLoaded) {
        _firstLoaded = YES;
        [self setupShopTableView];
    }
}
#pragma mark 用户登录代理方法
-(void)JHLoginCallBack{
    if (!_firstLoaded) {
        _firstLoaded = YES;
        [self setupShopTableView];
    }
}
-(void)setupShopTableView{
    _ibShopTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    __weak typeof(self) weakSelf = self;
//    [_ibShopTableView addFooterWithCallback:^{
//        [weakSelf loadDataList];
//    }];
    [self loadDataList];
}


-(JHTagListView *)tagListView
{
    if (!_tagListView) {
        //TODO: 从storyboard加载View，并Add到UIView
        _tagListView = [JHTagListView new];
    }
    return _tagListView;
}
-(ReqFilterStoreModel *)filterModel
{
    if (!_filterModel) {
        _filterModel = [ReqFilterStoreModel new];
        _filterModel.inspectEnum = 2;
        _filterModel.count = 10;
    }
    return _filterModel;
}

- (IBAction)ibaRefreshDataAction:(id)sender {
    [self loadDataList];
}
-(void)loadDataList{
    //    [Utility showProgressDialogText:@"正在加载..."];
    if (!_group) {
        _group = dispatch_group_create();
    }
    [self reqFilterDataList];
    [_tagListView loadDataList:_group];
    
    dispatch_group_notify(_group, dispatch_get_global_queue(0, 0), ^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //            [Utility hideProgressDialog];
            ///先加载已经指定的检查情况
            [self parseFilterStoreStatus];
            [_ibShopTableView reloadData];
        }];
    });
}

-(void)reqFilterDataList
{
    dispatch_group_enter(_group);
    [[ReqFilterServer shared] reqStoreList:self.filterModel Handler:^(NSArray<RestStoreListModel *> *listModel) {
        //门店列表
        dispatch_group_leave(_group);
        if ([listModel isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)listModel;
            [_shopDataArray addObjectsFromArray:array];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //                [_ibShopTableView footerEndRefreshing];
                [self.view sendSubviewToBack:_ibErrorView];
                _ibShopTableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
                [_ibShopTableView reloadData];
            }];
        }else{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //                [_ibShopTableView footerEndRefreshing];
                if (!_filterModel.time) {
                    [self.view bringSubviewToFront:_ibErrorView];
                }
                [_ibShopTableView reloadData];
            }];
        }
    }];
}
#pragma mark searchBar delegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    if (_clearSearchBar) {
        _clearSearchBar = NO;
    }else{
        [self performSegueWithIdentifier:@"HistoryRecordSegue" sender:self];
    }
    return NO;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString:@""]) {
        //清除
        _filterModel.keywords = @"";
        _filterModel.time = nil;
        _filterModel.pageNo = 1;
        _clearSearchBar = YES;
        [_shopDataArray removeAllObjects];
        [self reqFilterDataList];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //跳转到历史记录页
    if ([segue.identifier isEqualToString:@"HistoryRecordSegue"]) {
        HistoryRecordViewController *hrVc = segue.destinationViewController;
        //传递block开始历史搜索页面，当点击历史记录时，将历史记录文本填充搜索框
        __weak typeof(self) weakSelf = self;
        hrVc.fromVCName = @"FilterKeyHistoryArray";
        hrVc.searchText = ^(NSString *tag) {
            _ibSearchBar.text = tag;
            _filterModel.keywords = tag;
            _filterModel.time = nil;
            _filterModel.pageNo = 1;
            [_shopDataArray removeAllObjects];
            [weakSelf reqFilterDataList];
            [_ibSearchBar resignFirstResponder];
        };
    }
}

#pragma mark - table dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _shopDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FilterStoreCellView *shopCell = [tableView dequeueReusableCellWithIdentifier:@"FilterStoreCellView"];
    RestStoreListModel *model = [_shopDataArray objectAtIndex:indexPath.row];
    shopCell.storeModel = model;
    return shopCell;
}

//返回
- (IBAction)ibaBackAction:(id)sender {
//    [Utility hideProgressDialog];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter / setter
- (NSArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (IBAction)ibaClickFilterButtonAction:(id)sender {
    [self hiddenKeyWord];
    [self.view bringSubviewToFront:_tagListView];
    [_tagListView showListView];
}


-(NSInteger)toInt:(NSString *)str
{
    NSInteger num = 0;
    if (str && ![str isEqualToString:@""]) {
        num = str.integerValue;
    }
    return num;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hiddenKeyWord];
}
-(void)hiddenKeyWord
{
    [self.view endEditing:YES];
}

@end

