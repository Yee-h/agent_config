# 元技能与能力发现 (Meta-Skills & Discovery)

> 适用于查找新技能、编写 Skill 文件、建立会话规范等 Agent 能力管理场景。

| Skill 名称 | 调用方式 | 触发条件/适用场景 |
| :--- | :--- | :--- |
| **find-skills** | `Skill(name="find-skills")` | 用户询问"怎么做 X"、"有没有 skill 可以做 X"时，搜索并安装合适的技能包。 |
| **skill-creator** | `Skill(name="skill-creator")` | 创建/改进 Skill 的**全生命周期管理**：Design（SSO 结构规范、防绕过话术、反模式识别）、Verify（压力测试、RED-GREEN-REFACTOR、并行子代理评分、benchmark 查看器）、Ship（描述触发优化 run_loop.py、.skill 打包）。已融合原 writing-skills 内容方法论。 |
| **install-skill** | `Skill(name="install-skill")` | 安装新 Skill 的强制安全流程（多 Agent 通用）：Agent 检测 → 毒性检查 → 语言检查 → 跨 Agent 路径纠正 → 删除许可证 → 迁移到当前 Agent 目录 → 更新注册表。支持 OpenCode、Claude Code、Cursor、Windsurf、CodeBuddy。 |
| **using-superpowers** | `Skill(name="using-superpowers")` | **[自动加载]** 每次对话启动时自动注入，建立技能发现与使用规范。无需手动调用。 |

