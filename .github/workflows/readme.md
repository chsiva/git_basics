# GitHub Actions: 
    GitHub Actions is a robust continuous integration and continuous delivery (CI/CD) platform natively integrated within GitHub, 
    allowing for automation of the software development lifecycle directly from the repository. 
    Workflows, defined in YAML files, can be triggered by various events like code pushes or pull requests 
    and execute build, test, and deployment jobs on either GitHub-hosted or self-hosted runners. 
    This enables teams to automate critical tasks, streamline workflows, enhance collaboration through immediate feedback, and deploy applications efficiently, all while leveraging a vast marketplace of reusable actions for tasks such as linting, testing, and cloud deployments.

# software development lifecycle (SDLC):
     - Requirements gathering > Development (Design) > Implementation > Testing (QA analysis) > Deployment > Maintenance
     
# continuous integration and continuous delivery (CI/CD):
      - CI: Focuses on getting code integrated and tested frequently to ensure quality and prevent integration issues early on.
      - Continuous Delivery: Ensures that the codebase is always ready to be deployed, 
           but requires a "final manual step" before releasing to production.
      - Continuous Deployment: Automates the entire process, including the release to production, 
           once the code passes all tests. 
     In essence:
     Continuous Delivery: You have the capability to deploy to production at any time, but you choose when to do so manually.
                 Ex: Octoppus Deployand IBM UrbanCode Deploy (Udeploy)
     Continuous Deployment: Every successful code change is automatically deployed to production. 
                 Ex: Jenkins, Git Lab
    

    
 
### Summary Table (Componnents in Git Actions)

        | Component            | Common Name      | Identifier Example         |
        |---------------------|-------------------|----------------------------|
        | Workflow            | Workflow          | `name: CI/CD Pipeline`     |
        | Event               | Events            | `on: push`                 |
        | Job                 | Job               | `build-job:`               |
        | Step                | Step              | `- name: Checkout code`    |
        | Environment Variable | Environment      | `env: NODE_ENV: production`|
        | Output              | Output            | `outputs: build_number`    |
        | Input               | Input             | `inputs: branch:`          |

       Note: In GitHub Actions, identifiers are the names you use to refer to various components within your workflow.
   

# Identifiers (Names) must follow certain naming conventions:
    - No spaces or special characters (other than dashes and underscores).
    - Must be unique within the same context (e.g., each job name must be unique within a workflow).


# How do you trigger a GitHub Actions workflow?
  On GitHub events like push, pull_request, workflow_dispatch, schedule, release, etc.
  Can specify filters like branches, tags, or paths.
       on:
       push:
       branches:
         - main
       pull_request:
       branches:
         - develop

# What runners are available in GitHub Actions?
  - GitHub-hosted runners: Provided by GitHub, pre-configured VM images (Linux, Windows, macOS).
  - Self-hosted runners: Your own machines/servers you configure to run workflows.


# How do you pass secrets and environment variables in GitHub Actions?
  On Repo settings > Actions secrets and variables
   - Use GitHub Secrets to store sensitive data securely.
   - Access secrets in workflow via ${{ secrets.SECRET_NAME }}.
   - Can also set environment variables at workflow, job, or step level.

# How can you reuse code or workflows in GitHub Actions?
  1. Reusable Workflow (.github/workflows/reusable.yml)
  2. Use workflow_call event to call reusable workflows
     name: Reusable Workflow  
       on:
         workflow_call:
     jobs:
       call-reusable:
          uses: ./.github/workflows/reusable.yml



