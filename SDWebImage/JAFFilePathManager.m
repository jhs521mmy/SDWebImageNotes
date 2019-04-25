//
//  JAFFilePathManager.m
//  SDWebImage
//
//  Created by 阿飞 on 2019/3/6.
//  Copyright © 2019年 阿飞. All rights reserved.
//

#import "JAFFilePathManager.h"

@implementation JAFFilePathManager
+(nonnull instancetype)sharedPathManager{
    static dispatch_once_t once;
    static JAFFilePathManager *filePathManager;
    dispatch_once(&once, ^{
        
        filePathManager = [[JAFFilePathManager alloc]init];
        
    });
    return filePathManager;
}
+(instancetype)sharedPathManagerOne{
    
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

/**
  1.获取沙盒里Document文件夹的路径；
  2.找Document文件夹的路径的元素；
  3.设置路径
 */
- (NSString *)filePathRouteType:(RouteType)routeType fileName:(NSString *)fileName{
    NSArray *pathArray = [[NSArray alloc]init];
    NSString *path;
    switch (routeType) {
        case RouteDocumentType:
        {
            pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            path = [pathArray objectAtIndex:0];
        }
            break;
        case RouteLibraryType:
        {
            pathArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            path = [pathArray objectAtIndex:0];
        }
            break;
        case RouteCacheType:
        {
            pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            path = [pathArray objectAtIndex:0];
        }
            break;
        case RouteTempType:
        {
            path = NSTemporaryDirectory();
        }
            break;
        case RouteApplicationType:
        {
            path = NSHomeDirectory();
        }
            break;
        default:
            break;
    }
    NSString *plistFilePath = [path stringByAppendingPathComponent:fileName];
    
    return plistFilePath;
    
}
- (BOOL)filePath:(id)dataType routeType:(RouteType)routeType fileName:(NSString *)fileName{
   
    NSString *plistFilePath = [self filePathRouteType:routeType fileName:fileName];
    
    BOOL isSuccess = [dataType writeToFile:plistFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (isSuccess) {
        return YES;
    }else{
        return NO;
    }
}
- (void)readData:(DataNSType)dataNSType routeType:(RouteType)routeType fileName:(NSString *)fileName{
    NSString *plistFilePath = [self filePathRouteType:routeType fileName:fileName];
    switch (dataNSType) {
        case DataNSStringType:
        {
            NSString *str = [[NSString alloc]initWithContentsOfFile:plistFilePath encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"%@",str);
        }
            break;
        case DataNSArrayType:
        {
            NSArray *array = [[NSArray alloc]initWithContentsOfFile:plistFilePath];
            for (NSString *value in array) {
                NSLog(@"%@",value);
            }
        }
            break;
        case DataNSDictionaryType:
        {
            NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:plistFilePath];
            for (NSString *value in [dic allValues]) {
                NSLog(@"%@",value);
            }
        }
            break;
        case DataNSDataType:
        {
            NSData *data = [[NSData alloc]initWithContentsOfFile:plistFilePath];
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
        }
            break;
        default:
            break;
    }
}
- (BOOL)creatDirectoryWithPath:(NSString *)dirPath{
    BOOL ret = YES;
    BOOL isExist = [[NSFileManager defaultManager]fileExistsAtPath:dirPath];
    if (!isExist) {
        NSError *error;
        BOOL isSuccess = [[NSFileManager defaultManager]createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!isSuccess) {
            ret = NO;
            NSLog(@"creat Directory Failed. errorInfo:%@",error);
        }
    }
    return ret;
}
- (BOOL)fileIsPathExistOfPath:(NSString *)filePath{
    BOOL flag = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        flag = NO;
    }else{
        flag = YES;
    }
    return YES;
    
}
- (BOOL)removeFilePathOfPath:(NSString *)filePath{
    
    BOOL flag = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        if (![fileManager removeItemAtPath:filePath error:nil]) {
            flag = NO;
        }
    }
    return flag;
}
- (BOOL)removeFileOfURL:(NSURL *)fileUrl{
    
    BOOL flag = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:fileUrl.path]) {
        if (![fileManager removeItemAtURL:fileUrl error:nil]) {
            flag = NO;
        }
    }
    return flag;
}

