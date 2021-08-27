.source input_code.txt
.class public test
.super java/lang/Object

.method public <init>()V
aload_0
invokenonvirtual java/lang/Object/<init>()V
return
.end method

.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 100
iconst_0
istore 1
fconst_0
fstore 2
.line 1
iconst_0
istore 3
.line 2
L_0:
ldc 5
istore 3
.line 3
L_1:
iload 3
ldc 1
iadd
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
.line 4
L_2:
ldc 10
iconst_0
istore 4
istore 4
.line 5
L_3:
iload 4
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
.line 6
L_4:
iload 3
ldc 5
if_icmpeq L_5
goto L_6
L_5:
.line 7
iload 4
ldc 1
iadd
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
.line 8
goto L_7
.line 9
L_6:
L_7:
iload 4
ldc 10
if_icmpgt L_8
goto L_9
L_8:
.line 10
ldc 0
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
.line 11
goto L_10
L_9:
.line 12
ldc 666
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
.line 13
.line 14
.line 15
L_10:
goto L_11
L_11:
ldc 333
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
goto L_13
L_12:
.line 16
.line 17
L_13:
ldc 0
istore 3
L_14:
iload 3
ldc 10
if_icmplt L_16
goto L_17
L_15:
iload 3
ldc 1
iadd
istore 3
goto L_14
.line 18
L_16:
.line 19
iload 3
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
.line 20
goto L_15
L_17:
return
.end method
