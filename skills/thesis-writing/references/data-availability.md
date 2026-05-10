# 数据可用性声明 — Data Availability Statement (Nature/Springer Nature)

为 Nature 系列期刊和 Springer Nature 投稿撰写合规的数据可用性声明，支持中英双语输入。

源自 Springer Nature 研究数据政策、Nature Portfolio 报告标准、Scientific Data 仓储与引用实践、FAIR 指导原则及 DataCite 元数据规范。

## 核心原则

1. 将每份支撑研究结果的数据集映射到可持久访问的路径
2. 优先推荐学科专属或受命定的仓储平台（配持久标识符）
3. 受限数据须说明限制原因、管控方、审查途径和访问条件
4. 公开数据集需按 DataCite 格式引用（创建者、标题、仓储名、年份、标识符）
5. 区分数据（data）、代码（code）、材料（materials）和实验方案（protocols），除非期刊要求合并声明
6. 标记"available upon request"为弱声明，除非有具体法律/伦理/商业/第三方限制

## 中英双语工作模式

当用户使用中文输入、提供中文稿备忘录、或请求"数据可用性声明""数据获取声明""原始数据""数据存储库""受限数据"时：

- 自然接受中文输入，但最终提交声明以英文起草（除非用户明确要求仅中文）
- 附加简短的中文解释来说明尚未解决的决策（帮助作者行动时使用）
- 翻译意图而非字面：中文短语如"可向通讯作者索取"通常对 Nature 风格英文来说过于模糊，需补充限制条件和访问流程
- 精准转换中文仓储/状态描述：`数据可用性声明`→`Data Availability`；`原始数据`→`raw data`；`处理后数据`→`processed data`；`源数据`→`source data`；`补充材料`→`Supplementary Information`；`受限数据`→`restricted data`；`合理请求`→`reasonable request`

## 工作流

1. 识别目标期刊和文章类型。若期刊特定指令与此技能冲突，以期刊为准。
2. 逐项盘点支撑主文和补充材料所有结果所需的数据集：生成的原始数据、处理后数据、图表源数据、二次数据、软件输出、模型、表格、图像和统计分析的基础文件。
3. 为每个数据集分配访问路径类别：
   - `public repository`（公开仓储）
   - `controlled access repository`（受控访问仓储）
   - `within paper or supplement`（论文或补充材料内）
   - `reused public source`（复用的公开来源）
   - `third-party restricted`（第三方限制）
   - `available on justified request`（经合理申请可获取）
   - `not applicable`（不适用）
4. 在起草文本前选择仓储和标识符策略。优先 DOI、accession number、Handle、ARK 或稳定的仓储记录，而非个人网站和临时云链接。
5. 起草数据可用性声明，使用显式的"数据集-位置"映射。
6. 为支撑结论的公开数据添加正式的数据集引用。
7. 在定稿前运行 FAIR 和元数据审计。
8. 返回可直接粘贴的声明文本及作者需要确认的未决字段。

## 输出格式

（除非用户要求其他格式）

```text
Data Availability
[可直接粘贴的声明文本]

Repository and citation actions
- [具体操作列表或 "None"]

Missing information / risk flags
- [具体标记或 "None"]

中文核对
- [用中文列出作者需要确认的字段或 "无"]
```

审计现有声明时，先列出阻塞性问题，再提供修订版本。

## 深度辅助参考

按需加载：
- `references/nature-data-policy.md` — Nature/Springer Nature 数据共享政策原文解读：七种访问路径、敏感数据规则、提交阶段检查
- `references/nature-data-patterns.md` — 11 种场景的声明模板（中英双语）：公开单一/多仓储、仅补充材料、复用公开数据、混合数据、受控访问、第三方限制、商业敏感、禁运、合理申请、无数据
- `references/nature-data-fair.md` — FAIR 审计清单：Findable/Accessible/Interoperable/Reusable 四维度检查，DataCite 核心字段，README 模板，文件组织规则