- (BOOL)creatFileWithPath:(NSString *)filePath
{
    BOOL isSuccess = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL temp = [fileManager fileExistsAtPath:filePath];
    if (temp) {
        return YES;
    }
    NSError *error;
    //stringByDeletingLastPathComponent:删除最后一个路径节点
    NSString *dirPath = [filePath stringByDeletingLastPathComponent];
    isSuccess = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        NSLog(@"creat File Failed. errorInfo:%@",error);
    }
    if (!isSuccess) {
        return isSuccess;
    }
    isSuccess = [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    return isSuccess;
}

- (BOOL)saveFile:(NSString *)filePath data:(NSData *)data{
    
    BOOL ret = YES;
    ret = [self creatFileWithPath:filePath];
    if (ret) {
        ret = [data writeToFile:filePath atomically:YES];
        if (!ret) {
            NSLog(@"哈哈哈");
        }
    }else{
        
        NSLog(@"嘿嘿");
        
    }
    return ret;
    
}
//追加写文件
- (BOOL)appendData:(NSData *)data withPath:(NSString *)path
{
    BOOL result = [self creatFileWithPath:path];
    if (result) {
        NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:path];
        [handle seekToEndOfFile];
        [handle writeData:data];
        [handle synchronizeFile];
        [handle closeFile];
        return YES;
    } else {
        NSLog(@"%s Failed",__FUNCTION__);
        return NO;
    }
}
//获取文件
- (NSData *)getFileData:(NSString *)filePath
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    NSData *fileData = [handle readDataToEndOfFile];
    [handle closeFile];
    return fileData;
}

//读取文件
- (NSData *)getFileData:(NSString *)filePath startIndex:(long long)startIndex length:(NSInteger)length
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    [handle seekToFileOffset:startIndex];
    NSData *data = [handle readDataOfLength:length];
    [handle closeFile];
    return data;
}

//移动文件
- (BOOL)moveFileFromPath:(NSString *)fromPath toPath:(NSString *)toPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:fromPath]) {
        NSLog(@"Error: fromPath Not Exist");
        return NO;
    }
    if (![fileManager fileExistsAtPath:toPath]) {
        NSLog(@"Error: toPath Not Exist");
        return NO;
    }
    NSString *headerComponent = [toPath stringByDeletingLastPathComponent];
    if ([self creatFileWithPath:headerComponent]) {
        return [fileManager moveItemAtPath:fromPath toPath:toPath error:nil];
    } else {
        return NO;
    }
}

//拷贝文件
- (BOOL)copyFileFromPath:(NSString *)fromPath toPath:(NSString *)toPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:fromPath]) {
        NSLog(@"Error: fromPath Not Exist");
        return NO;
    }
    if (![fileManager fileExistsAtPath:toPath]) {
        NSLog(@"Error: toPath Not Exist");
        return NO;
    }
    NSString *headerComponent = [toPath stringByDeletingLastPathComponent];
    if ([self creatFileWithPath:headerComponent]) {
        return [fileManager copyItemAtPath:fromPath toPath:toPath error:nil];
    } else {
        return NO;
    }
}

//获取文件夹下文件列表
- (NSArray *)getFileListInFolderWithPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:path error:&error];
    if (error) {
        NSLog(@"getFileListInFolderWithPathFailed, errorInfo:%@",error);
    }
    return fileList;
}

//获取文件大小
- (long long)getFileSizeWithPath:(NSString *)path
{
    unsigned long long fileLength = 0;
    NSNumber *fileSize;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
    if ((fileSize = [fileAttributes objectForKey:NSFileSize])) {
        fileLength = [fileSize unsignedLongLongValue];
    }
    return fileLength;
    
    //    NSFileManager* manager =[NSFileManager defaultManager];
    //    if ([manager fileExistsAtPath:path]){
    //        return [[manager attributesOfItemAtPath:path error:nil] fileSize];
    //    }
    //    return 0;
}

//获取文件创建时间
- (NSString *)getFileCreatDateWithPath:(NSString *)path
{
    NSString *date = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
    date = [fileAttributes objectForKey:NSFileCreationDate];
    return date;
}

//获取文件所有者
- (NSString *)getFileOwnerWithPath:(NSString *)path
{
    NSString *fileOwner = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
    fileOwner = [fileAttributes objectForKey:NSFileOwnerAccountName];
    return fileOwner;
}

//获取文件更改日期
- (NSString *)getFileChangeDateWithPath:(NSString *)path
{
    NSString *date = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
    date = [fileAttributes objectForKey:NSFileModificationDate];
    return date;
}
@end
