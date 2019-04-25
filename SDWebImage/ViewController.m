//
//  ViewController.m
//  SDWebImage
//
//  Created by 阿飞 on 2019/2/27.
//  Copyright © 2019年 阿飞. All rights reserved.
//

#import "ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDImageCache.h>
#import "JAFFilePathManager.h"
@interface ViewController ()


/**
 注释
 */

@property (nonatomic,strong) UIImageView *nameImageView;

@property (nonatomic,strong) NSArray *prefetchURLs;
@property (nonatomic,assign) int requestedCount;
@property (nonatomic,assign) int finishedCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.nameImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 400, 300)];
    [self.view addSubview:self.nameImageView];
    
   // self.prefetchURLs = @[@"https://imgsrc.baidu.com/forum/pic/item/73c1209759ee3d6d439559664f166d224d4adecc.jpg",@"https://imgsrc.baidu.com/forum/pic/item/73c1209759ee3d6d439559664f166d224d4adecc.jpg", @"https://imgsrc.baidu.com/forum/pic/item/73c1209759ee3d6d439559664f166d224d4adecc.jpg", @"https://imgsrc.baidu.com/forum/pic/item/73c1209759ee3d6d439559664f166d224d4adecc.jpg", @"http://imgsrc.baidu.com/forum/pic/item/73c1209759ee3d6d439559664f166d224d4adecc.jpg", @"https://imgsrc.baidu.com/forum/pic/item/73c1209759ee3d6d439559664f166d224d4adecc.jpg", @"https://imgsrc.baidu.com/forum/pic/item/73c1209759ee3d6d439559664f166d224d4adecc.jpg", @"https://imgsrc.baidu.com/forum/pic/item/73c1209759ee3d6d439559664f166d224d4adecc.jpg", @"https://imgsrc.baidu.com/forum/pic/item/73c1209759ee3d6d439559664f166d224d4adecc.jpg", @"https://imgsrc.baidu.com/forum/pic/item/73c1209759ee3d6d439559664f166d224d4adecc.jpg", @"https://imgsrc.baidu.com/forum/pic/item/73c1209759ee3d6d439559664f166d224d4adecc.jpg"];
    self.prefetchURLs = @[@"https://www.tuchuang001.com/images/2017/05/02/1.png",@"https://www.tuchuang001.com/images/2017/05/02/1.png",@"https://www.tuchuang001.com/images/2017/05/02/1.png",@"https://www.tuchuang001.com/images/2017/05/02/1.png"];
//    for (int i=0; i<self.prefetchURLs.count; i++) {
//
//        [self startPrefetchingAtIndexOne:i];
//
//    }
    [self downLoad];
 
}
-(void)startPrefetchingAtIndexOne:(int)index{
    /// 判断index是否越界
    if (index >= self.prefetchURLs.count) return;
    // 已请求的个数加1
    self.requestedCount++;
    // 使用self.manager下载图片
    [SDWebImageManager.sharedManager loadImageWithURL:self.prefetchURLs[index] options:SDWebImageDownloaderIgnoreCachedResponse|SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        NSLog(@"下载多少%ld----总共：%ld",receivedSize,expectedSize);
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
       
        if (!finished) {   
            return ;
        }
        self.finishedCount++;
        if (image) {
            NSLog(@"下载成功%d",self.finishedCount);
        }else{
        
            NSLog(@"下载失败%d",self.finishedCount);
        }
        
    }];
    
//    [SDWebImageManager.sharedManager loadImageWithURL:self.prefetchURLs[index] options:SDWebImageFromCacheOnly progress:nil completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        /// 只有当finished完成之后，self.finishedCount加1
//        if (!finished) return;
//        self.finishedCount++;
//        if (image) {
//            NSLog(@"下载成功%d",self.finishedCount);
//        }else{
//
//            NSLog(@"下载失败%d",self.finishedCount);
//        }
//        if (image) { // 下载成功后，调用progressBlock
//            if (self.progressBlock) {
//                self.progressBlock(self.finishedCount,(self.prefetchURLs).count);
//            }
//        }
//        else { // 下载失败，也调用progressBlock，同时记录该次的下载失败
//            if (self.progressBlock) {
//                self.progressBlock(self.finishedCount,(self.prefetchURLs).count);
//            }
//            // Add last failed
//            self.skippedCount++;
//        }
        /// 调用delegate
