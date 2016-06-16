//
//  CustomTableViewController.m
//  顶部图片放大效果
//
//  Created by cocoabanana on 16/6/15.
//  Copyright © 2016年 cocoabanana. All rights reserved.
//

#import "CustomTableViewController.h"

@interface CustomTableViewController ()
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,assign) CGFloat initialHeight;
@property (nonatomic,assign) CGFloat initialWidth;
@property (nonatomic,assign) CGFloat startY;
@property (nonatomic,assign) CGFloat lastY;
@end

@implementation CustomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    _imageView = [UIImageView new];
    _imageView.image = [UIImage imageNamed:@"386515.jpg"];
    _imageView.bounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 200);
    
    _initialWidth = [[UIScreen mainScreen] bounds].size.width;
    _initialHeight = 200;
    
    self.tableView.tableHeaderView = _imageView;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell" forIndexPath:indexPath];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= -64) {
        
        CGFloat distance = (_lastY - offsetY);
        
        CGFloat bili = 1.5;
        
        CGFloat xheight = (distance*bili)*600/1242;
        CGFloat xwidth = distance*bili;
        
        [UIView animateWithDuration:0.02 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
            
            CGRect frame = _imageView.bounds;
            
            frame.size.height += xheight;
            frame.size.width +=xwidth;
            
            if (frame.size.height <= _initialHeight) {
                frame.size.height = _initialHeight;
                frame.size.width = _initialWidth;
            }
            
            _imageView.bounds = frame;
            
        } completion:NULL];
        
    }else{
        
        [UIView animateWithDuration:0.02 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
            
            CGRect frame = _imageView.bounds;
            
            frame.size.height = _initialHeight;
            frame.size.width = _initialWidth;
            
            _imageView.bounds = frame;
            
        } completion:NULL];
    
    }
    
    _lastY = offsetY;

    
}// any offset changes
//- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2); // any zoom scale changes

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    
    _startY = -64;
    _lastY = _startY;
}
// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));

    
}
// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));

}

//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    
//}// called on finger up as we are moving
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//}// called when scroll view grinds to a halt
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    
//}// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating

//- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;     // return a view that will be scaled. if delegate returns nil, nothing happens
//- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2); // called before the scroll view begins zooming its content
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale; // scale between minimum and maximum. called after any 'bounce' animations

//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{   // return a yes if you want to scroll to the top. if not defined, assumes YES
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;      // called when scrolling animation finished. may be called immediately if already at top

@end
