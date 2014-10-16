//
//  UIImageView+WebCach.m
//  团购
//
//  Created by  on 14-10-13.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "WebCach.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"//这个功能更加强大，是继承于ASIHTTPRequest
#import "ASIDownloadCache.h"

@implementation WebCach 
{
    ASIDownloadCache *cache;
}
/*
 - (void)setImageURL:(NSURL *)url
 {
 ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
 [request setRequestMethod:@"GET"];
 [request setTimeOutSeconds:60];
 
 //post请求
 //user=pwe&password=123
 //向请求体中设置参数
 //    [request addPostValue:<#(id<NSObject>)#> forKey:<#(NSString *)#>]
 
 }
 */
//异步请求的两种方法，一，delegate，二，block

- (void)setImageWithURL:(NSURL *)url
{
    __unsafe_unretained ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request setTimeOutSeconds:60];
    
    //设置代理
    //    request.delegate = self;
    //用block方法
    [request setCompletionBlock:^(){
        NSData *data = request.responseData;
        UIImage *image = [UIImage imageWithData: data];
        self.image = image;
//        if (request.didUseCachedResponse) {
//            NSLog(@"数据来自缓存");
//        }
//        else
//        {
//            NSLog(@"数据来自网络");
//        }
    }];
    
    [request setFailedBlock:^() {
//        NSError *error = request.error;
//        NSLog(@"请求出错:%@",error);
    }];
    
    NSString *cachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents"];
    //   NSLog(@"%@",cachePath);
    cache = [[ASIDownloadCache alloc]init];
    cache.storagePath = cachePath;
    cache.defaultCachePolicy = ASIOnlyLoadIfNotCachedCachePolicy;
    //缓存，永久缓存类型
    request.cacheStoragePolicy = ASICachePermanentlyCacheStoragePolicy;
    request.downloadCache = cache;
    
    [request startAsynchronous];
    
    //    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    //    [appDelegate.queue addOperation:request];
}

#pragma mark - ASIHTTPRequestDelegate
/*
 - (void)requestFinished:(ASIHTTPRequest *)request
 {
 NSData *data = request.responseData;
 UIImage *image = [UIImage imageWithData:data];
 self.image = image;
 }
 - (void)requestFailed:(ASIHTTPRequest *)request
 {
 NSError *error = request.error;
 NSLog(@"请求出错:%@",error);
 }
 */

@end
