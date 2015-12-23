//
//  WHFoldViewCell.h
//  折叠动画
//
//  Created by xxoo on 15/12/21.
//  Copyright © 2015年 xxoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHFoldView.h"

@interface WHFoldViewCell : UITableViewCell

@property (nonatomic , strong) WHFoldView  *foldView;
@property (nonatomic , assign) CGFloat viewHeight;

- (void)showOrigamiTransitionWithDuration:(CGFloat)duration
                               completion:(void (^)(BOOL finished))completion;

- (void)hideOrigamiTransitionWithDuration:(CGFloat)duration
                               completion:(void (^)(BOOL finished))completion;

@end
