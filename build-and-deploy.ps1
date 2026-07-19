# ============================================================================
# HarmonyOS 一键构建部署 -- kouol
#
# 用法：
#   .\build-and-deploy.ps1            仅构建
#   .\build-and-deploy.ps1 -Deploy    构建 + 安装到设备 + 启动应用
# ============================================================================
param([switch]$Deploy)

$ErrorActionPreference = "Stop"

# ============================================================================
# 项目配置
# ============================================================================

# 项目根目录（硬编码，避免 $PSScriptRoot 在某些环境下为 null）
$PROJECT_ROOT = "D:\Users\beart\code\kouol"

# --- 加载本地环境配置 ---
# env/.env 包含本机路径和敏感信息（不提交），env/.env.example 是模板
$envFile = Join-Path $PROJECT_ROOT "env\.env"
if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        $line = $_.Trim()
        if ($line -and -not $line.StartsWith("#")) {
            $idx = $line.IndexOf("=")
            if ($idx -gt 0) {
                $key = $line.Substring(0, $idx).Trim()
                $val = $line.Substring($idx + 1).Trim()
                if ($val) { [System.Environment]::SetEnvironmentVariable($key, $val, "Process") }
            }
        }
    }
} else {
    Write-Host "WARNING: env\.env not found. Copy env\.env.example to env\.env and fill in values." -ForegroundColor Yellow
}

# DevEco Studio 安装路径（优先从 env/.env 读取，兜底默认值）
$DEVETOOLS   = if ($env:DEVETOOLS_HOME) { $env:DEVETOOLS_HOME } else { "D:\Program Files\Huawei\DevEco Studio" }
$SDK_TOOLS   = "$DEVETOOLS\sdk\default\openharmony\toolchains"
$OHPM_BIN    = "$DEVETOOLS\tools\ohpm\bin"
$NODE_BIN    = "$DEVETOOLS\tools\node"
$HVIGORW     = "$DEVETOOLS\tools\hvigor\bin\hvigorw.js"

# HAP 应用入口（单模块项目，无 HSP）
$HAP_PATH = "$PROJECT_ROOT\entry\build\default\outputs\default\entry-default-unsigned.hap"

# 应用启动信息（来源：AppScope/app.json5 + entry/src/main/module.json5）
$BUNDLE_NAME  = "com.fty1.kouol"
$ABILITY_NAME = "EntryAbility"

# ============================================================================

# DEVECO_SDK_HOME 由 env/.env 加载；如未配置则兜底
if (-not $env:DEVECO_SDK_HOME) { $env:DEVECO_SDK_HOME = "$DEVETOOLS\sdk" }
$env:PATH = "$SDK_TOOLS;$OHPM_BIN;$NODE_BIN;$env:PATH"

# --- 构建 ---
Write-Host "=== Building kouol ===" -ForegroundColor Cyan
node $HVIGORW assembleApp --no-daemon
if ($LASTEXITCODE -ne 0) {
    Write-Host "BUILD FAILED" -ForegroundColor Red
    exit $LASTEXITCODE
}
Write-Host "BUILD SUCCESSFUL" -ForegroundColor Green

# --- 部署 ---
if (-not $Deploy) {
    Write-Host "Skip deploy (use -Deploy to install on device)." -ForegroundColor DarkGray
    exit 0
}

$targets = hdc list targets 2>$null
if (-not $targets -or $targets -eq "[Empty]") {
    Write-Host "No device connected. Connect a device or start an emulator first." -ForegroundColor Yellow
    exit 1
}

# 安装 HAP
Write-Host "=== Installing HAP ===" -ForegroundColor Cyan
Write-Host "HAP path: $HAP_PATH"
if (-not (Test-Path $HAP_PATH)) {
    Write-Host "HAP file not found!" -ForegroundColor Red
    exit 1
}
$result = hdc install $HAP_PATH 2>&1
Write-Host $result
if ($LASTEXITCODE -ne 0) {
    Write-Host "HAP INSTALL FAILED (exit code: $LASTEXITCODE)" -ForegroundColor Red
    exit $LASTEXITCODE
}

# 启动应用
Write-Host "=== Launching app ===" -ForegroundColor Cyan
hdc shell aa start -a $ABILITY_NAME -b $BUNDLE_NAME
Write-Host "Done." -ForegroundColor Green
