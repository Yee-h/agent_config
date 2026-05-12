---
name: tavily-web-search
description: |
  专为LLM设计的网络搜索skill，当用户提到搜索、查资料、找文章、提取网页内容、爬取网站、获取 URL 列表、深度调研、写研究报告、获取最新资讯新闻、或使用 /tavily-* 命令时使用。即使用户没有明确说"搜索"，只要涉及从互联网获取信息、验证事实、了解市场动态、收集竞品情报、构建需要实时数据的应用，都应使用此技能。支持中文和英文查询。
  Triggers: 搜索、查、找、提取、爬取、地图、研究、调研、报告、新闻、资讯、最新、网址
allowed-tools: Bash(tvly *)
---

# Tavily Web Search

通过 Tavily CLI (`tvly`) 提供全部网络能力：搜索、提取、爬取、地图、研究。

## 前置条件

确保 `tvly` 已安装并在 PATH 中：

```bash
tvly --version
```

如需安装：`pip install tavily-cli`。API Key 通过系统环境变量 `TAVILY_API_KEY` 配置。

### CLI 管理

```bash
tvly --version            # 查看版本
tvly --status --json      # 查看版本+认证状态
tvly auth --json          # 检查认证状态
tvly login --api-key tvly-xxx  # 登录（API Key 方式）
tvly logout               # 清除登录凭证
```

交互模式：直接运行 `tvly` 进入 REPL，无需 `tvly` 前缀即可执行命令。

### Stdin 输入

所有命令支持从 stdin 读取查询：

```bash
echo "query" | tvly search - --json
echo "topic" | tvly research - --json
```

### 卸载

```bash
pip uninstall tavily-cli
rm -rf ~/.tavily ~/.mcp-auth  # 清除凭证
```

## 渐进式决策树

根据用户需求选择最适合的子能力：

