# Define parameters
param(
    [string]$sourceRoot = ".",
    [string]$databaseName = "codeql-database",
    [string]$packDir = "./codeql-pack/csharp",
    [string]$databaseDir = "./codeql-dbs/csharp",
    [string]$outputFile = "csharp-windows-results.sarif"
)

# Check if CodeQL CLI is installed
if (!(Get-Command "codeql" -ErrorAction SilentlyContinue)) {
    Write-Error "CodeQL CLI is not installed or not in the PATH"
    exit 1
}

# Check if source root exists
if (!(Test-Path -Path $sourceRoot)) {
    Write-Error "Source root $sourceRoot does not exist"
    exit 1
}

# create database for javascript on https://github.com/microsoft/PowerApps-Samples
codeql.exe pack download codeql/javascript-queries --dir ./codeql-pack/javascript
codeql.exe database create --language=javascript --source-root . codeql-database-js --overwrite
codeql.exe database analyze .\codeql-database-js .\codeql-pack\javascript\codeql\javascript-queries\0.8.12\codeql-suites\javascript-code-scanning.qls --format=csv --output=results.csv
codeql.exe database analyze .\codeql-database-js .\codeql-pack\javascript\codeql\javascript-queries\0.8.12\codeql-suites\javascript-code-scanning.qls --format=sarif-latest --sarif-category=javascript --output=javascript.sarif

# Upload results to GitHub repository
$env:GH_PAT = "ghp_personalaccesstoken"

$env:GH_PAT | & codeql.exe github upload-results `
          --repository=ourrepo/test --ref=refs/heads/main `
          --commit 18cd21585b94dd16c48dc13bc1365269696a75a4 `
          --sarif=javascript.sarif --github-auth-stdin




