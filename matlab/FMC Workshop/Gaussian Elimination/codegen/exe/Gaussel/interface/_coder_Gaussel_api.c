/*
 * File: _coder_Gaussel_api.c
 *
 * MATLAB Coder version            : 3.3
 * C/C++ source code generated on  : 27-Sep-2017 12:24:17
 */

/* Include Files */
#include "tmwtypes.h"
#include "_coder_Gaussel_api.h"
#include "_coder_Gaussel_mex.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;
emlrtContext emlrtContextGlobal = { true,/* bFirstTime */
  false,                               /* bInitialized */
  131450U,                             /* fVersionInfo */
  NULL,                                /* fErrorFunction */
  "Gaussel",                           /* fFunctionName */
  NULL,                                /* fRTCallStack */
  false,                               /* bDebugMode */
  { 2045744189U, 2170104910U, 2743257031U, 4284093946U },/* fSigWrd */
  NULL                                 /* fSigMem */
};

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[36];
static void b_emlrt_marshallOut(const real_T u[6], const mxArray *y);
static real_T (*c_emlrt_marshallIn(const mxArray *b, const char_T *identifier))
  [6];
static const mxArray *c_emlrt_marshallOut(const real_T u[6]);
static real_T (*d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[6];
static real_T e_emlrt_marshallIn(const mxArray *tol, const char_T *identifier);
static real_T (*emlrt_marshallIn(const mxArray *A, const char_T *identifier))[36];
static void emlrt_marshallOut(const real_T u[36], const mxArray *y);
static real_T f_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static real_T (*g_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[36];
static real_T (*h_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[6];
static real_T i_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);

/* Function Definitions */

/*
 * Arguments    : const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : real_T (*)[36]
 */
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[36]
{
  real_T (*y)[36];
  y = g_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
/*
 * Arguments    : const real_T u[6]
 *                const mxArray *y
 * Return Type  : void
 */
  static void b_emlrt_marshallOut(const real_T u[6], const mxArray *y)
{
  static const int32_T iv1[1] = { 6 };

  mxSetData((mxArray *)y, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)y, *(int32_T (*)[1])&iv1[0], 1);
}

/*
 * Arguments    : const mxArray *b
 *                const char_T *identifier
 * Return Type  : real_T (*)[6]
 */
static real_T (*c_emlrt_marshallIn(const mxArray *b, const char_T *identifier))
  [6]
{
  real_T (*y)[6];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(emlrtAlias(b), &thisId);
  emlrtDestroyArray(&b);
  return y;
}
/*
 * Arguments    : const real_T u[6]
 * Return Type  : const mxArray *
 */
  static const mxArray *c_emlrt_marshallOut(const real_T u[6])
{
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv2[1] = { 0 };

  static const int32_T iv3[1] = { 6 };

  y = NULL;
  m0 = emlrtCreateNumericArray(1, iv2, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m0, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)m0, *(int32_T (*)[1])&iv3[0], 1);
  emlrtAssign(&y, m0);
  return y;
}

/*
 * Arguments    : const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : real_T (*)[6]
 */
static real_T (*d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[6]
{
  real_T (*y)[6];
  y = h_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
/*
 * Arguments    : const mxArray *tol
 *                const char_T *identifier
 * Return Type  : real_T
 */
  static real_T e_emlrt_marshallIn(const mxArray *tol, const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(emlrtAlias(tol), &thisId);
  emlrtDestroyArray(&tol);
  return y;
}

/*
 * Arguments    : const mxArray *A
 *                const char_T *identifier
 * Return Type  : real_T (*)[36]
 */
static real_T (*emlrt_marshallIn(const mxArray *A, const char_T *identifier))[36]
{
  real_T (*y)[36];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(emlrtAlias(A), &thisId);
  emlrtDestroyArray(&A);
  return y;
}
/*
 * Arguments    : const real_T u[36]
 *                const mxArray *y
 * Return Type  : void
 */
  static void emlrt_marshallOut(const real_T u[36], const mxArray *y)
{
  static const int32_T iv0[2] = { 6, 6 };

  mxSetData((mxArray *)y, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)y, *(int32_T (*)[2])&iv0[0], 2);
}

/*
 * Arguments    : const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : real_T
 */
static real_T f_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real_T y;
  y = i_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : real_T (*)[36]
 */
static real_T (*g_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[36]
{
  real_T (*ret)[36];
  static const int32_T dims[2] = { 6, 6 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims);
  ret = (real_T (*)[36])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
/*
 * Arguments    : const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : real_T (*)[6]
 */
  static real_T (*h_emlrt_marshallIn(const mxArray *src, const
  emlrtMsgIdentifier *msgId))[6]
{
  real_T (*ret)[6];
  static const int32_T dims[1] = { 6 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 1U,
    dims);
  ret = (real_T (*)[6])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

/*
 * Arguments    : const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : real_T
 */
static real_T i_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 0U,
    &dims);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

/*
 * Arguments    : const mxArray *prhs[3]
 *                const mxArray *plhs[3]
 * Return Type  : void
 */
void Gaussel_api(const mxArray *prhs[3], const mxArray *plhs[3])
{
  real_T (*x)[6];
  real_T (*A)[36];
  real_T (*b)[6];
  real_T tol;
  x = (real_T (*)[6])mxMalloc(sizeof(real_T [6]));
  prhs[0] = emlrtProtectR2012b(prhs[0], 0, true, -1);
  prhs[1] = emlrtProtectR2012b(prhs[1], 1, true, -1);

  /* Marshall function inputs */
  A = emlrt_marshallIn(emlrtAlias(prhs[0]), "A");
  b = c_emlrt_marshallIn(emlrtAlias(prhs[1]), "b");
  tol = e_emlrt_marshallIn(emlrtAliasP(prhs[2]), "tol");

  /* Invoke the target function */
  Gaussel(*A, *b, tol, *x);

  /* Marshall function outputs */
  emlrt_marshallOut(*A, prhs[0]);
  plhs[0] = prhs[0];
  b_emlrt_marshallOut(*b, prhs[1]);
  plhs[1] = prhs[1];
  plhs[2] = c_emlrt_marshallOut(*x);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void Gaussel_atexit(void)
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  Gaussel_xil_terminate();
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void Gaussel_initialize(void)
{
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void Gaussel_terminate(void)
{
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/*
 * File trailer for _coder_Gaussel_api.c
 *
 * [EOF]
 */
