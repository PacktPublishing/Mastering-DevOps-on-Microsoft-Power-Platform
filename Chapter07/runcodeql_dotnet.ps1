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
# clone https://github.com/microsoft/PowerApps-Samples
git clone https://github.com/microsoft/PowerApps-Samples
codeql.exe pack download codeql/csharp-queries --dir ./codeql-pack/csharp
codeql.exe database create --language=csharp --source-root . codeql-database --command "dotnet build .\dataverse\DiscoveryService\DiscoveryService.sln" --overwrite
# Perform CodeQL analysis for CSV result
codeql.exe database analyze .\codeql-database .\codeql-pack\csharp\codeql\csharp-queries\0.8.12\codeql-suites\csharp-code-scanning.qls --format=csv --output=csharp-results.csv
# Perform CodeQL analysis for SARIF result
codeql.exe database analyze ./codeql-database --format=sarif-latest --sarif-category=csharp-windows --output=csharp-windows-results.sarif --verbose
# Upload results to GitHub repository
$env:GH_PAT = "ghp_personalaccesstoken"

$env:GH_PAT | & codeql.exe github upload-results `
          --repository=ourrepo/test --ref=refs/heads/main `
          --commit 18cd21585b94dd16c48dc13bc1365269696a75a4 `
          --sarif=csharp-windows-results.sarif --github-auth-stdin




