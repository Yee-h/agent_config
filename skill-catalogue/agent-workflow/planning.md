# Agent 规划技能 (Agent Planning)

> 适用于需求分析、任务拆解、开发计划制定及长时运行 Agent 初始化等场景。

## OpenSpec 工作流（推荐）

使用 OpenSpec CLI 驱动开发全流程，`openspec/specs/` 为单一事实来源。

| Skill 名称 | 调用方式 | 触发条件/适用场景 |
| :--- | :--- | :--- |
| **openspec-explore** | `Skill(name="openspec-explore")` | 进入探索模式，作为思维伙伴深入调研问题、探索架构方案；**严禁写代码**，对应 `/opsx:explore`。 |
| **openspec-propose** | `Skill(name="openspec-propose")` | 一步生成完整变更提案（proposal.md + design.md + tasks.md），对应 `/opsx:propose`。 |
| **openspec-apply-change** | `Skill(name="openspec-apply-change")` | 按 tasks.md 逐个实现任务，支持断点续传，对应 `/opsx:apply`。需 openspec CLI 环境。 |
| **openspec-archive-change** | `Skill(name="openspec-archive-change")` | 归档已完成变更，同步 Delta Specs 至主规格，对应 `/opsx:archive`。需 openspec CLI 环境。 |

## 通用规划工具

| Skill 名称 | 调用方式 | 触发条件/适用场景 |
| :--- | :--- | :--- |
| **brainstorming** | `Skill(name="brainstorming")` | **[必须]** 任何创造性工作（设计功能、构建组件）开始前，探索用户意图与技术可行性。 |
| **writing-plans** | `Skill(name="writing-plans")` | 在编写代码前，针对多步骤复杂任务制定详细的技术实现方案。 |

## 并行执行与调度

| Skill 名称 | 调用方式 | 触发条件/适用场景 |
| :--- | :--- | :--- |
| **executing-plans** | `Skill(name="executing-plans")` | 在独立会话中执行已制定的详细实现计划，按步骤推进并带审查检查点。 |
| **dispatching-parallel-agents** | `Skill(name="dispatching-parallel-agents")` | 存在 2+ 个互不依赖的独立任务时，并行分发给多个子 Agent 同时执行。 |
| **subagent-driven-development** | `Skill(name="subagent-driven-development")` | 在当前会话中使用子 Agent 执行实现计划中的独立任务。 |

## 分支与环境管理

| Skill 名称 | 调用方式 | 触发条件/适用场景 |
| :--- | :--- | :--- |
| **using-git-worktrees** | `Skill(name="using-git-worktrees")` | 开始需要隔离当前工作区的特性开发前，创建独立 Git worktree。 |
| **finishing-a-development-branch** | `Skill(name="finishing-a-development-branch")` | 实现完成、所有测试通过后，决定收尾方式（合并、PR 或清理）。 |
