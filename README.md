# Treebank Syntax

This is a library for getting certain syntactic data from collections of treebanks
of ancient Greek. It works with treebanks in Perseus format and in PROIEL format.

## Example usage

```
$ ./process-perseus.rb --help
Usage: ./process-perseus.rb --type TYPE [--feature FEATURE] file1.xml [file2.xml ...]
        --feature FEATURE            Feature: ov, an, gn, adpn (default: ov)
        --type TYPE                  Input type: perseus, papygreek (required)
    -h, --help                       Show this message
```

```
./process-updated.rb --type perseus --feature adpn treebanks/**/* > out.csv
```
