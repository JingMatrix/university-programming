/*
 * File: _coder_Gaussel_api.h
 *
 * MATLAB Coder version            : 3.3
 * C/C++ source code generated on  : 27-Sep-2017 12:24:17
 */

#ifndef _CODER_GAUSSEL_API_H
#define _CODER_GAUSSEL_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_Gaussel_api.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void Gaussel(real_T A[36], real_T b[6], real_T tol, real_T x[6]);
extern void Gaussel_api(const mxArray *prhs[3], const mxArray *plhs[3]);
extern void Gaussel_atexit(void);
extern void Gaussel_initialize(void);
extern void Gaussel_terminate(void);
extern void Gaussel_xil_terminate(void);

#endif

/*
 * File trailer for _coder_Gaussel_api.h
 *
 * [EOF]
 */
