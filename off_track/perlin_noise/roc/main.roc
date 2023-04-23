# See:
#   https://github.com/roc-lang/basic-cli/blob/main/examples/file-mixedBROKEN.roc

# Run with:
#   echo main.roc | entr -c roc dev


app "noise"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.3.1/97mY3sUwo433-pcnEQUlMhn-sWiIf_J9bPhcAFZoqY4.tar.br" }
     imports [ pf.Stdout
             , pf.Stderr
             , pf.Task.{ Task, await }
             , pf.Process
             , pf.File
             , pf.Path
             ]
    provides [main] to pf

main : Task {} []
main =
    path = Path.fromStr "/tmp/roc.out"
    task =
        _ <-
            Stdout.line "--> Writing to: /tmp/roc.out"
            |> Task.await

        _ <-
            File.writeUtf8 path "Hello, World!"
            |> Task.await
        # contents <- File.readUtf8 path |> Task.await
        # Stdout.line "I read the file back. Its contents is: \"\(contents)\""
        Stdout.line "I am done!"

    Task.attempt task \result ->
        when result is
            Ok {} -> Stdout.line "--> Successfully wrote to: /tmp/roc.out!"
            Err err ->
                msg =
                    when err is
                        FileWriteErr _ _ -> "Oops, I could not write to a file!"
                        FileReadErr _  _ -> "Bogus, this shouldn't compile since it will never trigger!"
                        # FileReadUtf8Err _ _ -> "Encoding issue?"
                        # _ -> "wat?"

                {} <- Stderr.line msg |> Task.await
                Process.exit 1