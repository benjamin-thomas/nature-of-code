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

    processing-java --sketch=$PWD --run

Inspect the generated code with:

    rm -rf /tmp/sketch ; processing-java --sketch=$PWD --output=/tmp/sketch --export && tail -n+1 /tmp/sketch/source/*.java

Project must have this structure:

    projName/projName.pde

Auto-format on save with this command:

    find -name *.pde | entr clang-format -i /_
