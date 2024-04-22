# 仓库地址
$RepoUrl = $env:GIT_REPO

# 顶级目录
$rootPath = Split-Path -Parent (Get-Location).Path

# 读取当前项目配置
$ciConfigPath = Join-Path $rootPath "src" "ci-config.json"
$ciConfig = (Get-Content -Path $ciConfigPath -Encoding UTF8) | ConvertFrom-Json


# 设置环境变量
$env:TAG = $ciConfig.image.tag

# 克隆目标仓库代码
## git clone https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}
if ($ciConfig.mode -eq 'commit') {
    git clone --depth 1 `
        -b $ciConfig.git.branch `
        $RepoUrl repo-code
    Set-Location ./repo-code
    git log
    git checkout $ciConfig.git.commit
    Set-Location ..
}
if ($ciConfig.mode -eq 'tag') {
    git clone --depth 1 `
        --branch $ciConfig.git.tag `
        $RepoUrl repo-code
}

# 切换到目标仓库代码
# Set-Location repo-code











