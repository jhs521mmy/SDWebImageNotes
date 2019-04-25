//
//  JAFSDWebImageManager.m
//  SDWebImage
//
//  Created by 阿飞 on 2019/3/11.
//  Copyright © 2019年 阿飞. All rights reserved.
//

#import "JAFSDWebImageManager.h"

@implementation JAFSDWebImageManager


+ (nullable instancetype)shareSDWebImageManager{
    static dispatch_once_t once;
    static JAFSDWebImageManager *sdWebImageManager;
    dispatch_once(&once, ^{
        sdWebImageManager = [[JAFSDWebImageManager alloc]init];
    });
    
    return sdWebImageManager;
    
}
-(void)clearCacheMemory{
    
    //获取缓存图片的大小(字节)
    NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
    //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
    float MBCache = bytesCache/1000/1000;
    NSLog(@"%f",MBCache);
    //异步清除图片缓存 （磁盘中的）
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[SDImageCache sharedImageCache] clearMemory];
        
    });
}

-(void)clearCacheDisk{
    
    //获取缓存图片的大小(字节)
    NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
    //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
    float MBCache = bytesCache/1000/1000;
    NSLog(@"%f",MBCache);
    //异步清除图片缓存 （磁盘中的）
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            
        }];
        
    });
}

@end