//        if ([self.delegate respondsToSelector:@selector(imagePrefetcher:didPrefetchURL:finishedCount:totalCount:)]) {
//            [self.delegate imagePrefetcher:self
//                            didPrefetchURL:self.prefetchURLs[index]
//                             finishedCount:self.finishedCount
//                                totalCount:self.prefetchURLs.count
//             ];
//        }
        /// 如果URLs的数量大于已经下载的数量，就说明还有没下载完的任务，继续下载下一个
//        if (self.prefetchURLs.count > self.requestedCount) {
//            dispatch_async(self.prefetcherQueue, ^{
//                [self startPrefetchingAtIndex:self.requestedCount];
//            });
//        } else if (self.finishedCount == self.requestedCount) { // 当完成数等于已请求总数的时候，就宣告下载完毕
//            /// 告诉代理，下载已经完毕
//            [self reportStatus];
//            /// 调用completionBlock,这里把completionBlock和progressBlock都设为nil是为了避免循环引用
//            if (self.completionBlock) {
//                self.completionBlock(self.finishedCount, self.skippedCount);
//                self.completionBlock = nil;
//            }
//            self.progressBlock = nil;
//        }
//    }];
}

- (void)reportStatus {
    NSUInteger total = (self.prefetchURLs).count;
//    if ([self.delegate respondsToSelector:@selector(imagePrefetcher:didFinishWithTotalCount:skippedCount:)]) {
//        [self.delegate imagePrefetcher:self
//               didFinishWithTotalCount:(total - self.skippedCount)
//                          skippedCount:self.skippedCount
//         ];
//    }
}


-(void)downLoad{
   
//    [[SDImageCache sharedImageCache]storeImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://www.tuchuang001.com/images/2017/05/02/1.png"]]] imageData:nil forKey:@"haha" toDisk:NO completion:^{
//
//        NSLog(@"完成了啊啊啊啊啊啊 啊啊 ");
//
//    }];
//
//    [[SDImageCache sharedImageCache]imageFromCacheForKey:@"haha"];
//    NSLog(@"%@",[[SDImageCache sharedImageCache]imageFromCacheForKey:@"haha"]);
//    [self clearCache];
    
    [self.nameImageView sd_setImageWithURL:[NSURL URLWithString:@"https://imgsrc.baidu.com/forum/pic/item/73c1209759ee3d6d439559664f166d224d4adecc.jpg"] placeholderImage:[UIImage imageNamed:@"1024"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        CGFloat precent = (CGFloat)receivedSize*100/expectedSize;
        NSLog(@"%f",precent);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

        // 2 打印缓存路劲（沙盒缓存&磁盘缓存）
        NSLog(@"沙盒缓存path;%@", NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES));

        switch (cacheType) {
            case SDImageCacheTypeNone:
                {
                    NSLog(@"No cache ,直接下载");
                }
                break;
            case SDImageCacheTypeMemory:
               {
                    NSLog(@"from memory");
               }
                break;
            case SDImageCacheTypeDisk:
               {
                    NSLog(@"from disk");
               }
                break;
            default:
                break;
        }


    }];
   
}


#pragma mark ---- 计算单个文件大小

+ (float)fileSizeAtPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;

}
#pragma mark ----  计算文件夹大小(要利用上面的1提供的方法)
+ (float)folderSizeAtPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:absolutePath];
        }
        // SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}
#pragma mark ----   清除缓存
+ (void)clearCache:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{

    }];
}

@end
