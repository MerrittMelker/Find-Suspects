
param (
    [Parameter(Mandatory = $true)]
    [string]$CommitSha,

    [string]$RepoPath = "D:\tnc-main"
)

# Prompt if RepoPath not provided explicitly
if (-not $PSBoundParameters.ContainsKey("RepoPath") -or [string]::IsNullOrWhiteSpace($RepoPath)) {
    $RepoPath = Read-Host "Enter the repo root path"
}

Set-Location -Path $RepoPath

$branch = "origin/trunk"

Write-Host "Fetching latest from origin in $RepoPath..."
git fetch origin

Write-Host "Checking if $CommitSha exists on $branch..."
$ancestorCheck = git merge-base --is-ancestor $CommitSha $branch
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Commit $CommitSha is not an ancestor of $branch" -ForegroundColor Red
    exit 2
}

Write-Host "`nCommits since and including $CommitSha on $branch:`n" -ForegroundColor Cyan
git log "$CommitSha..$branch" --pretty=format:"%h %an %s" --reverse

Write-Host "`nFiles changed in these commits:`n" -ForegroundColor Cyan
git diff --name-only $CommitSha $branch

Write-Host "`nDone." -ForegroundColor Green
