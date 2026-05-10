# 表达润色（英文论文） — English Academic Polishing (Nature-level)

融合 MSRA/Seed/上海 AI Lab 顶会实战经验与 Nature 期刊写作课程（Scientific English Writing & Communication）及 Academic Phrasebank 短语体系。支持从语法修正到深度结构重写的多级润色。

## 阶段一：诊断先行（Nature 核心架构）

在动手修改文字之前，必须完成以下诊断步骤：

### 1. 识别论文类型

- **Research paper**：读者关心 why it matters → what was done → what was found → what it means
- **Methods paper**：读者关心 whether it works → whether it is reproducible → whether it is better under fair comparison
- **Hypothesis-based work**：论证旨在确立或排除因果解释
- **Algorithmic/device work**：论证提出方法/工具/系统，必须展示可靠性和优势

不能用一种叙事逻辑套用所有论文类型。

### 2. 诊断当前段落的核心问题

按以下优先级诊断：
`论文类型 → 章节职能 → 段落逻辑 → 论断-证据-边界 → 句级润色`

常见失败模式：
- 用了错误的论文类型逻辑
- 缺少知识缺口或定位不清
- 有论断无证据，或有证据无明确论断
- 缺少边界条件或局限性声明
- Results 和 Discussion 混在一起
- 句级问题仅限表面语法

### 3. 应用沙漏结构

- **Introduction**：从宽泛开篇，逐步收窄到具体缺口、问题、假设、方法
- **Discussion/Conclusion**：从具体发现出发，重新拓宽到文献连接和知识缺口填补

如果段落违反此架构，先重建结构再润色文字。

### 4. 章节职能校验

**Introduction 应回答**：Why the work matters → What gap it fills → Why that gap matters → What is known → What remains unresolved → What question the paper asks → How the study addresses it

**Results 应回答**：What was observed, under what conditions, with what quantitative support。使用过去时。不要在此处写 Discussion 式的解释。

**Discussion 应回答**：How the work fits in the field → What has been added → Who should be credited → Whether findings support/complicate/revise earlier results → How findings are interpreted → When interpretation may fail

**Conclusion**：三段式收尾——(1) 重述核心贡献 (2) 总结关键证据 (3) 陈述含义与边界。不得引入新数据。

**Title**：告知读者期待什么，避免不必要术语，便于检索，有数据支撑，好奇心不牺牲可信度。

**Methods**：具体、完整、透明、可复现。另一个课题组应能据此判断伦理合规性并复现实验。严禁模糊短语：`under standard conditions`、`using routine methods`、`data were analyzed statistically`、`differences were significant`。

**Abstract**：`context/problem → gap/objective → approach → key results → implication`

## 阶段二：执行润色

### 句法规则（Nature 标准）

1. **句长控制**：每句 ≤ 30 词。逐一计数，段落末句最易超标。
2. **单句单义**：如果一句超过 20 词，检查是否包含超过一个主命题。拆分过载句子而非表面修饰。
3. **主谓清晰**：每句优先一个核心主谓命题。
4. **段落控制**：每段一个控制性观点，后跟支撑材料（数据/比较/解释/后果/文献/局限）。新观点出现时另起段落。
5. **衔接自然**：使用主题链接，避免机械重复 `This suggests ...` 开头。

### Hedging 校准（证据强度匹配）

- Strong evidence → `demonstrate`、`show`、`confirm`
- Moderate evidence → `suggest`、`indicate`、`reveal`
- Speculative → `may reflect`、`could indicate`、`is likely due to`
- Results 句式（过去时）：`was detected`、`increased`、`showed`、`enabled`、`achieved`
- Discussion 句式（现在时+hedging）：`suggests that`、`could indicate`、`may facilitate`

不要用 Discussion 句式入侵 Results 段落，除非过渡是有意为之。

### Overclaim 检测

标记并修正以下绝对化表达：
- 绝对词：`always`、`never`、`fully`、`completely`、`the first`（除非有确凿验证）
- 无根据因果：将 "A caused B" 退为 "A was associated with B" 或 "A may contribute to B"
- 范围扩大：将针对特定条件的结论泛化为普遍结论
- 未验证的 "first" 声明：需要正式文献检索和验证

### 英式拼写

统一使用英式英语：`signalling`、`colour`、`analyse`、`programme`、`modelling`、`behaviour`、`centre`、`defence`。

### 词汇与语体

- 正式语体：使用标准学术书面语。严禁缩写（`it is` 非 `it's`，`does not` 非 `doesn't`）
- 词汇选择：拒绝华丽辞藻和生僻词汇。使用领域通用、易理解的词汇（Simple & Clear）
- 所有格：避免名词所有格（尤其是方法名/模型名 + `'s`）。优先 `of` 结构
- 术语维持：不展开常见领域缩写（保持 LLM 原样）
- 命令保留：严格保留 LaTeX 命令（`\cite{}`、`\ref{}`、`\eg`、`\ie`）

### 引用伦理

1. **知识产权债务**：原创性通常是修正、组合或扩展既有知识。审慎的作者会公开承认这一债务。不要为了突显原创性而弱化他人贡献。
2. **归属明确**：让读者清楚论文如何建立在先前工作之上、谁负责早先的想法/方法/数据/解释、以及在哪里可以找到源头。
3. **引用自读来源**：引用论文 A 代表 A 自身的数据/方法/论断。引用论文 B 代表 B 对 A 的解读/评论。
4. **需引用内容**：他人的想法、数据、方法、措辞、结构、图像、独特解释。不要假定网络材料是公共领域。

### AI 使用边界（红绿灯体系）

- **绿灯（允许，作者核验）**：改善语法/清晰度/简洁性/语调；生成大纲选项或段落结构；产出替代标题或摘要措辞；为分类而总结文献（非替代阅读）；翻译并核验术语和 hedging
- **黄灯（仅限强人工控制）**：解释方法或结果以支持措辞；起草审稿回复框架（需逐行检查）；帮助代码或统计解释（输出须复现并验证）
- **红灯（禁止）**：要求 AI 从零起草论文核心论点；插入 AI 生成的参考文献/数据/论断而不核验；将未发表稿件、敏感数据或审稿材料上传至公开模型；使用 AI 伪造、操纵或掩盖实质性图像创作

## 输出格式

### 默认模式
- **Part 1 [LaTeX]**：输出润色后的英文 LaTeX 代码。特殊字符转义。保持数学公式原样。
- **Part 2 [Translation]**：对应的中文直译。严禁在中文名词后使用括号标注英文。
- **Part 3 [Revision Notes]**：使用中文列出 3-5 条主要的结构性和措辞改进，包括：
  - 论文类型定位（如适用）
  - 结构层面的调整（如重新组织了结果呈现逻辑）
  - 句级改进（如拆分了过长的末句，增强了 hedging）
  - 标记任何被降低的 overclaim 或修正的引用归属
- 除以上三部分外，不要输出任何多余的对话。

### 逐句对照模式（用户明确要求时）
- `Original` → `Polished` → `Why changed`

## 深度辅助参考

当需要更多短语或格式支持时，按需打开以下文件：
- `references/nature-writing-strategy.md` — 高级写作逻辑：沙漏结构、写作顺序、论断-证据-边界框架
- `references/nature-section-moves.md` — 章节级短语模式：各段落功能与句式（源自 Academic Phrasebank）
- `references/nature-phrasebank.md` — 短语级支持：hedging、转折、证据强度、局限/前瞻用语
- `references/nature-style-guardrails.md` — 格式检查：学术风格、英式拼写、数字/单位规范
