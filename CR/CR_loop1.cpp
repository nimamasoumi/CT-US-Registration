#include "mex.h"
//#include "string.h"
// Copyright, 2014, Hassan Rivaz.  All Rights reserved.
// Permission granted to use for
// non-commercial research use only.  No further distribution or copying
// permitted without express written consent of Hassan Rivaz. contact:
// hrivaz@gmail.com

void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	
    if (nrhs!=6)
		mexErrMsgTxt("Wrong number of inputs");
	if (nlhs!=2)
		mexErrMsgTxt("Wrong number of outputaas");
        
    //---------------------- inputs -----------------------//
    const double *Imov, *b_f, *b_n, *b_f_1; //Im can be 1D or 2D or 3D. All vectors are the same size
    //int *b_n;
    int bins, n_pts;   // number of bins. num of pts in Im
       //---------------------- Get inputs --------------------//
	Imov = (double *)mxGetData(prhs[0]);
	b_n = (double *)mxGetData(prhs[1]);
    b_f = (double *)mxGetData(prhs[2]);
    b_f_1 = (double *)mxGetData(prhs[3]);
    bins = mxGetScalar(prhs[4]);
    n_pts = mxGetScalar(prhs[5]);
    //------------------------------------------------------//
    //---------------------- outputs -----------------------//
    double *CR_n, *CR_m;  // number and mean in each bin.
    int Dims1[2];
    Dims1[0] = bins+2; 
    Dims1[1] = 1;
    plhs[0] = mxCreateNumericArray(2,Dims1,mxDOUBLE_CLASS,mxREAL);
	CR_n = (double *)mxGetData(plhs[0]);
    
    plhs[1] = mxCreateNumericArray(2,Dims1,mxDOUBLE_CLASS,mxREAL);
	CR_m = (double *)mxGetData(plhs[1]);    
    //---------------------------------------------------//
    //---------------------- code ----------------------//
    int ii;
   //printf("%e %e %d  \n", b_n[0],b_n[1], bins);   
    for (ii = 0; ii < n_pts; ii++)
    {
        CR_n[(int) b_n[ii]-1]   += b_f_1[ii];
        CR_n[(int) b_n[ii]] += b_f[ii];
        
        CR_m[(int) b_n[ii]-1] += (b_f_1[ii]*Imov[ii]);
        CR_m[(int) b_n[ii]] += (b_f[ii]*Imov[ii]);
        
    }
    //printf("%e %e %d  \n", b_n[0],b_n[1], ii); 
}