---
title: Minecraft模组问题解决指南
date: 2024-03-11 22:12:13
tags: [Minecraft,模组]
---
## 前言
本篇文章是对Minecraft一些模组问题的解决指南，各位萌新请务必仔细阅读，如果你不愿意花费几分钟阅读该文章，隔壁[网易版](http://mc.163.com/)欢迎你。

我作为一个模组开发者，经常会被各位萌新问问题，但我不可能做到每个问题都能认真解答，很多时候我没有那么空闲，所以写了这篇文章来帮助大家解决一些常见的问题以及提问的方法。

## 模组下载
通常情况下，模组作者会将模组上传至[CurseForge](https://www.curseforge.com/)、[Modrinth](https://modrinth.com/)、[Github](https://github.com/)等网站，部分模组作者可能会上传至网盘或其它网站，不过这里主要讲解CurseForge、Modrinth和Github的使用方法。

### 如何获取模组的下载地址
如果你是从B站，Youtube等视频网站了解到的模组，那么你通常可以在视频简介或置顶评论中找到下载地址。

如果你是从MCBBS，MCMOD等网站了解到的模组，那么你可以从页面上提供的链接获取到下载地址。

### CurseForge
首先，你需要在模组页面中找到`Files`选项，如下图所示：
![img](assets/images/mc/mod-issues-solve-guide/curseforge-mod.png)

选择你需要的Minecraft版本，模组加载器（这个后面会讲），在下图的版本列表中选择最新版本即可：
![img](assets/images/mc/mod-issues-solve-guide/curseforge-files.png)

在新弹出的页面中，你只需要点击`Download`并等待一会而后即可下载该模组。
### Modrinth
同样的，你需要打开版本列表：
![img](assets/images/mc/mod-issues-solve-guide/modrinth-mod.png)

与CurseForge一样，选择你需要的Minecraft版本，模组加载器，并选择最新版本即可：
![img](assets/images/mc/mod-issues-solve-guide/modrinth-files.png)

在新弹出的页面中，你只需要点击`Download`就可以直接下载该模组。
### Github
Github与CurseForge和Modrinth相比有所不同，因为并非所有的作者都会上传编译好的jar文件，所以下载会稍微麻烦一点

**注意：**Github在国内访问体验可能较差

首先，你需要在模组页面中找到`Releases`选项，如下图所示：
![img](assets/images/mc/mod-issues-solve-guide/github-mod.png)

然后直接下载jar文件即可：
![img](assets/images/mc/mod-issues-solve-guide/github-files.png)

## 模组安装
### 模组加载器
Minecraft目前有四个主流模组加载器，分别为Fabric，Quilt，Forge，NeoForge，在下载模组的时候一定要选择正确的模组加载器，否则模组将无法正常运行。

不同加载器能运行的模组不同，其中，NeoForge兼容大部分Forge模组，Quilt兼容大部分Fabric模组，Forge/NeoForge与Fabric/Quilt互不兼容。

**注意：**即使部分模组加载器之间的模组可以互相兼容，但这并不意味着完全兼容，在出现问题时请使用正确的加载器。

### 安装方法
在作者没有额外声明的情况下，你只需要将模组放入`游戏目录/mods`文件夹即可。

### 前置模组
部分模组可能需要前置模组，请一并下载安装，通常情况下CurseForge和Modrinth会说明需要的前置模组（如下图）。
![img](assets/images/mc/mod-issues-solve-guide/modrinth-depends.png)

### 启动报错
如果你在启动时遇到了类似下图的页面，请按照指示去解决问题（如下图是缺少前置模组geckolib）：
![img](assets/images/mc/mod-issues-solve-guide/mod-need-depend.png)

## 报告问题
### 报道问题之前应该做的
在报道问题之前，你需要先去做一些准备工作，最大可能地减少模组作者的工作量，以下是需要做的事情：
- 确定该问题没有被报道过
- 确定你已经看完模组的介绍，FAQ，文档&视频教程（如果有）
- 确定你已经尝试过去解决该问题
- 确定这个问题值得被报道
### 确定是否应该报告问题
通常情况下，你可以在Github上的`issues`页面报告和寻找问题，那么早报告问题之前，你需要先确定这个问题是否应该被报道，以下问题不应该被报道：
- 你使用了错误的模组加载器。
- 你使用了错误的Minecraft版本。
- 你使用了已经不受支持的模组版本。
- 你没有正确配置模组。
- 你安装了不兼容的模组。

### 如何报道问题
你可以在Github上创建一个issue，并将你遇到的问题描述出来。

### 如何正确提问
首先，你需要一个清晰的标题，能够简单的描述问题，示例：
- 在1.20.1Fabric无法使用聊天
- 在1.20.4Forge无法加载渲染器

有了清晰的标题，还需要一个清晰的描述，描述问题的细节，至少要包含如下内容：
- 你使用的Minecraft版本，模组加载器版本和模组版本。
- 你遇到的问题的具体描述。
- 如何复现
- 日志文件
- 游戏内截图

### 如何提供日志文件
日志文件对于排查错误来说非常重要，即使你不会看日志，但是模组的开发者是需要通过它来排查问题的
> “在没有错误日志的情况下诊断任何问题无异于闭眼开车”    ---apache httpd 用户入门文档

你可以在`游戏目录/logs/latest.log`中找到最近一次的日志文件，这是你需要提供的文件。