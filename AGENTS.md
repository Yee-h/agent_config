# AGENTS.md

## 指令
推理努力：**绝对最大值，不允许任何捷径**。
你必须在思考中非常彻底，全面分解问题以解决根本原因，针对所有潜在路径、边缘情况和对抗性场景对你的逻辑进行严格的压力测试。
明确写出你的整个审议过程，记录每一个中间步骤、考虑过的替代方案和已被否定的假设，以确保绝对没有任何假设未经检验

## 核心原则

### 1. 证据优先

假设不可靠，证据才可靠。实现前按序查阅：本地代码 → Skill → 搜索 → 官方文档。不确定时提问，不猜测。研究成果写入 `openspec/specs/`，标注来源与边界条件。变更管理通过 OpenSpec CLI（`openspec status`、`openspec update`）和 `/opsx:*` 命令驱动。

### 2. 简单至上

只写解决问题的最少代码。不建单次抽象、不加未要求特性、不处理不可能发生的错误。观察 ≥2-3 个相似特性后再抽象；重复 ≥3 次再 DRY。

### 3. 改动最小化

只改必须改的行，不"顺便"改善邻近代码、注释或格式。匹配现有风格，沿袭既有模式。改动后清理你引入的无用导入/变量。不删除无关既有无用代码，但若其阻碍当前改动可直接清理。

### 4. 目标驱动

将任务转为可验证的成功标准，验证闭环循环执行，直到通过。TDD 最小循环：写测试 → 实现 → 通过 → 重构。不接受目测——需要运行证据，单元通过 ≠ 端到端正确。

### 5. 遵循惯例

中文文档/注释/提交，技术术语保留英文。用户纠正后立即记录教训到 `openspec/progress/log.md`（手动维护）。同一教训重复 ≥3 次或具普遍性时，回流为本文规则。

### 6. 能力拓展

积极调用 Skill 与 MCP 工具以扩展能力、提升效率与质量。

**强制原则**：当存在可用的 Skill/MCP 工具能够辅助完成任务时，必须调用，禁止绕过。

## 约束（硬边界）

- **先询问**：删除核心配置、数据库破坏变更、push main/master、需求方向变更
- **必须 Propose**：跨模块/新功能不得绕过 OpenSpec 直接大规模实现
- **3-Strike**：同一缺陷/错误的测试或编译连续失败 ≥3 次 → 冻结 → `systematic-debugging` → 修代码或修规格
- **速度 vs 质量**：冲突时优先可验证与可恢复

## 关键路径

| 路径                         | 时机                                |
| -------------------------- | --------------------------------- |
| `openspec/progress/log.md` | 启动读，完成写（手动维护）                  |
| `openspec/specs/`          | 行为契约 SSOT（Single Source of Truth） |
| `openspec/changes/`        | 活跃变更管理，通过 `/opsx:*` 命令驱动       |
| `agents/*.md`              | Subagent 定义，按需加载                  |

## 工作流

**标准**: `/opsx:propose` → `/opsx:apply` → `/opsx:archive`（OPSX 流体工作流，可随时编辑 artifact）
**轻量**（typo/重命名/注释/配置/格式重构/常规 Git，或 ≤3 文件且无跨文件语义耦合）：跳过 Propose，不查 specs

| 阶段      | 目标     | 允许                                              | 禁止      |
| ------- | ------ | ----------------------------------------------- | ------- |
| Explore | 澄清边界   | `brainstorming`, `/opsx:explore`             | 写代码     |
| Propose | 生成工件   | `/opsx:propose`                              | 无工件即实现  |
| Apply   | TDD 执行 | `/opsx:apply`, 领域 Skill               | 扩展范围    |
| Verify  | 测试诊断   | `brooks-lint`, `verification-before-completion` | 无证据宣称完成 |
| Archive | 归档同步   | `/opsx:archive`                       | 工件不全即归档 |

