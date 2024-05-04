# Power Platform Demo

## Description

The ppdemo repository primarily contains a project related to employee recognition, specifically a Kudos system. The project aims to showcase various features and capabilities of the Microsoft Power Platform in conjunction with DevOps processes.
You can find here examples and GitHub workflows how to:
 - spin up a Power Platform environments
 - import solutions from git branch to Power Platform developer environment
 - commit Power Platform solution changes back to developer branches
 - deploy to production environment
 - create GitHub releases that contain solutions and deployment packages as well
 - execute automated test in CI/CD
 - create branch protection rules and pull request validation workflow to check decsription and comments added to pull requests

The original Kudos application was copied from https://github.com/microsoft/Templates-for-Power-Platform and was modified to have depending solutions and the deployment package in the same folder structure. 

## Details
We use one of the applications available in the Power Platform Enterprise template to demonstrate the end-to-end scenario of DevOps processes. This application is the Kudos app that we can use to praise others for their outstanding achievements. The available solution provides a model-driven application to administer the kudos, opt out users and create badges that can be used in the canvas app to fill out the kudos. This latter canvas app called “Kudos app” in the solution provides the user interface for users in the organization. Since the Kudos solution depends on the Employee Experience base solution, we will learn how we can manage two solutions together by introducing multiple GitHub workflows in the release train and leveraging the deployment package. We will define the branch strategy for this application together, we will delve into the different GitHub workflows with DevSecOps tasks to manage the development of these solutions. We will introduce Backlog management and we will use the branch policies to protect our main branch from accidental changes. We will create tests for the Kudos app, and we will introduce monitoring on our app and flows. Finally, we will learn about feature flags and how we can use them to enable or disable certain features in our applications

## Usage

Fork this repository and change the workflow parameters, GitHub environments and GitHub secrets adjusted to your Power Platform tenant and Microsoft Azure subscription.

## Contributing

Contributions are welcome. Please feel free to fork this repository, make your changes, and then submit a pull request.

## License

The project is licensed under [INSERT LICENSE HERE]. Please see the `LICENSE` file for more information.
