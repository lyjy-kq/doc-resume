# ====================================
# LaTeX 简历项目 Makefile（扁平化结构）
# ====================================

# 查找所有源文件
SRC_INTERNSHIP = $(wildcard src/internship/*.tex)
SRC_POSTGRADUATE = $(wildcard src/postgraduate/*.tex)
SRC_BASE = $(wildcard src/base/*.tex)

# 生成对应的PDF文件名（输出到build目录）
PDFS_INTERNSHIP = $(patsubst src/%.tex,build/%.pdf,$(SRC_INTERNSHIP))
PDFS_POSTGRADUATE = $(patsubst src/%.tex,build/%.pdf,$(SRC_POSTGRADUATE))
PDFS_BASE = $(patsubst src/%.tex,build/%.pdf,$(SRC_BASE))

ALL_PDFS = $(PDFS_INTERNSHIP) $(PDFS_POSTGRADUATE) $(PDFS_BASE)

# 默认目标：编译所有PDF
all: $(ALL_PDFS)

# 编译单个PDF文件（输出到build目录）
build/%.pdf: src/%.tex | build
	@echo "正在编译: $<"
	cd src/$(dir $*) && xelatex -output-directory=../../build/$(dir $*) $(notdir $<)
	cd src/$(dir $*) && xelatex -output-directory=../../build/$(dir $*) $(notdir $<)
	@echo "编译完成: $@"

# 创建build目录结构
build:
	@echo "创建输出目录..."
ifeq ($(OS),Windows_NT)
	-@if not exist "build\internship" mkdir "build\internship"
	-@if not exist "build\postgraduate" mkdir "build\postgraduate"
	-@if not exist "build\base" mkdir "build\base"
else
	@mkdir -p build/internship build/postgraduate build/base
endif

# 快捷目标：只编译实习类简历
internship: $(PDFS_INTERNSHIP)

# 快捷目标：只编译推免类简历
postgraduate: $(PDFS_POSTGRADUATE)

# 快捷目标：只编译基础模板
base: $(PDFS_BASE)

# 清理编译产生的中间文件和PDF
clean:
	@echo "清理编译文件..."
ifeq ($(OS),Windows_NT)
	-@if exist "build" rd /s /q "build"
else
	@rm -rf build
endif
	@echo "清理完成！"

# 查看帮助信息
help:
	@echo "====================================="
	@echo " LaTeX 简历项目 Makefile 使用说明"
	@echo "====================================="
	@echo ""
	@echo "可用目标："
	@echo "  make all          - 编译所有简历（默认）"
	@echo "  make internship   - 只编译实习类简历"
	@echo "  make postgraduate - 只编译推免类简历"
	@echo "  make base         - 只编译基础模板"
	@echo "  make clean        - 清理所有编译文件"
	@echo "  make help         - 显示此帮助信息"
	@echo ""
	@echo "编译输出目录: build/"
	@echo "源文件目录:   src/"
	@echo ""

.PHONY: all clean help internship postgraduate base

