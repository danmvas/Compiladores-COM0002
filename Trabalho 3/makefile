all:
	flex com.lex
	bison -d com.y
	g++ -std=c++11 com.tab.c lex.yy.c -o com -lm
	./com
	java -jar ./jasmin-1.1/jasmin.jar output.j 
	java test