| 用户说... | 你需要的子能力 | 跳转 |
|-----------|---------------|------|
| "搜索一下..."、"找找关于..."、"/tavily-search" | **搜索** — 查找网络信息 | [→ 搜索](#搜索) |
| "提取这个URL的内容"、"获取这个页面的..."、"/tavily-extract" | **提取** — 从指定 URL 获取清洁内容 | [→ 提取](#提取) |
| "爬取这个网站"、"下载整个文档站"、"/tavily-crawl" | **爬取** — 爬取整个网站 | [→ 爬取](#爬取) |
| "列出这个站点的所有URL"、"看看网站结构"、"/tavily-map" | **地图** — 发现站点 URL | [→ 地图](#地图) |
| "深入研究..."、"写一份报告"、"调研一下"、"/tavily-research" | **研究** — AI 深度调研生成报告 | [→ 研究](#研究) |
| "构建一个 Tavily 集成"、"最佳实践"、"/tavily-best-practices" | **最佳实践** — 生产集成参考 | [→ 最佳实践](#最佳实践) |

## 搜索

```bash
tvly search "你的查询" --json
```

### 选项

| 选项 | 说明 |
|------|------|
| `--depth` | `ultra-fast`, `fast`, `basic`(默认), `advanced` |
| `--max-results` | 结果数 0-20（默认 5） |
| `--topic` | `general`(默认), `news`, `finance` |
| `--time-range` | `day`, `week`, `month`, `year` |
| `--include-domains` | 仅包含指定域名（逗号分隔） |
| `--exclude-domains` | 排除指定域名 |
| `--start-date` | 结果起始日期（YYYY-MM-DD） |
| `--end-date` | 结果截止日期（YYYY-MM-DD） |
| `--include-answer` | 包含 AI 摘要（`basic` / `advanced`） |
| `--include-raw-content` | 包含完整页面内容（`markdown` / `text`） |
| `--include-images` | 包含图片结果 |
| `--include-image-descriptions` | 包含 AI 图片描述 |
| `--chunks-per-source` | 每个来源 chunk 数（advanced/fast depth） |
| `--country` | 指定国家代码 |
| `-o, --output` | 保存输出到文件 |
| `--json` | JSON 输出 |

### 示例

```bash
# 新闻搜索
tvly search "AI regulations" --topic news --time-range week --json

# 指定域名搜索
tvly search "SEC filings" --include-domains sec.gov --json

# 带 AI 答案
tvly search "quantum computing" --depth advanced --include-answer basic --json

# 读取 stdin
echo "query" | tvly search - --json

# 日期范围搜索
tvly search "AI news" --start-date 2025-01-01 --end-date 2025-04-01 --json

# 保存到文件
tvly search "AI news" -o results.json --json

# 带 AI 图片描述
tvly search "sunset photos" --include-images --include-image-descriptions --json
```

## 动态搜索

根据用户查询自动选择最优搜索参数，无需手动指定。

### 自动决策

| 用户意图 | 推荐 depth | 推荐 topic | 说明 |
|----------|-----------|-----------|------|
| 快速查定义、查事实 | `fast` | `general` | 速度优先，适合常识性问题 |
| 一般信息查找 | `basic` | `general` | 默认，平衡速度与质量 |
| 精确查找特定信息 | `advanced` | `general` | 深度更高，适合专业问题 |
| 获取最新新闻动态 | `basic` | `news` | 结合 `--time-range week` 使用 |
| 金融/市场数据 | `basic` | `finance` | 返回财经优化结果 |
| 需要 AI 总结 | `basic` / `advanced` | 匹配 topic | 添加 `--include-answer basic` |

### 通用模式

```bash
# 快速事实查询
tvly search "query" --depth fast --max-results 3 --json

# 默认查询
tvly search "query" --json

# 精确深度查询
tvly search "query" --depth advanced --max-results 10 --json

# 新闻查询（最近一周）
tvly search "query" --topic news --time-range week --json
```

## 提取

```bash
tvly extract <url> [<url> ...]
```

### 选项

| 选项 | 说明 |
|------|------|
| `--query` | 按相关性筛选 chunks |
| `--chunks-per-source` | 每个 URL 的 chunk 数 1-5（需 `--query`） |
| `--extract-depth` | `basic`(默认), `advanced` |
| `--format` | `markdown`(默认), `text` |
| `--include-images` | 包含图片 |
| `--timeout` | 1-60 秒 |
| `-o, --output` | 保存输出到文件 |
| `--json` | JSON 输出 |

### 示例

```bash
tvly extract https://example.com/article --json
tvly extract https://docs.python.org --query "list comprehensions" --chunks-per-source 3 --json
tvly extract https://spa-app.com --extract-depth advanced --json
```

## 爬取

```bash
tvly crawl <url>
```

### 选项

| 选项 | 说明 |
|------|------|
| `--max-depth` | 爬取深度 1-5（默认 1） |
| `--max-breadth` | 每页最多链接数（默认 20） |
| `--limit` | 总页面上限（默认 50） |
| `--instructions` | 自然语言爬取指导 |
| `--chunks-per-source` | 每页 chunk 数（需 `--instructions`） |
| `--extract-depth` | `basic`(默认), `advanced` |
| `--format` | `markdown`(默认), `text` |
| `--select-paths` | 仅爬特定路径（正则，逗号分隔） |
| `--exclude-paths` | 排除特定路径（正则） |
| `--select-domains` | 仅包含匹配域名（正则） |
| `--exclude-domains` | 排除匹配域名（正则） |
| `--allow-external` | 包含外部域名链接 |
| `--include-images` | 包含图片 |
| `--timeout` | 超时秒数 10-150（默认 150） |
| `--output-dir` | 每页保存为独立 .md 文件 |
| `-o, --output` | 保存 JSON 输出到文件 |
| `--json` | JSON 输出 |

### 示例

```bash
tvly crawl https://docs.example.com --max-depth 2 --limit 50 --json
tvly crawl https://docs.example.com --select-paths "/api/.*" --json
tvly crawl https://docs.example.com --instructions "find authentication docs" --chunks-per-source 3 --json
tvly crawl https://docs.example.com --output-dir ./docs-mirror

# 域名过滤 + 超时控制
tvly crawl https://example.com --select-domains "docs\\.example\\.com" --exclude-paths "/blog/.*" --timeout 60 --json

# 保存到文件
tvly crawl https://docs.example.com -o crawl-results.json --json
```

## 地图

```bash
tvly map <url>
```

### 选项

| 选项 | 说明 |
|------|------|
| `--max-depth` | 发现深度 1-5（默认 1） |
| `--max-breadth` | 每页最多链接数（默认 20） |
| `--limit` | 最大 URL 数（默认 50） |
| `--instructions` | 自然语言发现指导 |
| `--select-paths` | 仅含匹配路径 |
| `--exclude-paths` | 排除匹配路径 |
| `--select-domains` | 仅包含匹配域名（正则） |
| `--exclude-domains` | 排除匹配域名（正则） |
| `--allow-external` | 包含外部域名链接 |
| `--timeout` | 超时秒数 10-150（默认 150） |
| `-o, --output` | 保存输出到文件 |
| `--json` | JSON 输出 |

### 示例

```bash
tvly map https://docs.example.com --json
tvly map https://docs.example.com --select-paths "/api/.*" --limit 200 --json
tvly map https://docs.example.com --instructions "find API docs" --json

# 域名过滤
tvly map https://example.com --select-domains "docs\\.example\\.com" --limit 100 --json

# 外部链接 + 超时控制
tvly map https://example.com --allow-external --timeout 30 --json

# 保存到文件
tvly map https://docs.example.com -o sitemap.json --json
```

## 研究

```bash
tvly research "你的研究主题"
```

### 选项

| 选项 | 说明 |
|------|------|
| `--model` | `mini`, `pro`, `auto`(默认) |
| `--stream` | 实时流式输出 |
| `--no-wait` | 异步启动，返回 request_id |
| `--citation-format` | `numbered`, `mla`, `apa`, `chicago` |
| `--output-schema` | 结构化输出 JSON Schema 文件 |
| `-o, --output` | 保存报告到文件 |

### 子命令

```bash
tvly research run "topic"          # 启动研究
tvly research status <request_id>  # 查询状态
tvly research poll <request_id>    # 轮询等待完成
```

### 示例

```bash
# 快速研究
tvly research "React vs Vue 2026" --model mini --json

# 深度研究 + 保存报告
tvly research "AI impact on healthcare" --model pro -o report.md --json

# 流式研究
tvly research "quantum computing" --stream --json
```

## 最佳实践

`/tavily-best-practices` — 生产级 Tavily 集成的最佳实践参考。

典型场景：
- 为内部聊天机器人添加实时搜索能力
- 构建潜在客户信息丰富工具
- 创建新闻监测与情感分析面板
- 实现竞品情报自动化监测

使用时直接描述你要构建的内容，Agent 会生成带最佳实践的代码：

```bash
/tavily-best-practices 构建一个集成 Tavily 搜索的内部聊天机器人
```

## 常见错误

| 错误 | 原因 | 修复 |
|------|------|------|
| `Error: Got unexpected extra argument` | 查询未用引号包裹，多词被拆为多个参数 | `tvly search "完整查询语句"` |
| `Error: No Tavily API key found` | 环境变量 `TAVILY_API_KEY` 未设置或未生效 | 检查系统环境变量配置 |
| `UnicodeEncodeError: 'gbk'` | Windows 控制台编码问题 | 添加 `--json` 参数 |
| 查询过长无结果 | 搜索查询建议 < 400 字符 | 拆分为多个子查询 |
| map/crawl 返回空结果 | 目标站无子页面或入口页受限 | 换用更具体的入口 URL |
