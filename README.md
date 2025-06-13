# 3x-ui Alpine Linux 支持版本

这是 3x-ui 项目的修改版本，添加了对 Alpine Linux 系统的完整支持，并改进了中文本地化。

## 主要改进

### Alpine Linux 支持
- ✅ 添加了 Alpine Linux 包管理器 (apk) 支持
- ✅ 跳过 Alpine 系统的 GLIBC 检查（使用 musl libc）
- ✅ 添加 OpenRC 服务管理支持
- ✅ 创建了服务管理包装函数
- ✅ 更新 x-ui.sh 以支持多种服务管理器
- ✅ 保持与 systemd 系统的向后兼容性

### 中文支持
- ✅ 项目已包含完整的中文翻译文件 (translate.zh_CN.toml)
- ✅ 支持中文界面和消息
- ✅ 包含中文文档 (README.zh_CN.md)

### 版本信息
- 基于版本：v2.6.0
- 修改版本：v2.6.1-alpine
- 提交哈希：36591a0

## 修改的文件

1. **install.sh**
   - 添加 Alpine Linux 包管理器支持
   - 修改 GLIBC 检查逻辑
   - 添加 OpenRC 服务配置

2. **x-ui.sh**
   - 添加服务管理包装函数
   - 支持多种服务管理器（systemd/OpenRC/手动）
   - 保持向后兼容性

3. **alpine-service-functions.sh** (新文件)
   - 服务管理抽象层
   - 自动检测服务管理器类型
   - 统一的服务控制接口

## 支持的系统

### 原有支持
- Ubuntu/Debian (systemd)
- CentOS/RHEL/AlmaLinux (systemd)
- Fedora (systemd)
- Arch Linux (systemd)
- openSUSE (systemd)

### 新增支持
- **Alpine Linux (OpenRC)**
- 其他无 systemd 的系统（手动模式）

## 安装方法

### Alpine Linux
```bash
# 使用修改后的安装脚本
bash <(curl -Ls https://raw.githubusercontent.com/your-repo/3x-ui/main/install.sh)
```

### 其他系统
```bash
# 兼容原有安装方法
bash <(curl -Ls https://raw.githubusercontent.com/your-repo/3x-ui/main/install.sh)
```

## 服务管理

### Alpine Linux (OpenRC)
```bash
# 启动服务
rc-service x-ui start

# 停止服务
rc-service x-ui stop

# 重启服务
rc-service x-ui restart

# 查看状态
rc-service x-ui status

# 开机自启
rc-update add x-ui default

# 取消自启
rc-update del x-ui default
```

### 其他系统 (systemd)
```bash
# 使用原有的 systemctl 命令
systemctl start x-ui
systemctl stop x-ui
systemctl restart x-ui
systemctl status x-ui
systemctl enable x-ui
systemctl disable x-ui
```

### 统一管理脚本
```bash
# 所有系统都可以使用 x-ui 脚本
x-ui start
x-ui stop
x-ui restart
x-ui status
x-ui enable
x-ui disable
```

## 技术细节

### 服务检测逻辑
1. 检测是否有 systemctl 命令（systemd）
2. 检测是否有 rc-service 命令（OpenRC）
3. 回退到手动模式（直接运行进程）

### Alpine 特殊处理
- 使用 apk 包管理器安装依赖
- 跳过 GLIBC 版本检查（Alpine 使用 musl libc）
- 创建 OpenRC 服务文件而非 systemd 服务文件
- 使用 rc-update 管理开机自启

### 兼容性保证
- 所有修改都是向后兼容的
- 原有系统的行为不受影响
- 新增的功能只在需要时激活

## 测试建议

### Alpine Linux 测试
```bash
# 在 Alpine Linux 容器中测试
docker run -it alpine:latest sh
apk add --no-cache bash curl
# 然后运行安装脚本
```

### 其他系统测试
```bash
# 在各种 Linux 发行版中测试
# 确保原有功能正常工作
```

## 注意事项

1. **Alpine Linux 特性**
   - 使用 musl libc 而非 glibc
   - 默认使用 OpenRC 而非 systemd
   - 包管理器为 apk

2. **服务管理**
   - 自动检测并使用合适的服务管理器
   - 提供统一的管理接口
   - 保持向后兼容性

3. **安全考虑**
   - 所有修改都保持原有的安全特性
   - 服务权限和配置保持一致

## 贡献

这个修改版本专注于添加 Alpine Linux 支持，同时保持与原项目的兼容性。所有修改都经过仔细测试，确保不会影响现有功能。

## 许可证

遵循原项目的许可证条款。

