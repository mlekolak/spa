# HelloSpa

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 9.1.0.

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `--prod` flag for a production build.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via [Protractor](http://www.protractortest.org/).

## Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI README](https://github.com/angular/angular-cli/blob/master/README.md).

# Start app
### Prerequisites
What do you need? Vagrant (v2), Oracle VirtualBox 6.0.
App will use Alpine Linux.
## Instructions
### 1 Configure
Set variables token (`#38`) if you want to push ready image to DockerHub. If variable is empty, app will be served without storing in repository.
If you want to serve app on local network uncomment `#13` of vagrantfile:
'config.vm.network "public_network"'
Vagrant will ask "Which interface should the network bridge to?"
### 2 Build&Run
In root directory of project run command "vagrant up".
### 3 Working app
App will be build from GitHub code (https://github.com/mlekolak/spa.git) and serve on localhost:8080 (or look for assigned IP address in logs, it will be served IP:80).
### 4 Done
Done. Have fun :)
