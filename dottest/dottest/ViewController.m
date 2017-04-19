//
//  ViewController.m
//  dottest
//
//  Created by andson-zhw on 17/4/18.
//  Copyright © 2017年 zhw. All rights reserved.
//

#import "ViewController.h"
#import "TAPageControl.h"
#import "TAAnimatedDotView.h"

@interface ViewController ()<UIScrollViewDelegate,TAPageControlDelegate>
@property (strong, nonatomic) TAPageControl *customStoryboardPageControl;
@property(nonatomic,strong)UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *imagesData;

@property (strong, nonatomic) TAPageControl *customStoryboardPageControl2;
@property(nonatomic,strong)UIScrollView *scrollView2;

@property (strong, nonatomic) TAPageControl *customStoryboardPageControl3;
@property(nonatomic,strong)UIScrollView *scrollView3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imagesData = @[@"image1.jpg", @"image2.jpg", @"image3.jpg", @"image4.jpg", @"image5.jpg"];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 150)];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.imagesData.count, 150);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    [self setupScrollViewImages:self.scrollView];
    
    self.scrollView2 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.scrollView.frame.origin.y + self.scrollView.frame.size.height, self.view.frame.size.width, 150)];
    self.scrollView2.contentSize = CGSizeMake(self.view.frame.size.width * self.imagesData.count, 150);
    self.scrollView2.pagingEnabled = YES;
    self.scrollView2.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView2];
    self.scrollView2.delegate = self;
    [self setupScrollViewImages:self.scrollView2];
    
    
    self.scrollView3 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.scrollView2.frame.origin.y + self.scrollView2.frame.size.height, self.view.frame.size.width, 150)];
    self.scrollView3.contentSize = CGSizeMake(self.view.frame.size.width * self.imagesData.count, 150);
    self.scrollView3.pagingEnabled = YES;
    self.scrollView3.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView3];
    self.scrollView3.delegate = self;
    [self setupScrollViewImages:self.scrollView3];
    
    self.customStoryboardPageControl = [[TAPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame) - 40, CGRectGetWidth(self.scrollView.frame), 40)];
    self.customStoryboardPageControl.numberOfPages = self.imagesData.count;
    
    self.customStoryboardPageControl.dotImage = [UIImage imageNamed:@"dotNormal"];
    self.customStoryboardPageControl.currentDotImage = [UIImage imageNamed:@"dotHight"];
    self.customStoryboardPageControl.delegate = self;
    [self.view addSubview:self.customStoryboardPageControl];
    
    
    self.customStoryboardPageControl2 = [[TAPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView2.frame) - 40, CGRectGetWidth(self.scrollView2.frame), 40)];
    self.customStoryboardPageControl2.numberOfPages = self.imagesData.count;
    self.customStoryboardPageControl2.dotColor = [UIColor orangeColor];
    self.customStoryboardPageControl2.dotCenterIfEmpty = YES;
    self.customStoryboardPageControl2.dotViewClass = [TAAnimatedDotView class];
    self.customStoryboardPageControl2.delegate = self;
    [self.view addSubview:self.customStoryboardPageControl2];
    
    self.customStoryboardPageControl3 = [[TAPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView3.frame) - 40, CGRectGetWidth(self.scrollView3.frame), 40)];
    self.customStoryboardPageControl3.numberOfPages = self.imagesData.count;
    self.customStoryboardPageControl3.dotColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    self.customStoryboardPageControl3.dotCenterIfEmpty = NO;
    self.customStoryboardPageControl3.dotViewClass = [TAAnimatedDotView class];
    self.customStoryboardPageControl3.delegate = self;
    [self.view addSubview:self.customStoryboardPageControl3];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    if (scrollView == self.scrollView) {
        self.customStoryboardPageControl.currentPage = pageIndex;
    }else if (scrollView == self.scrollView2){
        self.customStoryboardPageControl2.currentPage = pageIndex;
    }else if (scrollView == self.scrollView3){
        self.customStoryboardPageControl3.currentPage = pageIndex;
    }
    
    
}

- (void)TAPageControl:(TAPageControl *)pageControl didSelectPageAtIndex:(NSInteger)index
{
    NSLog(@"Bullet index %ld", (long)index);
    if (pageControl == self.customStoryboardPageControl) {
       [self.scrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.scrollView.frame) * index, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame)) animated:YES];
    }else if (pageControl == self.customStoryboardPageControl2){
        [self.scrollView2 scrollRectToVisible:CGRectMake(CGRectGetWidth(self.scrollView2.frame) * index, 0, CGRectGetWidth(self.scrollView2.frame), CGRectGetHeight(self.scrollView2.frame)) animated:YES];
    }else if (pageControl == self.customStoryboardPageControl3){
        [self.scrollView3 scrollRectToVisible:CGRectMake(CGRectGetWidth(self.scrollView3.frame) * index, 0, CGRectGetWidth(self.scrollView3.frame), CGRectGetHeight(self.scrollView3.frame)) animated:YES];
    }
    
}


- (void)setupScrollViewImages:(UIScrollView *)scrollView{
    [self.imagesData enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(scrollView.frame) * idx, 0, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame))];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
