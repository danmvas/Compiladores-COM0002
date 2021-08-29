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
.line 2
iconst_0
istore 3
.line 3
L_0:
ldc 50
istore 3
.line 4
L_1:
iload 3
ldc 50
if_icmpeq L_2
goto L_3
L_2:
ldc 50
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
goto L_4
L_3:
.line 5
.line 6
L_4:
ldc 10
iconst_0
istore 4
istore 4
.line 7
L_5:
iload 4
ldc 10
if_icmpge L_6
goto L_8
L_6:
.line 8
ldc 10
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
.line 9
L_7:
ldc 333
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
.line 10
goto L_10
L_8:
.line 11
ldc -10
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
.line 12
L_9:
ldc -333
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
.line 13
.line 14
.line 15
L_10:
iconst_0
istore 5
.line 16
L_11:
ldc 0
istore 4
L_12:
iload 4
ldc 2
if_icmplt L_14
goto L_18
L_13:
iload 4
ldc 1
iadd
istore 4
goto L_12
.line 17
L_14:
.line 18
iload 4
istore 5
L_15:
iload 5
iload 4
ldc 5
iadd
if_icmplt L_17
goto L_13
L_16:
iload 5
ldc 1
iadd
istore 5
goto L_15
.line 19
L_17:
.line 20
iload 5
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
.line 21
goto L_16
.line 22
goto L_13
.line 23
.line 24
L_18:
ldc 0
iconst_0
istore 6
istore 6
.line 25
L_19:
L_20:
iload 6
ldc 5
if_icmplt L_21
goto L_23
L_21:
.line 26
iload 6
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
.line 27
L_22:
iload 6
ldc 1
iadd
istore 6
.line 28
goto L_20
.line 29
.line 30
L_23:
L_24:
.line 31
iload 6
istore 1
getstatic      java/lang/System/out Ljava/io/PrintStream;
iload 1
invokevirtual java/io/PrintStream/println(I)V
.line 32
L_25:
iload 6
ldc 1
iadd
istore 6
.line 33
iload 6
ldc 0
if_icmplt L_26
goto L_27
L_26:
goto L_24
L_27:
return
.end method
