# 审查与调试技能 (Review & Debugging)

> 适用于代码审查、代码重构、系统化调试及提交前质量验证等场景。

| Skill 名称 | 调用方式 | 触发条件/适用场景 |
| :--- | :--- | :--- |
| **brooks-lint** | `Skill(name="brooks-lint")` | **[深度审查]** 基于六本经典工程书籍的代码质量诊断：PR 审查、架构审计、技术债评估、测试质量审查。 |
| **requesting-code-review** | `Skill(name="requesting-code-review")` | 完成主要功能或合并前，发起代码审查，验证实现是否满足要求。 |
| **receiving-code-review** | `Skill(name="receiving-code-review")` | 接收代码审查反馈时，在实施修改前进行技术验证，避免盲目接受建议。 |
| **systematic-debugging** | `Skill(name="systematic-debugging")` | 遇到 Bug、测试失败或意外行为时，系统化排查根因（假设→验证→修复）。 |

| **verification-before-completion** | `Skill(name="verification-before-completion")` | **[关键]** 任务完成前，运行验证命令并确认输出，证据确凿后再声明完成。 |
