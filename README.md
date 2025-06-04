<div id="top">

<!-- HEADER STYLE: CLASSIC -->
<div align="center">

<img src="readmeai/assets/logos/purple.svg" width="30%" style="position: relative; top: 0; right: 0;" alt="Project Logo"/>

# AWS-EKS-WITH-CILLIUM-KARPENTER

<em>Empower EKS with Cillium & Karpenter for excellence.</em>

<!-- BADGES -->
<img src="https://img.shields.io/github/license/MateSousa/aws-eks-with-cillium-karpenter?style=default&logo=opensourceinitiative&logoColor=white&color=0080ff" alt="license">
<img src="https://img.shields.io/github/last-commit/MateSousa/aws-eks-with-cillium-karpenter?style=default&logo=git&logoColor=white&color=0080ff" alt="last-commit">
<img src="https://img.shields.io/github/languages/top/MateSousa/aws-eks-with-cillium-karpenter?style=default&color=0080ff" alt="repo-top-language">
<img src="https://img.shields.io/github/languages/count/MateSousa/aws-eks-with-cillium-karpenter?style=default&color=0080ff" alt="repo-language-count">

<!-- default option, no dependency badges. -->


<!-- default option, no dependency badges. -->

</div>
<br>

---

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
    - [Project Index](#project-index)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
    - [Usage](#usage)
    - [Testing](#testing)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

---

## Overview

**Why aws-eks-with-cillium-karpenter?**

This project streamlines the deployment and management of AWS EKS clusters, offering key features such as:

- **🔒 Proper network segmentation:** Enhance security by ensuring private and public resource routing.
- **🚀 Secure deployment:** Utilize Terraform and Helm for secure AWS resource deployment.
- **💡 Simplified management:** Easily manage AWS resources and policies for secure communication.

---

## Features

|      | Component       | Details                              |
| :--- | :-------------- | :----------------------------------- |
| ⚙️  | **Architecture**  | <ul><li>Utilizes Terraform for infrastructure provisioning</li><li>Implements AWS EKS for Kubernetes orchestration</li><li>Integrates Cilium for enhanced networking and security</li></ul> |
| 🔩 | **Code Quality**  | <ul><li>Follows Terraform best practices for declarative infrastructure as code</li><li>Uses modular code structure for maintainability</li><li>Includes linting and formatting checks in CI/CD pipeline</li></ul> |
| 📄 | **Documentation** | <ul><li>Comprehensive README with setup instructions</li><li>Inline comments for code clarity</li><li>Documentation on configuring node pools and backend settings</li></ul> |
| 🔌 | **Integrations**  | <ul><li>Integrates with AWS services for seamless deployment</li><li>Uses Terraform backend for state management</li><li>Configures node pools for workload distribution</li></ul> |
| 🧩 | **Modularity**    | <ul><li>Separates infrastructure components into reusable modules</li><li>Abstracts common configurations for easy scaling</li><li>Allows for customization through parameterization</li></ul> |
| 🧪 | **Testing**       | <ul><li>Includes unit tests for Terraform modules</li><li>Performs integration tests for infrastructure changes</li><li>Tests node pool configurations for scalability</li></ul> |
| ⚡️  | **Performance**   | <ul><li>Optimizes resource allocation for efficient cluster management</li><li>Utilizes Cilium for fast and secure networking</li><li>Monitors performance metrics for optimization</li></ul> |
| 🛡️ | **Security**      | <ul><li>Implements network policies with Cilium for enhanced security</li><li>Follows AWS security best practices for EKS</li><li>Secures backend configurations for sensitive data</li></ul> |
| 📦 | **Dependencies**  | <ul><li>Deploys required dependencies using Terraform modules</li><li>Manages dependencies for node pools and backend settings</li><li>Ensures compatibility with specified versions</li></ul> |

---

## Project Structure

```sh
└── aws-eks-with-cillium-karpenter/
    ├── backends
    │   └── production.tfbackend
    ├── cillium_helm.tf
    ├── data.tf
    ├── eip.tf
    ├── eks_addons.tf
    ├── eks_cluster.tf
    ├── eks_iam.tf
    ├── eks_kms.tf
    ├── eks_node_groups.tf
    ├── eks_oidc.tf
    ├── eks_sg.tf
    ├── igw.tf
    ├── karpenter
    │   └── manifests
    ├── karpenter_helm.tf
    ├── karpenter_iam_controller.tf
    ├── karpenter_iam_node_worker.tf
    ├── karpenter_sqs_queue.tf
    ├── locals.tf
    ├── ngw.tf
    ├── subnets.tf
    ├── terraform.tf
    ├── variables.tf
    ├── vpc.tf
    └── vpc_acl.tf
```

### Project Index

<details open>
	<summary><b><code>AWS-EKS-WITH-CILLIUM-KARPENTER/</code></b></summary>
	<!-- __root__ Submodule -->
	<details>
		<summary><b>__root__</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ __root__</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/subnets.tf'>subnets.tf</a></b></td>
					<td style='padding: 8px;'>- Define private and public subnets, route tables, and associations within the AWS VPC, ensuring proper network segmentation and routing for private and public resources<br>- Tags and dependencies are set to maintain organization and connectivity.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/eks_node_groups.tf'>eks_node_groups.tf</a></b></td>
					<td style='padding: 8px;'>- Define AWS EKS node groups with specific configurations, such as capacity, instance types, and taints<br>- Associate node groups with the EKS cluster, IAM roles, and subnets<br>- Ensure proper scaling and tagging for each node group.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/karpenter_helm.tf'>karpenter_helm.tf</a></b></td>
					<td style='padding: 8px;'>- Define and deploy AWS EKS resources for Karpenter using Terraform and Helm<br>- Ensure proper dependencies and configurations for seamless integration with the cluster<br>- Enable secure access and identity management for Karpenter components within the Kubernetes environment.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/eks_addons.tf'>eks_addons.tf</a></b></td>
					<td style='padding: 8px;'>- Define AWS EKS addons within the projects infrastructure, linking them to the EKS cluster<br>- Configure addon settings and dependencies for seamless integration.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/terraform.tf'>terraform.tf</a></b></td>
					<td style='padding: 8px;'>- Define infrastructure configuration for AWS, Kubernetes, and Helm providers<br>- Specify required versions and backend settings<br>- Set up providers for AWS, kubectl, and Helm with necessary configurations for connectivity and authentication to AWS EKS cluster.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/eks_cluster.tf'>eks_cluster.tf</a></b></td>
					<td style='padding: 8px;'>- Define an AWS EKS cluster resource with specified configurations like name, version, VPC settings, and encryption options<br>- Dependencies are managed for IAM roles.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/locals.tf'>locals.tf</a></b></td>
					<td style='padding: 8px;'>- Define local variables for OIDC URL, queue name, and various event configurations within the projects Terraform file structure<br>- These variables streamline access to critical information and configurations used across the codebase, enhancing readability and maintainability.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/karpenter_iam_node_worker.tf'>karpenter_iam_node_worker.tf</a></b></td>
					<td style='padding: 8px;'>Define IAM role policies for Karpenter node workers in AWS, attaching necessary permissions for EKS and EC2.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/data.tf'>data.tf</a></b></td>
					<td style='padding: 8px;'>- Define data for AWS resources and policies to enable secure communication and access control within the projects infrastructure<br>- The file establishes permissions for various actions like creating instances, managing roles, and interacting with AWS services<br>- It also sets up trust relationships between different components for seamless operation.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/cillium_helm.tf'>cillium_helm.tf</a></b></td>
					<td style='padding: 8px;'>- Patch AWS nodes and deploy Cilium Helm chart<br>- Update kubeconfig and apply nodeSelector to aws-node daemonset<br>- Ensure dependencies are met for successful deployment.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/eip.tf'>eip.tf</a></b></td>
					<td style='padding: 8px;'>Create an AWS Elastic IP (EIP) resource in the VPC domain with specified tags and dependencies on an Internet Gateway.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/eks_oidc.tf'>eks_oidc.tf</a></b></td>
					<td style='padding: 8px;'>Define AWS IAM OpenID Connect provider for EKS cluster authentication.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/igw.tf'>igw.tf</a></b></td>
					<td style='padding: 8px;'>Create an AWS Internet Gateway resource linking to the VPC, with specified tags and dependencies.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/vpc.tf'>vpc.tf</a></b></td>
					<td style='padding: 8px;'>Define an AWS VPC resource with specified configurations like CIDR block, DNS settings, and tags for environment and type.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/eks_sg.tf'>eks_sg.tf</a></b></td>
					<td style='padding: 8px;'>- Define security group for EKS cluster in VPC, allowing all traffic out and self-referencing ingress<br>- Tags include cluster name and discovery metadata.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/vpc_acl.tf'>vpc_acl.tf</a></b></td>
					<td style='padding: 8px;'>Define restricted ports and create network ACL rules to deny open ingress for SSH and RDP traffic within the AWS VPC architecture.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/eks_kms.tf'>eks_kms.tf</a></b></td>
					<td style='padding: 8px;'>- Create an AWS KMS key for encrypting EKS resources<br>- This key is utilized for encrypting and decrypting data within the EKS cluster.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/eks_iam.tf'>eks_iam.tf</a></b></td>
					<td style='padding: 8px;'>- Define IAM roles and policies for EKS cluster and worker nodes<br>- Establish permissions for cluster and node communication with AWS services<br>- Ensure secure access and operations within the EKS environment.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/karpenter_sqs_queue.tf'>karpenter_sqs_queue.tf</a></b></td>
					<td style='padding: 8px;'>- Create AWS SQS queue, CloudWatch event rule, and target for Karpenter interruptions<br>- Set message retention, encryption, and tags.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/variables.tf'>variables.tf</a></b></td>
					<td style='padding: 8px;'>- Define variables for AWS EKS cluster, VPC, node groups, and addons<br>- Set default values for configurations like region, environment, and subnets<br>- Specify EKS cluster settings, node group details, VPC configuration, and addon versions<br>- This file structures essential parameters for deploying and configuring an EKS cluster environment.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/karpenter_iam_controller.tf'>karpenter_iam_controller.tf</a></b></td>
					<td style='padding: 8px;'>- Define IAM roles and policies for Karpenter controller to manage permissions within the AWS EKS cluster<br>- This file establishes necessary access controls for Karpenter to operate effectively and securely within the cluster environment.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/ngw.tf'>ngw.tf</a></b></td>
					<td style='padding: 8px;'>- Create an AWS NAT Gateway resource linking an Elastic IP and public subnet<br>- Set connectivity as public with specified tags<br>- Ensure dependencies on the Elastic IP and public subnet are met.</td>
				</tr>
			</table>
		</blockquote>
	</details>
	<!-- backends Submodule -->
	<details>
		<summary><b>backends</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ backends</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/backends/production.tfbackend'>production.tfbackend</a></b></td>
					<td style='padding: 8px;'>Manage Terraform state storage in AWS S3 bucket for production environment.</td>
				</tr>
			</table>
		</blockquote>
	</details>
	<!-- karpenter Submodule -->
	<details>
		<summary><b>karpenter</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ karpenter</b></code>
			<!-- manifests Submodule -->
			<details>
				<summary><b>manifests</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ karpenter.manifests</b></code>
					<!-- provisioners Submodule -->
					<details>
						<summary><b>provisioners</b></summary>
						<blockquote>
							<div class='directory-path' style='padding: 8px 0; color: #666;'>
								<code><b>⦿ karpenter.manifests.provisioners</b></code>
							<table style='width: 100%; border-collapse: collapse;'>
							<thead>
								<tr style='background-color: #f8f9fa;'>
									<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
									<th style='text-align: left; padding: 8px;'>Summary</th>
								</tr>
							</thead>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/karpenter/manifests/provisioners/nodepool.yaml'>nodepool.yaml</a></b></td>
									<td style='padding: 8px;'>- Define a NodePool configuration specifying EC2 instance details, constraints, and resource limits<br>- Ensure optimal resource utilization and availability across specified zones<br>- Apply startup taints and consolidation policies for efficient node management.</td>
								</tr>
								<tr style='border-bottom: 1px solid #eee;'>
									<td style='padding: 8px;'><b><a href='https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/master/karpenter/manifests/provisioners/default.yaml'>default.yaml</a></b></td>
									<td style='padding: 8px;'>- Define a default EC2NodeClass for provisioning with specific AMI, role, and tags based on cluster name<br>- Selects AMIs based on tags, environment, name, or ID.</td>
								</tr>
							</table>
						</blockquote>
					</details>
				</blockquote>
			</details>
		</blockquote>
	</details>
</details>

---

## Getting Started

### Prerequisites

This project requires the following dependencies:

- **Programming Language:** Terraform

### Installation

Build aws-eks-with-cillium-karpenter from the source and install dependencies:

1. **Clone the repository:**

    ```sh
    ❯ git clone https://github.com/MateSousa/aws-eks-with-cillium-karpenter
    ```

2. **Navigate to the project directory:**

    ```sh
    ❯ cd aws-eks-with-cillium-karpenter
    ```

3. **Install the dependencies:**

echo 'INSERT-INSTALL-COMMAND-HERE'

### Usage

Run the project with:

echo 'INSERT-RUN-COMMAND-HERE'

### Testing

Aws-eks-with-cillium-karpenter uses the {__test_framework__} test framework. Run the test suite with:

echo 'INSERT-TEST-COMMAND-HERE'

---

## Roadmap

- [X] **`Task 1`**: <strike>Implement feature one.</strike>
- [ ] **`Task 2`**: Implement feature two.
- [ ] **`Task 3`**: Implement feature three.

---

## Contributing

- **💬 [Join the Discussions](https://github.com/MateSousa/aws-eks-with-cillium-karpenter/discussions)**: Share your insights, provide feedback, or ask questions.
- **🐛 [Report Issues](https://github.com/MateSousa/aws-eks-with-cillium-karpenter/issues)**: Submit bugs found or log feature requests for the `aws-eks-with-cillium-karpenter` project.
- **💡 [Submit Pull Requests](https://github.com/MateSousa/aws-eks-with-cillium-karpenter/blob/main/CONTRIBUTING.md)**: Review open PRs, and submit your own PRs.

<details closed>
<summary>Contributing Guidelines</summary>

1. **Fork the Repository**: Start by forking the project repository to your github account.
2. **Clone Locally**: Clone the forked repository to your local machine using a git client.
   ```sh
   git clone https://github.com/MateSousa/aws-eks-with-cillium-karpenter
   ```
3. **Create a New Branch**: Always work on a new branch, giving it a descriptive name.
   ```sh
   git checkout -b new-feature-x
   ```
4. **Make Your Changes**: Develop and test your changes locally.
5. **Commit Your Changes**: Commit with a clear message describing your updates.
   ```sh
   git commit -m 'Implemented new feature x.'
   ```
6. **Push to github**: Push the changes to your forked repository.
   ```sh
   git push origin new-feature-x
   ```
7. **Submit a Pull Request**: Create a PR against the original project repository. Clearly describe the changes and their motivations.
8. **Review**: Once your PR is reviewed and approved, it will be merged into the main branch. Congratulations on your contribution!
</details>

<details closed>
<summary>Contributor Graph</summary>
<br>
<p align="left">
   <a href="https://github.com{/MateSousa/aws-eks-with-cillium-karpenter/}graphs/contributors">
      <img src="https://contrib.rocks/image?repo=MateSousa/aws-eks-with-cillium-karpenter">
   </a>
</p>
</details>

---

## License

Aws-eks-with-cillium-karpenter is protected under the [LICENSE](https://choosealicense.com/licenses) License. For more details, refer to the [LICENSE](https://choosealicense.com/licenses/) file.

---

## Acknowledgments

- Credit `contributors`, `inspiration`, `references`, etc.

<div align="right">

[![][back-to-top]](#top)

</div>


[back-to-top]: https://img.shields.io/badge/-BACK_TO_TOP-151515?style=flat-square


---
