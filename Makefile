JFLAGS = -g
JC = javac

.SUFFIXES: .java .class

.java.class:
	$(JC) $(JFLAGS) $*.java

CLASSES = \
		  Test.java \
		  Token.java \
		  TOKEN_TYPE.java \
		  LexTest.java

default: classes

classes: $(CLASSES:.java=.class)

clean:
	$(RM) *.class

run:
	java Test