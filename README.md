# PAMI-2015
Labs &amp; HomeWork for Pattern Analysis and Machine Intelligence course in Politechico di Milano, AY 2015/16

## How to use Makefile for compilation of the documents
All compiled files are placed in the directory of their origins (./Docs). 

The LaTeX compilation mistakes (e.g. missed image files) are ignored.

###Available Commands

To compile the HomeWork report you will need to execute the following command:
```
make
```

To compile the summary of exams of year 2014/15 the first time you will need to execute the following command:
```
make exams
```

To compile the summary of formulas the first time you will need to execute the following command:
```
make exams
```

To remove compiled report you will need to execute the following command:
```
make clean
```

To remove compiled exams summary you will need to execute the following command:
```
make clean-exams
```

To remove compiled formulas summary you will need to execute the following command:
```
make clean-formulas
```

If you want to recompile the report without any changes you will need to execute the following command:
```
make clean && make
```

If you want to recompile the summary of exams without any changes you will need to execute the following command:
```
make clean-exams && make exams
```

If you want to recompile the summary of formulas without any changes you will need to execute the following command:
```
make clean-formulas && make formulas
```

Modified TeX-file can be compiled in both ways.

All techical files appeared during the compilation of a TeX-file (.lof, .lot, .toc, etc.) are removed automatically.
