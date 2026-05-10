# 子 Agent 工具 (Subagent Tools)

> 通过 `Task(subagent_type=...)` 调用的内置子 Agent，用于在指定阶段委托专项任务。
> 与 `Skill(name=...)` 不同，这些 Agent 在独立上下文中运行，不共享当前会话状态。

| Subagent 名称 | 调用方式 | 触发条件/适用场景 |
| :--- | :--- | :--- |
| **architect** | `Task(subagent_type="architect")` | 从零设计项目架构，输出架构方案、ADR、模块划分、技术选型、数据流设计。 |
| **code-simplifier** | `Task(subagent_type="code-simplifier")` | TDD 的 **Refactor** 阶段，或代码逻辑过于复杂时。简化代码结构、提升可读性，**严禁改变原有逻辑或破坏测试**。 |
| **code-reviewer** | `Task(subagent_type="code-reviewer")` | **[强制]** **Verification** 阶段，提交代码之前。审查实现是否符合 PRD 要求、安全规范及项目风格。 |
| **debug-agent** | `Task(subagent_type="debug-agent")` | 通过日志分析、堆栈跟踪、复现步骤和二分法定位根因。**只读分析，不修改代码**。 |
| **doc-writer** | `Task(subagent_type="doc-writer")` | **[推荐]** **Delivery** 阶段，代码提交后。自动扫描代码，更新技术文档，确保文档与代码同步。 |
| **performance-analyst** | `Task(subagent_type="performance-analyst")` | 分析 CPU/memory 热点、数据库查询、渲染性能、网络瓶颈、bundle 体积。**只读分析，不修改代码**。 |
| **refactoring-specialist** | `Task(subagent_type="refactoring-specialist")` | 架构模式级别的重构，识别设计模式、改善模块边界和依赖方向。`code-simplifier` 关注文件级，此 Agent 关注模块级。 |
| **security-auditor** | `Task(subagent_type="security-auditor")` | 安全审计：输入验证、认证授权、数据暴露、依赖漏洞。**只读分析，不修改代码**。 |
| **test-writer** | `Task(subagent_type="test-writer")` | 编写高质量测试用例，覆盖核心逻辑、边界条件和回归场景，遵循 TDD 最小循环。 |
