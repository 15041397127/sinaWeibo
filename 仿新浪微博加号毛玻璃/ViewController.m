//
//  ViewController.m
//  仿新浪微博加号毛玻璃
//
//  Created by ZhangXu on 16/3/24.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import "ViewController.h"
#import "MenuPage.h"
@interface ViewController ()<MenuPageDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

 
}



- (IBAction)btnClicked:(id)sender {
    
    MenuPageItem *addItem1 = [[MenuPageItem alloc]init];
    [addItem1 setTitle:@"文字"];
    [addItem1 setIcon:[UIImage imageNamed:@"tabbar_compose_idea"]];
    
    MenuPageItem *addItem2 = [[MenuPageItem alloc]init];
    [addItem2 setTitle:@"照片/视频"];
    [addItem2 setIcon:[UIImage imageNamed:@"tabbar_compose_photo"]];
    
    MenuPageItem *addItem3 = [[MenuPageItem alloc]init];
    [addItem3 setTitle:@"头条文章"];
    [addItem3 setIcon:[UIImage imageNamed:@"tabbar_compose_headlines"]];
    
    MenuPageItem *addItem4 = [[MenuPageItem alloc]init];
    [addItem4 setTitle:@"签到"];
    [addItem4 setIcon:[UIImage imageNamed:@"tabbar_compose_lbs"]];
    
    MenuPageItem *addItem5 = [[MenuPageItem alloc]init];
    [addItem5 setTitle:@"点评"];
    [addItem5 setIcon:[UIImage imageNamed:@"tabbar_compose_review"]];
    
    MenuPageItem *addItem6= [[MenuPageItem alloc]init];
    [addItem6 setTitle:@"更多"];
    [addItem6 setIcon:[UIImage imageNamed:@"tabbar_compose_more"]];
    
    MenuPage *menu = [[MenuPage alloc]initWithMenus:@[addItem1,addItem2,addItem3,addItem4,addItem5,addItem6]];

    [menu setDelegate:self];
    
    menu.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [menu setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentViewController:menu animated:YES completion:nil];
    
    
    
}

#pragma mark 实现代理方法

-(void)MenuPageDidTapOnBackgroud:(MenuPage *)menu{
    
    [self dismissViewControllerAnimated:YES completion:nil];
   
    
}

-(void)MenuPage:(MenuPage *)menu didTapOnItem:(MenuPageItem *)item{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
  
    NSLog(@"item.title:%@",item.title);
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
