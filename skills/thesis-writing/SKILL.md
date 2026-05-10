---
name: thesis-writing
description: "AI 学术论文写作助手，覆盖论文全生命周期 20 个核心场景：英文学术润色（Nature 期刊级深度架构——论文类型识别、沙漏结构、章节职责、句长≤30词、hedging 校准、英式英语、overclaim 检测、引用伦理、AI 使用边界）、中文润色、中英互译、篇幅调整（缩写/扩写）、逻辑检查、去 AI 味（LaTeX 英文/Word 中文）、论文架构图、科研图表生成（Nature/Science/Cell 级多面板图、Figure Contract 先于代码、Python/R 后端、语义调色板、SVG/PDF/TIFF 导出）、图表类型推荐、图表标题生成、实验数据分析、Reviewer 视角审视、数据可用性声明（Nature/Springer Nature FAIR 合规）、论文转 PPT（中文汇报课件）、模型选择。每个场景均由顶尖研究机构（MSRA、ByteDance Seed、上海 AI Lab）一线研究员实战打磨，并融合 Nature 期刊论文写作课程与 Academic Phrasebank 短语体系。触发词包括：论文润色、学术写作、中转英、英转中、缩写、扩写、去AI味、论文架构图、实验分析、Reviewer审稿、LaTeX润色、academic writing、polish、proofread、figure caption、table caption、experiment analysis、Nature figure、publication plot、scientific figure、科研绘图、Data Availability、数据可用性声明、paper PPT、journal club、文献汇报、论文做成PPT。当用户提到任何与学术论文写作、润色、翻译、去AI痕迹、实验图表、数据声明、论文汇报相关的需求时，都应使用此 skill。"
---

# Academic Research Writing — 学术论文写作助手

源自 MSRA、ByteDance Seed、上海 AI Lab 等顶尖研究机构一线研究员的实战经验，并融合 Nature 期刊写作课程（Scientific English Writing & Communication）、Academic Phrasebank 短语体系、Springer Nature 数据政策及 Nature 期刊图表规范。覆盖论文写作全流程 20 个核心场景，渐进式加载，深度可调。

## 使用流程

1. 识别用户的写作需求，匹配下方场景路由表
2. 读取对应的 `references/<file>.md` 获取完整 prompt 指令
3. 部分场景支持加载更深层的辅助参考文件（在 prompt 中指明），按提示按需打开
4. 将用户提供的文本作为 Input，按 prompt 规定的输出格式返回结果

## 场景路由表

| # | 场景 | 触发条件 | 参考文件 |
|---|------|----------|----------|
| 1 | **中转英** | 用户提供中文草稿，要求翻译为英文学术论文 LaTeX | `references/zh-to-en.md` |
| 2 | **英转中** | 用户提供英文 LaTeX，要求翻译为中文便于理解 | `references/en-to-zh.md` |
| 3 | **中转中** | 用户提供中文草稿，要求重写为学术规范的中文段落（Word 场景） | `references/zh-to-zh.md` |
| 4 | **缩写** | 用户要求微幅减少英文文本字数（约 5-15 词） | `references/condense.md` |
| 5 | **扩写** | 用户要求微幅增加英文文本字数（约 5-15 词） | `references/expand.md` |
| 6 | **英文润色** | 用户要求对英文论文进行深度表达润色（含 Nature 级深度架构：论文类型识别、沙漏结构、章节职责、句长控制、hedging、overclaim 检测、引用伦理） | `references/polish-en.md` |
| 7 | **中文润色** | 用户要求对中文论文进行专业润色（Word 场景，含结构性写作原则） | `references/polish-zh.md` |
| 8 | **逻辑检查** | 用户要求对终稿进行一致性与逻辑核对 | `references/logic-check.md` |
| 9 | **去 AI 味（英文）** | 用户要求去除英文文本的 AI 生成痕迹 | `references/deai-latex-en.md` |
| 10 | **去 AI 味（中文）** | 用户要求去除中文文本的 AI 生成痕迹（Word 场景） | `references/deai-word-zh.md` |
| 11 | **论文架构图** | 用户要求根据方法描述生成学术架构图 | `references/architecture-diagram.md` |
| 12 | **科研图表生成** | 用户要求生成 Nature/Science/Cell 级多面板科研图表（含 Figure Contract、Python/R 后端、调色板、出版级导出） | `references/figure-generation.md` |
| 13 | **图表类型推荐** | 用户提供实验数据，要求推荐最佳图表类型（轻量级，不含完整绘图代码） | `references/chart-recommendation.md` |
| 14 | **图标题** | 用户要求生成符合顶会/顶刊规范的英文 figure caption | `references/figure-caption.md` |
| 15 | **表标题** | 用户要求生成符合顶会/顶刊规范的英文 table caption | `references/table-caption.md` |
| 16 | **实验分析** | 用户提供实验数据，要求写出 LaTeX 分析段落（含 Results/Discussion 区分、hedging 校准） | `references/experiment-analysis.md` |
| 17 | **Reviewer 审视** | 用户要求以审稿人视角全面评估论文（含 overclaim 检测、证据门槛评估） | `references/reviewer-perspective.md` |
| 18 | **数据可用性声明** | 用户要求撰写 Nature/Springer Nature 合规的数据可用性声明、FAIR 元数据审计、仓库规划（支持中英双语） | `references/data-availability.md` |
| 19 | **论文转 PPT** | 用户要求将科学论文转化为中文 PPTX 汇报课件（期刊俱乐部/组会/文献分享） | `references/paper-to-ppt.md` |
| 20 | **模型选择** | 用户询问学术写作/代码场景下的模型推荐 | `references/model-selection.md` |

