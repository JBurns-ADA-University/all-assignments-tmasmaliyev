
c_assembly:     file format elf32-littlearm


Disassembly of section .init:

000102d8 <_init>:
   102d8:	e92d4008 	push	{r3, lr}
   102dc:	eb000022 	bl	1036c <call_weak_fn>
   102e0:	e8bd8008 	pop	{r3, pc}

Disassembly of section .plt:

000102e4 <.plt>:
   102e4:	e52de004 	push	{lr}		@ (str lr, [sp, #-4]!)
   102e8:	e59fe004 	ldr	lr, [pc, #4]	@ 102f4 <.plt+0x10>
   102ec:	e08fe00e 	add	lr, pc, lr
   102f0:	e5bef008 	ldr	pc, [lr, #8]!
   102f4:	00001d0c 	.word	0x00001d0c

000102f8 <__libc_start_main@plt>:
   102f8:	e28fc600 	add	ip, pc, #0, 12
   102fc:	e28cca01 	add	ip, ip, #4096	@ 0x1000
   10300:	e5bcfd0c 	ldr	pc, [ip, #3340]!	@ 0xd0c

00010304 <printf@plt>:
   10304:	e28fc600 	add	ip, pc, #0, 12
   10308:	e28cca01 	add	ip, ip, #4096	@ 0x1000
   1030c:	e5bcfd04 	ldr	pc, [ip, #3332]!	@ 0xd04

00010310 <__gmon_start__@plt>:
   10310:	e28fc600 	add	ip, pc, #0, 12
   10314:	e28cca01 	add	ip, ip, #4096	@ 0x1000
   10318:	e5bcfcfc 	ldr	pc, [ip, #3324]!	@ 0xcfc

0001031c <abort@plt>:
   1031c:	e28fc600 	add	ip, pc, #0, 12
   10320:	e28cca01 	add	ip, ip, #4096	@ 0x1000
   10324:	e5bcfcf4 	ldr	pc, [ip, #3316]!	@ 0xcf4

Disassembly of section .text:

00010328 <_start>:
   10328:	e3a0b000 	mov	fp, #0
   1032c:	e3a0e000 	mov	lr, #0
   10330:	e49d1004 	pop	{r1}		@ (ldr r1, [sp], #4)
   10334:	e1a0200d 	mov	r2, sp
   10338:	e52d2004 	push	{r2}		@ (str r2, [sp, #-4]!)
   1033c:	e52d0004 	push	{r0}		@ (str r0, [sp, #-4]!)
   10340:	e59fa01c 	ldr	sl, [pc, #28]	@ 10364 <_start+0x3c>
   10344:	e28f3018 	add	r3, pc, #24
   10348:	e08aa003 	add	sl, sl, r3
   1034c:	e3a03000 	mov	r3, #0
   10350:	e52d3004 	push	{r3}		@ (str r3, [sp, #-4]!)
   10354:	e59f000c 	ldr	r0, [pc, #12]	@ 10368 <_start+0x40>
   10358:	e79a0000 	ldr	r0, [sl, r0]
   1035c:	ebffffe5 	bl	102f8 <__libc_start_main@plt>
   10360:	ebffffed 	bl	1031c <abort@plt>
   10364:	00001c9c 	.word	0x00001c9c
   10368:	00000020 	.word	0x00000020

0001036c <call_weak_fn>:
   1036c:	e59f3014 	ldr	r3, [pc, #20]	@ 10388 <call_weak_fn+0x1c>
   10370:	e59f2014 	ldr	r2, [pc, #20]	@ 1038c <call_weak_fn+0x20>
   10374:	e08f3003 	add	r3, pc, r3
   10378:	e7932002 	ldr	r2, [r3, r2]
   1037c:	e3520000 	cmp	r2, #0
   10380:	012fff1e 	bxeq	lr
   10384:	eaffffe1 	b	10310 <__gmon_start__@plt>
   10388:	00001c84 	.word	0x00001c84
   1038c:	0000001c 	.word	0x0000001c

00010390 <deregister_tm_clones>:
   10390:	e59f0018 	ldr	r0, [pc, #24]	@ 103b0 <deregister_tm_clones+0x20>
   10394:	e59f3018 	ldr	r3, [pc, #24]	@ 103b4 <deregister_tm_clones+0x24>
   10398:	e1530000 	cmp	r3, r0
   1039c:	012fff1e 	bxeq	lr
   103a0:	e59f3010 	ldr	r3, [pc, #16]	@ 103b8 <deregister_tm_clones+0x28>
   103a4:	e3530000 	cmp	r3, #0
   103a8:	012fff1e 	bxeq	lr
   103ac:	e12fff13 	bx	r3
   103b0:	0001202c 	.word	0x0001202c
   103b4:	0001202c 	.word	0x0001202c
   103b8:	00000000 	.word	0x00000000

000103bc <register_tm_clones>:
   103bc:	e59f0024 	ldr	r0, [pc, #36]	@ 103e8 <register_tm_clones+0x2c>
   103c0:	e59f3024 	ldr	r3, [pc, #36]	@ 103ec <register_tm_clones+0x30>
   103c4:	e0433000 	sub	r3, r3, r0
   103c8:	e1a01fa3 	lsr	r1, r3, #31
   103cc:	e0811143 	add	r1, r1, r3, asr #2
   103d0:	e1b010c1 	asrs	r1, r1, #1
   103d4:	012fff1e 	bxeq	lr
   103d8:	e59f3010 	ldr	r3, [pc, #16]	@ 103f0 <register_tm_clones+0x34>
   103dc:	e3530000 	cmp	r3, #0
   103e0:	012fff1e 	bxeq	lr
   103e4:	e12fff13 	bx	r3
   103e8:	0001202c 	.word	0x0001202c
   103ec:	0001202c 	.word	0x0001202c
   103f0:	00000000 	.word	0x00000000

000103f4 <__do_global_dtors_aux>:
   103f4:	e92d4010 	push	{r4, lr}
   103f8:	e59f4018 	ldr	r4, [pc, #24]	@ 10418 <__do_global_dtors_aux+0x24>
   103fc:	e5d43000 	ldrb	r3, [r4]
   10400:	e3530000 	cmp	r3, #0
   10404:	18bd8010 	popne	{r4, pc}
   10408:	ebffffe0 	bl	10390 <deregister_tm_clones>
   1040c:	e3a03001 	mov	r3, #1
   10410:	e5c43000 	strb	r3, [r4]
   10414:	e8bd8010 	pop	{r4, pc}
   10418:	0001202c 	.word	0x0001202c

0001041c <frame_dummy>:
   1041c:	eaffffe6 	b	103bc <register_tm_clones>

00010420 <countIterations>:
   10420:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
   10424:	e28db000 	add	fp, sp, #0
   10428:	e24dd01c 	sub	sp, sp, #28
   1042c:	e50b0018 	str	r0, [fp, #-24]	@ 0xffffffe8
   10430:	e50b101c 	str	r1, [fp, #-28]	@ 0xffffffe4
   10434:	e51b3018 	ldr	r3, [fp, #-24]	@ 0xffffffe8
   10438:	e50b3010 	str	r3, [fp, #-16]
   1043c:	e51b3018 	ldr	r3, [fp, #-24]	@ 0xffffffe8
   10440:	e50b3008 	str	r3, [fp, #-8]
   10444:	e3a03000 	mov	r3, #0
   10448:	e50b300c 	str	r3, [fp, #-12]
   1044c:	ea000006 	b	1046c <countIterations+0x4c>
   10450:	e51b300c 	ldr	r3, [fp, #-12]
   10454:	e2833001 	add	r3, r3, #1
   10458:	e50b300c 	str	r3, [fp, #-12]
   1045c:	e51b2010 	ldr	r2, [fp, #-16]
   10460:	e51b3008 	ldr	r3, [fp, #-8]
   10464:	e0823003 	add	r3, r2, r3
   10468:	e50b3010 	str	r3, [fp, #-16]
   1046c:	e51b2010 	ldr	r2, [fp, #-16]
   10470:	e51b301c 	ldr	r3, [fp, #-28]	@ 0xffffffe4
   10474:	e1520003 	cmp	r2, r3
   10478:	dafffff4 	ble	10450 <countIterations+0x30>
   1047c:	e51b300c 	ldr	r3, [fp, #-12]
   10480:	e1a00003 	mov	r0, r3
   10484:	e28bd000 	add	sp, fp, #0
   10488:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
   1048c:	e12fff1e 	bx	lr

00010490 <main>:
   10490:	e92d4800 	push	{fp, lr}
   10494:	e28db004 	add	fp, sp, #4
   10498:	e24dd010 	sub	sp, sp, #16
   1049c:	e3a03005 	mov	r3, #5
   104a0:	e50b3010 	str	r3, [fp, #-16]
   104a4:	e3a03014 	mov	r3, #20
   104a8:	e50b300c 	str	r3, [fp, #-12]
   104ac:	e51b100c 	ldr	r1, [fp, #-12]
   104b0:	e51b0010 	ldr	r0, [fp, #-16]
   104b4:	ebffffd9 	bl	10420 <countIterations>
   104b8:	e50b0008 	str	r0, [fp, #-8]
   104bc:	e51b1008 	ldr	r1, [fp, #-8]
   104c0:	e59f0010 	ldr	r0, [pc, #16]	@ 104d8 <main+0x48>
   104c4:	ebffff8e 	bl	10304 <printf@plt>
   104c8:	e3a03000 	mov	r3, #0
   104cc:	e1a00003 	mov	r0, r3
   104d0:	e24bd004 	sub	sp, fp, #4
   104d4:	e8bd8800 	pop	{fp, pc}
   104d8:	00010578 	.word	0x00010578

Disassembly of section .fini:

000104dc <_fini>:
   104dc:	e92d4008 	push	{r3, lr}
   104e0:	e8bd8008 	pop	{r3, pc}
