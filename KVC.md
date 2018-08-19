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