## 关键规范

以下规范贯穿所有场景，无需重复加载：

- **LaTeX 转义**：特殊字符必须转义（`95%` → `95\%`，`model_v1` → `model\_v1`，`R&D` → `R\&D`）
- **时态**：一般现在时描述方法/结论；Results 用过去时报告观察结果；Discussion 用现在时+hedging 解释含义
- **禁止列表化**：拒绝 `\item` 列表，保持连贯段落
- **去格式修饰**：不使用加粗、斜体、引号（除非原文已有）
- **去破折号**：尽量不使用 em-dash（—），用从句或同位语替代
- **引用顺序**：参考文献必须按递增顺序出现，如 `[1][2][3]`，禁止 `[1][12][2][3]` 等乱序引用
- **英式拼写**：英文输出统一英式英语（signalling、colour、analyse、programme、behaviour）

## 深度辅助参考文件

以下文件提供更深层的写作与图表支持，在对应场景的 prompt 中按需加载：

| 文件 | 使用场景 | 来源 |
|------|----------|------|
| `references/nature-writing-strategy.md` | 需要高级写作逻辑：沙漏结构、写作顺序、论断-证据-边界框架 | Nature Polishing |
| `references/nature-section-moves.md` | 需要章节级短语模式：Introduction/Results/Discussion 各段落功能与句式 | Academic Phrasebank |
| `references/nature-phrasebank.md` | 需要短语级支持：hedging、转折、证据强度、局限/前瞻用语 | Academic Phrasebank |
| `references/nature-style-guardrails.md` | 需要格式检查：学术风格、英式拼写、数字/单位、句长/段落检查 | Nature Polishing |
| `references/nature-figure-design.md` | 需要图表设计理论：排版、配色、布局、多面板信息架构、导出规范 | Nature Figure |
| `references/nature-figure-api.md` | 需要 Python 绘图 API：调色板、辅助函数签名、验证规则 | Nature Figure |
| `references/nature-figure-contract.md` | 需要在绘图前建立 Figure Contract：核心结论、证据链、原型分类 | Nature Figure |
| `references/nature-figure-backend.md` | 需要 Python/R 后端选择决策与互斥规则 | Nature Figure |
| `references/nature-figure-qa.md` | 需要在交付前做图表 QA：15项检查清单、统计说明、图像完整性 | Nature Figure |
| `references/nature-data-policy.md` | 需要 Nature/Springer Nature 数据共享政策原文解读 | Nature Data |
| `references/nature-data-patterns.md` | 需要数据可用性声明模板（11 种场景，中英双语） | Nature Data |
| `references/nature-data-fair.md` | 需要 FAIR 元数据检查清单与 DataCite 规范 | Nature Data |

## 多场景组合

用户可能一次请求涉及多个场景（如"先翻译再润色"）。此时按顺序依次加载对应 reference 执行，将上一步输出作为下一步输入。
