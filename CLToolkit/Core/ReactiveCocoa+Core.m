//
//  RACSignal+Core.m
//  Collections
//
//  Created by Tony Xiao on 2/8/13.
//  Copyright (c) 2013 Collections Labs, Inc. All rights reserved.
//

#import <ReactiveCocoa/RACKVOTrampoline.h>
#import "ReactiveCocoa+Core.h"

@implementation RACSignal (Core)

- (instancetype)mapWithError:(id(^)(id value))block {
	NSParameterAssert(block != NULL);
    return [self flattenMap:^RACStream *(id value) {
        id ret = block(value);
        if ([ret isKindOfClass:[NSError class]]) {
            return [RACSignal error:ret];
        } else {
            return [RACSignal return:ret];
        }
    }];
}

- (RACSignal *)deliverOnMain {
    return [self deliverOn:[RACScheduler mainThreadScheduler]];
}

- (RACSignal *)catchLoop {
	return [[self bind:^{
		__block id lastValue = nil;
		__block BOOL initial = YES;
        
		return ^(id x, BOOL *stop) {
			if (!initial && (lastValue == x || [x isEqual:lastValue])) return [RACSignal empty];
            
			initial = NO;
			lastValue = x;
			return [RACSignal return:x];
		};
	}] setNameWithFormat:@"[%@] -distinctUntilChanged", self.name];
}

- (RACDisposable *)subscribeNext:(void (^)(id))nextBlock completed:(void (^)(void))completedBlock error:(void (^)(NSError *))errorBlock {
    return [self subscribeNext:nextBlock error:errorBlock completed:completedBlock];
}

- (RACDisposable *)subscribeCompleted:(void (^)(void))completedBlock error:(void (^)(NSError *error))errorBlock {
    return [self subscribeError:errorBlock completed:completedBlock];
}

+ (RACSignal *)delay:(NSTimeInterval)seconds {
    return [[[RACSignal interval:seconds] take:1] deliverOn:[RACScheduler mainThreadScheduler]];
}

@end

@implementation RACSubject (Core)

- (void)sendNextAndComplete:(id)value {
    [self sendNext:value];
    [self sendCompleted];
}

+ (instancetype)subjectWithName:(NSString *)name {
    RACSubject *subject = [self subject];
    subject.name = name;
    return subject;
}

+ (instancetype)subjectWithSelector:(SEL)selector {
    return [[self subject] setNameWithFormat:@"-%@", NSStringFromSelector(selector)];
}

+ (instancetype)subjectWithClassSelector:(SEL)selector {
    return [[self subject] setNameWithFormat:@"+%@", NSStringFromSelector(selector)];
}

@end

@implementation NSObject (CLRACExtensions)

- (RACSignal *)rac_signalForKeyPath:(NSString *)keyPath {
    return [[self rac_changeSignalForKeyPath:keyPath options:0] map:^id(id x) {
        return [self valueForKey:keyPath];
    }];
}

- (RACSignal *)rac_signalWithInitialValueForKeyPath:(NSString *)keyPath {
    return [[self rac_changeSignalForKeyPath:keyPath options:NSKeyValueObservingOptionInitial] map:^id(id x) {
        return [self valueForKey:keyPath];
    }];
}

- (RACSignal *)rac_changeSignalForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options {
    return [RACSignal defer:^RACSignal *{
        @unsafeify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            return [[RACKVOTrampoline alloc] initWithTarget:self observer:nil keyPath:keyPath options:options block:^(id target, id observer, NSDictionary *change) {
                [subscriber sendNext:change];
            }];
        }];
    }];
}

@end
