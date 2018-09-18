//
//  YZGroupHeaderView.h
//  YZTagListDemo
//
//  Created by yz on 16/8/16.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FoldSectionHeaderViewDelegate <NSObject>

- (void)foldHeaderInSection:(NSInteger)SectionHeader;
- (void)foldCellCurrentRow:(NSIndexPath *)indexPath;
@end


@class JHGroupItem;
@class JHTagGroupItem;
@interface YZGroupHeaderView : UIView

@property (nonatomic, strong) JHGroupItem *groupItem;
@property (nonatomic, strong) JHTagGroupItem *tagGroupItem;
+ (instancetype)groupHeaderView;

@property (weak, nonatomic) IBOutlet UIButton *ibClearBtn;
- (IBAction)ibaClearAction:(id)sender;

//折叠单元格
@property (strong, nonatomic) IBOutlet UIButton *ibFoldButton;
@property (weak, nonatomic) IBOutlet UILabel *groupLabel;
@property(nonatomic, assign) BOOL fold;/**< 是否折叠 */
@property(nonatomic, assign) NSInteger section;/**< 选中的section */
@property(nonatomic, assign) NSIndexPath *rowIndexPath;/**< 选中的cell title */

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headViewTopConstraint;
@property (strong, nonatomic) IBOutlet UILabel *headerLineLabel;

@property(nonatomic, weak) id<FoldSectionHeaderViewDelegate> delegate;/**< 代理 */

@end
