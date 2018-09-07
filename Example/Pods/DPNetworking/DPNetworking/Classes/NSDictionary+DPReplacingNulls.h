//
//  NSDictionary+Additions.h
//  PAJKCardApp
//
//  Created by wangweishun@pajk.cn on 5/22/14.
//  Copyright (c) 2014 Ping An Health Insurance Company of China, Ltd. All rights reserved.
//

//http://stackoverflow.com/questions/8075147/replace-all-nsnull-objects-in-an-nsdictionary
#import <Foundation/Foundation.h>

@interface NSDictionary (DPReplacingNulls)

- (id)jsonObjectForKey:(id)aKey;
- (NSDictionary *)dictionaryByReplacingNullsWithBlanks;

- (NSArray*)arrayForKey:(id)key;
@end


@interface NSArray (DPReplacingNulls)

- (NSArray *)arrayByReplacingNullsWithBlanks;

@end
