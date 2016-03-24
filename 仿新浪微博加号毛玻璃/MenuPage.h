//
//  MenuPage.h
//  仿新浪微博加号毛玻璃
//
//  Created by ZhangXu on 16/3/24.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuPage,MenuPageItem;
@protocol MenuPageDelegate <NSObject>

//点击背景dismiss回去
-(void)MenuPageDidTapOnBackgroud:(MenuPage *)menu;

//点击item
-(void)MenuPage:(MenuPage*)menu didTapOnItem:(MenuPageItem *)item;


@end

@interface MenuPageItem : NSObject

@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic ,strong)UIImage *icon;//图标


@end

@interface MenuPage : UIViewController
@property(nonatomic,weak)id<MenuPageDelegate>delegate;
@property(nonatomic,copy)NSArray *menuItemArr;

-(instancetype)initWithMenus:(NSArray *)menus;

@end
