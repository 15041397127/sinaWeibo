//
//  MenuPage.m
//  仿新浪微博加号毛玻璃
//
//  Created by ZhangXu on 16/3/24.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import "MenuPage.h"

@implementation MenuPageItem

@end

@interface MenuPage ()


@end

@implementation MenuPage

-(instancetype )initWithMenus:(NSArray *)menus{
    
    self = [super init];
    if (self) {
        self.menuItemArr  = menus;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self gesture];
    [self setUpView];
    


    
    // Do any additional setup after loading the view.
}


-(void)gesture{
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapOnBackground)]];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didTapOnBackground)];
    
    [self.view addGestureRecognizer:swipeGesture];
    
}

#pragma mark setUpView

-(void)setUpView{
    //毛玻璃
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [visualEffectView setFrame:self.view.bounds];
    [self.view addSubview:visualEffectView];
    
   //三列
    NSInteger totalloc =3;
    CGFloat appViewW = 80;
    CGFloat appViewH = 80;
    CGFloat margin = (self.view.frame.size.width - totalloc*appViewW)/(totalloc+1);
    
    for (NSInteger i =0; i<self.menuItemArr.count; i++) {
        NSInteger row = i/totalloc;//行号
        NSInteger loc = i%totalloc; //列号
        
        CGFloat appViewX = margin + (margin + appViewW)*loc;
        CGFloat appViewY = 300+(50 + appViewH) *row;
        
        UIView *tabView = [[UIView alloc]init];
        tabView.frame =  CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40);
        tabView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:tabView];
        
        UIImageView *dismissImg  = [[UIImageView alloc]init];
        dismissImg.frame = CGRectMake(self.view.frame.size.width/2 -15, CGRectGetMinY(tabView.frame)+5, 30, 30);
        dismissImg.image = [UIImage imageNamed:@"toolbar_stop_highlighted"];

        [self.view addSubview:dismissImg];
        
        UIImageView *pic = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-80, 100, 160, 50)];
        pic.image = [UIImage imageNamed:@"compose_slogan"];
        [self.view addSubview:pic];
        
        
        

        //button
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(appViewX, 800, appViewW, appViewH)];
        [button setTag:i];
        
        [button addTarget:self action:@selector(itemBtnClicked :) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        //label
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(appViewX, button.frame.origin.y+button.bounds.size.height+5, appViewW, 25);
        
        label.textColor = [UIColor grayColor];
        
        label.font = [UIFont systemFontOfSize:14.0];
        
        label.textAlignment = NSTextAlignmentCenter;
        [label setTag:i];
        [self.view addSubview:label];
        
        MenuPageItem *item = self.menuItemArr[i];
        
        [button setImage:item.icon forState:UIControlStateNormal];
        [label setText:item.title];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //UIView animate动画:仿钉钉弹出添加按钮,从顶部弹到指定位置
            [UIView animateWithDuration:1.f delay:(0.2+0.02*i) usingSpringWithDamping:1.0f initialSpringVelocity:15.0f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                button.frame = CGRectMake(appViewX, appViewY, appViewW, appViewH);
                [label setFrame:CGRectMake(appViewX,button.frame.origin.y+button.bounds.size.height+5, appViewW, 25)];
                
                
            } completion:^(BOOL finished) {
                
            }];
   
        });
     }
 }


#pragma mark  - Event

-(void)didTapOnBackground{
    
    //点击空白处 dissmiss
    [self customAnimation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        if (_delegate &&[_delegate respondsToSelector:@selector(MenuPageDidTapOnBackgroud:)]) {
            [_delegate MenuPageDidTapOnBackgroud:self];
        }
        
    });
    
    
}

-(void)itemBtnClicked:(UIButton *)sender{
    
    //点击按钮缩放代码
    [UIView animateWithDuration:0.25 animations:^{
        sender.transform = CGAffineTransformMakeScale(1.7, 1.7);
        
    }];
    
    //button dismiss动画 Spring Animation
    
    [self customAnimation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        if (_delegate && [_delegate respondsToSelector:@selector(MenuPage:didTapOnItem:)]) {
            [_delegate MenuPage:self didTapOnItem:self.menuItemArr[sender.tag]];
        }
    });

}

#pragma mark - UIView animation
//Spring Animation
-(void)customAnimation{
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               //UIView animate动画
                [UIView animateWithDuration:1.f delay:0.02*(btn.tag) usingSpringWithDamping:0.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                    btn.frame = CGRectMake(btn.frame.origin.x, 800, btn.frame.size.width, btn.frame.size.height);
                    
                } completion:^(BOOL finished) {
                    
                }];
 
            });
            
        }
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *lable = (UILabel *)view;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              //UIView animate动画
                [UIView animateWithDuration:1.f delay:0.02*(lable.tag) usingSpringWithDamping:0.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                    [lable setTextColor:[UIColor clearColor]];
                } completion:^(BOOL finished) {
                    
                }];

            });
        }
        
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *dismissImg = (UIImageView *)view;
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //UIView animate动画
                CABasicAnimation *anmition = [CABasicAnimation animationWithKeyPath:@"transform"];
                
                anmition.duration = 0.3;
                CATransform3D transform3D = CATransform3DMakeRotation(-M_PI_4, 0, 0,1);
                anmition.toValue = [NSValue valueWithCATransform3D:transform3D];
                anmition.cumulative = YES;
                anmition.removedOnCompletion = YES;
                anmition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                anmition.repeatCount = NO;
                anmition.autoreverses = NO;
                anmition.fillMode = kCAFillModeForwards;
                [dismissImg.layer addAnimation:anmition forKey:@"transform"];
                
            });

            
            
        }
        
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
