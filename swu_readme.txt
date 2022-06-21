the roiginal verson is from:
https://www.flir.com/support/products/boson/#Downloads

But there are some issues to build it on ARM with C++15, i fixed them and version controled at here.

To build the sttaic lib on Arm, you need to:
1. go to BosonSDK\FSLP_Files, modify the pathes defined in  Makefile_fslp4arm.mak for your environment, then run
   ~/BosonSDK/FSLP_Files$make -f Makefile_fslp4arm.mak
   then
   libFslp.a will be created in current folder.
   
2. go to BosonSDK/ClientFiles_C,  modify the pathes defined in Makefile_bosonSdk4arm.mak for your environment, then run
   ~/BosonSDK/ClientFiles_C$ make -f Makefile_bosonSdk4arm.mak
   then ../build/libBosonSdk.a will be created.
   
Todo: 
	1. create a cmake file for all platforms
	2. add Makefile to build the test/Example.c
	
shunguang.wu@gmail.com
05/27/2022
