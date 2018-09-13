//
//  HistoryRecordViewController.m
//  YGPatrol
//
//  Created by admin on 2018/5/23.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "HistoryRecordViewController.h"
#import "YZTagList.h"
#import "FilterPatrolSearchBar.h"
//#import "Utility.h"
@interface HistoryRecordViewController ()<UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *ibScrollView;
@property (strong, nonatomic) IBOutlet FilterPatrolSearchBar *ibSearchBar;


@end

@implementation HistoryRecordViewController
{
    YZTagList *_tagList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 创建标签列表
    _tagList = [[YZTagList alloc] init];
    //    tagList.backgroundColor = [UIColor brownColor];
    // 高度可以设置为0，会自动跟随标题计算
    _tagList.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 0);
    _tagList.tagBackgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    _tagList.tagFont = [UIFont systemFontOfSize:15];
    _tagList.tagButtonMargin = 10;
    _tagList.tagCornerRadius = 8;
    _tagList.tagMargin = 20;
    _tagList.tagColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    NSMutableArray *tagArray = [[NSUserDefaults standardUserDefaults] objectForKey:_fromVCName];
    if (tagArray && tagArray.count > 0) {
        [_tagList addTags:tagArray];
    }
    // 点击标签，就会调用,点击标签，删除标签
    __weak typeof(self) weakSelf = self;
    _tagList.clickTagBlock = ^(NSString *tag){
        [weakSelf onClickTag:tag];
    };
    _ibScrollView.contentSize = CGSizeMake(_tagList.frame.size.width, _tagList.frame.size.height);
    [_ibScrollView addSubview:_tagList];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_ibSearchBar becomeFirstResponder];
}

- (IBAction)ibaClearHistoryTagAction:(id)sender {
    NSMutableArray *tagArr = [NSMutableArray arrayWithArray:_tagList.tagArray];
    for (NSString *tag in tagArr) {
        [_tagList deleteTag:tag];
    }
    
    [_tagList.tagArray removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:_fromVCName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)onClickTag:(NSString *)tag{
    //返回保存数据
    NSMutableArray *array = [[[NSUserDefaults standardUserDefaults] objectForKey:_fromVCName] mutableCopy];
    if (!array) {
        array = [NSMutableArray new];
    }
    for (NSString *tagname in array) {
        if ([tagname isEqualToString:tag]) {
            [array removeObject:tagname];
            break;
        }
    }
    [array insertObject:tag atIndex:0];
    if (array.count > 8) {
        [array removeLastObject];
    }
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:_fromVCName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //重置tag
    NSMutableArray *tagArr = [NSMutableArray arrayWithArray:_tagList.tagArray];
    for (NSString *tag in tagArr) {
        [_tagList deleteTag:tag];
    }
    [_tagList.tagArray removeAllObjects];
    
    for (NSString *tag in array) {
        [_tagList addTag:tag];
    }
    [self ibaCancelAction:tag];
}

- (IBAction)ibaCancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([sender isKindOfClass:[NSString class]]) {
            _searchText(sender);
        }
    }];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *str = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (str.length == 0) {
//        [Utility showAllTextDialog:self.view Text:@"请输入搜索内容"];
        return;
    }
    
    [self onClickTag:searchBar.text];
    [self ibaCancelAction:searchBar.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
