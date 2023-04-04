## TypeScript

See:

    00_basic_setup/typescript

Run project with:

    yarn dev

## Java

Use `Luke-zhang-04.processing-vscode` vscode extension.

See:

    00_basic_setup/java

Run project with:

    processing-java --sketch=$PWD --run`

Project must have this structure:

    projName/projName.pde

Auto-format on save with this command:

    find -name *.pde | entr clang-format -i /_
