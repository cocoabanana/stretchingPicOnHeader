//
//  ViewController.m
//  顶部图片放大效果
//
//  Created by cocoabanana on 16/6/15.
//  Copyright © 2016年 cocoabanana. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,assign) CGFloat initialHeight;
@property (nonatomic,assign) CGFloat initialWidth;
@property (nonatomic,assign) CGFloat startY;
@property (nonatomic,assign) CGFloat lastY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    
    _imageView.image = [UIImage imageNamed:@"386515.jpg"];
    
    _initialWidth = [[UIScreen mainScreen] bounds].size.width;
    _initialHeight = 200;
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    NSLog(@"%@",NSStringFromCGRect(_imageView.frame));

}


-(void)viewDidLayoutSubviews{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = [touches anyObject];
    CGPoint initialPoint = [touch locationInView:self.view];
    
    _startY = initialPoint.y;
    _lastY = _startY;
    NSLog(@"touchesBegan---%@",NSStringFromCGPoint(initialPoint));


}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    UITouch * touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    CGFloat distance = (currentPoint.y - _lastY);
    
    CGFloat bili = 1.5;
    
    CGFloat xheight = (distance*bili)*600/1242;
    CGFloat xwidth = distance*bili;

    [UIView animateWithDuration:0.02 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        CGRect bounds = _imageView.bounds;
        
        bounds.size.height += xheight;
        bounds.size.width +=xwidth;
        
        if (bounds.size.height <= _initialHeight) {
            bounds.size.height = _initialHeight;
            bounds.size.width = _initialWidth;
        }
        
        _imageView.bounds = bounds;
        
    } completion:NULL];
    
    _lastY = currentPoint.y;
    
    NSLog(@"touchesMoved---%@",NSStringFromCGPoint(currentPoint));
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    UITouch * touch = [touches anyObject];
    CGPoint endPoint = [touch locationInView:self.view];
    
    NSLog(@"touchesEnded---%@",NSStringFromCGPoint(endPoint));
    
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect bounds = _imageView.bounds;
        bounds.size.height = _initialHeight;
        bounds.size.width = _initialWidth;
        _imageView.bounds = bounds;
    } completion:NULL];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    
    UITouch * touch = [touches anyObject];
    CGPoint cancelPoint = [touch locationInView:self.view];
    
    NSLog(@"touchesCancelled---%@",NSStringFromCGPoint(cancelPoint));
}
@end
