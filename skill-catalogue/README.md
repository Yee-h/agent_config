# Skill Catalogue — 技能总目录

本目录按领域分类收录所有已安装 Skill，供 Agent 在对应开发阶段快速查阅调用方式。

> **已安装 Skill** 可直接通过 `Skill(name="...")` 调用。
> **Subagent** 通过 `Task(subagent_type="...")` 调用，无需安装。

---

## 目录结构

| 文件 | 领域 | 已收录技能数 | 说明 |
| :--- | :--- | :--- | :--- |
| [development/front-end.md](./development/front-end.md) | 前端开发 | 3 | UI/UX 设计、Draw.io 图表、HTML 设计 |
| [development/back-end.md](./development/back-end.md) | 后端开发 | 3 | 深度研究（Deep Research）+ Web 搜索（Tavily）+ 百度千帆 |
| [testing/unit-testing.md](./testing/unit-testing.md) | 单元测试 | 2 | TDD、验证 |
| [testing/e2e-testing.md](./testing/e2e-testing.md) | E2E测试 | 1 | Playwright CLI 浏览器自动化 |
| [data-science/analytics.md](./data-science/analytics.md) | 数据分析 | 1 | 电子表格处理 |
| [agent-workflow/planning.md](./agent-workflow/planning.md) | Agent 规划 | 11 | OpenSpec 工作流、任务拆解、计划执行、并行调度、分支管理 |
| [agent-workflow/review-and-debug.md](./agent-workflow/review-and-debug.md) | 审查与调试 | 5 | 代码审查、系统化调试、质量验证 |
| [agent-workflow/subagent-tools.md](./agent-workflow/subagent-tools.md) | 子 Agent 工具 | 9 | 架构、审查、简化、调试、文档、安全、测试、探索 |
| [document-processing/office-docs.md](./document-processing/office-docs.md) | 文档处理 | 6 | Word、Excel、PDF、PPT、AI 幻灯片、MarkItDown 格式转换 |
| [document-processing/academic-writing.md](./document-processing/academic-writing.md) | 学术写作 | 1 | 全流程学术写作：Nature 级润色/图表/数据声明/论文转PPT；翻译、去AI味、Reviewer审视 |

| [discovery/meta-skills.md](./discovery/meta-skills.md) | 元技能 | 4 | Skill 发现、安装、创建与 Superpowers 规范 |

---

## 快速查阅：按开发阶段

| 开发阶段 | 推荐查阅 |
| :--- | :--- |
| 需求分析 / 架构设计 | [planning.md](./agent-workflow/planning.md) |
| 前端实现 | [front-end.md](./development/front-end.md) |
| 后端实现 | [back-end.md](./development/back-end.md) |
| 测试编写 | [unit-testing.md](./testing/unit-testing.md) |
| 代码审查 / 重构 | [review-and-debug.md](./agent-workflow/review-and-debug.md)、[subagent-tools.md](./agent-workflow/subagent-tools.md) |
| 文档更新 | [office-docs.md](./document-processing/office-docs.md)、[subagent-tools.md](./agent-workflow/subagent-tools.md) (doc-writer) |
| 学术论文写作 | [academic-writing.md](./document-processing/academic-writing.md) |
| 新能力发现 | [meta-skills.md](./discovery/meta-skills.md) |

---

## Subagent 速查

| Subagent | 调用方式 | 用途 |
| :--- | :--- | :--- |
| **architect** | `Task(subagent_type="architect")` | 系统架构设计 |
| **code-reviewer** | `Task(subagent_type="code-reviewer")` | 代码审查 |
| **code-simplifier** | `Task(subagent_type="code-simplifier")` | 代码简化重构 |
| **debug-agent** | `Task(subagent_type="debug-agent")` | 调试/故障调查 |
| **doc-writer** | `Task(subagent_type="doc-writer")` | 文档同步更新 |
| **performance-analyst** | `Task(subagent_type="performance-analyst")` | 性能分析与调优 |
| **refactoring-specialist** | `Task(subagent_type="refactoring-specialist")` | 架构模式重构 |
| **security-auditor** | `Task(subagent_type="security-auditor")` | 安全审计/漏洞扫描 |
| **test-writer** | `Task(subagent_type="test-writer")` | 测试编写 |
| **researcher** | `Task(subagent_type="researcher")` | 搜索调研/研究 |

---
