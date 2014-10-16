//
//  LocationController.m
//  团购
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "LocationController.h"
#import "CitySection.h"
#import "NSObject+Value.h"
#import "City.h"
#import "MetaData.h"
#import "SearchController.h"

@implementation LocationController
{
    NSMutableArray *_citySections;
    NSArray *cities1;
    NSArray *array;
    UIView *myView;
    UITableView *tableView1;
    UISearchBar *search;
    SearchController *searchController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self addSearch];
    [self addTableView];
    
    [self addCity];

     
}



- (void)addCity
{
    
    _citySections = [NSMutableArray array];
    NSArray *all = [MetaData sharedMetaData].allCitySections;
    
    [_citySections addObjectsFromArray:all];
//    
//    NSString *path = [[NSBundle mainBundle]pathForResource:@"Cities" ofType:@"plist"];
//    cities1 = [NSArray arrayWithContentsOfFile:path];
//    
//    for (NSDictionary *dic in cities1) {
//        CitySection *citySection = [[CitySection alloc]init]; 
//        [citySection setValues:dic];
//        [_citySections addObject:citySection];
//    }
    //NSLog(@"citysection=%@",_citySections);
    
    
    
    
}

- (void)addSearch
{
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    search.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    search.delegate = self;
    search.placeholder = @"请输入城市名或拼音";
    search.barStyle = UIBarStyleBlackOpaque;
    [self.view addSubview:search];
}

- (void)addTableView
{
    tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStylePlain];

    tableView1.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tableView1.dataSource = self;
    tableView1.delegate = self;
    [self.view addSubview:tableView1];
}
#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        //隐藏搜索界面
        [searchController.view removeFromSuperview];
    }
    else
    {
        if (searchController == nil) {
            //创建搜索界面
            searchController = [[SearchController alloc]init];
            searchController.view.frame = myView.frame;
            searchController.view.autoresizingMask = myView.autoresizingMask;
            [self addChildViewController:searchController];
        }
        //searchController拿到搜索框的文字
        searchController.text = searchText;
        [self.view addSubview:searchController.view];
    }
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //显示取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    if (myView == nil) {
        myView = [[UIView alloc]init];
        myView.backgroundColor = [UIColor blackColor];
        myView.autoresizingMask = tableView1.autoresizingMask;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [myView addGestureRecognizer:tap];
        
    }
    myView.frame = tableView1.frame;
    myView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^(){
        myView.alpha = 0.6;
    }];
    [self.view addSubview:myView];
    
}
//点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self tapAction];
}
//结束编辑
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self tapAction];
}

- (void)tapAction
{
    //将画布移出
    [UIView animateWithDuration:0.5 animations:^() {
        myView.alpha = 0;
    } completion:^(BOOL finished) {
            [myView removeFromSuperview];
    }];
  
    //将取消按钮隐藏
    [search setShowsCancelButton:NO animated:YES];
    //将键盘收回
    [search resignFirstResponder];
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _citySections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    array = [[cities objectAtIndex:section] objectForKey:@"cities"];
//    return array.count;
    
    CitySection *c = [_citySections objectAtIndex:section];

    return c.cities.count;
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //valueForKey拿到所有元素name属性的数组
    NSArray *indexs = [_citySections valueForKey:@"name"];
    return indexs;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    NSString *sectionName = [[cities objectAtIndex:section] objectForKey:@"name"];
//    return sectionName;
    CitySection *c = [_citySections objectAtIndex:section];
    return c.name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
       
    }
//    array = [[cities1 objectAtIndex:indexPath.section] objectForKey:@"cities"];
//    NSString *name = [[array objectAtIndex:indexPath.row]objectForKey:@"name"];
//    cell.textLabel.text = name;
    
    CitySection *c = [_citySections objectAtIndex:indexPath.section];
    City *city = [c.cities objectAtIndex:indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CitySection *c = [_citySections objectAtIndex:indexPath.section];
    City *city = [c.cities objectAtIndex:indexPath.row];
    [MetaData sharedMetaData].currentCity = city;
}

@end
