---
title: 动态加载GeckoLib模型
date: 2024-09-02 10:30:58
tags: [Minecraft,GeckoLib]
---

好像已经有两个月没写博客了呢...... 最近正在进行[ayame](https://github.com/AyameMC/ayame)的开发，遇到了这个难题，不过好在解决了，所以就分享出来吧。

## 前言
`GeckoLib`是一个很流行的Minecraft动画库，如题，这篇文章要讲的就是如何动态加载模型（例如从文件或远程URL获取模型并加载）

**编写这篇文章使用的`Minecraft`版本为`1.21`，`GeckoLib`版本为`4.5.8`，映射表为官方映射表，其它版本可能不适用**

## 创建缓存
第一步实现创建缓存，目的是为了方便后续的调用。假设你的Entity类是`CMEntity`，只需要创建三个`Map<CMEntity,ResourceLocation>`，像下面这样：
```java
public static Map<CMEntity,ResourceLocation> modelCache = new HashMap<>(); // 模型缓存
public static Map<CMEntity,ResourceLocation> animationCache = new HashMap<>(); // 动画缓存
public static Map<CMEntity,ResourceLocation> textureCache = new HashMap<>(); // 贴图缓存
```
## 向GeckoLib缓存写入模型和动画
既然要动态加载，首先就要写入GeckoLib的缓存，也就是`GeckoLibCache`这个类。它提供了两个静态的getter方法：`getBakedAnimations()`和`getBakedModels()`，通过它们可以获取到缓存的Map。因此，我们就可以向Map里面添加值。
### 添加模型
通过`getBakedModels()`方法可以得到一个`Map<ResourceLocation,BakedGeoModel>`，接下来我们就需要往里面添加我们的模型。
```java
ResourceLocation loc = ResourceLocation.fromNamespaceAndPath("mod_id","geo/entity/cmentity/model_0.json"); // 请换成你自己的模组ID，Path可以随意，只要保证是json就行
Model m = KeyFramesAdapter.GEO_GSON.fromJson(aJsonObject, Model.class); // 请把aJsonObject换成你要加载的模型的JsonObject，可以从文件，url等获取
BakedGeoModel bakedGeoModel = BakedModelFactory.getForNamespace("mod_id").constructGeoModel(GeometryTree.fromModel(m)); // 这一步创建BakedGeoModel，还是请把mod_id换成你自己的

GeckoLibCache.getBakedModels().put(loc, bakedGeoModel); // 写入GeckoLib的缓存
modelCache.put(entity,loc); // 写入刚才创建的模型缓存，把entity换成你自己的Entity对象
```
到这里，模型缓存写入完成。
### 添加动画
动画的操作和模型类似，只需要如下即可：
```java
ResourceLocation loc = ResourceLocation.fromNamespaceAndPath("mod_id","animations/entity/cmentity/animation_0.json"); // 请换成你自己的模组ID，Path可以随意，只要保证是json就行    
BakedAnimations ani = KeyFramesAdapter.GEO_GSON.fromJson(aJsonObject, "animations"), BakedAnimations.class);
GeckoLibCache.getBekedAnimations().put(loc, ani); // 写入GeckoLib的缓存
animationCache.put(loc,ani); // 写入刚才创建的模型缓存，把entity换成你自己的Entity对象
```
到这里，模型和动画就算完成。

## 添加贴图
贴图不直接由GeckoLib管理，而是由Minecraft直接管理，所以它不在geckoLib缓存中。

添加贴图只需要在TextureManager中注册即可。代码如下：
```java
InputStream stream = ... // 从文件或url等获取到的输入流，也可以使用byte[]代替
String name = "cmentity_texture_0"; // 贴图的名称，可以随意，但是最好不要重复
try{
	DynamicTexture texture = new DynamicTexture(NativeImage.read(stream));
} catch (IOException e){
	// 按需处理错误
	LOGGER.error("Failed to load texture for model :{}", name,e);
}
ResourceLocation loc = Minecraft.getInstance().getTextureManager().register(name,texture); // 注册贴图
textureCache.put(entity,loc); // 写入缓存，确保entity是你自己的实体对象
```
到这里，贴图的添加也算完成了。

## 创建GeoModel
这一步大家应该都会，[GeckoLib官方wiki](https://github.com/bernie-g/geckolib/wiki/Geo-Models-(Geckolib4))上也是有的，就不多赘述了，这里我们主要讲如何从缓存获取。

我们直接看下面重写的这三个方法：
```java
@Override
public ResourceLocation getModelResource(CMEntity animatable) {
// 这是获取模型资源的方法，从我们的缓存读取
return modelCache.getOrDefault(animatable,defaultModel); // 为了防止出错，建议添加一个默认模型
}
@Override
public ResourceLocation getTextureResource(CMEntity animatable) {
// 这是获取贴图资源的方法，从我们的缓存读取
return textureCache.getOrDefault(animatable,defaultModel); // 同上
}
@Override
public ResourceLocation getAnimationResource(CMEntity animatable) {
// 这是获取贴图资源的方法，从我们的缓存读取
return animationCache.getOrDefault(animatable,defaultModel); // 同上
}
```
完成了这些，那么恭喜你，已经大功告成了，接下来只需要优化细节即可。

## 折腾过程
正文结束，接下来讲讲我是怎么折腾的以及为什么会去做这个。

最近在进行[Ayame](https://github.com/AyameMC/ayame)的开发，它是一个用于自定义玩家模型的模组，使用GeckoLib作为前置，正常情况下修改模型是通过资源包的方式实现，不过对于玩家而言，使用资源包太过麻烦了，因此，能直接从文件或者链接加载模型显然更为方便，不过这需要动态加载模型了。最开始我是尝试使用Minecraft的资源管理器来实现动态加载，但是折腾了一天无果，遂放弃，也想过其它办法，但是大多不太行，最后选择了修改GeckoLib的缓存来实现它，没想到它确实有效，不过它只能加载模型和动画文件，不支持贴图，在翻阅代码后发现贴图依然是由原版在处理。在翻阅大量代码后，最后找到了贴图管理器，于是尝试使用它，没想到它确实有效，至此，动态加载模型也算完成了，距离Ayame的又进一步
