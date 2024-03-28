---
title: 使用Modrinth Maven[Minecraft模组开发]
date: 2024-03-28 22:19:29
tags: [Minecraft,Java,模组]
---
## 前言
在开发模组的过程中有时候会使用其它模组作为依赖项，但并非所有模组都提供了Maven仓库，因此可以使用Modrinth的Maven仓库来获取模组依赖。

## 添加Maven源
在`gradle.build`中找到`repositories`节点，添加如下内容：
```groovy
repositories {
    maven {
        name = "Modrinth"
        url = "https://api.modrinth.com/maven"
    }
}
```
## 添加模组
在`dependencies`节点中添加类似如下内容：
```groovy
dependencies {
    modImplementation "maven.modrinth:模组名称:版本号"
}
```
## 获取模组名称和版本号
这里以`Fabric API`为例，打开需要使用的版本页面，并复制链接，链接大致如下：

`https://modrinth.com/mod/fabric-api/version/0.96.11+1.20.4` 其中`fabric-api`即为模组名称，`0.96.11+1.20.4`即为模组版本号。
