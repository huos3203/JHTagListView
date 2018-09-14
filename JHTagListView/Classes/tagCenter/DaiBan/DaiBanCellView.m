//
//  FilterTableCellView.m
//  JHPatrolSDK
//
//  Created by admin on 2018/5/30.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "DaiBanCellView.h"
#import "DaiBanCellModel.h"

@interface DaiBanCellView()
@property (strong, nonatomic) IBOutlet UIButton *ibCheckButton;
@property (strong, nonatomic) IBOutlet UILabel *PatrolResultLabel;

@end

@implementation DaiBanCellView

-(void)setDbModel:(DaiBanCellModel *)dbModel
{
    self.model = dbModel;
    _dbModel = dbModel;
    _ibCheckButton.selected = dbModel.isEditing;
}

- (IBAction)ibaCheckAction:(id)sender {
    _ibCheckButton.selected = _ibCheckButton.isSelected?NO:YES;
    _dbModel.isEditing = _ibCheckButton.selected;
}

@end
