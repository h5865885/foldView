//
//  ViewController.m
//  折叠动画
//
//  Created by xxoo on 15/12/21.
//  Copyright © 2015年 xxoo. All rights reserved.
//

#import "ViewController.h"
#import "WHFoldViewCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * CellHeightArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CellHeightArr = [[NSMutableArray alloc]init];
    [CellHeightArr addObjectsFromArray:@[@150,@150,@150,@150,@150,@150,@150,@150,@150,@150]];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT-100) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [CellHeightArr[indexPath.row] floatValue];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return CellHeightArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"foldCellID";
    WHFoldViewCell * foldCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!foldCell) {
        foldCell = [[WHFoldViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        foldCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ([CellHeightArr[indexPath.row] floatValue] == 300) {
        [foldCell showOrigamiTransitionWithDuration:0.5 completion:^(BOOL finished) {
            
        }];
    }else{
        
    }
    [foldCell.foldView setHeight:[CellHeightArr[indexPath.row] floatValue]];

    return foldCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    WHFoldViewCell  * foldCell = [tableView cellForRowAtIndexPath:indexPath];
    [CellHeightArr replaceObjectAtIndex:indexPath.row withObject:foldCell.bounds.size.height == 150?@300:@150];
    NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    if ([CellHeightArr[indexPath.row] floatValue] == 150) {
        [foldCell hideOrigamiTransitionWithDuration:0.4 completion:^(BOOL finished) {
            
        }];
    }
    [UIView animateWithDuration:0.5 animations:^{
        [tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    }];

//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [tableView beginUpdates];
//    [tableView endUpdates];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    cell.backgroundColor = COLOR(arc4random()%255, arc4random()%255, arc4random()%255, 1);
}



@end
