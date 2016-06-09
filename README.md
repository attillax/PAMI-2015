# PAMI-2015
HomeWork &amp; useful materials for Pattern Analysis and Machine Intelligence course in Politecnico di Milano, AY 2015/16


## Repository contents
1) Course book compilated from selected chapters of ISL and ESL.
(Sulutions for questions from ISL are available in the appropriate [repo](https://github.com/attillax/ISL))

2) Sources, solutions and report for course homework.

3) Summary of exam questions and answers for them.

4) Summary of course topics.

5) Makefile for .tex documents.

### Folders structure
**/Docs** contains all provided .tex files and .pdf for them.

**/statLearningDemos** contains homework sources.


## Rights
Summaries and solutions are done by me. 

Homework sources and exams texts are provided by teachers.

Original [ISL](http://www.springer.com/it/book/9781461471370) and [ESL](http://www.springer.com/it/book/9780387848570) books are available in the Internet for free download.

Feel free to contact me in case case of any doubts or suggestions =)


## How to use Makefile for compilation of the documents
All compiled files are placed in the directory of their origins (./Docs). 

The LaTeX compilation mistakes (e.g. missed image files) are ignored.

###Available Commands

To compile the HomeWork report you will need to execute the following command:
```
make
```

To compile the summary of exams you will need to execute the following command:
```
make exams
```

To compile the summary of exams with solutions you will need to execute the following command:
```
make exams-solutions
```

To compile the course summary you will need to execute the following command:
```
make course
```

To remove compiled report you will need to execute the following command:
```
make clean
```

To remove compiled summary of exams you will need to execute the following command:
```
make clean-exams
```

To remove compiled summary of exams with solutions you will need to execute the following command:
```
make clean-exams-solutions
```

To remove compiled course summary you will need to execute the following command:
```
make clean-course
```

If you want to recompile the report without any changes you will need to execute the following command:
```
make clean && make
```

If you want to recompile the summary of exams without any changes you will need to execute the following command:
```
make clean-exams && make exams
```

If you want to recompile the summary of exams with solutions without any changes you will need to execute the following command:
```
make clean-exams-solutions && make exams-solutions
```

If you want to recompile the course summary without any changes you will need to execute the following command:
```
make clean-course && make course
```

Modified TeX-file can be compiled in both ways.

All techical files appeared during the compilation of a TeX-file (.lof, .lot, .toc, etc.) are removed automatically.
