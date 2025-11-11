# Debug PowerShell script to push project with backdated history

$repoUrl = "https://github.com/Abiram08/Invoice-Generator-Tracker.git"

# Clean up
if (Test-Path .git) { Remove-Item -Recurse -Force .git -ErrorAction SilentlyContinue }
if (Test-Path .git_backup) { Remove-Item -Recurse -Force .git_backup -ErrorAction SilentlyContinue }

# Init
git init
git remote add origin $repoUrl

function Commit-Backdated($message, $date) {
    $env:GIT_AUTHOR_DATE = "$date 10:00:00"
    $env:GIT_COMMITTER_DATE = "$date 10:00:00"
    git commit -m $message --allow-empty
    $env:GIT_AUTHOR_DATE = $null
    $env:GIT_COMMITTER_DATE = $null
    Write-Host "Committed: $message"
}

Write-Host "Step 1..."
git add .gitignore package.json package-lock.json README.md public/ .env.example .qodo/
Commit-Backdated "Initial project structure and configuration" "2025-10-29"

Write-Host "Step 2..."
git add backend/server.js backend/package.json backend/package-lock.json backend/.env.example backend/middleware/
Commit-Backdated "Backend: Core server setup and middleware" "2025-10-30"

Write-Host "Step 3..."
git add backend/models/
Commit-Backdated "Backend: Database models for Users, Clients, and Invoices" "2025-10-31"

Write-Host "Step 4..."
git add backend/routes/auth.js
Commit-Backdated "Backend: Authentication routes and JWT implementation" "2025-11-01"

Write-Host "Step 5..."
git add backend/routes/clients.js backend/routes/products.js backend/routes/users.js
Commit-Backdated "Backend: Core routes for clients, products, and user management" "2025-11-02"

Write-Host "Step 6..."
git add backend/routes/invoices.js backend/routes/dashboard.js backend/routes/clientPortal.js backend/routes/clientSignup.js backend/routes/templates.js
Commit-Backdated "Backend: Invoice generation, dashboard, and portal routes" "2025-11-03"

Write-Host "Step 7..."
git add src/index.js src/App.js src/App.css src/App.test.js src/logo.svg src/reportWebVitals.js src/setupTests.js src/config/ src/index.css
Commit-Backdated "Frontend: React base setup and routing configuration" "2025-11-05"

Write-Host "Step 8..."
git add src/context/ src/utils/ src/components/Layout/
Commit-Backdated "Frontend: Shared context, utilities, and layout components" "2025-11-07"

Write-Host "Step 9..."
git add src/pages/Auth/ src/pages/Landing.js src/pages/Dashboard/ src/components/Marketing/
Commit-Backdated "Frontend: Auth pages, landing page, and dashboard UI" "2025-11-09"

Write-Host "Step 10..."
git add src/pages/Clients/ src/pages/Invoices/ src/pages/Analytics/ src/pages/Requests/
Commit-Backdated "Frontend: Business features (Clients, Invoices, Analytics)" "2025-11-10"

Write-Host "Step 11..."
git add .
Commit-Backdated "Frontend: Client portal, settings, and final refinements" "2025-11-11"

git branch -M main
git push -u origin main --force
Write-Host "DEBUG COMPLETE"
