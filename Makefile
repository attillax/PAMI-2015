TEMPFILES = \
	*.aux \
	*.lo[g,f,t] \
	*.out \
	*.toc \
	*.syntex.gz \
	*.gnuplot \
	*.table \

REPORTDIR = ./Docs
REPORT = report_hw.pdf
EXAMS = ExamsSummary.pdf
SOLUTIONS = ExamsSummarySolutions.pdf
COURSE = CourseSummary.pdf

$(REPORTDIR)/$(REPORT): $(REPORTDIR)/$(REPORT:%.pdf=%.tex)

#compiling twice for autogenerated lists
	(cd $(REPORTDIR);\
	pdflatex -interaction=nonstopmode $(REPORT:%.pdf=%.tex);\
	pdflatex -interaction=nonstopmode $(REPORT:%.pdf=%.tex);\
	rm -f $(TEMPFILES))

#compiling exams summary
exams:
	(cd $(REPORTDIR);\
	pdflatex -interaction=nonstopmode $(EXAMS:%.pdf=%.tex);\
	pdflatex -interaction=nonstopmode $(EXAMS:%.pdf=%.tex);\
	rm -f $(TEMPFILES))

#compiling exams summary with solutions
solutions:
	(cd $(REPORTDIR);\
	pdflatex --enable-write18 $(SOLUTIONS:%.pdf=%.tex);\
	pdflatex -interaction=nonstopmode $(SOLUTIONS:%.pdf=%.tex);\
	rm -f $(TEMPFILES))

#compiling formulas summary
course:
	(cd $(REPORTDIR);\
	pdflatex -interaction=nonstopmode $(COURSE:%.pdf=%.tex);\
	pdflatex -interaction=nonstopmode $(COURSE:%.pdf=%.tex);\
	rm -f $(TEMPFILES))

#remove comliped report 
clean:
	(cd $(REPORTDIR);\
	rm -f $(REPORT))

#remove comliped exams summary 
clean-exams:
	(cd $(REPORTDIR);\
	rm -f $(EXAMS))

#remove comliped exams summary with solutions
clean-solutions:
	(cd $(REPORTDIR);\
	rm -f $(SOLUTIONS))

#remove comliped formulas summary 
clean-course:
	(cd $(REPORTDIR);\
	rm -f $(COURSE))

.PHONY: exams, solutions, formulas, clean, clean-exams, clean-solutions, clean-course