| Feature                   | Composite Actions (using: "composite")   | Reusable Workflows (`workflow_call`)     |
| ------------------------- | ---------------------------------------- | ---------------------------------------- |
| Purpose                   | Reuse a sequence of steps in **one job** | Reuse **entire workflows or jobs**       |
| YAML Location             | `.github/actions/my-action/action.yml`   | `.github/workflows/reusable.yml`         |
| Called with               | `uses: ./github/actions/my-action`       | `uses: ./.github/workflows/reusable.yml` |
| Can define multiple jobs? | ❌ No                                     | ✅ Yes                                    |
| Can access secrets?       | ✅ Yes                                    | ✅ Yes                                    |
| Can run scripts?          | ✅ Yes (with `run:`)                      | ✅ Yes                                    |
| Better for...             | Small, repeatable logic in one job       | Higher-level orchestration, full flows   |

composite example 
on: push
jobs:
  example_job:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ./.github/actions/my-composite-action
        with:
          input_name: 'World'
        id: my_composite_step
      - name: Use output from composite action
        run: echo "Output from composite action: ${{ steps.my_composite_step.outputs.output_name }}"

# What is the difference between jobs.<job_id>.needs and jobs.<job_id>.strategy.matrix?
  - needs: Defines job dependencies; a job waits for others to finish.
  - strategy.matrix: Runs the same job with different configurations (e.g., different OS or language versions).

# How do you handle failure or retry in GitHub Actions?
  - Use continue-on-error to ignore step failures.
  - Use if conditionals to run steps/jobs conditionally.
  - Use jobs.<job_id>.timeout-minutes to limit execution time.
  Currently, no native retry, but you can script retries or use marketplace actions.

# How do you debug failed GitHub Actions runs?
    - Check logs on GitHub Actions UI.
    - Use ::debug:: commands in workflow scripts.
    - Run workflows locally using tools like act.
    - Add verbose logging in your scripts.

# How do you control access and permissions in GitHub Actions?
   - Use repository and organization level actions policies.
   - Control access to secrets and tokens.
   - Use least privilege principle in workflow permissions.

# Build artifacts In GitHub Actions, 
   artifacts are files or data generated during a workflow run that you can save and share between jobs or download later. They're commonly used to store:

    - Build outputs (e.g., compiled binaries, packages)
    - Test results
    - Log files
    - Coverage reports

    Local storage on runners (Temporary)
      During a job:
      Artifacts are temporarily stored on the runner’s local disk (e.g., /home/runner/work/repo-name/).
      Once the job ends, the runner is destroyed, and the files are lost unless uploaded.



# Why Use Caching in Workflows?
  Caching reduces:
    - Dependency installation time (e.g., npm install, pip install, maven install)
    - Rebuilding or re-downloading large files
    - CI/CD costs (faster builds = fewer compute minutes)


| Feature                       | **GitHub Actions**                            | **GitLab CI/CD**                                                    |
| ----------------------------- | --------------------------------------------- | ------------------------------------------------------------------- |
| **Platform**                  | Part of GitHub                                | Part of GitLab                                                      |
| **CI/CD Integration**         | Built-in automation with `.github/workflows/` | Built-in with `.gitlab-ci.yml`                                      |
| **Pipeline Model**            | Workflow → Job(s) → Step(s)                   | Pipeline → Stage(s) → Job(s)                                        |
| **Triggers**                  | Events (push, PR, schedule, etc.)             | Events (push, merge request, schedule, etc.)                        |
| **Runner Types**              | GitHub-hosted & self-hosted runners           | GitLab-hosted & self-hosted runners                                 |
| **Ease of Use**               | Simple YAML syntax; marketplace actions       | Mature syntax; integrated with GitLab UI                            |
| **Marketplace**               | ✅ 25,000+ reusable Actions available          | ❌ No centralized marketplace (reusable jobs via includes/templates) |
| **Container/Service Support** | Docker support built-in                       | Excellent Docker and Kubernetes support                             |
| **Caching & Artifacts**       | Supported (manual configuration)              | More mature & easier caching/artifact features                      |
| **Monorepo Support**          | Decent (manual workflows)                     | Strong monorepo support (rules, includes)                           |
| **Security Features**         | OIDC, Secrets, Approvals                      | OIDC, Secrets, Protected Envs, Runner isolation                     |
| **Open Source**               | Mostly closed source                          | GitLab CE (Community Edition) is open source                        |
| **Self-hosting**              | Partial (runners only)                        | Full self-hosted GitLab instance possible                           |


