---
layout: default
title: "Product Owner"
description: "Angel Lopez"
---

# [Home](index.md)


- [Product planning](#product-planning)
- [Scrum Methodology](#scrum-methodology)
- [DevOps Collaboration](#devops-collaboration)


### Product Planning
Product vision: Provide a secure, intuitive, and efficient digital banking solution for managing accounts, transactions, and personal finances, prioritizing user convenience and operational transparency.

Product mision: Empower users with a robust, easy-to-use platform for banking services, ensuring data security, financial accessibility, and a seamless user experience to build trust and foster long-term customer relationships.

Product vision board.

Minimum Viable Product(MVP):
->Admin Portal:

  -Default admin credentials.

  -CRUD functionalities for user management (view, create, update, delete users).

->User Portal:

  -Registration for new users (default account assigned).

  -Login functionality.
  
  -Ability to view owned accounts and transactions.
  
  -Transfer money to existing accounts with validation.

->Basic Authentication System:

  -User credentials securely hashed.

->Simple Frontend Interface:

  -Functional and minimalistic design.


Requirements:

->Functional Requirements:

  -Default admin account creation.
  
  -Admin portal for user management.
  
  -User registration, login, and account management.
  
  -Transaction functionalities (view, transfer).

->Non-Functional Requirements:

  -Secure storage for user credentials.
  
  -Minimalistic and responsive user interface.


Objectives and OKRs:

Objective 1: Deliver a functional MVP within the next quarter.

Key Results:

  -Admin portal completed and tested
  
  -User registration and login functionalities deployed 
  
  -Transaction features functional and deployed 
  
  -Basic UI design finalized and integrated


Objective 2: Ensure platform security and reliability.

Key Results:

  -Implement secure credential storage by week 3.
  
  -Test authentication systems with 100% success rate by week 6.
  
  -Achieve uptime of 99.9% during MVP testing phase.
  
  -Conduct three rounds of vulnerability assessments.

Objective 3: Optimize development and collaboration processes.

Key Results:

  -Conduct daily stand-ups with at least 90% participation.
  
  -Reduce sprint backlog overflow to under 5% per sprint.
  
  -Achieve a 10% reduction in deployment issues.
  
  -Document all processes in GitHub pages.

Objective 4: Enhance user experience.

Key Results:

  -Achieve user feedback score of 4.5/5 for UI design.
  
  -Reduce user flow navigation issues by 20% 
  
  -Complete UX testing 


Objective 5: Foster a collaborative team environment.

Key Results:

  -Conduct a minimum of three sprint reviews with actionable feedback.
  
  -Organize at least two retrospective meetings to refine team practices.
  
  -Train team members on new tools and integrations.
 
### Scrum Methodology
1. Scrum Ceremonies
- Backlog Grooming:
  Collaborate with team members to refine and prioritize the backlog.
  Break down epics into actionable user stories with clear acceptance criteria.
  Schedule weekly grooming sessions to ensure backlog readiness.

- Sprint Planning
  Define sprint goals based on the MVP requirements and project roadmap.
  Select user stories from the product backlog to include in the sprint backlog.
  Ensure all stories are well-documented and feasible for the sprint duration.
  Use Azure DevOps Boards to track and document the sprint backlog.

- Daily Stand-ups
  Conduct 15-minute stand-ups weekly.
  Team members share:
  What they accomplished since the last meeting.
  What they plan to do next.
  Any blockers impeding their progress.
  Record and track stand-ups using Zoom or Slack integrations.

- Sprint Review
  Present completed functionalities to stakeholders.
  Showcase the MVP features using a live demo (e.g., UAT environment).
  Gather feedback to update the product backlog.

- Sprint Retrospective
  Discuss:
  What went well during the sprint.
  Areas of improvement.
  Acknowledgments for team contributions.
  Use Azure DevOps Team Retrospective tools to document the outcomes.

2. Roles and Responsibilities

Product Owner
- Define the product vision and roadmap.
- Prioritize and manage the product backlog.
- Communicate project goals and updates to stakeholders.
- Ensure stories are well-defined with clear acceptance criteria.

Scrum Team
- Cross-functional team responsible for delivering the sprint goals.
- Includes developers, DevOps engineers, and cybersecurity specialists.

Scrum Master
- Facilitate Scrum ceremonies and remove blockers for the team.
- Ensure adherence to Scrum principles and methodologies.

3. Tools and Integrations
Azure DevOps Boards
- Use for backlog and sprint planning.
- Document epics, features, and user stories.
GitHub
- Use for version control and integration with CI/CD pipelines.
Slack
- Integrate with Azure Boards for real-time collaboration and updates.
- Connect with GitHub for notifications on pull requests and builds.
Zoom
- Record stand-ups, sprint planning, and reviews for documentation purposes.

4. Sprint Workflow
Pre-Sprint:
- Conduct backlog grooming and sprint planning.
- Ensure acceptance criteria for all stories are documented.
- Prepare GitHub and Azure DevOps integrations.
During Sprint:
- Host weekly stand-ups.
- Track progress on Azure DevOps Boards.
- Resolve blockers quickly in collaboration with team members.
Post-Sprint:
- Conduct sprint review and retrospective.
- Update backlog based on feedback and lessons learned.
- Plan the next sprint.

### DevOps Collaboration

-We connected Slack with Github to have notifications on slack about our progress on the 
 advancement in github.

-Slack was connnected also to Azure Devops, through some extensions of slack.

-The connection of Slaack-Zoom was not working, so we used normal zoom, whatsapp and slack calls 
 to have meetings online.

-We connected Azure-alerts with slack, through slack webhooks.

-The conexion github-azure devops, was not completed due to problems with azure devops, when we tryed to connect it, it appears a message saying that we arent part of a group that has the persmissions, but wevery member of devOpps is inside that group.
