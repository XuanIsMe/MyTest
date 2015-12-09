//
//  ViewController.m
//  GCDDemo
//
//  Created by lzxuan on 15/10/21.
//  Copyright (c) 2015年 lzxuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate >

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createMainQueue];
    //[self createUserQueue];
    //[self createGlobalQueue];
}
#pragma mark - GCD主线程队列
- (void)createMainQueue {
    
    
    //先获取主线程队列 (内部是串行执行任务)
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    /*
     dispatch_sync -->相对于 当前线程 同步增加 任务， 必须要 block任务执行完毕dispatch_sync函数调用才会返回
     
     主线程中 不能 使用dispatch_sync 同步增加 否则导致 死锁
     
     原因1.dispatch_sync 增加 block任务给 主线程 ，主线程需要等待 block 任务执行完dispatch_sync函数才会返回
        2. dispatch_sync把任务同步增加给主线程，必须等着主线程 执行完当前任务，才能增加进去block任务
     
     dispatch_async  异步增加 任务--》一旦增加block 任务，dispatch_async函数就会立即返回 ，(不用等待block任务)
     */
    
    //向 主线程队列 增加一个任务
    NSLog(@"1");
    dispatch_async(mainQueue, ^{
        //block 代码块就是一个任务
        NSLog(@"isMain:%d 任务1是%@在执行",[NSThread isMainThread],[NSThread isMainThread]?@"主线程":@"子线程");
//        for (NSInteger i = 0; i < 10; i++) {
//            [NSThread sleepForTimeInterval:0.2];
//            NSLog(@"i:%ld",i);
//        }
    });
    
    dispatch_async(mainQueue, ^{
        //block 代码块就是一个任务
        NSLog(@"isMain:%d 任务2是%@在执行",[NSThread isMainThread],[NSThread isMainThread]?@"主线程":@"子线程");
        for (NSInteger i = 0; i < 10; i++) {
            [NSThread sleepForTimeInterval:0.2];
            NSLog(@"i:%ld",i);
        }
    });

    NSLog(@"createMainQueue");
}
#pragma mark - 用户队列
- (void)createUserQueue {
    //用户队列 需要自己创建
    //串行(用的较多) 和 并行
   // DISPATCH_QUEUE_SERIAL 串行 ->用户队列中的任务 串行执行
   // DISPATCH_QUEUE_CONCURRENT 并行-》用户队列中的任务 并发执行
    //第一个参数 是一个倒装的字符串
    dispatch_queue_t userQueue = dispatch_queue_create("com.1514.www", DISPATCH_QUEUE_SERIAL);
    //异步增加任务 到用户队列
    dispatch_async(userQueue, ^{
        NSLog(@"isMain:%d 用户队列任务1是%@在执行",[NSThread isMainThread],[NSThread isMainThread]?@"主线程":@"子线程");
        for (NSInteger i = 0; i < 10; i++) {
            [NSThread sleepForTimeInterval:0.2];
            NSLog(@"i:%ld",i);
        }
    });
    
    dispatch_async(userQueue, ^{
        NSLog(@"isMain:%d 用户队列任务2是%@在执行",[NSThread isMainThread],[NSThread isMainThread]?@"主线程":@"子线程");
        for (NSInteger i = 0; i < 10; i++) {
            [NSThread sleepForTimeInterval:0.2];
            NSLog(@"i:%ld",i);
        }
    });
    
    dispatch_async(userQueue, ^{
        NSLog(@"isMain:%d 用户队列任务3是%@在执行",[NSThread isMainThread],[NSThread isMainThread]?@"主线程":@"子线程");
        for (NSInteger i = 0; i < 10; i++) {
            [NSThread sleepForTimeInterval:0.2];
            NSLog(@"i:%ld",i);
        }
    });
}

#pragma mark - 全局
- (void) createGlobalQueue {
    //全局队列 只需要 获取 系统自带的
    //全局队列 内部 任务 是并发执行
    //第一个参数 是一个优先级
    /*
     // DISPATCH_QUEUE_PRIORITY_HIGH
     // DISPATCH_QUEUE_PRIORITY_DEFAULT
     // DISPATCH_QUEUE_PRIORITY_LOW
     */
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //异步增加
    dispatch_async(globalQueue, ^{
        NSLog(@"isMain:%d 全局队列任务1是%@在执行",[NSThread isMainThread],[NSThread isMainThread]?@"主线程":@"子线程");
        for (NSInteger i = 0; i < 10; i++) {
            [NSThread sleepForTimeInterval:0.2];
            NSLog(@"i:%ld",i);
        }

    });
    dispatch_async(globalQueue, ^{
        NSLog(@"isMain:%d 全局队列任务2是%@在执行",[NSThread isMainThread],[NSThread isMainThread]?@"主线程":@"子线程");
        for (NSInteger i = 0; i < 10; i++) {
            [NSThread sleepForTimeInterval:0.2];
            NSLog(@"i:%ld",i);
        }
        
    });
    dispatch_async(globalQueue, ^{
        NSLog(@"isMain:%d 全局队列任务3是%@在执行",[NSThread isMainThread],[NSThread isMainThread]?@"主线程":@"子线程");
        for (NSInteger i = 0; i < 10; i++) {
            [NSThread sleepForTimeInterval:0.2];
            NSLog(@"i:%ld",i);
        }
        
    });
    NSLog(@"%s",__func__);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end





