//
//  ZDSerialOperation.m
//  ZDToolKit
//
//  Created by Zero.D.Saber on 2019/5/11.
//

#import "ZDSerialOperation.h"

typedef NS_ENUM(NSInteger, ZDOperationState) {
    ZDOperationState_Ready,
    ZDOperationState_Executing,
    ZDOperationState_Finished,
};

@interface ZDSerialOperation ()
@property (nonatomic, assign) ZDOperationState state;

@property (nonatomic, copy) ZDOperationBlock block;
@end

@implementation ZDSerialOperation

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

+ (instancetype)operationWithBlock:(ZDOperationBlock)block {
    ZDSerialOperation *op = [[ZDSerialOperation alloc] init];
    op->_block = [block copy];
    return op;
}

#pragma mark - Override OP Method

- (void)main {
    self.state = ZDOperationState_Ready;
}

- (void)start {
    if (self.isCancelled) return;
    if (!self.block) return;
    
    __weak typeof(self) weakSelf = self;
    ZDOnComplteBlock onCompleteBlock = ^(BOOL isTaskFinished){
        __strong typeof(weakSelf) self = weakSelf;
        if (!isTaskFinished) return;
        self.state = ZDOperationState_Finished;
    };
    self.block(onCompleteBlock);
    self.state = ZDOperationState_Executing;
}

- (void)cancel {
    if (self.isCancelled || self.isFinished) {
        return;
    }
    
    [super cancel];
    self.block = nil;
    self.state = ZDOperationState_Finished;
}

#pragma mark - Override State

- (BOOL)isReady {
    return self.state == ZDOperationState_Ready && [super isReady];
}

- (BOOL)isExecuting {
    return self.state == ZDOperationState_Executing;
}

- (BOOL)isFinished {
    return self.state == ZDOperationState_Finished;
}

- (BOOL)isAsynchronous {
    return NO;
}

- (BOOL)isConcurrent {
    return NO;
}

#pragma mark - Private

static NSString *StateKey(ZDOperationState state) {
    NSString *key = nil;
    switch (state) {
        case ZDOperationState_Ready: {
            key = NSStringFromSelector(@selector(isReady));
        } break;
        case ZDOperationState_Executing: {
            key = NSStringFromSelector(@selector(isExecuting));
        } break;
        case ZDOperationState_Finished: {
            key = NSStringFromSelector(@selector(isFinished));
        } break;
        default: {
            key = NSStringFromSelector(@selector(state));
        } break;
    }
    return key;
}

#pragma mark - Setter

- (void)setState:(ZDOperationState)state {
    if (_state == state) return;
    
    NSString *newKey = StateKey(state);
    NSString *oldKey = StateKey(_state);
    
    [self willChangeValueForKey:newKey];
    [self willChangeValueForKey:oldKey];
    _state = state;
    [self didChangeValueForKey:newKey];
    [self didChangeValueForKey:oldKey];
}

@end
