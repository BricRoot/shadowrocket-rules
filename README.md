# Shadowrocket Rules(Custom)

本仓库用于**自动下载并构建Shadowrocket规则**，并在`[Rule]`段落下插入自定义规则。

规则源来自项目**Shadowrocket-ADBlock-Rules-Forever**，并通过GitHub Actions自动更新。

## 规则来源

* https://johnshall.github.io/Shadowrocket-ADBlock-Rules-Forever/sr_cnip_ad.conf
* https://johnshall.github.io/Shadowrocket-ADBlock-Rules-Forever/sr_top500_banlist_ad.conf

## 自定义规则

自定义规则写在：

```
insert_rules.txt
```

示例：

```
RULE-SET,https://clashios.app/static/rules/bytedance-classical-set.yaml,PROXY
RULE-SET,https://raw.githubusercontent.com/SunsetMkt/anti-ip-attribution/refs/heads/main/generated/quantumultx.list,PROXY
```

这些规则会自动插入到`[Rule]`下方。

## 自动构建

通过GitHub Actions每天自动运行：

```
北京时间09:00
```

流程：

```
下载原始规则
↓
插入自定义规则
↓
生成最终规则
↓
自动提交到仓库
```

## 生成规则

CNIP规则：

```
sr_cnip_ad_custom.conf
```

订阅地址：

```
https://raw.githubusercontent.com/BricRoot/shadowrocket-rules/main/sr_cnip_ad_custom.conf
```

Top500规则：

```
sr_top500_ad_custom.conf
```

订阅地址：

```
https://raw.githubusercontent.com/BricRoot/shadowrocket-rules/main/sr_top500_ad_custom.conf
```

## 仓库结构

```
.
├── insert_rules.txt        #自定义规则
├── build.sh                #构建脚本
├── sr_cnip_ad_custom.conf  #生成规则
├── sr_top500_ad_custom.conf
└── .github/workflows/update.yml
```

## 说明

* 本仓库仅用于规则整合与自动构建
* 原始规则版权归对应项目作者所有
