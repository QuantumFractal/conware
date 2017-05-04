/*****************************************************************************
* Filename:          C:\Users\micha\Documents\projects\conware\xps\system\drivers/conware_v2_00_a/src/conware_selftest.c
* Version:           2.00.a
* Description:       
* Date:              Fri Apr 28 23:44:49 2017 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#include "xparameters.h"
#include "conware.h"

/* IMPORTANT:
*  Slot ID is hard coded in this example to 0. Modify it if needs to connected to different slot.
*/
#define input_slot_id   0
#define output_slot_id  0

XStatus CONWARE_SelfTest()
{
	 unsigned int input_0[1];     
	 unsigned int output_0[1];     

	 //Initialize your input data over here: 
	 input_0[0] = 12345;     

	 //Call the macro with instance specific slot IDs
	 conware(
		 input_slot_id,
		 output_slot_id,
		 input_0,      
		 output_0       
		 );

	 if (output_0[0] != 12345)
		 return XST_FAILURE;
	 if (output_0[0] != 12345)
		 return XST_FAILURE;

	 return XST_SUCCESS;
}
