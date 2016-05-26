//
//  Model.h
//  联级菜单
//
//  Created by wgw on 16/5/23.
//  Copyright © 2016年 wgw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

//子类别
@property(nonatomic,strong)NSArray * subcategories ;
//name
@property(nonatomic,copy)NSString * name ;
//icon
@property(nonatomic,copy)NSString * icon ;
//highlighted_icon
@property(nonatomic,copy)NSString * highlighted_icon ;


+(instancetype)modelWithDict :(NSDictionary *)dict ;





@end
