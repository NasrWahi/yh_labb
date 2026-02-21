# School Management (YrkesCo) Database Architecture

# Overview

This project implements a centralized relational database system for a vocational school management platform. The system is designed to handle the complex relationships between students, educational programs, courses, staff roles (educators and leaders), facilities, and external consulting companies.

The architecture leverages PostgreSQL 16 and is fully containerized using Docker to ensure environmental consistency across development and production stages.

# Technical Specifications

- Database Engine: PostgreSQL 16
- Environment: Docker & Docker Compose
- Modeling Strategy: Third Normal Form (3NF) 
- Access: pgAdmin 4 (included in stack)

# Key Architectural Features

## 1. Database Normalization (3NF)
The schema is strictly designed according to Third Normal Form to eliminate data redundancy and ensure integrity:
- 1NF: Every table has a primary key, and all columns contain atomic values.
- 2NF: All non-key columns are fully dependent on the primary key.
- 3NF: Eliminated all transitive dependencies. For example, facility data (city/address) is stored separately from class to avoid duplication.

## 2. Person Specialization Hierarchy
To minimize data redundancy, the system utilizes a super-type person table. Roll-specific data is isolated into sub-type tables:
- student: Linked to class.
- educator: Contains payroll-specific data like hourly_rate.
- education_leader: Manages administrative class assignments.
- consultant: Linked to external consultant_company.

## 3. Security & GDPR Compliance
Sensitive data, such as personal identification numbers and emails, are isolated in the person_details table. This allows for restricted access logic where administrative users can access name data without exposing sensitive personal identifiers.

# File Structure
Project is organized into a clean directory structure for ease of navigation. The files can be located in the sql/ directory and must be executed sequential order.

# Installation & Setup

## Prerequisites
- Docker & Docker Compose
- A tool to execute SQL (psql or pgAdmin)

## 1. Start the Environment
Launch the PostgreSQL and pgAdmin containers with:
- docker-compose up -d

## 2. Environment Configuration
The database is initialized with the following credentials (defined in docker-compose.yaml):
- Database: yrkesco_db
- User: yrkesco_user
- Password: yrkesco_password
- pgAdmin: Accessible at http://localhost:8080 (admin@yrkesco.se / admin)

## 3. Initialize the Database
The docker-compose.yaml is configured to automatically mount and initialize scripts. To manually run the full setup:
- docker compose exec -T postgres psql -U yrkesco_user -d yrkesco_db < sql/create_tables.sql
- docker compose exec -T postgres psql -U yrkesco_user -d yrkesco_db < sql/insert_data.sql

# Verification & Queries
To verify system functionality and 3NF relationships, execute the queries.sql script:
- docker compose exec -T postgres psql -U yrkesco_user -d yrkesco_db < sql/queries.sql

This will demonstrate:
- Enrollment Statistics: Grades and status per student per course.
- Staffing Overview: Assignments of educators (internal and consultants) to specific courses.
- Facility Usage: Which classes are currently assigned to specific locations.
