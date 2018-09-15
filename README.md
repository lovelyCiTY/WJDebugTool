# WJLog

### 开发背景

在日常开发中我们经常会遇到下边的一些情况。WJLog 就是为了解决如下情况而开发的一个轻量级的日志记录工具。

1.日常开发中测试同学发现了 bug ，但是 bug 很难复现，偶现光看到现象也很难找到问题的情况.

2.日常开发中我们可能需要记录很多页面的打开时间，方法的执行时间，一些接口从 post 到 response 过程的时间等等

3.日常开发过程中，可能一个项目多组并行开发，但是终端输出的内容很多无法进高效的筛选，只想看到自己组的内容时没有有效的筛选条件。


### 功能介绍

因为将 LOG 定义了 `normal` , `Warn` , `Error` 三个级别 ，并且提供了业务线区分和是否记录本地日志的功能,所以用户可以对 Log 进行自定义。

### 自定义业务线宏

> XXLOG(format...)    WJLogBase(@"businessline",WJLogLevelNormal,NO,format)
> 
>根据参数可以发现   
>第一个参数为业务线名称（方便区分业务线，其实开发中还可以在业务先后拼接业务名称 方便查找）   
>第二个参数输出日志级别   
>第三个参数是否写入数据库   
>第四个参数就是我们的输出内容了

在我的 WJLogConst 中总共设置了 6 个宏 ，可以根据自己的需要自行添加


### 数据库查询

当前已经提供了存储功能和根据业务线查询和根据日志级别查询的功能。之后可能会进一步提供根据时间查询的功能

其实查询相关的东西，和不同项目业务不同产生的相关性很大，所以笔者建议使用的小伙伴可以根据自己的业务自行的添加。

WJLog 的数据库基于 FMDB 基本的操作方式已经完成封装，所有的查询只需要写简单的 sqlite 查询语句，然后调用 WJDBManager 中的方法即可。


### 性能

因为 Log 如果存储到数据库中，如果在次数很大的 for 循环中进行操作，频繁的 IO 操作可能对于主线程造成影响，所以现已将所有 DB 操作放到了 Background 级别的线程做处理，而且保证了线程的安全。所以对于性能可以放心使用。




