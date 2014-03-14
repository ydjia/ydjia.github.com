---
layout: post
title: "mysql_Innodb的undo_log和redo_log"
description: ""
category: technique
tags: [mysql, original, innodb]
---
众所周知，mysql支持多种存储引擎，现在常用的是MyISAM和InnoDB。MyISAM相对简单，但不支持事务，而InnoDB是事务安全型的。而InnoDB的事务处理离不开undo_log和redo_Log。
##mysql innodb存储引擎
下面简单的介绍一下innodb的存储引擎
###内存缓冲池
![buffer pool](/assets/images/mysql_undo_redo/bufferpool.png)
如果mysql不用内存缓冲池，每次读写数据时，都需要访问磁盘，必定会大大增加I/O请求，导致效率低下。所以Innodb引擎在读写数据时，把相应的数据和索引载入到内存中的缓冲池(buffer pool)中，一定程度的提高了数据读写的速度。

buffer pool：占最大块内存，用来存放各种数据的缓存包括有索引页、数据页、undo页、插入缓冲、自适应哈希索引、innodb存储的锁信息、数据字典信息等。工作方式总是将数据库文件按页(每页16k)读取到缓冲池，然后按最近最少使用(lru)的算法来保留在缓冲池中的缓存数据。如果数据库文件需要修改，总是首先修改在缓存池中的页(发生修改后即为脏页dirty page)，然后再按照一定的频率将缓冲池的脏页刷新到文件。
###表空间
表空间可看做是InnoDB存储引擎逻辑结构的最高层。 表空间文件：InnoDB默认的表空间文件为ibdata1。

- 段：表空间由各个段组成，常见的段有数据段、索引段、回滚段（undo log段）等。 

- 区：由64个连续的页组成，每个页大小为16kb，即每个区大小为1MB。 

- 页：每页16kb，且不能更改。常见的页类型有：数据页、Undo页、系统页、事务数据页、插入缓冲位图页、插入缓冲空闲列表页、未压缩的二进制大对象页、压缩的二进制大对象页。
##redo log 和undo log
为了满足事务的持久性，防止buffer pool数据丢失，innodb引入了redo log。为了满足事务的原子性，innodb引入了undo log。

####redo log
redo log就是保存执行的SQL语句到一个指定的Log文件，当mysql执行数据恢复时，重新执行redo log记录的SQL操作即可。引入buffer pool会导致更新的数据不会实时持久化到磁盘，当系统崩溃时，虽然buffer pool中的数据丢失，数据没有持久化，但是系统可以根据Redo Log的内容，将所有数据恢复到最新的状态。redo log在磁盘上作为一个独立的文件存在。默认情况下会有两个文件，名称分别为 ib_logfile0和ib_logfile1。

参数innodb_log_file_size指定了redo log的大小；innodb_log_file_in_group指定了redo log的数量，默认为2; innodb_log_group_home_dir指定了redo log所在路径。

	innodb_additional_mem_pool_size = 100M
	innodb_buffer_pool_size = 128M
	innodb_data_home_dir = /home/mysql/local/mysql/var
	innodb_data_file_path = ibdata1:1G：autoextend
	innodb_file_io_threads = 4
	innodb_thread_concurrency = 16
	innodb_flush_log_at_trx_commit = 1
	
	innodb_log_buffer_size = 8M
	innodb_log_file_size = 128M
	innodb_log_file_in_group = 2
	innodb_log_group_home_dir = /home/mysql/local/mysql/var

####undo log
为了满足事务的原子性，在操作任何数据之前，首先将数据备份到Undo Log，然后进行数据的修改。如果出现了错误或者用户执行了ROLLBACK语句，系统可以利用Undo Log中的备份将数据恢复到事务开始之前的状态。与redo log不同的是，磁盘上不存在单独的undo log文件，它存放在数据库内部的一个特殊段(segment)中，这称为undo段(undo segment)，undo段位于共享表空间内。

Innodb为每行记录都实现了三个隐藏字段：

- 6字节的事务ID（DB_TRX_ID）
- 7字节的回滚指针（DB_ROLL_PTR）
- 隐藏的ID</li></ul>

####redo log的记录内容
undo log和 redo log本身是分开的。innodb的undo log是记录在数据文件(ibd)中的，而且innodb将undo log的内容看作是数据，因此对undo log本身的操作(如向undo log中插入一条undo记录等)，都会记录redo log。undo log可以不必立即持久化到磁盘上。即便丢失了，也可以通过redo log将其恢复。
因此当插入一条记录时：

