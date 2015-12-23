//
//  WHFoldViewCell.m
//  折叠动画
//
//  Created by xxoo on 15/12/21.
//  Copyright © 2015年 xxoo. All rights reserved.
//

#import "WHFoldViewCell.h"

@interface WHFoldViewCell ()

@end

@implementation WHFoldViewCell

@synthesize foldView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self.contentView addSubview:self.foldView];
        [self insertSubview:self.foldView atIndex:0];
    }
    return self;
}

- (WHFoldView *)foldView{
    if (foldView == nil) {
        foldView = [[WHFoldView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,300)];
        foldView.backgroundColor = [UIColor cyanColor];
    }
    return foldView;
}

- (void)showOrigamiTransitionWithDuration:(CGFloat)duration
                               completion:(void (^)(BOOL finished))completion
{
    CGRect renderFrame = CGRectMake(0, 150, SCREEN_WIDTH, 300);
    CGPoint anchorPoint =CGPointMake(0.5, 0);
    
    UIGraphicsBeginImageContext(renderFrame.size);
    [foldView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewSnapShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imageCrop = CGImageCreateWithImageInRect(viewSnapShot.CGImage, CGRectMake(0, 150, SCREEN_WIDTH, 150));
    UIImage* imageSnapShot = [UIImage imageWithCGImage:imageCrop];
//    imageLayer.contents = (__bridge id)imageCrop;
//    imageLayer.backgroundColor = [UIColor redColor].CGColor;
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500;
    CALayer * origamiLayer = [CALayer layer];
    origamiLayer.frame = CGRectMake(0, 150, SCREEN_WIDTH, 150);
    origamiLayer.backgroundColor = [UIColor blackColor].CGColor;
    origamiLayer.sublayerTransform = transform;
    [foldView.layer addSublayer:origamiLayer];
    
    double startAngle;
    CGFloat foldHeight = 150/2;
    CALayer *prevLayer = origamiLayer;
    
    for (int i = 0; i < 2; i++) {
        if (i == 0) {
            startAngle = -M_PI/2;
        }else{
            startAngle = M_PI;
        }
        CGRect imageFrame = CGRectMake(0, i * 150/2, SCREEN_WIDTH, foldHeight);
        CATransformLayer *transLayer = [self transformLayerFromImage:imageSnapShot Frame:imageFrame Duration:duration AnchorPiont:anchorPoint StartAngle:startAngle EndAngle:0];
        [prevLayer addSublayer:transLayer];
        prevLayer = transLayer;
    }
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        //        移除覆盖在上面的图片
        [origamiLayer removeFromSuperlayer];
        
        if (completion)
            completion(YES);
    }];
}

- (void)hideOrigamiTransitionWithDuration:(CGFloat)duration
                               completion:(void (^)(BOOL finished))completion{
    
    CGRect renderFrame = CGRectMake(0, 150, SCREEN_WIDTH, 300);
    CGPoint anchorPoint =CGPointMake(0.5, 0);
    
    UIGraphicsBeginImageContext(renderFrame.size);
    [foldView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewSnapShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imageCrop = CGImageCreateWithImageInRect(viewSnapShot.CGImage, CGRectMake(0, 150, SCREEN_WIDTH, 150));
    UIImage* imageSnapShot = [UIImage imageWithCGImage:imageCrop];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500;
    CALayer * origamiLayer = [CALayer layer];
    origamiLayer.frame = CGRectMake(0, 150, SCREEN_WIDTH, 150);
    origamiLayer.backgroundColor = [UIColor blackColor].CGColor;
    origamiLayer.sublayerTransform = transform;
    [foldView.layer addSublayer:origamiLayer];

    double endAngle;
    CGFloat foldHeight = 150/2;
    CALayer *prevLayer = origamiLayer;
    
    for (int i = 0; i < 2; i++) {
        if (i == 0) {
            endAngle = -M_PI/2;
        }else{
            endAngle = M_PI;
        }
        CGRect imageFrame = CGRectMake(0, i * 150/2, SCREEN_WIDTH, foldHeight);
        CATransformLayer *transLayer = [self transformLayerFromImage:imageSnapShot Frame:imageFrame Duration:duration AnchorPiont:anchorPoint StartAngle:0 EndAngle:endAngle];
        [prevLayer addSublayer:transLayer];
        prevLayer = transLayer;
    }
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        //        移除覆盖在上面的图片
        [origamiLayer removeFromSuperlayer];
        
        if (completion)
            completion(YES);
    }];
}

- (CATransformLayer *)transformLayerFromImage:(UIImage *)image Frame:(CGRect)frame Duration:(CGFloat)duration AnchorPiont:(CGPoint)anchorPoint StartAngle:(double)start EndAngle:(double)end;
{
    CATransformLayer *jointLayer = [CATransformLayer layer];
    jointLayer.anchorPoint = anchorPoint;
    CGFloat layerWidth;
// anchorPoint = NSPoint:{0.5, 0} {{0, 0}, {375, 75}} {{0, 75}, {375, 75}}
    NSLog(@"frame hide %@",[NSValue valueWithCGRect:frame]);
    if (anchorPoint.x == 0.5)
    {
        layerWidth = image.size.width - frame.origin.x;
        jointLayer.frame = CGRectMake(0, 0, layerWidth, 150/2);
        if (frame.origin.y) {
            jointLayer.position = CGPointMake(SCREEN_WIDTH/2,150/2);
        }
        else {
            jointLayer.position = CGPointMake(SCREEN_WIDTH/2,0);
        }
    }
    
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150/2);
    imageLayer.anchorPoint = anchorPoint;
    imageLayer.position = CGPointMake(SCREEN_WIDTH/2, 0);
    [jointLayer addSublayer:imageLayer];
    CGImageRef imageCrop = CGImageCreateWithImageInRect(image.CGImage, frame);
    imageLayer.contents = (__bridge id)imageCrop;
    imageLayer.backgroundColor = [UIColor redColor].CGColor;
    NSLog(@"jointLayer %@",[UIImage imageWithCGImage:imageCrop]);
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    [animation setDuration:duration];
    [animation setFromValue:[NSNumber numberWithDouble:start]];

    [animation setToValue:[NSNumber numberWithDouble:end]];
    //    播放完成是否回到原来的样子
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //          自动回放 原路返回
//    animation.autoreverses = YES;
    [jointLayer addAnimation:animation forKey:@"jointAnimation"];
    return jointLayer;
}

@end
