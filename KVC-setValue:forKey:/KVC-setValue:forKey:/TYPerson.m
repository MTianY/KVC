//
//  TYPerson.m
//  KVC-setValue:forKey:
//
//  Created by 马天野 on 2018/8/19.
//  Copyright © 2018年 Maty. All rights reserved.
//

#import "TYPerson.h"

@implementation TYPerson

//- (void)setAge:(int)age {
//
//    NSLog(@"setAge: %d",age);
//
//}

//- (void)_setAge:(int)age {
//    NSLog(@"_setAge: %d",age);
//}


+ (BOOL)accessInstanceVariablesDirectly {

    NSLog(@"允许访问成员变量");
    return YES;
}

@end