1. 向undo log中插入一条undo log记录。
1. 向redo log中插入一条”插入undo log记录“的redo log记录。
1. 插入数据。
1. 向redo log中插入一条”insert”的redo log记录。

####redo log的io性能
为了保证Redo Log能够有比较好的IO性能，InnoDB 的 Redo Log的设计有以下几个特点：

1. 尽量保持Redo Log存储在一段连续的空间上。因此在系统第一次启动时就会将日志文件的空间完全分配。以顺序追加的方式记录Redo Log。
2. 批量写入日志。日志并不是直接写入文件，而是先写入redo log buffer,然后每秒钟将buffer中数据一并写入磁盘
3. 并发的事务共享Redo Log的存储空间，它们的Redo Log按语句的执行顺序，依次交替的记录在一起，以减少日志占用的空间。
4. Redo Log上只进行顺序追加的操作，当一个事务需要回滚时，它的Redo Log记录也不会从Redo Log中删除掉

####redo & undo log的作用

<ul><li> **数据持久化**

buffer pool中维护一个按脏页修改先后顺序排列的链表，叫flush_list。根据flush_list中页的顺序刷数据到持久存储。按页面最早一次被修改的顺序排列。
正常情况下，dirty page什么时候flush到磁盘上呢？

1. 当redo空间占满时，将会将部分dirty page flush到disk上，然后释放部分redo log。
2. 当需要在Buffer pool分配一个page，但是已经满了，这时候必须 flush dirty pages to disk。一般地，可以通过启动参数 innodb_max_dirty_pages_pct控制这种情况，当buffer pool中的dirty page到达这个比例的时候，把dirty page flush到disk中。
3. 检测到系统空闲的时候，会flush。</li>

<li> **数据恢复**

随着时间的积累，Redo Log会变的很大。如果每次都从第一条记录开始恢复，恢复的过程就会很慢，从而无法被容忍。为了减少恢复的时间，就引入了Checkpoint机制。
假设在某个时间点，所有的脏页都被刷新到了磁盘上。这个时间点之前的所有Redo Log就不需要重做了。系统记录下这个时间点时redo log的结尾位置作为checkpoint。在进行恢复时，从这个checkpoint的位置开始即可。Checkpoint点之前的日志也就不再需要了，可以被删除掉。</li>

<li>**事务回滚**

![rollback1](/assets/images/mysql_undo_redo/rollback1.png)
F1～F6是某行列的名字，1～6是其对应的数据。后面三个隐含字段分别对应该行的事务号和回滚指针。假如这条数据是刚INSERT的，可以认为ID为1，其他两个字段为空。

举例说明数据行更新以及回滚的过程：

**事务1：更改某行数据的值**

当事务1更改该行的值时，会进行如下操作：

1. 用排他锁锁定该行
2. 把该行修改前的值Copy到undo log，即下图中下面的行
3. 修改当前行的值，填写事务编号，使回滚指针指向undo log中的修改前的行
4. 记录redo log

**事务2：再次更改该行数据的值**
![rollback2](/assets/images/mysql_undo_redo/rollback2.png)

与事务1相同，此时undo log中有两行记录，并且通过回滚指针连在一起。
因此，如果undo log一直不删除，则会通过当前记录的回滚指针回溯到该行创建时的初始内容。在Innodb中存在purge线程，它会查询那些比现在最老的活动事务还早的undo log，并删除它们，从而保证undo log文件不至于无限增长。

**回滚过程**

根据当前回滚指针从undo log中找出事务修改前的版本，并恢复。如果事务影响的行非常多，回滚则可能会变的效率不高。当事务行数在1000～10000之 间，Innodb效率还是非常高的。

Innodb也会将事务回滚时的操作也记录到redo log中。回滚操作本质上也是对数据进行修改，因此回滚时对数据的操作也会记录到Redo Log中。

一个回滚过程的redo log 看起来是这样的：

- 记录1: <trx1, Undo log insert <undo_insert …>>
- 记录2: <trx1, insert A…>
-     记录3: <trx1, Undo log insert <undo_update …>>
-     记录4: <trx1, update B…>
-     记录5: <trx1, Undo log insert <undo_delete …>>
-     记录6: <trx1, delete C…>
-     记录7: <trx1, insert C>
-     记录8: <trx1, update B to old value>
-     记录9: <trx1, delete A>

</li>

ydjia原创，转载请注明出处
