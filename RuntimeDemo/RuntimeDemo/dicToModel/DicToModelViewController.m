//
//  DicToModelViewController.m
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/4/3.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import "DicToModelViewController.h"
#import "DicToModelUserInfo.h"
@interface DicToModelViewController ()

@end

@implementation DicToModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
     测试模型和字典转换
     */
    NSDictionary *dic =@{@"user":@"muxh",@"age":@3};
    
    DicToModelUserInfo *userInfo = [[DicToModelUserInfo alloc]initWithDic:dic];
    
    NSLog(@"dictoModel:user=%@,age=%@",userInfo.user,userInfo.age);
    
    DicToModelUserInfo *userInfo2 = [DicToModelUserInfo new];
    userInfo2.user = @"newName";
    userInfo2.age = @34;
    
    NSDictionary *dic2 =[userInfo2 convertModelToDic];
    NSLog(@"ModeltoDic:%@",dic2);
    
/**
 测试普通归档
 */

NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
NSString *filePath = [documentPath stringByAppendingPathComponent:@"cache001"];
    //普通归档
    [NSKeyedArchiver archiveRootObject:userInfo2 toFile:filePath];
    
    //读取归档
    DicToModelUserInfo *model = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"dictoModel:user=%@,age=%@",model.user,model.age);
  
/*
 测试安全归档
 遵循<NSSecureCoding>
 实现支持安全方法
 + (BOOL)supportsSecureCoding{
 return YES;
 }
 **/
    
NSString *filePath2 = [documentPath stringByAppendingPathComponent:@"cache002"];
NSError *error;
  NSData * data =  [NSKeyedArchiver archivedDataWithRootObject:userInfo2 requiringSecureCoding:YES error:&error];
    if (error) {
        NSLog(@"archivedData:%@",error);
    }

  BOOL isWrite =  [data writeToFile:filePath2 atomically:YES];
    if (isWrite) {
        NSLog(@"writeSuccsee");
    }
    
    NSData *readData = [NSData dataWithContentsOfFile:filePath2];
    DicToModelUserInfo *model2 =[NSKeyedUnarchiver unarchivedObjectOfClass:[DicToModelUserInfo class] fromData:readData error:&error];
    if (error) {
        NSLog(@"unarchivedObjectOfClass:%@",error);
    }else{
        NSLog(@"dictoModel:user=%@,age=%@",model2.user,model2.age);
    }
    
}



@end
