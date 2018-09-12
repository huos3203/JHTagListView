//
//  JHTagCenterViewController.m
//  JHTagListView_Example
//
//  Created by admin on 2018/9/12.
//  Copyright © 2018年 huo3203@hotmail.com. All rights reserved.
//

#import "JHTagCenterViewController.h"
#import "DaiBanViewController.h"

#import "PatrolSearchBar.h"
#import "JHTagListView.h"
//#import "ReqFilterServer.h"
#import "HistoryRecordViewController.h"
#import "ReqFilterStoreModel.h"

//#import "Utility.h"
//#import "MJRefresh.h"

#define XMGScreenW [UIScreen mainScreen].bounds.size.width

#define XMGScreenH [UIScreen mainScreen].bounds.size.height

#define labelW [UIScreen mainScreen].bounds.size.width/3


@interface JHTagCenterViewController ()<UIScrollViewDelegate,UISearchBarDelegate>
@property (nonatomic, weak) UILabel *selLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic, strong) NSMutableArray *titleLabels;


@property (strong, nonatomic) IBOutlet PatrolSearchBar *ibSearchBar;
@property (strong, nonatomic) ReqFilterStoreModel *filterModel;
@property (strong, nonatomic) IBOutlet UIView *ibErrorView;
@property (strong, nonatomic) IBOutlet UIButton *ibRefreshBtn;

@property (strong, nonatomic) IBOutlet JHTagListView *tagListView;
@end

@implementation JHTagCenterViewController
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
    //    [self.tagListView setupFilterView:nil];
    // 1.添加所有子控制器
    [self setUpChildViewController];
    
    // 2.添加所有子控制器对应标题
    [self setUpTitleLabel];
    
    // iOS7会给导航控制器下所有的UIScrollView顶部添加额外滚动区域
    // 不想要添加
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 3.初始化UIScrollView
    [self setUpScrollView];
    
    UIColor * grayColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f];
    [_ibRefreshBtn.layer setBorderWidth:1];
    [_ibRefreshBtn.layer setBorderColor:grayColor.CGColor];
    [_ibRefreshBtn.layer setMasksToBounds:YES];
    [_ibRefreshBtn.layer setCornerRadius:15.0];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
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
            //            [self parseFilterStoreStatus];
//            [_ibTableView reloadData];
        }];
    });
}

