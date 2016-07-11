
##概述

因为国内网络的问题 下载minecraft服务器的时候 在aliyun上面实在是忍不了
但是也很无奈 


所以我借鉴了国外的一位大神的项目[github](https://github.com/itzg/dockerfiles/tree/master/minecraft-server)  修改了一下dockerfile 

由于mac下并且从小受到的支持盗版的奇怪熏陶的原因 我暂时能够找到的某种意义上免费最高版本的minecraft客户端只到1.8.1 而且还找不到forge  实在是无奈


所以这个项目的version被我写死到了1.8.1


我自己翻墙下载了一些需要下载的jar包 然后在七牛云上保存 然后再替换进去 说实话 技术含量实在是低的可以 

但是不得不说非常有效 hahah


下面标出我修改的地方 

start.mincecraft.sh  文件是主要修改的文件 


1. 第127行 function installVanilla 方法

```
function installVanilla {
  SERVER="minecraft_server.$VANILLA_VERSION.jar"

  if [ ! -e $SERVER ]; then
    echo "Downloading $SERVER ..."
    wget -q http://7xrlqi.com1.z0.glb.clouddn.com/minecraft_server.1.8.1.jar
  fi
}

```

##使用方法

####build  

```
$ docker build -t minecraft .

```

####run

```
$ docker run -d -it -v /root/data/minecraft/data:/data -e EULA=TRUE -e VERSION=1.8.1 -e DIFFICULTY=easy -e MODE=survival -e PVP=0 -e FORCE_GAMEMODE=false -e MOTD=Waiting for xiaoqiang -e ENABLE_COMMAND_BLOCK=true -p 25565:25565 --restart=always --name mc minecraft

```  

####logs

```
$ docker logs -f mc

```

####attache

```
$ docker attache mc
```

在attache中 可以作弊

attache到容器中 输入 ```/help``` 查看你可以输入的作弊命令

退出attache ``` ctrl+P+Q ```



##server.properties

属性           | 描述
:------------ | :-----------:
allow-flight  | 允许玩家在安装添加飞行功能的mod前提下在生存模式下飞行。允许飞行可能会使作弊者更加常见，因为此设定会使他们更容易达成目的。在创造模式下本属性不会有任何作用。
false | 不允许飞行。悬空超过5秒的玩家会被踢出服务器。true  允许飞行。玩家得以使用飞行MOD飞行。
allow-nether | 允许玩家进入下界。false  下界传送门不会生效。true  玩家可以通过下界传送门前往下界。
difficulty  | 定义服务器的游戏难度（例如生物对玩家造成的伤害，饥饿与中毒对玩家的影响方式等）。0 - 和平 1 - 简单 2 - 普通 3 - 困难
enable-query |  允许使用GameSpy4协议的服务器监听器。用于收集服务器信息。
enable-rcon | 是否允许远程访问服务器控制台。
gamemode | 定义游戏模式 0 - 生存模式 1 - 创造模式 2 - 冒险模式（仅在12w22a之后，或正式版1.3之后可用）
generate-structures  | 定义是否在生成世界时生成结构（例如NPC村庄）false - 新生成的区块中将不包含结构。 true - 新生成的区块中将包含结构。 注：即使设为 false，地牢和下界要塞仍然会生成
generator-settings  | 本属性质用于自订义超平坦世界的生成。详见超平坦世界了解正确的设定及例子。
hardcore|一旦启用，玩家在死后会自动被服务器封禁（即开启极限模式）。
level-name  |“level-name”的值将作为世界名称及其文件夹名。你也可以把你已生成的世界存档复制过来，然后让这个值与那个文件夹的名字保持一致，服务器就可以载入该存档。部分字符，例如 ' （单引号）可能需要在前面加反斜杠号 \ 才能正确应用。
level-seed  | 与单人游戏类似，为你的世界定义一个种子。这里有一些例子：minecraft，404，1a2b3c。
level-type  | 确定地图所生成的类型 DEFAULT - 标准的世界带有丘陵，河谷，海洋等  FLAT - 一个没有特色的平坦世界，适合用于建设 LARGEBIOMES - 如同预设世界，但所有生态系都更大（仅快照12w19a，或正式版1.3之后可用） AMPLIFIED - 如同预设世界，但世界生成高度提高（仅快照13w36a，或正式版1.7.2之后可用） CUSTOMIZED - 自快照14w21b以来，服务器亦支援自定义地形。使用方法是在generator-settings贴上代码。
max-build-height |  玩家在游戏中能够建造的最大高度。然而地形生成算法并不会受这个值的影响。
max-players | 服务器同时能容纳的最大玩家数量。但请注意在线玩家越多，对服务器造成的负担也越大，而且服务器OP也不具有在人满的情况下强行进入服务器的权力。所以请慎重设置本属性，过大的数值会使客户端显示的玩家列表崩坏。
motd | 本属性值是玩家客户端的多人游戏服务器列表中显示的服务器讯息，显示于名称下方。请注意，motd 不支持彩色样式代码。 如果 motd 超过59字符，服务器列表很可能会返回“通讯错误”。
online-mode | 是否允许在线验证。服务器会与 Minecraft 的账户数据库对比检查连入玩家。如果你的服务器并未与 Internet 连接，则将这个值设为 false ，然而这样的话破坏者也能够使用任意假账户登录服务器。如果 Minecraft.net 服务器下线，那么开启在线验证的服务器会因为无法验证玩家身份而拒绝所有玩家加入。通常，这个值设为 true 的服务器被称为“正版服务器”，设为 false 的被称为“离线服务器”或“盗版服务器”。 true - 启用。服务器会认为自己具有 Internet 连接，并检查每一位连入的玩家。   false - 禁用。服务器不会检查玩家。
op-permission-level | 设定OP的权限等级   1 - OP可以无视重生点保护   2 - OP可以使用 /clear、/difficulty、/effect、/gamemode、/gamerule、/give 以及 /tp 指令，可以编辑指令方块    3 - OP可以使用 /ban、/deop、/kick 以及 /op 指令   4 - OP可以使用 /stop 指令
texture-pack | 客户端加入服务器后是否会自动下载材质包。请在这里填入完整的材质包URL。注意：这个链接必须直接连到事实的材质包ZIP文件，而且虽然材质包可以是高清的，服务器并不会对玩家服务端进行自动高清修补。所以如果你想让大多数玩家都能够使用该材质包的话，请使用标准16x16清晰度。
pvp | 是否允许PvP。玩家自己的箭也只有在允许PvP时才可能伤害到自己。注： 来源于玩家的间接伤害，例如岩浆，火，TNT等，还是会造成伤害。true - 玩家可以互相残杀。false - 玩家无法互相造成伤害。
query.port  | 设置监听服务器的端口号（详见enable-query）。
rcon.password | 设置远程访问的密码（详见enable-rcon）。
rcon.port | 设置远程访问的端口号（详见enable-rcon）。
server-ip | 将服务器与一个特定IP绑定。强烈建议你留空本属性值！留空，或是填入你想让服务器绑定的IP。
server-port  | 改变服务器端口号。如果服务器通过路由器与外界连接的话，该端口必须也能够通过路由器。
snooper-enabled | 自1.3正式版之后，一旦启用，将允许服务端定期发送统计数据到http://snoop.minecraft.net.    false - 禁用数据采集   true - 启用数据采集
spawn-animals | 决定动物是否可以生成。true - 动物可以生成。 false - 动物生成后会立即消失。
spawn-monsters | 决定攻击型生物（怪兽）是否可以生成。true - 可以。只要满足条件的话怪物就会生成。false - 禁用。不会有任何怪物。如果difficulty = 0（和平）的话，本属性值不会有任何影响。
spawn-npcs  | 决定是否生成村民。true - 生成村民  false - 不会有村民。
view-distance | 设置服务端传送给客户端的数据量。用每一个方向上的区块数量衡量。这个值也是客户端视野距离的上限。当视野为“远”时，实际的值为9，所以默认推荐值为 10 。
white-list | 允许服务器白名单  当启用时，只有白名单上的用户才能连接服务器。白名单主要用于私人服务器，例如相识的朋友等。注 - OP会自动被视为在白名单上。所以无需再将OP加入白名单。false - 不使用白名单。true - 从 white-list.txt 文件加载白名单。
enable-command-block | 当启用时地图中的命令方块可以被红石所激活注 - 只有在创造模式的OP才可以正常输入命令方块指令       

