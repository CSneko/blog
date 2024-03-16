---
title: 添加新附魔[Minecraft模组开发]
date: 2024-03-16 15:36:58
tags: [Minecraft,Java,Fabric]
---
## 前言
本文章是以 Minecraft 1.20.4 版本编写的，使用`Fabric`加载器和`Yarn`映射，如果你使用官方映射或MCP映射，可在[linkie](https://linkie.shedaniel.dev/)进行转换。

文章中所有的`modid`,`enchantnid`等都请替换成你自己的模组id和附魔id。

## 创建附魔类
首先，你需要创建一个继承自`Enchantment`的类，然后在类中重写一些方法，如下所示：
```java
public class EnchantID extends Enchantment {
    // 类的构造函数
    public EnchantID() {
        super(Enchantment.Rarity.UNCOMMON, EnchantmentTarget.WEAPON, new EquipmentSlot[] {EquipmentSlot.MAINHAND});
    }
    // 当攻击到到目标时触发
    @Override
    public void onTargetDamaged(LivingEntity user, Entity target, int level) {
        super.onTargetDamaged(user, target, level);
    }
    // 当物品攻击目标时触发
    @Override
    public void onUserDamaged(LivingEntity user, Entity attacker, int level) {
        super.onUserDamaged(user, attacker, level);
    }

    // 获取最小的伤害
    @Override
    public int getMinPower(int level) {
        return 1;
    }
    // 获取最大伤害
    @Override
    public int getMaxPower(int level) {
        return this.getMinPower(level) + 5;
    }
    // 获取最小等级
    @Override
    public int getMinLevel() {
        return 1;
    }
    // 获取最大等级
    @Override
    public int getMaxLevel() {
        return 5;
    }
    // 获取攻击伤害
    @Override
    public float getAttackDamage(int level, EntityGroup group) {
        return 0.0F;
    }
    // 可否合并
    @Override
    public final boolean canCombine(Enchantment other) {
        return this.canAccept(other) && other.canAccept(this);
    }
    // 可否接受其它附魔
    @Override
    public boolean canAccept(Enchantment other) {
        return this != other;
    }
    // 是否为宝藏附魔
    @Override
    public boolean isTreasure() {
        return false;
    }
    // 是否为诅咒附魔
    @Override
    public boolean isCursed() {
        return false;
    }
    // 可否为附魔书
    @Override
    public boolean isAvailableForEnchantedBookOffer() {
        return true;
    }
    // 可否随机选择
    @Override
    public boolean isAvailableForRandomSelection() {
        return true;
    }
    // 物品可否接受该附魔
    @Override
    public boolean isAcceptableItem(ItemStack stack) {
        Item item = stack.getItem();
        return item == Items.DIAMOND_AXE || item == Items.IRON_AXE;
    }
}
```

## 注册附魔
在`onInitialize`方法中注册你的附魔，如下所示：
```java
public static final EnchantID ENCHANT_ID = new EnchantID();
@Override
public void onInitialize(){
    Registry.register(Registries.ENCHANTMENT,new Identifier("mod_id","enchant_id"),ENCHANT_ID);
}
```

接下来你需要为它添加语言文件，否则附魔名称会显示为`enchantment.mod_id.enchant_id`，在`assets/mod_id/lang/zh_cn.json`和`en_us.json`中添加如下内容：
```json
"enchantment.mod_id.enchant_id":"附魔名称"
```
**小贴士：游戏中如果找不到语言文件会显示为`type.mod_id.id`的形式，你只需要在语言文件中添加这个键值对即可。如果找不到对应的语言文件，游戏会自动使用英文语言文件。**
## 大功告成
你的附魔在被注册后会自动添加一本附魔书，你可以使用它为物品附魔。
