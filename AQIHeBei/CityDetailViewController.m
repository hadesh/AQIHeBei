//
//  CityDetailViewController.m
//  AQIHeBei
//
//  Created by xiaoming han on 14-2-13.
//  Copyright (c) 2014年 xiaoming han. All rights reserved.
//

#import "CityDetailViewController.h"
#import "UIColor+Extension.h"


@interface CityDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *infoArray;

@property (nonatomic, strong) UIColor *levelColor;

@end

@implementation CityDetailViewController
@synthesize city = _city;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    self.title = self.city.name;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self initData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    self.infoArray = @[[NSString stringWithFormat:@"名称: %@", self.city.name],
                       [NSString stringWithFormat:@"AQI: %@", self.city.AQI],
                       [NSString stringWithFormat:@"污染等级: %@", self.city.level],
                       [NSString stringWithFormat:@"主要污染物: %@", self.city.maxPoll],
                       [NSString stringWithFormat:@"空气质量状况: %@", self.city.intro],
                       [NSString stringWithFormat:@"建议及措施: %@", self.city.tips]];
    
    self.levelColor = [UIColor colorWithHexString:self.city.color];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row > 3)
    {
        return 100;
    }
    
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    
    if (section == 0)
    {
        number = self.infoArray.count;
    }
    else if (section == 1)
    {
        number = self.city.pointers.count;
    }
    
    return number;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    
    if (section == 0)
    {
        title = @"详细信息";
    }
    else if (section == 1)
    {
        title = @"监测点信息";
    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mainCellIdentifier = @"mainCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainCellIdentifier];
    }
    
    cell.opaque = NO;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = @"";
    cell.detailTextLabel.text = @"";
    cell.textLabel.numberOfLines = 0;
    
    if (indexPath.section == 0)
    {
        cell.textLabel.text = self.infoArray[indexPath.row];
        cell.backgroundColor = [self.levelColor colorWithAlphaComponent:0.2];
    }
    else if (indexPath.section == 1)
    {
        HHAQIPointer *pointer = self.city.pointers[indexPath.row];
        
        if (pointer)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", pointer.region, pointer.name];
            
            if (pointer.level.length > 1 && pointer.maxPoll.length > 0)
            {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@ - %@", pointer.level, pointer.maxPoll, pointer.AQI];
            }
            else
            {
                cell.detailTextLabel.text = @"暂无数据";
            }
            
            cell.backgroundColor = [[UIColor colorWithHexString:pointer.color] colorWithAlphaComponent:0.5];

        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
