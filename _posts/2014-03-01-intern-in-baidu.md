---
layout: post
title: "百度实习总结"
category: essay
tags: [original, summary]
---


转眼间半年过去了，在百度实习了这半年，收获很多。但是仅仅过了半年让我回忆实习初期干了什么，都已经有些想不起来了，让我意识到总结这次实习的重要性了。把这次实习经历总结记录下来，可以为自己，也为看到这篇文章的人提供一些积极的借鉴。

<!--more-->
##实习求职

实习求职，十分推荐的门路是各大高校论坛，我就是在[本校论坛实习兼职版](http://bbs.byr.cn/#!board/ParttimeJob)中找到的百度开发测试实习生内推信息，投得简历，并最终获得实习的offer。

更早些的时候我也上[大街网](www.dajie.com)投过简历，投了几家公司，等了很久都没有消息。事实证明，内推比自己找要靠谱的多，在大街网上基本上所有的简历最终都石沉大海杳无音信，而内推相比而言有如下好处：

1. 相当于绿色通道：不需要经过笔试，直接进入面试。在一天内直接面完两轮技术面，就可以回学校等信了。
2. 效率高：我投简历的一周内收到了面试通知。面试之后第二天offer就发了出来，效率十分高。

由于我受益于内推，所以实习之后我也积极内推，想给有实习想法无门路的同学一些帮助。亲自感受了面试以及内推之后，我发现面试结果其实是在**当天**就可以确定你是pass或者fail。也就是说如果你通过了，第二天boss就可以跟hr说，这个人我要了，发offer吧。而你fail之后，除非你邮件询问帮你内推的人，他再帮你问boss你的面试结果，不然你死等也不会邮件的，亦即默拒。	

##面试经验

由于实习offer来的太快，或者说幸福来的太突然..我整个求职过程，收到过3个面试通知，进行过两次面试。

第一次就是百度测试开发实习生，面试之前准备了3天：

1. 突击了1天算法；
2. 网上有非常翔实的[百度测试开发实习生面试资料](http://wenku.baidu.com/link?url=Xcx9FK_rnhEiw4dO63dTjPL65qdgap3wWvMoJaze7cyaLvQY9DKkuc8Qp2beb3FaeTGC6TVIHMIuIImC2Km6ak4NtK6DHPzGZ9JmPVB2eJu)
，看了1天；
3. 程序设计语言基础知识面试题，看了1天。

面试第一轮面试官就根据我简历上有的东西提一些问题，并进行展开讨论，讨论的过程夹杂着程序设计基础知识。面试官面试的过程中给我说，非常鄙视笔试卷子上那些难死人的算法题，因为大部分码农在实际工作中根本用不到，所以，第一面，根本就没问我算法题，顺利通过。

面试第二轮就不是那么轻松了，上来就是一道算法题，不过难度不大，在纸上写出来给面试官看即可，同时还有分析时间空间复杂度。然后就是各种程序设计基础，最后还面试了测试思维——经典的怎么去测试一个电梯。最后面试官问我，你还有什么问题没有。这可以说是我第一次求职面试，我第一次遇到这个问题，真的不知道怎么说，我很脑残的问了两个问题：1.结果什么时候能给？2.这次面试为啥这么简单...

很感谢，他们没有因为我这脑残的问题拒绝了我。事实是，这两个面试官，在我入职以后都是同事，一个是我的导师，一个是我的boss。

第二次面试表现非常糟糕，投递的是百度个性化推荐部的开发实习。问了我很多大数据处理的问题，我真的没接触过，答得一塌糊涂。算是长经验吧。

##工作收获

在技术能力方面，我的收获是巨大的：

1. 学会了linux和vim。进行这次实习之前，我曾看过*几页*[鸟哥的linux私房菜](http://book.douban.com/subject/4889838/)，也安装过ubantu作为我的第二系统，但是之后从来都是进入windows..但是这次实习让我很快学会了linux。因为天天在用，所以学的很快。vim这个好东西，可以让人彻底脱离鼠标编代码，是非常强大的编辑器。
2. 学习了php和zend framwork。我所在的项目组是百度商桥，项目web部分使用的是php。不过作为一个脚本语言，学习起来相对容易很多，并且调试起来要比c++这种编译型语言方便多了。除此之外，我还采用zend framework开发了一个机器管理平台，为了标明某个机器现在谁在用，以及自动化进行测试环境的部署。
3. 开阔了视野。商桥项目的架构很复杂，但是所用的很多东西都是开源的一些软件，将他们组合在一起就能产生巨大的作用。比如使用的关系型数据库mysql，非关系型数据库mongodb，redis，还有memcached，他们一起构成了底层的数据服务。
4. 此外还实现了hadoop大数据处理的一个实例（其实就是一个wordcount）；学习了基于百度商桥产品的各种测试方式，如回归测试，压力测试；另外还经常就代码与开发人员讨论，曾参与多次code review并给出意见。

其他软实力方面，也是实习相比于在学校做项目所具有的优势：

1. **体验上班族生活**，每天乘坐公交地铁上下班，每天总结自己的测试工作，每周总结自己的所有工作；
2. **锻炼学习能力**，商桥是一个很复杂的系统，在一周或者两周之内就要上手进行测试，对学习能力有着很高的要求；
3. **感受加班**，有的时候测试任务很繁重，若不测试完成不了，之后的上线进度就会受到影响，因此时常需要加班。另外，qa也需要跟进上线流程，而上线不免会对服务产生影响，经常于晚上进行；
4. **接触互联网产品的基本开发流程**。我接触到百度商桥时，它已然是个成熟的产品了，处于迭代开发的阶段，让我对敏捷有了一定的了解。每个项目都是PM依据客户需求或者RD依据技术需求产生的，最后交由我们进行测试。整个项目开发流程大致包括了如下几个阶段：pm需求设计——需求评审——rd详细设计——详设评审——rd进行开发及自测——code review——提交测试——qa测试——验收——上线。


##企业文化

百度的核心价值观是，“简单可依赖”，印在每张工卡后面。其实实习过程中对这个价值观的理解并不深刻，但我感受的很深刻的是，公司的“同学文化”，有一瞬间，让我觉得，这个公司就如同一个学校一样，大家的称呼（主要是在邮件中体现）都是同学，以及同学们。

项目组关系很融洽，没有什么所谓的同事间的勾心斗角什么的，也或许作为实习生还接触不到勾心斗角的层次，不管怎么都觉得在这里工作很舒适。每天和组里的人一起吃饭，不过半个月就可以与组员建立起很好的关系，这对工作效率有很积极的影响。

工作过程中，很多时间并不是自己闷声写代码，而是需要互相交流。pm，rd(fe)和qa，三方之间，需要很多的合作，才能最终将一个项目完成，并成功上线，提供更优质的服务。

不过大公司也有其不太好的地方，不同组之间的合作，有的时候相对困难，需要经常push才行。还有多方联调时，也有死活不愿意担责任的情况。

总而言之，作为实习生的我，还是很欣赏这样的工作环境，当然我这只是管中窥豹，不能知其全貌。

##自身不足

我在去实习之前，曾下决心要将实习期间接触的代码都研读一遍。但是真正实习开始了之后，除了较为易懂的php代码读了较多之外，c++的代码读的很少。自己还是没有足够的坚持和毅力。尤其实习后期，十分松懈...

##总结

总而言之，这次长达6个月的实习，是我本科学习中很重要的一次经历。这次经历，对我的技术能力有较大提高，也让我接触到了企业文化和互联网产品的生产流程。

最后希望读到这篇文章的人也能从中受益。
