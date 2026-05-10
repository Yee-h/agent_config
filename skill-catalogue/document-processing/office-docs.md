# Office 文档处理技能 (Office Document Processing)

> 适用于电子表格、Word 文档、PowerPoint 演示文稿及 PDF 文件的读写与处理场景。

| Skill 名称 | 调用方式 | 触发条件/适用场景 |
| :--- | :--- | :--- |
| **document-skills** | `Skill(name="document-skills")` | 文档处理聚合技能入口，覆盖文档创建、编辑、格式调整与常见办公文档自动化流程。 |
| **xlsx** | `Skill(name="xlsx")` | 处理电子表格文件（.xlsx, .csv, .tsv），读写、清洗、格式化、计算，或从其他数据源创建报表。 |
| **docx** | `Skill(name="docx")` | 处理 Word 文档（.docx），创建、读取、编辑，支持表格、页眉页脚、样式、目录等格式。 |
| **pdf** | `Skill(name="pdf")` | 处理 PDF 文件，读取提取文本/表格、合并拆分、旋转页面、添加水印、OCR 扫描文档。 |
| **markitdown** | `Skill(name="markitdown")` | 使用 Microsoft MarkItDown 将文件转换为 Markdown。支持 Word、PDF、PPT、Excel、HTML、图片、音频等格式，适用于文档提取、RAG 预处理、LLM 输入准备。 |
| **slides-creator** | `Skill(name="slides-creator")` | AI 幻灯片端到端生产：大纲→设计→AI 插图→可编辑 PPTX，含 18 种设计风格、3 种协作模式。 |
