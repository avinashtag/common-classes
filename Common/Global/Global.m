//
//  Global.m
//  SVB
//
//  Created by Samvit Infotech.
//  Copyright 2009 Samvit Infotech. All rights reserved.
//

#import "Global.h"


@implementation Global

+ (NSString*) GetDateString:(NSDate*)date
{
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM/dd/yyyy"];
	NSString* strDate = [dateFormatter stringFromDate:date];
	return strDate;
}

+ (NSString*) GetChartAPIUrl:(NSDictionary*)chartData
{
	NSString* strChartType = @"cht=lc";
	NSString* strChartSize = @"chs=400x150";
	NSString* strChartColor = @"chco=00FF00,00FF00&chg=20,50";
	NSString* strChartLabels = @"chdl=Current BMI";
	
	NSArray* chartLegends = [chartData objectForKey:@"Legends"];
	NSDictionary* chartValues = [chartData objectForKey:@"Values"];
	
	NSMutableString* chartApiUrl = [[NSMutableString alloc] initWithString:@"http://chart.apis.google.com/chart?"];
	[chartApiUrl appendString:strChartType];
	[chartApiUrl appendFormat:@"&%@", strChartSize];
	[chartApiUrl appendFormat:@"&%@", strChartColor];
	[chartApiUrl appendFormat:@"&%@&chxt=x,y&chxl=0:|", strChartLabels];
	
	for (int i = 0 ; i < [chartLegends count] ; i++) {
		NSString* chartLegend = [chartLegends objectAtIndex:i];
		[chartApiUrl appendFormat:@"%@", chartLegend];
		if(i != [chartLegends count] - 1)
			[chartApiUrl appendString:@"|"];
	}
	
	[chartApiUrl appendFormat:@"%@",@"|1:|0|50|100"];
	[chartApiUrl appendFormat:@"&chd=t:"];
	
	NSArray* allKeys = [chartValues allKeys];

	if([allKeys count] >0)
	{
		NSArray* value = [chartValues objectForKey:[allKeys objectAtIndex:0]];
		for (int i = 0 ; i < [value count] ; i++) {
			NSString* strCurrentBMI = [value objectAtIndex:i];
			[chartApiUrl appendFormat:@"%@", strCurrentBMI];
			if(i != [value count] - 1)
				[chartApiUrl appendString:@","];
		}
	}
	
	
	return chartApiUrl;	
}

@end
