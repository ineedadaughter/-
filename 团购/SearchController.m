//
//  SearchController.m
//  团购
//
//  Created by  on 14-9-18.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "SearchController.h"
#import "City.h"
#import "MetaData.h"
#import "PinYin4Objc.h"


@implementation SearchController
{
    NSMutableArray *searchCities;
}
@synthesize text = _text;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = text;
    //清除前面的搜索结果
    [searchCities removeAllObjects];
    
    HanyuPinyinOutputFormat *hanyu = [[HanyuPinyinOutputFormat alloc]init];
    hanyu.vCharType = VCharTypeWithUUnicode;
    hanyu.caseType = CaseTypeLowercase;
    hanyu.toneType = ToneTypeWithoutTone;
    
    //遍历筛选
    NSDictionary *dic = [MetaData sharedMetaData].totalCities;
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString *key, City *obj, BOOL *stop) {
        
        //#号为汉字之见的分隔符号
        NSString *pinyin = [PinyinHelper toHanyuPinyinStringWithNSString:obj.name withHanyuPinyinOutputFormat:hanyu withNSString:@"#"];
        
        //将#作为分割，分出拼音的集合
        NSArray *words = [pinyin componentsSeparatedByString:@"#"];
        NSMutableString *firstWords = [NSMutableString string];
        
        //去掉#号
        pinyin = [pinyin stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        for (NSString *first in words) {
            //firstWords为首字母的集合
            [firstWords appendString:[first substringToIndex:1]];
        }
        
        //首字母也可以搜索
        if (([key rangeOfString:text].length != 0) || 
            ([pinyin rangeOfString:text.lowercaseString].length != 0) || 
            ([firstWords rangeOfString:text.lowercaseString].length != 0)) 
        {
            [searchCities addObject:obj];
        }
    }];
    //刷新表格
    [self.tableView reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    searchCities = [NSMutableArray array];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return searchCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    City *city = [searchCities objectAtIndex:indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = [NSString stringWithFormat:@"共%d条搜索所结果",searchCities.count];
    return title;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    City *city = [searchCities objectAtIndex:indexPath.row];
    [MetaData sharedMetaData].currentCity = city;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"cityChange" object:nil];
}

@end
