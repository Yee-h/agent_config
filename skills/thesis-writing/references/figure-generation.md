# 科研图表生成 — Publication-Quality Figure Generation

为 Nature、Science、Cell、NeurIPS、ICLR、CVPR 等顶级期刊/会议生成多面板科研图表。支持 Python（matplotlib/seaborn）和 R（ggplot2/patchwork/ComplexHeatmap）。

图表是视觉论证，不是孤立的美观绘图。每张图始于论断（claim），经由证据层级（evidence hierarchy），终于评审风险评估。

## 第一道门：Figure Contract — 绘图前必须建立的契约

在写任何绘图代码之前，必须完成以下步骤：

### 0. 后端选择（阻塞关口）

**如果用户尚未明确选择 Python 或 R，必须先用一句话询问："Python 还是 R？"然后停止等待回答。**
不得默认选择、不得生成模拟数据、不得写任何绘图脚本。当用户提供明确的语言特定输入时，直接使用对应语言。

**选定的后端是排他性的**：一旦选择，所有绘图脚本、预览、SVG/PDF/TIFF/PNG 导出、QA 渲染都必须由同一后端完成。禁止交叉渲染。

### 1. 核心结论

用一句话写出图表必须捍卫的论断（claim）。图表存在的唯一理由是让这个论断清晰、可辩护、可审阅。

### 2. 证据链

将每个计划的面板映射到论断。删除不承载独特证据的面板。多面板图遵循三级信息层级：
- **Overview（概览）**：让读者快速理解全局
- **Deviation（偏差）**：展示关键差异、变化、对比
- **Relationship（关系）**：揭示变量之间的关联

任两个面板不能回答相同的科学问题。

### 3. 原型分类

将图表归入以下四种原型之一：
- `quantitative grid`：量化网格，多个同类型面板规则排列
- `schematic-led composite`：示意图为主导的复合图
- `image plate + quant`：图像板+量化面板
- `asymmetric mixed-modality figure`：非对称混合模态图

**优先一个 Hero 面板+从属证据面板**，而非将画布填满等大小的子图。

### 4. 期刊/导出契约

在样式设计前确定：最终尺寸（mm 或英寸）、文本可编辑性（SVG）、源数据追踪、统计信息、图像完整性说明、导出格式。

## Python 快速启动

```python
import matplotlib as mpl
import matplotlib.pyplot as plt

mpl.rcParams.update({
    "font.family": "sans-serif",
    "font.sans-serif": ["Arial", "Helvetica", "DejaVu Sans", "sans-serif"],
    "svg.fonttype": "none",     # SVG中文本保持为<text>节点，可编辑
    "pdf.fonttype": 42,         # PDF中可编辑TrueType文本
    "font.size": 7,             # 期刊标准字号；15-24仅用于大型幻灯片面板
    "axes.spines.right": False,
    "axes.spines.top": False,
    "axes.linewidth": 0.8,
    "legend.frameon": False,
})

def save_pub_py(fig, filename, dpi=600):
    """出版级导出：SVG(主)+PDF+TIFF"""
    fig.savefig(f"{filename}.svg", bbox_inches="tight")
    fig.savefig(f"{filename}.pdf", bbox_inches="tight")
    fig.savefig(f"{filename}.tiff", dpi=dpi, bbox_inches="tight")
```

`text.usetex = True` 仅在 LaTeX 已安装且需要数学密集型标签时使用。

**Python 独占规则**：用户选择 Python 后，所有绘图/预览/导出/QA 必须用 Python 完成。不得调用 R/ggplot2/ComplexHeatmap/patchwork 或任何 R 图形设备。若 Python 或所需包缺失，停止并报告缺失依赖。

## R 快速启动

```r
library(ggplot2)
library(patchwork)

theme_set(
  theme_classic(base_size = 6.5, base_family = "Arial") +
    theme(
      axis.line = element_line(linewidth = 0.35, colour = "black"),
      axis.ticks = element_line(linewidth = 0.35, colour = "black"),
      legend.title = element_text(size = 6.2),
      legend.text = element_text(size = 5.8),
      strip.text = element_text(size = 6.2, face = "bold"),
      plot.title = element_text(size = 7, face = "bold"),
      panel.grid = element_blank()
    )
)

save_pub_r <- function(plot, filename, width_mm = 183, height_mm = 120, dpi = 600) {
  w <- width_mm / 25.4; h <- height_mm / 25.4
  svglite::svglite(paste0(filename, ".svg"), width = w, height = h)
  print(plot); dev.off()
  grDevices::cairo_pdf(paste0(filename, ".pdf"), width = w, height = h, family = "Arial")
  print(plot); dev.off()
  ragg::agg_tiff(paste0(filename, ".tiff"), width = w, height = h, units = "in", res = dpi)
  print(plot); dev.off()
}
```

## 调色板纪律

### 核心原则
- **统一方法类群**：跨所有面板使用一致的颜色映射方法类群，而非最大化色调分离
- **每张图一个约束调色板**：通常一个中性色系+一个信号色系+一个强调色系
- **语义化用色**：绿色/红色主要用于增益/下降/方向性信号