my-repo/
└── .github/
    └── workflows/
        ├── test.yml
        ├── deploy.yml
        └── lint.yml

| Limit Type                  | Maximum Allowed             |
| --------------------------- | --------------------------- |
| **Total jobs per workflow** | **256 jobs**                |
| **Total steps per job**     | 2,000 steps                 |
| **Max run time per job**    | 6 hours (depending on plan) |
| **Artifacts per workflow**  | 100 artifacts               |
| **Matrix job combinations** | 256 (max matrix expansion)  |
| **Concurrent jobs**         | Varies by plan (see below)  |


| Concept       | What It Is                                                                                              | Example                                                                        |
| ------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| **`jobs`**    | Top-level units of work that run independently or in sequence. Each job runs in a separate environment. | `yaml<br>jobs:<br>  build:<br>    runs-on: ubuntu-latest<br>`                  |
| **`steps`**   | Instructions within a job that run **in order**. Can be shell commands or actions.                      | `yaml<br>steps:<br>  - run: echo "Hello"<br>  - uses: actions/checkout@v4<br>` |
| **`runs-on`** | Specifies the **runner environment** (e.g., Ubuntu, Windows, macOS) for a job.                          | `yaml<br>runs-on: ubuntu-latest<br>`                                           |
| **`uses`**    | Invokes a prebuilt **action** from GitHub Marketplace or a local/custom action.                         | `yaml<br>- uses: actions/checkout@v4<br>`                                      |
| **`env`**     | Sets **environment variables** for jobs or steps. Can be reused in commands.                            | `yaml<br>env:<br>  NODE_ENV: production<br>`                                   |
| **`secrets`** | Secure values (e.g., API keys, tokens) stored in repo or org settings. Accessed using `secrets.*`.      | `yaml<br>env:<br>  API_KEY: ${{ secrets.MY_API_KEY }}<br>`                     |



name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test


| Trigger             | Description                                         | Manual / Auto | Common Use Cases                         | Supports Inputs |
| ------------------- | --------------------------------------------------- | ------------- | ---------------------------------------- | --------------- |
| `push`              | Runs on `git push` to specified branches/tags       | 🚀 Automatic  | Run CI on every code push                | ❌               |
| `pull_request`      | Runs when a PR is opened, synchronized, or reopened | 🚀 Automatic  | Validate PRs before merging              | ❌               |
| `schedule`          | Runs on a cron schedule (UTC time)                  | 🕒 Automatic  | Nightly builds, dependency updates       | ❌               |
| `workflow_dispatch` | Runs only when manually triggered via GitHub UI/API | ✅ Manual      | On-demand tests, deployments, patch jobs | ✅ Yes           |


# Workflow create
  option: Actions > Create new workflow option > create workflow/simple workflow by GitHub ( your repo)

# Integrate with Terraform

  option1: Actions > Create new workflow option > under deployments category > Terraform

  https://github.com/hashicorp/setup-terraform#

name: Terraform

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2  # it is the action that will get the terraform installed
        with:
          terraform_version: 1.0.0 # Specify the desired Terraform version

      - name: Terraform Init
        run: terraform init

      - name: Terraform Plan
        if: github.event_name == 'pull_request'
        run: terraform plan -out tfplan

      - name: Terraform Apply
        if: github.event_name == 'push' && github.ref == 'refs/heads/main'
        run: terraform apply -auto-approve

  

# Integrate checkmarx/Sonarqube/Veracode

  options: Actions > Create new workflow option > under security category > checkmarx/Sonarqube/Veracode

# Integration workflow with actions from marketplace
  https://github.com/marketplace
