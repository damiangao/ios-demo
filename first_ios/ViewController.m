//
//  ViewController.m
//  first_ios
//
//  Created by OurEDA on 2018/3/5.
//  Copyright © 2018年 lx. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIButton *myDemoBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 50)];
//    myDemoBtn.backgroundColor = [UIColor grayColor];
//    [myDemoBtn setTitle:@"BUTTON" forState:UIControlStateNormal];
//    [myDemoBtn setTitle:@"PRESSD" forState:UIControlStateHighlighted];
//    [myDemoBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:myDemoBtn];
//    UIImage *btnImage1 = [UIImage imageNamed:@"Cosmos02.jpg"];
//    UIImage *btnImage2 = [UIImage imageNamed:@"Cosmos02.jpg"];
    
//    myDemoSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 50, 300, 50)];
//    myDemoSlider.maximumValue = 100.0;
//    myDemoSlider.minimumValue = 0.0;
//    myDemoSlider.value=20.0;
//    myDemoSlider.continuous=NO;
//    [myDemoSlider addTarget:self action:@selector(myDemoSS:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:myDemoSlider];
    
//    mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(20, 300, 1, 1)];
//    [self.view addSubview:mySwitch];
//    myPC = [[UIPageControl alloc] initWithFrame:CGRectMake(20, 400, 200, 200)];
//    myPC.numberOfPages=5;
//    myPC.currentPage=3;
//    myPC.hidden=NO;
//    [myPC setBackgroundColor:[UIColor purpleColor]];
//    [self.view addSubview:myPC];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake1(0, 0, 414, 736)];
    [scrollView setContentSize:CGSizeMake1(414*4, 736)];
    [scrollView setDelegate:self];
    scrollView.pagingEnabled = YES;
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake1(0, 0, 414, 736)];
    [imageView1 setImage:[UIImage imageNamed:@"001.jpg"]];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake1(414, 0, 414, 736)];
    [imageView2 setImage:[UIImage imageNamed:@"002.jpg"]];
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake1(414*2, 0, 414, 736)];
    [imageView3 setImage:[UIImage imageNamed:@"003.jpg"]];
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake1(414*3, 0, 414, 736)];
    [imageView4 setImage:[UIImage imageNamed:@"004.jpg"]];
    [scrollView addSubview:imageView1];
    [scrollView addSubview:imageView2];
    [scrollView addSubview:imageView3];
    [scrollView addSubview:imageView4];

    [self.view addSubview:scrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake1(0, 706, 414, 30)];
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    
}

CG_INLINE CGSize
CGSizeMake1(CGFloat width,CGFloat height)
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    return CGSizeMake(width * app.autoSizeScaleX, height * app.autoSizeScaleY);
}

CG_INLINE CGRect
CGRectMake1(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    return CGRectMake(x * app.autoSizeScaleX, y * app.autoSizeScaleY, width * app.autoSizeScaleX, height * app.autoSizeScaleY);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [pageControl setCurrentPage:offset.x/bounds.size.width];
    NSLog(@"%ld", pageControl.currentPage);
}
- (void)pageChanged:(id)sender{
    CGSize viewSize = scrollView.frame.size;
    CGRect rectBounds = CGRectMake(pageControl.currentPage*viewSize.width, 0, viewSize.width, viewSize.height);
    [scrollView scrollRectToVisible:rectBounds animated:YES];
}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(IBAction)btnPressed:(id)sender{
//    NSLog(@"Button Pressed");
//}
//
//-(void)myDemoSS:(id)sender{
//    if(sender == myDemoSlider){
//        NSLog(@"%f",myDemoSlider.value);
//    }
//}

@end