**卡住**：冻结 → `systematic-debugging` → 修正 → 回到 Explore 或 Apply

## 强制 Skill

| 时机        | Skill                            |
| --------- | -------------------------------- |
| 宣称完成前     | `verification-before-completion` |
| 归档前       | `brooks-lint`（Critical 则禁归档）     |
| 连续失败 ≥3 次 | `systematic-debugging`           |
| 创意/方案设计前  | `brainstorming`                  |

## 启动例行

1. 确认工作目录 → 2. 读本文件 → 3. 若 `openspec/` 目录不存在，执行 `openspec init --tools <platform>` 初始化（`<platform>` 根据当前 Agent 选择：OpenCode 用 `opencode`，Claude Code 用 `claude`，Codex 用 `codex`，详见 `openspec init --help` 支持的 `--tools` 参数值） → 4. 读 `openspec/progress/log.md`（手动维护） → 5. `git log --oneline -10` → 6. `git status` 冒烟确认仓库干净，关键配置存在；失败则停新功能，修基线

## 调度(**强制**)

**MainAgent 调度，Subagent 执行**。默认委派，保持上下文干净。MainAgent 直接改仅限：单文件 ≤10 行 且 不涉架构/API/跨文件 且 委派开销 > 实现开销。若 `agents/*.md` 缺失，直接构造 prompt（五要素），不等文件加载。

### 场景示例
以下仅为示例说明，不作为调用限制。**任何可通过委派独立完成的任务都应交给 Subagent 执行**，包括但不限于代码审查、性能分析、安全审计、重构、测试编写、调试定位等。MainAgent 的角色是拆解任务 → 委派 Subagent → 汇总结果，而非亲力亲为。

**搜索/调研类任务**：MainAgent 明确搜索/调研目标，可使用的 skill/MCP 工具，Subagent 执行后返回结果，MainAgent 根据结果判断是否继续搜索/调研，或是否完成任务。

**文档类任务**：MainAgent 明确文档目标，可使用的 skill/MCP 工具，Subagent 执行后返回结果，MainAgent 根据结果判断是否继续文档编写，或是否完成任务。


### Subagent 速查

| 工作     | 文件                                         |
| -------- | -------------------------------------------- |
| 系统架构   | `agents/architect.md`                        |
| 代码审查   | `agents/code-reviewer.md`                    |
| 代码简化   | `agents/code-simplifier.md`                  |
| 架构重构   | `agents/refactoring-specialist.md`           |
| 安全审计   | `agents/security-auditor.md`                 |
| 性能分析   | `agents/performance-analyst.md`              |
| 调试定位   | `agents/debug-agent.md`                      |
| 测试编写   | `agents/test-writer.md`                      |
| 搜索调研   | `agents/researcher.md`                       |
| 文档撰写   | `agents/doc-writer.md`                       |

### Skill 决策

| 场景   | Skill / OPSX 命令                                                        |
| ---- | ------------------------------------------------------------ |
| 需求澄清 | `brainstorming`, `/opsx:explore`                          |
| 变更方案 | `/opsx:propose`                                           |
| 任务执行 | `/opsx:apply`, `test-driven-development`, 领域 Skill               |
| 验证核验 | `verification-before-completion`, `brooks-lint`              |
| 故障恢复 | `systematic-debugging`                                       |
| 变更归档 | `/opsx:archive`                                    |
| 代码审查 | `requesting-code-review`, `receiving-code-review`            |
| 并行任务 | `dispatching-parallel-agents`, `subagent-driven-development` |

Subagent prompt 五要素：**TASK**（原子目标）、**EXPECTED OUTCOME**（交付物）、**MUST DO**（要求）、**MUST NOT DO**（禁止）、**CONTEXT**（文件路径/约束）。模板见 `skill-catalogue/README.md`。

## 插件生态

需要扩展能力边界安装插件时，优先查阅 [awesome-opencode](https://github.com/awesome-opencode/awesome-opencode) 安装插件。
