//
//  NSDictionary+Core.m
//  Collections
//
//  Created by Tony Xiao on 7/5/12.
//  Copyright (c) 2012 Collections Labs, Inc. All rights reserved.
//

#import "NSDictionary+Core.h"

@implementation NSDictionary (Core)

- (instancetype)dictionaryByRemovingNulls {
    return [self reject:^BOOL(id key, id obj) {
        return obj == [NSNull null];
    }];
}

- (id)dictionaryByMergingFrom:(NSDictionary *)other {
    if (!other.count)
        return self;
    NSMutableDictionary *newDict = [self mutableCopy];
    [newDict addEntriesFromDictionary:other];
    return newDict;
}

+ (instancetype)dictionaryWithArrayOfPairs:(NSArray *)pairs {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    for (NSArray *pair in pairs)
        dictionary[pair[0]] = pair[1];
    return dictionary;
}

+ (instancetype)dictionaryWithDictionaries:(NSArray *)dictionaries {
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] init];
    for (NSDictionary *dict in dictionaries)
        [mutableDict addEntriesFromDictionary:dict];
    return mutableDict;
}

@end


@implementation NSMutableDictionary (Concise)

- (id)popObjectForKey:(id)key {
    id val = [self objectForKey:key];
    if (val)
        [self removeObjectForKey:key];
    return val;
}

@end