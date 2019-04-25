//
//  JAFFilePathManager.h
//  SDWebImage
//
//  Created by 阿飞 on 2019/3/6.
//  Copyright © 2019年 阿飞. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,RouteType){
    RouteDocumentType,
    RouteLibraryType,
    RouteCacheType,
    RouteTempType,
    RouteApplicationType
};
typedef NS_ENUM(NSInteger,DataNSType) {
    DataNSStringType,
    DataNSArrayType,
    DataNSDictionaryType,
    DataNSDataType
};
@interface JAFFilePathManager : NSObject

+ (nonnull instancetype)sharedPathManager;

/**
 获取你要保存的路径

 @param routeType 枚举
 @param fileName  某某.plist 例如 1.plist文件(字典.plist)；2.txt文件(iOS.txt);3.文件夹(iOS)等
 @return 返回路径
 */
- (NSString *)filePathRouteType:(RouteType)routeType fileName:(NSString *)fileName;
/**
 保存数据 -----  writeToFile
 @param dataType 数据类型
 @param routeType 保存类型
 @param fileName .plist
 @return 写入是否成功
 */
- (BOOL)filePath:(id)dataType routeType:(RouteType)routeType fileName:(NSString *)fileName;


/**
 读数据

 @param dataNSType 类型
 @param routeType 枚举
 @param fileName 某某.plist
 */
- (void)readData:(DataNSType)dataNSType routeType:(RouteType)routeType fileName:(NSString *)fileName;

/**
 创建文件夹或者文件
 
 @param dirPath 路径
 @return 是否创建成功
 */
- (BOOL)creatDirectoryWithPath:(NSString *)dirPath;

/**
 判断文件是否存在于某个路径

 @param filePath 路径
 @return 是否存在
 */
- (BOOL)fileIsPathExistOfPath:(NSString *)filePath;


/**
 从某个路径中移除文件

 @param filePath 路径
 @return 哈哈哈
 */
- (BOOL)removeFilePathOfPath:(NSString *)filePath;

/**
 从URL路径中移除文件

 @param fileUrl url
 @return 哈哈
 */
- (BOOL)removeFileOfURL:(NSURL *)fileUrl;

/**
 创建文件
 @param filePath filePath
 @return 哈哈
 */
- (BOOL)creatFileWithPath:(NSString *)filePath;

/**
 保存文件

 @param filePath 路径
 @param data data
 @return 哈哈
 */
- (BOOL)saveFile:(NSString *)filePath data:(NSData *)data;



/**
 追加写文件

 @param data <#data description#>
 @param path <#path description#>
 @return <#return value description#>
 */
- (BOOL)appendData:(NSData *)data withPath:(NSString *)path;



/**
 获取文件

 @param filePath <#filePath description#>
 @return <#return value description#>
 */
- (NSData *)getFileData:(NSString *)filePath;

/**
 读取文件

 @param filePath <#filePath description#>
 @param startIndex <#startIndex description#>
 @param length <#length description#>
 @return <#return value description#>
 */
- (NSData *)getFileData:(NSString *)filePath startIndex:(long long)startIndex length:(NSInteger)length;

/**
 移动文件

 @param fromPath <#fromPath description#>
 @param toPath <#toPath description#>
 @return <#return value description#>
 */
- (BOOL)moveFileFromPath:(NSString *)fromPath toPath:(NSString *)toPath;
/**
 拷贝文件

 @param fromPath <#fromPath description#>
 @param toPath <#toPath description#>
 @return <#return value description#>
 */
- (BOOL)copyFileFromPath:(NSString *)fromPath toPath:(NSString *)toPath;

/**
 获取文件夹下文件列表

 @param path <#path description#>
 @return <#return value description#>
 */
- (NSArray *)getFileListInFolderWithPath:(NSString *)path;

/**
 获取文件大小

 @param path <#path description#>
 @return <#return value description#>
 */
- (long long)getFileSizeWithPath:(NSString *)path;

/**
 获取文件创建时间

 @param path <#path description#>
 @return <#return value description#>
 */
- (NSString *)getFileCreatDateWithPath:(NSString *)path;


/**
 获取文件所有者

 @param path <#path description#>
 @return <#return value description#>
 */
- (NSString *)getFileOwnerWithPath:(NSString *)path;

/**
 获取文件更改日期

 @param path <#path description#>
 @return <#return value description#>
 */
- (NSString *)getFileChangeDateWithPath:(NSString *)path;
@end
