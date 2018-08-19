# KVC

## 一. KVC 简单介绍

1.KVC 的全称

- Key-Value Coding
- 可以通过一个 key 来`访问某个属性`

2.常见 API

```objc
- (void)setValue:(id)value forKeyPath:(NSString *)keyPath;
- (void)setValue:(id)value forKey:(NSString *)key;
- (id)valueForKeyPath:(NSString *)keyPath;
- (id)valueForKey:(NSString *)key;
```

## 二. KVC API 简单使用

1.`- (void)setValue:(id)value forKeyPath:(NSString *)keyPath` 和 `- (void)setValue:(id)value forKey:(NSString *)key` 的区别?

- key 就是根据某个对象的属性去找
- keyPath 可以理解为根据某个对象的属性路径去找.可以更精确.

```objc
// TYPerson 类有个属性 age 和 TYStudent 对象;
// TYStudent 类有个属性 no;

TYPerson *person = [[TYPerson alloc] init];
person.student = [[TYStudent alloc] init];

// 1.使用 KVC 的 setValue:forKey: 给 person 的 age 赋值.
// 打印结果为 10;
[person setValue:@10 forKey:@"age"];
NSLog(@"Key: age = %@",[person valueForKey:@"age"]);

// 2.使用 KVC 的 setValue:forKeyPath: 给 person 的 age 赋值.
// 打印结果为 20
[person setValue:@20 forKeyPath:@"age"];
NSLog(@"KeyPath: age = %@",[person valueForKeyPath:@"age"]);

// 3.使用 KVC 的 setValue:forKey 或 setValue:forKeyPath: 给一个 person 没有的属性赋值.
// 报错:Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<TYPerson 0x1005394b0> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key weight.'

// 4.使用 setValue:forKey: 给 person 的 student 对象的属性赋值
// 打印结果:40
person.student = [[TYStudent alloc] init];
[person.student setValue:@40 forKey:@"no"];
NSLog(@"key: no = %@",[person.student valueForKey:@"no"]);

// 5.使用 setValue:forkeyPath: 给 person 的student 对象的属性赋值
// 打印结果 60
[person.student setValue:@60 forKeyPath:@"no"];
NSLog(@"keyPath: no = %@",[person.student valueForKeyPath:@"no"]);

// 6.使用 setValue:forKeyPath: 直接用 person 对象给 student 对象的属性赋值.

```

## 三. `setValue:forKey:`原理

![](https://lh3.googleusercontent.com/XX1hoB2p4L2mCqjy2xuFRtXjevwWhVyggIZAOJcYKFLkpU4QPzSBZCUmRqJJT4jJ-nwI28EVM84WOwzurVthHgWduyGG7uYXnvTBREA6KZ2J7IBnNsiqIm1wqSb6s2za0olgzbRUy2o8TnYxsFjo8UxjHsy7-66jc9nbSTxEIqedTaVMgvEp_-9rg8tV1VQ1oEWBMYmFNeG4bZp9UiLR_t187yr7bus4y5jCSdGqbL-re2QLIx1TC869rFAYZcuDPl8Iq5OvO_gzaJuRBksOEi6NauGFZjEtRMs3IJmRTHcLWWvpNVNpi2mjQJ13yHPxD6kx0bGWWMYYd0k9VTBQ_6lZSY1WKqhGmU5uYMZqdE-hrQe4E9qibNeMW8vr4bbWvNazR3q0-y_2StsigbZtQAo_1H87xS6_NeilzC_bBmZsmKsXuZiDfN9f0FXfgJpYXxSIXhVt_IrjxYvjMCeVGM3ceWlX0_4AV5Axmvy75Tvl_6EqkfNlYu3Uuu0VUDXLDRg708t4gdV3gYNoiy0_YlM5iSklOkm8xHsv1ONCbeWjuYrSRyD8sKKNWykOHHQEGVz_nC6x2bLvNhWgqbw0e-dqOYFCrrlVV0rgHQ=w1024-h768-no)

- 首先查找`setKey:`方法.如果找到: `传递参数,调用 setKey:`方法.
 - 如果`没有找到 setKey:` 方法,那么接着查找`_setKey:`方法.如果找到:`传递参数,调用_ setKey: 方法.`
 - 如果`setKey:`和`_setKey:`方法都没有找到,那么调用`+ (BOOL)accessInstanceVariablesDirectly`方法.该方法的含义是:`是否可以直接访问成员变量`.查看其返回值
     - 如果返回值为`YES`
            - 那么将严格按照顺序查找成员变量: `_key、 _isKey、 key、 isKey`.如果找到其中某个成员变量,那么就`直接赋值`.
            - 如果一个都没有找到,那么调用`setValueForUndefinedKey:`方法,并且抛异常,找不到 key
        - 如果返回 NO 
            - 调用`setValueForUndefinedKey:`并且抛异常,找不到 key 

