clean:
	rm *.o *.map *.hex *.sym *.lef
prog1 : prog1.s
	pcompile prog1.s && ldpic32 prog1 && pterm

getPutChar : getputChar.s
	pcompile getputChar.s && ldpic32 getputChar && pterm
	
inkey : inkey.s
	pcompile inkey.s && ldpic32 inkey && pterm

readprintInt: readprintInt.s
	pcompile readprintInt.s && ldpic32 readprintInt && pterm

