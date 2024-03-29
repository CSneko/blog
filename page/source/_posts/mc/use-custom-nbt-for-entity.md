---
title: 实体使用自定义nbt[Minecraft模组开发]
date: 2024-03-09 19:28:47
tags: [Minecraft,NBT,Java,Fabric]
---
## 前言
### 什么是NBT
NBT是Minecraft中的一个非常重要的数据结构，它包含了实体、方块、物品、生物、方块实体、存档、附魔、附魔等实体的属性。

### 为何要使用NBT
NBT在Minecraft可以被玩家和其它模组用来读取和修改，因此兼容性较好，且修改方便

### 本教程的相关方法
这个教程中存在一些不存在的方法，因为这是我是在做[toneko模组](https://github.com/csneko/toneko)时顺便写的

`scale`全局变量是一个`Vec3d`对象，用于设置实体的缩放，`setScale(Vec3d)`和`getScale()`方法是我用于设置实体缩放的方法，传入`Vec3d`，返回`Vec3d`对象，实现如下:
```java
// 不知道这里的代码有什么用的接着往下看就行了
    public void setScale(Vec3d scale){
        this.scale = scale; // 设置缩放比例
        NbtCompound scaleNbt = new NbtCompound();
        scaleNbt.putDouble("x", scale.getX());
        scaleNbt.putDouble("y", scale.getY());
        scaleNbt.putDouble("z", scale.getZ());
        this.dataTracker.set(SCALE_DATA, scaleNbt);
    }
    public void setScale(double x, double y, double z){
        this.setScale(new Vec3d(x,y,z));
    }
    //获取渲染缩放
    public Vec3d getScale() {
        NbtCompound nbt = this.dataTracker.get(SCALE_DATA);
        scale = new Vec3d(nbt.getDouble("x"),nbt.getDouble("y"),nbt.getDouble("z"));
        return scale;
    }
```

## 在实体中使用NBT
### 1.NBT的结构
NBT使用的是JSON格式，如果你对JSON熟悉的话，那么NBT的结构你一定能够看懂，否则的话，你只需要理解JSON的结构就可以了。

### 2.召唤实体时设置NBT
通常情况下，玩家可以使用`/summon modid:entity x y z {nbt}`来召唤实体，其中`{nbt}`为设置的NBT数据，那么为了让nbt生效，就需要在实体类中使用nbt。

因此，需要在实体的构造函数中读取nbt数据，然后将数据设置到实体上。如下代码所示：
```java
public nekoEntity(EntityType<? extends AnimalEntity> entityType, World world) {
    super(entityType, world);
    // 创建一个NbtCompound并将实体的nbt数据写入到这个NbtCompound中
    NbtCompound nbt = this.writeNbt(new NbtCompound());
    /* 获取名为"scale"的子NbtCompound
       我的代码中的scale长这样: {"scale":{x:"1.0",y:"1.0",z:"1.0}}     
    */
    NbtCompound scaleNbt = nbt.getCompound("scale");
    // 如果"scale"不为空，则读取并设置缩放值
    if (!scaleNbt.toString().equals("{}")) {
        //setScale()方法见上文
        this.setScale(scaleNbt.getDouble("x"), scaleNbt.getDouble("y"), scaleNbt.getDouble("z"));
    }
}
```
### 2.dataTracker的使用
在`setScale()`方法中，我调用了`this.dataTracker.set(SCALE_DATA, scaleNbt);`，这用于设置实体的数据，接下来将会讲述如何使用它

第一步是注册一个DataTracker，添加一个这样的全局变量:
```java
// 记得把YourEntity换成你的实体类
public final DataTracker<NbtCompound> SCALE_DATA = DataTracker.registerData(YourEntity.class, TrackedDataHandlerRegistry.NBT_COMPOUND);
```

第二步是注册DataTracker,需要重写`initDataTracker()`方法，如下所示:
```java
public void initDataTracker() {
    super.initDataTracker();
    // 创建一个NbtCompound并设置初始值
    NbtCompound scaleNbt = new NbtCompound();
    scaleNbt.putDouble("x",1.0);
    scaleNbt.putDouble("y",1.0);
    scaleNbt.putDouble("z",1.0);
    //写入数据
    this.dataTracker.startTracking(SCALE_DATA, scaleNbt);
}
```
完成之后呢，你就可以在实体类中使用`this.dataTracker.get(SCALE_DATA);`和`this.dataTracker.set(SCALE_DATA, nbt);`来读取和设置数据了。
### 3.NBT的获取和写入
需要重写`readCustomDataFromNbt(NbtCompound)`和`writeCustomDataFromNbt(NbtCompound)`方法，如下所示:
```java
    @Override
    public void readCustomDataFromNbt(NbtCompound nbt) {
        super.readCustomDataFromNbt(nbt);
        if(!nbt.getCompound("scale").toString().equalsIgnoreCase("{}")) {
            NbtCompound scaleNbt = nbt.getCompound("scale");
            this.setScale(new Vec3d(scaleNbt.getDouble("x"), scaleNbt.getDouble("y"), scaleNbt.getDouble("z")));
        }

    }
    @Override
    public void writeCustomDataToNbt(NbtCompound nbt) {
        NbtCompound scaleNbt = new NbtCompound();
        Vec3d vec = this.getScale();
        scaleNbt.putDouble("x",vec.getX());
        scaleNbt.putDouble("y",vec.getY());
        scaleNbt.putDouble("z",vec.getZ());
        nbt.put("scale",scaleNbt);
        super.writeCustomDataToNbt(nbt);
    }
```

为什么要重写这两个方法呢？因为`readCustomDataFromNbt(NbtCompound)`会在实体被加载和nbt被更改时调用，可以使用它来设置实体的属性，而`writeCustomDataToNbt(NbtCompound)`会在实体被保存时调用，因此这两个方法可以让nbt发挥其作用。
### 4.大功告成
在完成这些后，实体就能够在生成时读取nbt并在nbt被修改时自动更新相关数据了。

## 折腾过程
看起来弄nbt挺简单的，但为了搞这玩意儿，我折腾了一整个下午，我写这篇文章时已经晚上7点了，但我是从中午12点就开始弄这玩意儿的。

最开始我寻思着应该有个get或者说set之类的方法来直接读取和设置nbt，然后我就找到了`writeNbt`和`setNbt`方法，本来我以为直接用这两个方法就可以了，但是我发现它们的返回值似乎不对，我就以为`readNbt`是将实体的nbt读取到传入的nbt对象中，然后我发现我错了，这玩意压根不是这样，我就又尝试使用`writeNbt`，然而我发现它似乎也没有传入相应的数据，我就把另外几个nbt相关的方法也都试了，结果还是不行。

既然这样不行，那怎么办呢？于是我就看了一下这俩方法的源码，发现`readNbt`是将nbt设置为实体的属性，而`writeNbt`则是将实体的属性写入nbt，困惑一下就被解开了，原来获取到的nbt是现场生成的啊，之前我一直以为nbt在实体属性更改时顺带更改的，这一下我懂了，于是乎在查看了一下其它实体的源码后，我就尝试重写了这两个方法，似乎确实有效...个poi

还能怎样，看其它实体的源代码呗。我想到了一个相似的实体，那 就 是 史莱姆!!在查看了史莱姆的源代码后，我了解到了`TrackedData`，原来存储数据要靠这玩意儿，然后我就看了一下它的源代码后，就在我自己的实体中使用了它。

本来到这里其实已经差不多了，但是由于我犯了一点小小的错误，导致nbt出现了亿点问题，我就一直在调试。哎~我居然连参数都会填错，甚至把`scale`写成了`Scale`，但我居然一直没有发觉，导致浪费了很多时间，希望以后不会再犯这种低级错误了吧。

其实写这篇文章也花了我不少时间，我从7点半写到了8点半，希望对大家能有所帮助吧。有啥问题可以发表在评论区哦~
