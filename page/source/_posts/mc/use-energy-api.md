---
title: 使用Energy API让物品可以充能[Minecraft模组开发]
date: 2024-07-01 01:42:44
tags: [Minecraft,Fabric,TechReborn,Energy]
---
yoyo~ 已经是深夜啦，为啥我还要写文章，我自己也不知道为什么呢，诶嘿٩（｡・ω・｡）و

不过话说回来，感觉自己有点懒懒的，刚做完模组其实就想写了，不过现在才写●﹏●

算了，不说那么多啦，正片开始 Ciallo～(∠・ω< )⌒☆

## 添加依赖
**我先声明一下，这篇教程我是根据Fabric的yarn映射编写的，不过与mojmap大致差不多**

既然要用这个API，那么第一步肯定是先添加依赖啦

把下面的代码添加到你的`build.gradle`的`dependencies`块就可以啦
```groovy```
include modApi('teamreborn:energy:3.0.0') {
    exclude(group: "net.fabricmc.fabric-api")
}
```
给大家解释一下这串代码

`include`呢就表示把这个API包含在模组的`META-INF/jars`里，作用其实就和在模组里套模组差不多的啦

其余的大家应该都懂，这里就不多说啦，让我们来看看接下来的一些东西

## 添加物品
怎么添加物品我相信大家应该都会的，这里我就不多说了，不会的话可以去看看[Fabric Wiki:添加物品](https://fabricmc.net/wiki/zh_cn:tutorial:items)

接下来就来为它实现能源接口，首先让你的物品类实现`SimpleEnergyItem`这个接口，然后它会要求我们重写以下三个方法
```java```
/**
物品的能源最大存储量，应该能理解吧
这里的话我给它设置的是10000E　（单位你随便，为了方便我以后都叫它E）
**/
public long getEnergyCapacity(ItemStack stack) {
    return 10000;
}
/**
最大充电速度
这里它最大可以输入1000E/t
**/
public long getEnergyMaxInput(ItemStack stack) {
    return 1000;
}
/**
最大反向充电速度（也就是向外输出能源的速度）
和最大充电速度一样
**/
public long getEnergyMaxOutput(ItemStack stack) {
    return 1000;
}
```
对了，这里还是提醒一下大家，不要用`10^5`的形式来代替`100000`，我最开始就是因为不知道导致debug了半天（╥﹏╥）

这样的话呢，物品就可以存储能源啦，但是它不会直接显示，如何显示能量可以继续往下看
## 显示能量
很多模组显示能量的方式都是通过物品提示和耐久度来显示的，不过我只做过第一个，所以呢暂时就不说第二个啦

首先，你要在物品类中重写这个方法
```java```
@Override
public void appendTooltip(ItemStack stack, @Nullable World world, List<Text> tooltip, TooltipContext context) {
// 获取电量
long amount = this.getStoredEnergy(stack);
// 获取最大电量
long max = this.getEnergyCapacity(stack) / 1000;
// 将电量转换为 k 为单位（因为我的物品能存的比较多嘛，所以以k为单位更好显示，不过我这里写的很简略，你可以做的更复杂）
amount = amount / 1000;
//　添加tooltip（原谅我在这里使用javascript语法，${}代表变量）
tooltip.add(Text.of(`${amount} / ${max} E`));
}
```
像这样做之后，你的物品提示（你也可以叫它物品描述）就会显示当前电量啦
## 使用能量
既然有能量了，那肯定要让它有用武之地（电池除外），比如说可以在执行某个操作时消耗能量，这里我就假设每一个tick都消耗2E的能量，可以看看下面的代码
```java```
@Override
public void inventoryTick(ItemStack stack, World world, Entity entity, int slot, boolean selected) {
    super.inventoryTick(stack, world, entity, slot, selected);
    // 检查是否有足够的能量
    if(this.getStoredEnergy(stack) > 2){    
	// 消耗2E能量
	this.setStoredEnergy(this.getStoredEnergy(stack) - 2);
    }
}
```
上面这串代码就会在每tick都消耗2E的能量，当然你也可以在其它地方消耗能量，但是我上面提供的代码是简化版本，你可能需要做的更为复杂，其实这个if语句是可以不要的，你可以使用`this.tryUseEnergy`（应该是这个方法吧，我忘记方法名了（☍﹏⁰。）），它会返回boolean，如果为true代表成功消耗了能量，这时候就可以去执行一些要做的事啦~
## 最后我想说的
这篇文章其实有些地方不够详细，大家可以自己探索下（毕竟我了解的就这么多嘛（＝ｍ＝））

最后祝大家代码不出Bugヽ（＝＾･ω･＾＝）丿

睡觉去啦
