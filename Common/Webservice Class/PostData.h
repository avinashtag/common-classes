//
//  PostData.h
//  common classes
//
//  Created by Vertax on 11/04/13.
//  Copyright (c) 2013 Vertax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostData : NSObject


@property(nonatomic, strong) NSMutableData *Body;
@property(nonatomic, strong) NSString *Url;
@property(nonatomic, strong) NSMutableURLRequest *Request;
@end
