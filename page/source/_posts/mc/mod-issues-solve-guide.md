---
title: Minecraft模组问题解决指南
date: 2024-03-11 22:12:13
tags: [Minecraft,模组]
---
## 前言
本篇文章是对Minecraft一些模组问题的解决指南，各位萌新请务必仔细阅读。既然你要选择玩模组，那么你就需要有一定的耐心和解决问题的能力。如果你不愿意花费几分钟阅读该文章或者不愿意按照文章说的来做。那么隔壁[网易版](http://mc.163.com/)欢迎你。

我作为一个模组开发者，经常会被各位萌新问问题，但我不可能做到每个问题都能认真解答，很多时候我没有那么空闲，所以写了这篇文章来帮助大家解决一些常见的问题以及提问的方法。

## 模组下载
通常情况下，模组作者会将模组上传至[CurseForge](https://www.curseforge.com/)、[Modrinth](https://modrinth.com/)、[Github](https://github.com/)等网站，部分模组作者可能会上传至网盘或其它网站，不过这里主要讲解CurseForge、Modrinth和Github的使用方法。

### 如何获取模组的下载地址
通常情况下，直接在搜索引擎搜索模组名称就可以搜索到模组的相关链接。

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

**注意：Github在国内访问体验可能较差**

首先，你需要在模组页面中找到`Releases`选项，如下图所示：
![img](assets/images/mc/mod-issues-solve-guide/github-mod.png)

然后直接下载jar文件即可：
![img](assets/images/mc/mod-issues-solve-guide/github-files.png)

**注意：不要下载`source code`或者直接点击右上角的下载按钮，因为你下载到的不是模组文件而是源代码**

### 启动器内下载
对于被上传到了CurseForge和Modrinth的模组，大部分都可以直接在启动器内直接下载。

下载方式与上面介绍的基本一致，故不再过多赘述。
## 模组安装
### 模组加载器
Minecraft目前有四个主流模组加载器，分别为Fabric，Quilt，Forge，NeoForge，在下载模组的时候一定要选择正确的模组加载器，否则模组将无法正常运行。

不同加载器能运行的模组不同，Quilt兼容大部分Fabric模组，Forge，NeoForge，Fabric/Quilt互不兼容。

**注意：即使部分模组加载器之间的模组可以互相兼容，但这并不意味着完全兼容，在出现问题时请使用正确的加载器**

### 安装方法
在作者没有额外声明的情况下，你只需要将模组放入`游戏目录/mods`文件夹即可。

### 前置模组
部分模组可能需要前置模组，请一并下载安装，通常情况下CurseForge和Modrinth会说明需要的前置模组（如下图）。
![img](assets/images/mc/mod-issues-solve-guide/modrinth-depends.png)

## 整合包安装
整合包安装方法相对来说更为简单，但不同作者使用的格式会有所不同，这里我们主要讲几种常见的格式。
### 整合包格式
模组平台的整合包主要有两种，CurseForge的整合包（后缀为`.zip`）和Modrinth的整合包（后缀为`.mrpack`），它们通常可以直接在模组平台下载。除此之外，比较常见的还有MMC和MCBBS整合包（后缀均为`.zip`），通常可以在各大论坛或网站见到。

部分作者可能不使用以上格式，安装方式请留意作者提供的安装方法。
### 安装方法
对于常见的整合包格式，大部分启动器都能直接支持。以下以HMCL启动器为例，其它启动器过程大致相同。

首先，打开版本列表：
![img](assets/images/mc/mod-issues-solve-guide/hmcl-main.png)

然后，点击安装整合包：
![img](assets/images/mc/mod-issues-solve-guide/hmcl-versions.png)

接下来将整合包拖到安装界面即可。
## 错误排查
通常情况下，很多问题是你自己导致的，与模组无关。

即使这些问题可能不是由于你导致的，但是你也应该尝试去解决该问题，这可以减少作者的工作量。

**不要觉得排查错误会消耗你大量的时间，作者的时间比你更宝贵**

### 启动报错
如果你在启动时遇到了类似下图的页面，只需按照指示去解决问题，看不懂英文可以使用翻译软件（如下图是缺少前置模组geckolib）：

**在手机启动器启动时不会出现这个页面，但是会导致卡在加载界面，你需要自己去寻找错误原因**

![img](assets/images/mc/mod-issues-solve-guide/mod-need-depend.png)

### 错误解决
这里是一些简单的问题解决方法，可以帮助你解决一些常见问题。

| 错误 | 解决方法 |
| :--- | :--- |
| 模组未被加载 | 请使用正确的模组加载器 |
| Minecraft版本不支持 | 请使用正确的Minecraft版本 |
| 缺少前置模组 | 请安装前置模组 |
| 模组需要前置模组的更高或更低版本 | 请升级或降低前置模组的版本 |
| 安装了不兼容的模组 | 请卸载不兼容的模组 |
| 没发现模组菜单 | 如果是Fabric，请检查是否安装了[模组菜单](https://www.mcmod.cn/class/1675.html)，否则请检查是否安装了加载器 |
| 因为Sodium导致的崩溃 | 如果是手机启动器，请切换渲染器。如果是电脑启动器，请检查显卡驱动。否则请卸载Sodium |

#### 善用AI
利用AI可以帮助你快速解决问题，你可以直接将日志文件上传给AI，AI或许能给出一些有用的答复。

推荐使用[deepseek](https://chat.deepseek.com/)和[ChatGPT](https://chatgpt.com/)。
### 小贴士
如果你安装了Optifine模组导致出现问题，建议你先删除Optifine。

如果你使用的是Fabric/Quilt，建议在使用之前检查是否已经安装或是否为最新版本的Fabric API/QSL。

## 报告问题
在提问之前，我推荐你先看看[《提问的智慧》](https://github.com/tvvocold/How-To-Ask-Questions-The-Smart-Way)，它会详细告诉你该如何提问，这里我只做一个简单的解释。

### 报道问题之前应该做的
在报道问题之前，你需要先去做一些准备工作，最大可能地减少模组作者的工作量，以下是需要做的事情：
- 确定该问题没有被报道过
- 确定你已经看完模组的介绍，FAQ，文档&视频教程（如果有的话）
- 确定你已经尝试过去解决该问题
- 确定这个问题值得被报道
#### 不要分享启动器的崩溃页面
**不要分享启动器的崩溃页面！
不要分享启动器的崩溃页面！
不要分享启动器的崩溃页面！**

重要的事情说三遍，不要分享这个页面。请不要通过任何手段包括但不限于截图，拍屏等将这个页面发送给他人，这个页面对于诊断错误来说几乎没有帮助（只要不瞎的话，应该都能看见这个页面上提示的“请勿将该页面分享给他人”）。
### 确定是否应该报告问题
通常情况下，你可以在Github上的`issues`页面报告和寻找问题，那么早报告问题之前，你需要先确定这个问题是否应该被报道，以下问题不应该被报道：
- 你使用了错误的模组加载器。
- 你使用了错误的Minecraft版本。
- 你使用了已经不受支持的模组版本。
- 你没有正确配置模组。
- 你安装了不兼容的模组。

### 如何报道问题
最好的办法是在Github上创建一个issue，然后在issue中描述问题。当然，你也可以在其它地方报道问题，不过Github是最有效的渠道之一。

**注意：不推荐向作者私信或发送邮件，你的问题最好公开地解决，这样可以让更多的人参与讨论，同时可以帮助更多的人解决问题。**

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

#### 提供日志
日志在诊断错误的过程中极其重要，如果需要提供日志，你可以采取以下方式：
- 直接发送文件
- 发送**完整**的日志内容（如果是群聊，请不要这样干）
- 将日志上传到日志网站，例如[mclo.gs](https://mclo.gs)
#### 不要问没必要的问题
很多问题并没有任何意义，根本没必要去问。能自己通过简单的尝试得到答案的问题，就没必要去问别人。
#### 正确示例
标题：模组在Fabric无法启用聊天修改

JDK版本：Openjdk17 ；系统：Windows 11 ；Minecraft版本1.20.4 ；模组版本：0.3.3 ；加载器：Fabric

已安装的模组：geckolib 4.2.2，toneko 0.3.3，Fabric API 0.96.4，ctlib 0.1.0

问题描述：在`游戏目录/ctlib/toneko/config.yml`将`chat.enable`设置为true后导致游戏崩溃，重新设置为fasle即可解决。

崩溃日志：[日志链接]()

#### 错误示例
- 为什么模组会崩溃啊
- 模组在哪里下载啊
- 怎么安装模组啊
- 为什么模组安装上没用啊
- 为什么会卡在加载页面啊
- 这是怎么回事（启动器截图）
- PCL可以玩吗 

### 如何提供日志文件
日志文件对于排查错误来说非常重要，即使你不会看日志，但是模组的开发者需要通过它来排查问题。
> “在没有错误日志的情况下诊断任何问题无异于闭眼开车”  
  ---apache httpd 用户入门文档

你可以在`游戏目录/logs/latest.log`中找到最近一次的日志文件，这是你需要提供的文件。

**注意：如果最近一次启动不是与该问题相关的，请不要提供这个文件，你需要在logs文件夹中找到与该问题相关的日志文件。**

## 如何为模组提供建议
如果你对模组有好的建议，你可以通过Github的`issues`页面来提交。

### 提供建议之前应该做的
- 确定你的建议是合理的，不要重复建议。
- 确定你的建议可以被玩家和作者所接受。
- 确定你的建议不会导致模组使用困难或不稳定/兼容性下降等问题。

## 结尾
感谢你阅读了本教程，如果你有什么疑问或者认为我写的不完善的地方，可以在评论为我提供建议，非常感谢。