### Python 调色板（详情见 `references/nature-figure-api.md`）
```python
PALETTE = {
    "proposed": "#E64B35",     # 红色信号 — 提出方法
    "baseline": "#4DBBD5",     # 蓝色 — 基线方法
    "ablation": "#00A087",     # 绿色 — 消融变体
    "oracle": "#F39B7F",       # 暖色 — 上界
    "human": "#3C5488",        # 深蓝 — 人类水平
}
PALETTE_NMI_PASTEL = { ... }  # 低饱和度版本，用于Nature Machine Intelligence密集页面
```

### R 调色板
使用 `scale_color_manual(values = ...)` 和 `scale_fill_manual(values = ...)`。

## 版面与布局

### 字体大小层级
- `panel label (a, b, c)`：9pt 加粗
- `axis title`：7pt
- `axis tick labels`：6pt
- `legend title`：6.2pt
- `legend text`：5.8pt
- `bar/value text`：5.5pt

### 图例纪律
- 默认关闭图例边框（`legend.frameon = False`）
- 空间允许时用直接标签代替图例
- 多面板共享图例时，创建一个专用的图例面板（legend-only axis）
- 不要每面板重复图例

### Nature 页面原型
- **两栏（~85mm）**：小型独立图表的标准宽度
- **1.5栏（~120mm）**：包含多个子面板的中型图表
- **全宽（~183mm）**：大型综合多面板图
- **选择依据**：面板密度、数据维度、论文的视觉论证需求

### 面板标注与间距
- 面板标签放在左上角，使用 `(a)`、`(b)`、`(c)` 格式
- 面板间距使用 `wspace=0.25`、`hspace=0.3` 左右
- 用留白分隔视觉角色，而非构建对称网格

### 常见布局模式
- **Ultra-wide 多指标面板**：横向柱状图+右侧独立图例面板（比例 75:25）
- **Hero 面板+量化行**：一个大型示意/图像面板占上方 60%，下方一行 2-3 个量化子图
- **暗色图像板**：仅用于显微成像/体积渲染；普通图表保持白色背景
- **临床三联面板**：experiment → result → quantification（左中右）

详细模式见 `references/nature-figure-design.md` 和 `references/nature-figure-api.md`。

## 反冗余检查

多面板图提交前检查：
1. 每个面板是否承载了独特证据？（删除重复面板）
2. 面板是否按 Overview → Deviation → Relationship 顺序排列？
3. 是否每个面板都直接支持核心论断？
4. 是否存在可以合并的冗余标签或图例？

## 图表类型支持

本场景支持 10 大类学术图表：

| 分类 | 类型 | 指导文件 |
|------|------|----------|
| 柱状图 | 分组柱、堆叠柱、横向消融柱、对数柱 | `references/nature-figure-api.md` |
| 折线/趋势 | 趋势线、带置信区间、带事件标注 | `references/nature-figure-api.md` |
| 热力图 | 顺序热力、发散Z-score热力 | `references/nature-figure-api.md` |
| 散点/气泡 | 散点图、颜色编码气泡图 | `references/nature-figure-api.md` |
| 雷达/极坐标 | 雷达图、自定义辐条 | `references/nature-figure-api.md` |
| 分布 | 小提琴图、箱线图 | `references/nature-figure-api.md` |
| 森林/区间 | 森林图、效应量区间 | `references/nature-figure-api.md` |
| 面积/堆叠 | 填充区域、图案填充 | `references/nature-figure-api.md` |
| 图像板 | 暗色图像板+重复视图 | `references/nature-figure-api.md` |
| 网络/矩阵 | GridSpec多面板布局 | `references/nature-figure-api.md` |

## 默认操作立场

- 优先直接标签而非图例（当类别空间固定或图例会强制不必要的视线移动时）
- 统计信息、样本量 n、误差线定义、源数据溯源、图像完整性说明是图表的一部分，不是可选的图注清理项
- 当用户请求通用 Nature 风格（非 ML/NMI 特定风格）时，先查阅 `references/nature-figure-design.md`
- 保持隐私：不对外暴露私有路径、模板名称、内部工作材料出处

## 何时使用本场景 vs 场景13（图表类型推荐）

- **本场景（12）**：用户要求完整生成图表代码、需要 SVG/PDF 导出、需要多面板布局、有明确的出版目标
- **场景13**：用户只需要图表类型建议、视觉设计规范说明，不需要完整代码

## 输出格式

1. **Figure Contract**：核心结论 + 证据链 + 原型 + 导出规格
2. **绘图代码**：完整可运行的 Python/R 代码
3. **导出文件**：SVG（主）+ PDF + TIFF（300dpi+）
4. **QA 注解**：统计信息、误差线定义、样本量、图像完整性说明

## 深度辅助参考

按需加载：
- `references/nature-figure-design.md` — 图表设计理论：排版、配色、布局、导出策略
- `references/nature-figure-api.md` — Python 绘图 API：调色板字典、辅助函数、验证规则、图表类型代码
- `references/nature-figure-contract.md` — Figure Contract 模板和反冗余检查清单
- `references/nature-figure-backend.md` — Python/R 后端选择决策表
- `references/nature-figure-qa.md` — 针对各期刊的提交前/修订后 15 项 QA 检查清单