-(void)reqFilterDataList
{
    //    dispatch_group_enter(_group);
    //    [[ReqFilterServer shared] reqStoreList:self.filterModel Handler:^(NSArray<RestStoreListModel *> *listModel) {
    //        //门店列表
    //        dispatch_group_leave(_group);
    //        if ([listModel isKindOfClass:[NSArray class]]) {
    //            NSArray *array = (NSArray *)listModel;
    //            [_shopDataArray addObjectsFromArray:array];
    //            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    //                //                [_ibShopTableView footerEndRefreshing];
    //                [self.view sendSubviewToBack:_ibErrorView];
    //                _ibShopTableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
    //                [_ibShopTableView reloadData];
    //            }];
    //        }else{
    //            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    //                //                [_ibShopTableView footerEndRefreshing];
    //                if (!_filterModel.time) {
    //                    [self.view bringSubviewToFront:_ibErrorView];
    //                }
    //                [_ibShopTableView reloadData];
    //            }];
    //        }
    //    }];
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

//返回
- (IBAction)ibaBackAction:(id)sender {
    //    [Utility hideProgressDialog];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter / setter
- (NSMutableArray *)titleLabels
{
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (IBAction)ibaClickFilterButtonAction:(id)sender {
    [self hiddenKeyWord];
    [self.view bringSubviewToFront:_tagListView];
    [_tagListView showListView];
}

- (IBAction)ibaResetTableViewAction:(id)sender {
    _filterModel.storeTypeId = @"";
    _filterModel.storeTypeLevel = 0;
    _filterModel.locationId = @"";
    _filterModel.locationLevel = 0;
    _filterModel.inspectEnum = 2;
    _filterModel.time = nil;
    _filterModel.pageNo = 1;
    [_shopDataArray removeAllObjects];
    [self ibaClickFilterButtonAction:nil];
    [self reqFilterDataList];
}

- (IBAction)ibaStartFilterAction:(id)sender {
    _filterModel.time = nil;
    _filterModel.pageNo = 1;
    [_shopDataArray removeAllObjects];
    [self ibaClickFilterButtonAction:nil];
    [self reqFilterDataList];
}

-(void)hiddenKeyWord
{
    [self.view endEditing:YES];
}

#warning 3.初始化UIScrollView
// 初始化UIScrollView
- (void)setUpScrollView
{
    NSUInteger count = self.childViewControllers.count;
    // 设置标题滚动条
    self.titleScrollView.contentSize = CGSizeMake(count * labelW, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置内容滚动条
    self.contentScrollView.contentSize = CGSizeMake(count * XMGScreenW, 0);
    // 开启分页
    self.contentScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    self.contentScrollView.bounces = NO;
    // 隐藏水平滚动条
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    self.contentScrollView.delegate = self;
}

#warning 2.添加所有子控制器对应标题
// 添加所有子控制器对应标题
- (void)setUpTitleLabel
{
    NSUInteger count = self.childViewControllers.count;
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelH = 44;
    UIColor *selColor = [UIColor greenColor];

    for (int i = 0; i < count; i++) {
        // 获取对应子控制器
        UIViewController *vc = self.childViewControllers[i];
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        
        labelX = i * labelW;
        
        // 设置尺寸
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        // 设置label文字
        label.text = vc.title;
        
        // 设置高亮文字颜色
        label.highlightedTextColor = selColor;
        
        // 设置label的tag
        label.tag = i;
        
        // 设置用户的交互
        label.userInteractionEnabled = YES;
        
        // 文字居中
        label.textAlignment = NSTextAlignmentCenter;
        // line下划线
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelW - 60, 1)];
        line.center = CGPointMake(labelW/2, labelH-1);
        line.backgroundColor = selColor;
        line.hidden = YES;
        [label addSubview:line];
        /// 当第一个tag时，显示红点
        if (i == 0) {
            UIImageView *reddot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_xiaohongdian"]];
            [reddot sizeToFit];
            reddot.center = CGPointMake(labelW - 20, 14);
            [label addSubview:reddot];
        }
        
        // 添加到titleLabels数组
        [self.titleLabels addObject:label];
    
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        
        // 默认选中第0个label
        if (i == 0) {
            [self titleClick:tap];
        }
        
        // 添加label到标题滚动条上
        [self.titleScrollView addSubview:label];
    }
    
}

// 设置标题居中
- (void)setUpTitleCenter:(UILabel *)centerLabel
{
    // 计算偏移量
    CGFloat offsetX = centerLabel.center.x - XMGScreenW * 0.5;
    
    if (offsetX < 0) offsetX = 0;
    
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - XMGScreenW;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    
    // 滚动标题滚动条
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

#pragma mark - UIScrollViewDelegate
//隐藏键盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hiddenKeyWord];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.titleLabels[index];
    
    [self selectLabel:selLabel];
    
    // 3.让选中的标题居中
    [self setUpTitleCenter:selLabel];
    
    
}

// 显示控制器的view
- (void)showVc:(NSInteger)index
{
    CGFloat offsetX = index * XMGScreenW;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    vc.view.frame = CGRectMake(offsetX, 0, XMGScreenW, XMGScreenH);
    
    [self.contentScrollView addSubview:vc.view];
}

// 点击标题的时候就会调用
- (void)titleClick:(UITapGestureRecognizer *)tap
{
    
    // 0.获取选中的label
    UILabel *selLabel = (UILabel *)tap.view;
    
    // 1.标题颜色变成红色,设置高亮状态下的颜色
    [self selectLabel:selLabel];
    
    // 2.滚动到对应的位置
    NSInteger index = selLabel.tag;
    // 2.1 计算滚动的位置
    CGFloat offsetX = index * XMGScreenW;
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 3.给对应位置添加对应子控制器
    [self showVc:index];
    
    // 4.让选中的标题居中
    [self setUpTitleCenter:selLabel];
    
}

// 选中label
- (void)selectLabel:(UILabel *)label
{
    _selLabel.highlighted = NO;
    if (_selLabel.subviews.count > 0) {
        UILabel *selline = _selLabel.subviews[0];
        selline.hidden = YES;
    }
    
    label.highlighted = YES;
    if (label.subviews.count > 0) {
        UILabel *line = label.subviews[0];
        line.hidden = NO;
    }
    _selLabel = label;
}

#warning 1.添加所有子控制器对应标题
// 添加所有子控制器
- (void)setUpChildViewController
{
    DaiBanViewController *ssVc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"JHTagBaseViewController"];
    ssVc1.title = @"待办(123)";
    [self addChildViewController:ssVc1];
    [ssVc1 didMoveToParentViewController:self];
    DaiBanViewController *ssVc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"JHTagBaseViewController"];
    ssVc2.title = @"已办(123)";
    [ssVc2 didMoveToParentViewController:self];
    [self addChildViewController:ssVc2];
    
    DaiBanViewController *ssVc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"JHTagBaseViewController"];
    ssVc3.title = @"管理(123)";
    [self addChildViewController:ssVc3];
}

@end
