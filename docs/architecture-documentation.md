# AWS Scalable and Highly Available Web Application Architecture

## 1. Overview

This project demonstrates how to deploy a secure, scalable, and highly available web application on Amazon Web Services (AWS) using EC2, Elastic Load Balancing (ALB), and Auto Scaling Groups (ASG).

The goal was not just to “run a web app” but to design it the way real-world production systems are built — fault-tolerant, cost-efficient, and self-adjusting to traffic demands.

In simple terms:

If one server goes down, users won’t notice. If traffic spikes, more servers automatically come online. If traffic slows, costs go down.

## 2. High-Level Design

At its core, the architecture is built inside a Virtual Private Cloud (VPC) — AWS’s logically isolated network environment — and distributed across two Availability Zones (AZs) for redundancy.

The main components include:

- `Elastic Load Balancer (ALB)` to evenly distribute incoming traffic.

- `Auto Scaling Group (ASG)` managing multiple EC2 instances that host the web application.

- `Amazon RDS` database in a `Multi-AZ` setup for data availability.

- `IAM, CloudWatch`, and `SNS` to handle security, monitoring, and alerts.

- `NAT Gateway` and `Internet Gateway` to securely route network traffic.

## 3. Detailed Architecture Walkthrough

Let’s walk through the flow step by step — from the moment a user visits the application to how AWS keeps it running behind the scenes.

### Step 1: User Access via the Internet

Users access the web application through a domain name (can be managed by Route 53).
The request is routed to the Application Load Balancer (ALB) sitting in the public subnet of the VPC.

The ALB acts like the front door — it receives all traffic and smartly distributes it to healthy backend servers.

### Step 2: Load Balancing Across Availability Zones

The ALB forwards the request to the Auto Scaling Group (ASG), which manages a pool of EC2 instances located in private subnets across two Availability Zones.

This setup ensures:

- If one Availability Zone fails, the other continues serving traffic.

- The web app remains available 24/7.

Each EC2 instance runs the web application and connects securely to the database tier.

### Step 3: Database Layer – Amazon RDS

The `Amazon RDS` service (configured with `Multi-AZ` replication) hosts the backend database — for example, `MySQL` or `PostgreSQL`.

- The `primary RDS instance` handles read/write operations.

- The `secondary instance` in another AZ stands by for automatic failover.

This means even if one AZ or DB node fails, AWS automatically promotes the standby node, keeping the application online.

### Step 4: Secure Network Design

The network is carefully segmented for security and control:

- **Public Subnet**:
Contains the ALB and NAT Gateway, which have direct internet access.

- **Private Subnets**:
Contain the EC2 instances and RDS databases — isolated from direct internet exposure.
Outbound access (for updates, patches, etc.) happens through the NAT Gateway, ensuring security best practices.

- **IAM Roles**:
EC2 instances are assigned specific `IAM roles` to securely access other AWS services (like S3 or CloudWatch) without using long-term credentials.

### Step 5: Auto Scaling for Performance and Cost Optimization

The `Auto Scaling Group` monitors metrics like CPU utilization via Amazon CloudWatch.
When traffic increases, new EC2 instances are launched automatically.
When demand drops, extra instances are terminated to save costs.

This dynamic scaling ensures:

- Consistent performance under varying loads.

- Optimized resource usage and spending.

### Step 6: Monitoring, Alerts, and Observability

`Amazon CloudWatch` continuously tracks key metrics such as:

- CPU utilization on EC2 instances

- Request counts and latency on the ALB

- Database health

If any metric crosses a predefined threshold (e.g., CPU > 80%), `CloudWatch` triggers an `Amazon SNS` (Simple Notification Service) alert.
This sends an email or SMS notification to the operations team, enabling quick response before an issue impacts users.

## 4. Security Best Practices Applied

- **Network Isolation**:
Public and private subnets ensure that backend resources (EC2 and RDS) are never directly exposed to the internet.

- **Least Privilege Access**:
IAM roles grant only the permissions required by each component.

- **Encrypted Connections**:
All communication between ALB, EC2, and RDS can be configured to use HTTPS/TLS for data-in-transit encryption.

- **High Availability**:
Redundant setup across multiple AZs prevents downtime from hardware or AZ-level failures.

## 5. Cost Optimization Techniques

- **Auto Scaling**:
Automatically scales down during low traffic, reducing compute costs.

- **Right-Sized EC2 Instances**:
Chosen based on the application’s performance needs to avoid overprovisioning.

- **RDS Multi-AZ Standby**:
Adds resilience but is used efficiently — no additional reads happen on standby to avoid unnecessary cost.

- **CloudWatch Metrics**:
Help continuously fine-tune instance sizes and scaling policies.