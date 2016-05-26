//
//  ViewController.m
//  联级菜单-一个控制器
//
//  Created by wgw on 16/5/24.
//  Copyright © 2016年 wgw. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"

#define SCREEN_WIDTH   CGRectGetWidth([UIScreen  mainScreen].bounds)
#define SCRENN_HEIGHT  CGRectGetHeight([UIScreen mainScreen].bounds)


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * leftTableView ;
@property(nonatomic,strong)UITableView * rightTableView ;



//所有的类别数据
@property(nonatomic,strong)NSArray * categories ;




@end

@implementation ViewController


-(NSArray *)categories {
    if (_categories == nil) {
        NSArray * dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle ] pathForResource:@"categories" ofType:@"plist"]] ;
        NSMutableArray * categoryArray = [NSMutableArray array] ;
        for (NSDictionary * dict in dictArray) {
            [categoryArray addObject:[Model modelWithDict:dict]] ;
            
        }
        _categories = categoryArray ;
        
    }
    return _categories ;
}








- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTableViews] ;
    
    
    self.leftTableView.delegate = self ;
    self.leftTableView.dataSource = self ;
    self.rightTableView.delegate = self ;
    self.rightTableView.dataSource = self ;




    // 默认选中左边表格的第0行
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];


}

-(void)creatTableViews {
    self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.5, SCRENN_HEIGHT) style:UITableViewStylePlain] ;
     self.rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5, 0, SCREEN_WIDTH * 0.5, SCRENN_HEIGHT) style:UITableViewStylePlain] ;
    self.rightTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0) ;
    [self.view addSubview:self.leftTableView] ;
    [self.view addSubview:self.rightTableView] ;

    
}



#pragma mark === UITableViewDataSource,UITableViewDelegate ===

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 左边表格
    if (tableView == self.leftTableView){
        return self.categories.count;
    }else {
        // 右边表格
        Model * m = self.categories[self.leftTableView.indexPathForSelectedRow.row];
        return m.subcategories.count;
    }
  
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        static NSString * ID = @"leftTableView" ;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID] ;
            Model * m = self.categories[indexPath.row];
            // 设置普通图片
            cell.imageView.image = [UIImage imageNamed:m.icon];
            // 设置高亮图片
            cell.imageView.highlightedImage = [UIImage imageNamed:m.highlighted_icon];
            // 设置label高亮时的文字颜色
            cell.textLabel.highlightedTextColor = [UIColor redColor];
            cell.textLabel.text = m.name;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;

    }else {
        // 右边表格
        static NSString *reuseID = @"rightTableView";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID] ;
        }
            // 获得左边表格被选中的模型
        Model * m = self.categories[self.leftTableView.indexPathForSelectedRow.row];
            
        cell.textLabel.text = m.subcategories[indexPath.row];
        return cell;

    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        [self.rightTableView reloadData] ;
    }
    
}



















@end
