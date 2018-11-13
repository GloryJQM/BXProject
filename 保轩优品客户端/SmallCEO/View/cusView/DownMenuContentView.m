//
//  DownMenuContentView.m
//  chufake
//
//  Created by pan on 13-11-20.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import "DownMenuContentView.h"

@implementation DownMenuContentView

- (void)dealloc
{
    _contentData = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _currentCityIndex = -1;
        _currentProvinceIndex = -1;
        _currentSingleIndex = -1;
    }
    return self;
}

- (void)cleanup
{
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    singleTableView = nil;
    provincesTableView = nil;
    cityTableView = nil;
}

- (void)loadContent:(id)cotent type:(DownMenuContentType)type
{
    [self cleanup];
    _contentData = [cotent copy];
    _contentType = type;
    
    if (type == DownMenuContentType_Single) {
        singleTableView = [[UITableView alloc] initWithFrame:self.bounds];
        singleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        singleTableView.delegate = self;
        singleTableView.dataSource = self;
        [self addSubview:singleTableView];
    }
    if (type == DownMenuContentType_Provinces) {
        provincesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height)];
        provincesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        provincesTableView.delegate = self;
        provincesTableView.dataSource = self;
        [self addSubview:provincesTableView];
        
        cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height)];
        cityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cityTableView.delegate = self;
        cityTableView.dataSource = self;
        [self addSubview:cityTableView];
    }
}

- (void)resetPosition
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (tableView == singleTableView) {
        cell.textLabel.text = [_contentData objectAtIndex:indexPath.row];
    }
    if (tableView == provincesTableView) {
        id currentProvinceValue = [[_contentData objectAtIndex:indexPath.row] objectForKey:@"province"];
        cell.textLabel.text = currentProvinceValue;
    }
    if (tableView == cityTableView) {
        if (_currentProvinceIndex >= 0 && _currentProvinceIndex < [_contentData count]) {
            cell.textLabel.text = [[[_contentData objectAtIndex:_currentProvinceIndex] objectForKey:@"city"] objectAtIndex:indexPath.row];
        }
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_contentData != nil) {
        if (tableView == singleTableView) {
            return [_contentData count];
        }
        if (tableView == provincesTableView) {
            return [_contentData count];
        }
        if (tableView == cityTableView) {
            if (_currentProvinceIndex >= 0 && _currentProvinceIndex < [_contentData count]) {
                return [[[_contentData objectAtIndex:_currentProvinceIndex] objectForKey:@"city"] count];
            }
            return 0;

        }
    }

    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == provincesTableView && _currentSingleIndex != indexPath.row) {
        UITableViewCell *provinceCell = [provincesTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentProvinceIndex inSection:0]];
        [provinceCell setSelected:NO animated:NO];
        _currentProvinceIndex = indexPath.row;
        [cityTableView reloadData];
        return;
    }
    if (tableView == cityTableView && _currentCityIndex != indexPath.row) {
        UITableViewCell *cityCell = [cityTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentCityIndex inSection:0]];
        [cityCell setSelected:NO animated:NO];
        _currentCityIndex = indexPath.row;
    }
    if (tableView == singleTableView) {
        UITableViewCell *cell = [singleTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentSingleIndex inSection:0]];
        [cell setSelected:NO animated:NO];
        _currentSingleIndex = indexPath.row;
    }
    
    
    NSString *recallStr = [self currentTitle];
    NSInteger c_id = [self currentID];
    
    if ([self.delegate respondsToSelector:@selector(downMenuContentViewDidSelected:withID:downMenuContentView:)]) {
        [self.delegate downMenuContentViewDidSelected:recallStr withID:c_id downMenuContentView:self];
    }
}

- (NSInteger)currentID
{
   NSInteger recallStr = 0;
    if (_contentType == DownMenuContentType_Single) {

    }
    if (_contentType == DownMenuContentType_Provinces) {
        if (_currentProvinceIndex >= 0) {
            recallStr = [[[[_contentData objectAtIndex:_currentProvinceIndex] objectForKey:@"ID"]  objectAtIndex:_currentCityIndex] intValue];
        }
    }
    
    return recallStr;
}


- (NSString *)currentTitle
{
    NSString *recallStr = nil;
    if (_contentType == DownMenuContentType_Single) {
        if (_currentSingleIndex >= 0) {
            recallStr = [_contentData objectAtIndex:_currentSingleIndex];
        }
    }
    if (_contentType == DownMenuContentType_Provinces) {
        if (_currentProvinceIndex >= 0) {
            recallStr = [[[_contentData objectAtIndex:_currentProvinceIndex] objectForKey:@"city"]  objectAtIndex:_currentCityIndex];
        }
    }
    
    return recallStr;
}

- (void)setCurrentCity:(NSString *)theCity
{
    if (_contentType == DownMenuContentType_Provinces) {
        for (NSDictionary *province in _contentData) {
            NSArray *citys = [province objectForKey:@"city"];
            for (NSString *city in citys) {
                if ([city isEqualToString:theCity]) {
                    int cityIndex = [citys indexOfObject:city];
                    int provinceIndex = [_contentData indexOfObject:province];
                    [self setCurrentProvinceIndex:provinceIndex cityIndex:cityIndex];
                }
            }
        }
    }

}

- (void)setCurrentProvinceIndex:(int)provinceIndex cityIndex:(int)cityIndex
{
    _currentProvinceIndex = provinceIndex;
    _currentCityIndex = cityIndex;
    [provincesTableView reloadData];
    [cityTableView reloadData];
    
    UITableViewCell *provinceCell = [provincesTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:provinceIndex inSection:0]];
    [provinceCell setSelected:YES animated:NO];
    
    UITableViewCell *cityCell = [cityTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:cityIndex inSection:0]];
    [cityCell setSelected:YES animated:NO];
}

- (void)setCurrentSingleIndex:(int)index
{
    _currentSingleIndex = index;
    [singleTableView reloadData];
    
    UITableViewCell *cell = [singleTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell setSelected:YES animated:NO];
}

@end
