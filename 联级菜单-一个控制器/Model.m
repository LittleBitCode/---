//
//  Model.m
//  联级菜单
//
//  Created by wgw on 16/5/23.
//  Copyright © 2016年 wgw. All rights reserved.
//

#import "Model.h"

@implementation Model



+(instancetype)modelWithDict :(NSDictionary *)dict {
    
    Model * m = [[self alloc]init] ;
    
    
    
    [m setValuesForKeysWithDictionary:dict] ;
    
    
    return m ;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}






@end
